class Graph
  include Enumerable

  def initialize(system)
    @system = system
    @graph = []
    next_nodes = system.entry_point

    while next_nodes.any? do
      graph << next_nodes

      _n = next_nodes.map do |n|
        next unless n.starting_edges.any?
        n.starting_edges.pluck(:end_node_id)
      end.compact

      next_nodes = Node.where(id: _n).all
    end
  end

  def path
    build_path = lambda do |node|
      downstream_apps = node.starting_edges.map do |se|
        build_path.call(se.end_node)
      end

      node.attributes.merge("downstream_apps" => downstream_apps)
    end

    build_path.call(system.entry_point.first)
  end

  def health_checks
    build_path = lambda do |node|

      downstream_apps = node["downstream_apps"].map do |dsa|
        build_path.call(dsa)
      end

      {
        uri: node["metadata"]["uri"],
        downstream_apps:
      }
    end

    build_path.call(path)
  end

  def width
    @width ||= begin
                 max = 0
                 graph.each do |row|
                   max = row.length if row.length > max
                 end
                 max
               end
  end

  def depth
    graph.length
  end

  def each(&block)
    graph.each do |node|
      block.call(node)
    end
  end

  private

  attr_reader :graph, :system
end
