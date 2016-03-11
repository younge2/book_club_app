class Topic < ActiveRecord::Base
  belongs_to :book
  belongs_to :club
  has_many :comments
end
