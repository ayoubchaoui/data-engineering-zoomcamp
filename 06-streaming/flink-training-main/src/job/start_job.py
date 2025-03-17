from pyflink.datastream import StreamExecutionEnvironment
from pyflink.table import EnvironmentSettings, DataTypes, TableEnvironment, StreamTableEnvironment


def create_processed_events_sink_postgres(t_env):
    table_name = 'processed_events'
    sink_ddl = f"""
        CREATE TABLE {table_name} (
            test_data INTEGER,
            event_timestamp TIMESTAMP
        ) WITH (
            'connector' = 'jdbc',
            'url' = 'jdbc:postgresql://postgres:5432/postgres',
            'table-name' = '{table_name}',
            'username' = 'postgres',
            'password' = 'postgres',
            'driver' = 'org.postgresql.Driver'
        );
        """
    t_env.execute_sql(sink_ddl)
    return table_name

# event_timestamp: 1710316000000 → event_watermark :'2024-03-13 10:00:00.000' 
# WATERMARK  :If the event timestamp is 10:00:10.000, 
# Flink will accept it only if it arrives before 10:00:15.000 late yes
def create_events_source_kafka(t_env):
    table_name = "events"
    pattern = "yyyy-MM-dd HH:mm:ss.SSS"
    source_ddl = f"""
        CREATE TABLE {table_name} (
            test_data INTEGER,
            event_timestamp BIGINT,
            event_watermark AS TO_TIMESTAMP_LTZ(event_timestamp, 3),
            WATERMARK for event_watermark as event_watermark - INTERVAL '5' SECOND
        ) WITH (
            'connector' = 'kafka',
            'properties.bootstrap.servers' = 'redpanda-1:29092',
            'topic' = 'test-topic',
            'scan.startup.mode' = 'latest-offset',
            'properties.auto.offset.reset' = 'latest',
            'format' = 'json'
        );
        """
    t_env.execute_sql(source_ddl)
    return table_name
# Available Options for scan.startup.mode
# earliest-offset	Start reading from the beginning of the topic (first message ever published).
# latest-offset	Start reading from the latest message (ignore old messages).
# group-offsets	Resume from where the Kafka consumer group last stopped (if checkpoints exist).
# timestamp	Start reading from a specific timestamp (e.g., only messages after a certain date
def log_processing():
    # Set up the execution environment
    env = StreamExecutionEnvironment.get_execution_environment()
    env.enable_checkpointing(10 * 1000)
    # env.set_parallelism(1)

    # Set up the table environment
    settings = EnvironmentSettings.new_instance().in_streaming_mode().build()
    t_env = StreamTableEnvironment.create(env, environment_settings=settings)
    try:
        # Create Kafka table
        source_table = create_events_source_kafka(t_env)
        postgres_sink = create_processed_events_sink_postgres(t_env)
        # write records to postgres too!
        t_env.execute_sql(
            f"""
                    INSERT INTO {postgres_sink}
                    SELECT
                        test_data,
                        TO_TIMESTAMP_LTZ(event_timestamp, 3) as event_timestamp
                    FROM {source_table}
                    """
        ).wait()

    except Exception as e:
        print("Writing records from Kafka to JDBC failed:", str(e))


if __name__ == '__main__':
    log_processing()
