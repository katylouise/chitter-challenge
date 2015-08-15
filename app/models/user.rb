require 'bcrypt'
require 'data_mapper'

class User
  include DataMapper::Resource

  attr_reader :password
  attr_accessor :password_confirmation

  property :id, Serial
  property :name, String
  property :email, String, required: true
  property :password_digest, Text
  property :username, String, required: true

  validates_confirmation_of :password
  validates_uniqueness_of :email, :username

  def password=(password)
    @password = password
    self.password_digest = BCrypt::Password.create(password)
  end
end