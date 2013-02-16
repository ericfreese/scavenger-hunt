class Hunt < ActiveRecord::Base
  attr_accessible :name

  has_many :clues
  belongs_to :user

  validates_presence_of :name
end
