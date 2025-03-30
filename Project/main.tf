provider "docker" {
  host = "unix:///var/run/docker.sock"  # Use Docker socket on local machine
}

# Create Docker volumes to persist data
resource "docker_volume" "postgres_data" {
  name = "postgres-data"
}

resource "docker_volume" "kestra_data" {
  name = "kestra-data"
}

# Create the PostgreSQL Docker container
resource "docker_container" "postgres" {
  image = "postgres"
  name  = "postgres"
  env = [
    "POSTGRES_DB=kestra",
    "POSTGRES_USER=kestra",
    "POSTGRES_PASSWORD=k3str4"
  ]
  volumes = [
    "${docker_volume.postgres_data.name}:/var/lib/postgresql/data"
  ]
  ports = ["5432:5432"]
  
  healthcheck {
    test     = ["CMD-SHELL", "pg_isready -d $POSTGRES_DB -U $POSTGRES_USER"]
    interval = "30s"
    timeout  = "10s"
    retries  = 10
  }
}

# Create the Kestra Docker container
resource "docker_container" "kestra" {
  image = "kestra/kestra:latest"
  name  = "kestra"
  command = "server standalone"
  user    = "root"
  volumes = [
    "${docker_volume.kestra_data.name}:/app/storage",
    "/var/run/docker.sock:/var/run/docker.sock",
    "/tmp/kestra-wd:/tmp/kestra-wd",
    "/path/to/local/yaml/folder:/app/kestra-workflows"  # Mount your YAML files here
  ]
  environment = {
    KESTRA_CONFIGURATION = <<EOF
datasources:
  postgres:
    url: jdbc:postgresql://postgres:5432/kestra
    driverClassName: org.postgresql.Driver
    username: kestra
    password: k3str4
kestra:
  server:
    basicAuth:
      enabled: false
      username: "admin@kestra.io"
      password: kestra
  repository:
    type: postgres
  storage:
    type: local
    local:
      basePath: "/app/storage"
  queue:
    type: postgres
  tasks:
    tmpDir:
      path: /tmp/kestra-wd/tmp
  url: http://localhost:8080/
  executor:
    run:
      - "/app/kestra-workflows/01_gcp_kv.yml"
      - "/app/kestra-workflows/02_gcp_setup.yml"
      - "/app/kestra-workflows/03_gcp_bucket.yml"
      - "/app/kestra-workflows/04_gcp_biqGuery.yml"
      - "/app/kestra-workflows/05_gcp_dbt.yml"
EOF
  }
  ports = ["8080:8080", "8081:8081"]

  depends_on = [docker_container.postgres]
}
