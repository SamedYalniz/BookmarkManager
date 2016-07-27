require 'bcrypt'
require 'dm-validations'

class User
  include BCrypt
  include DataMapper::Resource

  property :id, Serial
  property :e_mail, String
  property :password_digest, String, length: 60
  
  attr_reader :password
  attr_accessor :password_confirmation

  validates_confirmation_of :password

  def password=(my_password)
    @password = my_password
    self.password_digest = BCrypt::Password.create(my_password)
  end
end