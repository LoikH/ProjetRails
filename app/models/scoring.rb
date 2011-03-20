class Scoring < ActiveRecord::Base
  belongs_to :user
  belongs_to :category
  attr_accessible :score
end
