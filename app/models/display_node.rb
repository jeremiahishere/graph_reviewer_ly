class DisplayNode < ActiveRecord::Base
  belongs_to :display_graph
  belongs_to :node

  validates_presence_of :display_graph_id, :node_id

  # do we also want to validate position?
end
