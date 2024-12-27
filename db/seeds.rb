sys = System.create(
  name: "Heroku Demo System"
)

api = sys.components.create(
  name: "Demo API",
  component_type: "app",
  heroku_id: SecureRandom.uuid,
  gateway: true,
  metadata: {
    health_check: {
      path: "/health",
      dependent_paths: "/health"
    }
  }
)

serv1 = sys.components.create(
  name: "Demo Service 1",
  component_type: "app",
  heroku_id: SecureRandom.uuid,
  gateway: false,
  metadata: {}
)

serv2 = sys.components.create(
  name: "Demo Service 2",
  component_type: "app",
  heroku_id: SecureRandom.uuid,
  gateway: false,
  metadata: {}
)

serv3 = sys.components.create(
  name: "Demo Service 3",
  component_type: "app",
  heroku_id: SecureRandom.uuid,
  gateway: false,
  metadata: {}
)

Edge.create(
  start_node: api,
  end_node: serv1,
  metadata: {}
)

Edge.create(
  start_node: api,
  end_node: serv2,
  metadata: {}
)

Edge.create(
  start_node: serv2,
  end_node: serv3,
  metadata: {}
)
