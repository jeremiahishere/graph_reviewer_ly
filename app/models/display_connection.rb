class DisplayConnection < ActiveRecord::Base
  belongs_to :display_graph
  belongs_to :connection

  validates_presence_of :display_graph_id, :connection_id
end
