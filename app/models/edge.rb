class Edge < ApplicationRecord
  belongs_to :start_node, class_name: 'Node'
  belongs_to :end_node, class_name: 'Node'
end
