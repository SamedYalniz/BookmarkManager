require 'bcrypt'
require 'dm-validations'

class User

  include DataMapper::Resource
  include BCrypt

  property :id, Serial
  property :first_name, String, required: true
  property :last_name, String
  property :email, String, format: :email_address, required: true
  property :password_digest, String, length: 60

  attr_accessor :password_confirmation
  attr_reader :password

  validates_confirmation_of :password

  def password=(password)
    @password = password
    self.password_digest = BCrypt::Password.create(password)
  end

end
