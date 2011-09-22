class DisplayGraph < ActiveRecord::Base
  belongs_to :graph

  has_many :display_nodes
  has_many :display_connections

  validates_presence_of :graph_id, :name, :public
  
end
