class User < ActiveRecord::Base
  #has_and_belongs_to_many :books
  has_and_belongs_to_many :clubs
  has_many :bookstates

  validates :name,
  presence: true

  validates :email,
  presence: true,
  uniqueness: {case_sensitive: false},
  email: true

  validates :password,
  length: {:minimum => 6, :maximum => 50}
  
  validates_confirmation_of :password, unless: :provider?
  validates_presence_of :password, on: :create, unless: :provider?

  has_secure_password validations: false

  def provider?
    self.provider
  end

  def self.authenticate email, password
    User.find_by_email(email).try(:authenticate, password)
  end
end
