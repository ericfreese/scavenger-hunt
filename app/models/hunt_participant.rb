class HuntParticipant < ActiveRecord::Base
  attr_accessible :user, :hunt, :status

  as_enum :status,
    :invited => 1,
    :requested => 2,
    :player => 3,
    :judge => 4

  belongs_to :hunt
  belongs_to :user
end