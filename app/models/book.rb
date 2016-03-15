class Book < ActiveRecord::Base

  has_and_belongs_to_many :clubs
  has_many :topics
  has_many :bookstates
end
