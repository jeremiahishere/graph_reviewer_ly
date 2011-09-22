class DisplayGraphPermission < ActiveRecord::Base
  belongs_to :display_graph
  belongs_to :user

  validates_presence_of :display_graph_id, :user_id, :permission_level
end
