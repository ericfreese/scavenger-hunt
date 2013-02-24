class Hunt < ActiveRecord::Base
  attr_accessible :name, :hunt_participants_attributes, :is_live

  has_many :clues

  has_many :hunt_participants
  has_many :users, :through => :hunt_participants do
    def judges
      where(:hunt_participants => {
        :status_cd => HuntParticipant.judge
      })
    end

    def players
      where(:hunt_participants => {
        :status_cd => HuntParticipant.player
      })
    end
  end

  has_many :hunt_invitations

  validates_presence_of :name

  validate :must_have_judge

  accepts_nested_attributes_for :hunt_participants

  protected
    def must_have_judge
      if !hunt_participants.any? { |hp| hp.status == :judge }
        errors.add(:base, 'Hunt must have at least one judge')
      end
    end

end
