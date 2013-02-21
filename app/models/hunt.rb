class Hunt < ActiveRecord::Base
  attr_accessible :name, :hunt_participants_attributes, :is_live

  has_many :clues

  has_many :hunt_participants
  has_many :users, :through => :hunt_participants

  validates_presence_of :name

  validate :must_have_judge

  accepts_nested_attributes_for :hunt_participants

  def judges
    User.joins(:hunt_participants).where(:hunt_participants => { :is_judge => true, :hunt_id => self.id })
  end

  def players
    User.joins(:hunt_participants).where(:hunt_participants => { :is_judge => false, :hunt_id => self.id })
  end

  protected
    def must_have_judge
      if !hunt_participants.any? { |hp| hp.is_judge }
        errors.add(:base, 'Hunt must have at least one judge')
      end
    end

end
