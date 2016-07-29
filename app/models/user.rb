require 'bcrypt'
class User
  include DataMapper::Resource

  property :id, Serial
  property :email, String
  property :password_encrypted, String, length: 60



  def password=(new_password)
    self.password_encrypted = BCrypt::Password.create(new_password)
  end
end
