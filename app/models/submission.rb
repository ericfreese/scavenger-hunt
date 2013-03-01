class Submission < ActiveRecord::Base
  attr_accessible :upload, :user_id, :clue_id, :votes

  mount_uploader :upload, SubmissionUploader

  belongs_to :user
  belongs_to :clue

  has_many :votes

  def team
    user.team_for(clue.hunt)
  end

  def vote_by_user(user)
    votes.where(:user_id => user.id).first
  end
end
