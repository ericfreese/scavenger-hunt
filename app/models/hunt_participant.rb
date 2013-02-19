class HuntParticipant < ActiveRecord::Base
  attr_accessible :user, :hunt, :is_judge

  belongs_to :hunt
  belongs_to :user
end