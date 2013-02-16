class Hunt < ActiveRecord::Base
  attr_accessible :name

  has_many :clues

  validates_presence_of :name
end
