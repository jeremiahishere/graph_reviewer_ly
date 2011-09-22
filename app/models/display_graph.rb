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
      :permission_level => "full"
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

  # determines if the user has display graph permissions of the given level
  # this needs to be seriously refactored
  def has_permission?(user, perm_level)
    perm = display_graph_permissions.where(:user_id => user.id).first
    if perm.nil?
      return false
    elsif perm_level == "show"
      if self.public? || perm.permission_level == "show" || perm.permission_level == "edit" || perm.permission_level == "edit" 
        return true
      end
    elsif perm_level == "edit"
      if perm.permission_level == "edit" || perm.permission_level == "edit" 
        return true
      end
    elsif perm_level == "full"
      if perm.permission_level == "edit" 
        return true
      end
    end
    return false
  end
end
