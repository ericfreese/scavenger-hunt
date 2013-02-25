class Clue < ActiveRecord::Base
  attr_accessible :description, :name, :point_value, :hunt

  belongs_to :hunt
  
  has_many :submissions

  validates_presence_of :name, :description, :point_value
end
