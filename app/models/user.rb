class User < ActiveRecord::Base
  attr_accessor :password
  
  before_save :encrypt_password
  after_save :clear_password
  
  EMAIL_REGEX = /^[A-Z0-9._%+-]+@[A-Z0-9.-]+\.[A-Z]{2,4}$/i
  validates :username, :presence => true, :uniqueness => true, :length => { :in => 5..20}
  validates :email, :presence => true, :uniqueness => true, :format => EMAIL_REGEX
  validates :password, :confirmation => true # with confirmations, checks for ATTR_confirmation
  validates_length_of :password, :in => 6..20, :on => :create
  
  attr_accessible :username, :email, :password, :password_confirmation
  
  def encrypt_password
    unless password.blank?
      self.salt = BCrypt::Engine.generate_salt
      self.hash_pass = BCrypt::Engine.hash_secret(password, salt)
    end
  end
  
  def clear_password
    self.password = nil
  end
end
