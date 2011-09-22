class DisplayGraph < ActiveRecord::Base
  belongs_to :graph
  belongs_to :user

  has_many :display_nodes
  accepts_nested_attributes_for :display_nodes, :allow_destroy => true
  has_many :display_connections
  accepts_nested_attributes_for :display_connections, :allow_destroy => true

  has_many :display_graph_permissions

  after_save :create_default_permission


  validates_presence_of :graph_id, :name
  validates_inclusion_of :public, :in => [true, false]

  # not sure if this is necessary
  def create_default_permission
    # that is a fun looking method name
    DisplayGraphPermission.find_or_create_by_display_graph_id_and_user_id(
      :display_graph_id => self.id,
      :user_id => self.user.id,
      :permission_level => "edit"
    )
  end

  scope :public_display_graphs, lambda { where(:public => true) }

  # get the display graphs the user has permissions for
  # and the public ones
  # this seems sort of messy
  # this could potentially return the same display graph multiple times
  def self.by_permissions(user)
    DisplayGraphPermission.where(:user_id => user.id).collect { |p| p.display_graph } | DisplayGraph.public_display_graphs
  end
end
