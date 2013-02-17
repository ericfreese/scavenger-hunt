class Hunt < ActiveRecord::Base
  attr_accessible :name

  has_many :clues

  has_many :hunt_participants
  has_many :users, :through => :hunt_participants

  validates_presence_of :name
end
