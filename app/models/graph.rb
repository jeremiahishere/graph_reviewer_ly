class Graph < ActiveRecord::Base
  belongs_to :user
  has_many :nodes
  has_many :connections

  has_many :display_graphs

  after_save :process_raw_input

  validates_presence_of :name, :raw_input, :user_id

  def process_raw_input
    parsed_graph = Cabbage.dotfile(self.raw_input)
    parsed_graph.nodes.each do |node_hash|
      new_node = Node.new
      new_node.name = node_hash[:name]
      self.nodes << new_node
      node_hash[:fields].each do |field|
        new_node.fields << Field.new( :name => field[:name] ) # :type => field[:type]
      end
      new_node.save
    end
    parsed_graph.connections.each do |connection|
      new_connection = Connection.new
      new_connection.graph_id = self.id
      new_connection.start_node_id = Node.find_by_name(connection[:start_node]).id
      new_connection.end_node_id = Node.find_by_name(connection[:end_node]).id
      new_connection.start_type = connection[:arrowhead]
      new_connection.end_type = connection[:arrowtail]
      # new_connection.line_type = ??
      new_connection.weight = connection[:weight]
      new_connection.save
    end
  end

  scope :by_user, lambda { |user| where(:user_id => user.id) }

  def in_use?
    self.display_graphs.count > 0
  end
end
