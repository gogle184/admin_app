class User < ApplicationRecord
  before_create :initialize_profile
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  def initialize_profile
   self.profile = { "email": self.email, "name": self.name, "old": self.old }
  end
end
