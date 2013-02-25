class Submission < ActiveRecord::Base
  attr_accessible :upload, :user_id

  mount_uploader :upload, SubmissionUploader

  belongs_to :user
  belongs_to :clue
end
