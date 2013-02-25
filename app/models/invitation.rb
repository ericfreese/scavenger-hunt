class Invitation < ActiveRecord::Base
  attr_accessible :created_at, :canceled_at, :user, :hunt, :status

  as_enum :status,
    :invited => 1,
    :canceled => 2,
    :declined => 3,
    :accepted => 4

  belongs_to :hunt
  belongs_to :user
  # belongs_to :created_by, :class_name => "User", :foreign_key => "owner_id"

  scope :status_invited, where(:status_cd => self.invited)
  scope :status_canceled, where(:status_cd => self.canceled)
  scope :status_accepted, where(:status_cd => self.accepted)

  # A user can only have one active hunt invitation at a time
  validates_uniqueness_of :user_id, :scope => [ :hunt_id, :status_cd ], :if => :invited?

  validate :must_not_be_participant

  protected
    def must_not_be_participant
      if invited? && hunt.hunt_participants.any? { |hp| hp.user_id == user.id }
        errors.add(:base, 'User is already a participant.')
      end
    end
end
