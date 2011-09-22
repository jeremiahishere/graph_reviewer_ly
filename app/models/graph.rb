class Graph < ActiveRecord::Base
  belongs_to :user
  has_many :nodes

  has_many :display_graphs

  after_save :process_raw_input

  validates_presence_of :name, :raw_input, :user_id

  def process_raw_input
    puts "This should convert the raw input into the database's data structures"
  end

  scope :by_user, lambda { |user| where(:user_id => user.id) }

  def in_use?
    self.display_graphs.count > 0
  end
end
