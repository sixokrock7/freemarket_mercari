class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :omniauthable,
         omniauth_providers: [:facebook, :google_oauth2]

  has_many :authentications, dependent: :destroy

  validates :email, uniqueness: true
  validates :nickname, uniqueness: true
  validates :nickname, presence: true
end
