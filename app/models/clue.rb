class Clue < ActiveRecord::Base
  attr_accessible :description, :name, :point_value

  belongs_to :hunt

  validates_presence_of :name, :description, :point_value
end
