class HuntParticipant < ActiveRecord::Base
  attr_accessible :user, :is_judge

  belongs_to :hunt
  belongs_to :user
end