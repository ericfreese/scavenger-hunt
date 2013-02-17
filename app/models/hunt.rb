class Hunt < ActiveRecord::Base
  attr_accessible :name

  has_many :clues

  has_many :hunt_participants
  has_many :users, :through => :hunt_participants

  validates_presence_of :name

  def judges
    User.joins(:hunt_participants).where(:hunt_participants => { :is_judge => true, :hunt_id => self.id })
  end

  def players
    User.joins(:hunt_participants).where(:hunt_participants => { :is_judge => false, :hunt_id => self.id })
  end

end
