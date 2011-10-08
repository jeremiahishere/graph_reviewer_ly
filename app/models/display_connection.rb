class DisplayConnection < ActiveRecord::Base
  belongs_to :display_graph
  belongs_to :connection

  validates_presence_of :display_graph_id, :connection_id

  # order the output by the name function
  def self.ordered_by_name
    sort_by(&:name)
  end

  # maybe could include the display graph name in the future
  def name
    self.connection.name
  end

  def to_json
    {
      :id => self.id,
      :name => name,
      :start_node_id => self.connection.start_node.id,
      :end_node_id => self.connection.end_node.id,
      :start_type => self.connection.start_type,
      :end_type => self.connection.end_type,
      :line_type => self.connection.line_type,
      :weight => self.connection.weight
    }
  end
end
