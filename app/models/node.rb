class Node < ActiveRecord::Base
  belongs_to :graph
  has_many :fields
  has_many :start_connections, :class_name => "Connection", :foreign_key => :start_node_id
  has_many :end_connections, :class_name => "Connection", :foreign_key => :end_node_id

  validates_presence_of :graph_id, :name
end
