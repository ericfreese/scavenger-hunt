class Vote < ActiveRecord::Base
  attr_accessible :points, :active, :user_id

  belongs_to :submission
  belongs_to :user

  validates_presence_of :points if submission.clue.competition?
end
