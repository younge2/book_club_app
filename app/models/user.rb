class User < ActiveRecord::Base
  has_and_belongs_to_many :books
  has_and_belongs_to_many :clubs

  validates :email,
  presence: true,
  uniqueness: {case_sensitive: false}

  validates :password, presence: true, on: :create

  has_secure_password

  def self.authenticate email, password
    User.find_by_email(email).try(:authenticate, password)
  end
end

