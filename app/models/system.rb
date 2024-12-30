class System < ApplicationRecord
  has_many :components, class_name: 'Node'

  def entry_point
    components.where(gateway: true)
  end

  def traverse
    graph = build_graph
  end

  def build_graph
    next_nodes = components.where(gateway: true)
    graph = []

    while next_nodes.any? do
      graph << next_nodes

      _n = next_nodes.reduce([]) do |nn|
        next unless nn.starting_edges.any?
        nn.starting_edges.pluck(:end_node_id)
      end.compact

      next_nodes = Node.where(id: _n).all
    end
  end
end
