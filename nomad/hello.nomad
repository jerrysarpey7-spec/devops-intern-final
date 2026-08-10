job "hello-devops" {
  datacenters = ["dc1"]
  type        = "service"

  group "hello-group" {
    count = 1

    network {
      port "http" {
        to = 8080
      }
    }

    task "hello-task" {
      driver = "docker"

      config {
        image      = "devops-hello:v1"
        force_pull = false
        ports      = ["http"]
      }

      logs {
        max_files     = 10
        max_file_size = "10MB"
      }

      resources {
        cpu    = 100
        memory = 128
      }
    }
  }
}
