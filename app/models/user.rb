require 'bcrypt'
require 'dm-validations'

class User
  include DataMapper::Resource

  property :id, Serial
  property :email, String, required: true, format: :email_address
  property :password_encrypted, String, length: 60
  attr_accessor :password_confirmation
  attr_reader   :password

  validates_confirmation_of :password

  def password=(new_password)
    @password = new_password
    self.password_encrypted = BCrypt::Password.create(new_password)
  end
end
