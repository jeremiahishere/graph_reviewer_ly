class Field < ActiveRecord::Base
  belongs_to :node

  validates_presence_of :node_id, :name

  def to_json
    {
      :id => self.id,
      :name => self.name
    }
  end
end
