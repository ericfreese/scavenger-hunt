class Vote < ActiveRecord::Base
  attr_accessible :points, :active, :user_id

  belongs_to :submission
  belongs_to :user
end
