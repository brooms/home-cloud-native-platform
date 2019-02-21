job "radicale" {

  region = "global"
  
  datacenters = ["dc1"]
  
  type = "service"

  group "radicale-app" {
    count = 1

    restart {
      attempts = 3
      delay    = "20s"
      mode     = "delay"
    }

    task "radicale" {
      driver = "docker"

      config {
        image = "{{ radicale.image.name }}:{{ radicale.image.tag }}"
        volumes = [
      	  "{{ radicale.storage }}/config:/etc/radicale:ro",
          "{{ radicale.storage }}/data:/var/lib/radicale",
          "{{ radicale.storage }}/logs:/var/log/radicale"
        ]
        port_map {
          http = 5232
        }
      }

      env {

      }

      service {
        name = "{{ radicale.container.name }}"

        port = "http"
      }

      resources {
        network {
          port "http" { }
        }
      }
    }
  }
}
