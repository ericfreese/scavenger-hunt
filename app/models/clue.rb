class Clue < ActiveRecord::Base
  attr_accessible :description, :name, :point_value, :hunt, :type

  as_enum :type,
    :standard => 1, # Award points based on whether any submissions match criteria.
    :competition => 2 # Only one team can get the points for it. Judges vote for the winner.

  belongs_to :hunt

  has_many :submissions

  validates_presence_of :name, :description, :point_value
end
