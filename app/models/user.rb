class User < ActiveRecord::Base

  has_and_belongs_to_many :clubs
  has_many :bookstates, dependent: :destroy

  validates :name,
  presence: true

  validates :email,
  presence: true,
  uniqueness: {case_sensitive: false},
  email: true


  validates :password, unless: :provider?,
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

  def set_password_reset
    self.reset_code = loop do 
      code = SecureRandom.urlsafe_base64
      break code unless User.exists?(reset_code: code)
    end
    self.expires_at = 4.hours.from_now
    self.save!
  end
end
