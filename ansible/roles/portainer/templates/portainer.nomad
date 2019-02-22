task "portainer" {
  driver = "docker"

  config {
    image = "{{ portainer.image.name }}:{{ portainer.image.tag }}"
    labels {
      group = "portainer-app"
    }
  }
}