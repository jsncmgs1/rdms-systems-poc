sys = System.create(
  name: "Heroku Demo System"
)

api = sys.components.create(
  name: "Demo API",
  component_type: "app",
  heroku_id: SecureRandom.uuid,
  gateway: true,
  metadata: {
    uri: "https://localhost:5000/health",
  }
)

serv1 = sys.components.create(
  name: "Demo Service 1",
  component_type: "app",
  heroku_id: SecureRandom.uuid,
  gateway: false,
  metadata: {
    uri: "http://localhost:5001/health",
  }
)

serv2 = sys.components.create(
  name: "Demo Service 2",
  component_type: "app",
  heroku_id: SecureRandom.uuid,
  gateway: false,
  metadata: {
    uri: "http://localhost:5002/health",
  }
)

serv3 = sys.components.create(
  name: "Demo Service 3",
  component_type: "app",
  heroku_id: SecureRandom.uuid,
  gateway: false,
  metadata: {
    uri: "http://localhost:5003/health",
  }
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
