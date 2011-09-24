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
      node = Node.where(:graph_id => self.id, :name => node_hash[:name]).first
      if node.nil?
        node = Node.create(:graph_id => self.id, :name => node_hash[:name])
      end

      node_hash[:fields].each do |field|
        if Field.where(:node_id => node.id, :name => node_hash[:name]).count == 0
          Field.create(:node_id => node.id, :name => field[:name] )
        end
      end
    end

    parsed_graph.connections.each do |connection|
      start_node = Node.find_by_name(connection[:start_node])
      end_node = Node.find_by_name(connection[:end_node])

      # naively assumes there is only one connection between each node
      # doing this because I am lazy and it makes the coding easier
      existing_connection = Connection.where(:graph_id => self.id, :start_node_id => start_node.id, :end_node_id => end_node.id).first
      if existing_connection.nil?
        new_connection = Connection.create(
          :graph_id => self.id, 
          :start_node_id => start_node,
          :end_node_id => end_node,
          :start_type => connection[:arrowhead],
          :end_type => connection[:arrowtail],
          :weight => connection[:weight],
          :line_type => "" # no support yet
        )
      end
    end
  end

  scope :by_user, lambda { |user| where(:user_id => user.id) }

  def in_use?
    self.display_graphs.count > 0
  end
end
