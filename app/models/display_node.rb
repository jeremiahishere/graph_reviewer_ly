class DisplayNode < ActiveRecord::Base
  belongs_to :display_graph
  belongs_to :node

  before_save :initialize_location

  validates_presence_of :display_graph_id, :node_id

  def initialize_location
    self.x_pos = 0 unless self.x_pos
    self.y_pos = 0 unless self.y_pos
    self.scale = 1 unless self.scale
  end

  # maybe could include the display graph name in the future
  def name
    self.node.name
  end

  def to_json
    field_data = []
    self.node.fields.each do |field|
      field_data.push(field.to_json)
    end

    {
      :id => self.id,
      :x_pos => self.x_pos,
      :y_pos => self.y_pos,
      :scale => self.scale,
      :name => self.node.name,
      :fields => field_data
    }
  end

  # updates position data for the node through a json/hash object
  def update_positions(data)
    self.x_pos = data[:x_pos] 
    self.y_pos = data[:y_pos] 
    self.scale = data[:scale] 
    self.save
  end
end
