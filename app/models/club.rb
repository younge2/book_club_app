class Club < ActiveRecord::Base
  has_many :topics
  has_and_belongs_to_many :books
  has_and_belongs_to_many :users
end
