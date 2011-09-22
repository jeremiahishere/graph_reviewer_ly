class Field < ActiveRecord::Base
  belongs_to :node

  validates_presence_of :node_id, :name
end
