require 'bcrypt'
require 'debugger'

class User < ActiveRecord::Base
  has_many :urls
  
  include BCrypt

  validates :email, :uniqueness => true
  validates :email, :presence => true
  validates :password, :presence => true
  validates :password, :length => {:minimum => 6 }
  before_create :encrypt


  def self.authenticate(params)
    user = User.find_by_email(params[:email])
    db_pass = Password.new(user.password)
    db_pass == params[:password]
  end

  def encrypt
    @password = Password.create(self.password)
    self.password = @password
  end
end
