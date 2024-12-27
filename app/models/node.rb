class Node < ApplicationRecord
  scope :applications, -> { where(component_type: 'application') }
  scope :datastores, -> { where(component_type: 'datastore') }
  belongs_to :system
  has_many :starting_edges, foreign_key: "start_node_id", class_name: "Edge"
  has_many :ending_edges, foreign_key: "end_node_id", class_name: "Edge"
end
