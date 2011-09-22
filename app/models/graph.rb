class Graph < ActiveRecord::Base
  has_many :nodes

  after_save :process_raw_input

  validates_presence_of :name, :raw_input

  def process_raw_input
    puts "This should convert the raw input into the database's data structures"
  end
end
