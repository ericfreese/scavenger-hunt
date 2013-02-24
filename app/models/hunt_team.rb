class HuntTeam < ActiveRecord::Base
  attr_accessible :name, :hunt

  belongs_to :hunt
  has_many :hunt_participants
  has_many :users, :through => :hunt_participants

  validates_presence_of :name

  # Each team must have a unique name
  validates_uniqueness_of :name, :scope => :hunt_id, :case_sensitive => false
end