class Team < ActiveRecord::Base
  belongs_to :hunt
  attr_accessible :name
end
