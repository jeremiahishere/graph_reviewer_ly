class Connection < ActiveRecord::Base
  belongs_to :start_node, :class_name => "Node", :foreign_key => :start_node_id
  belongs_to :end_node, :class_name => "Node", :foreign_key => :end_node_id

  validates_presence_of :start_node_id, :end_node_id
end
