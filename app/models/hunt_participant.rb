class HuntParticipant < ActiveRecord::Base
  attr_accessible :user, :hunt, :status

  as_enum :status,
    :player => 1,
    :judge => 2

  belongs_to :hunt
  belongs_to :user

  # A user can only participate in a hunt once
  validates_uniqueness_of :user_id, :scope => :hunt_id
end