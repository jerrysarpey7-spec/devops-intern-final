job "hello-devops" {
  datacenters = ["dc1"]
  type        = "service"

  group "hello-group" {
    count = 1

    # 1. Add this network block
    network {
      port "http" {
        to = 8080 # The port your app listens on internally
      }
    }

    task "hello-task" {
      driver = "docker"

      config {
        image = "devops-hello:v1"
        
        # 2. Tell Docker to use the port defined above
        ports = ["http"] 
      }

      resources {
        cpu    = 100
        memory = 128
      }
    }
  }
}
