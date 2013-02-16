class Clue < ActiveRecord::Base
  attr_accessible :description, :name

  belongs_to :hunt

  validates_presence_of :name, :description
end
