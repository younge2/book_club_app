class Topic < ActiveRecord::Base
  belongs_to :book
  belongs_to :club
end
