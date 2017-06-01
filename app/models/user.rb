class User < ApplicationRecord
  devise :database_authenticatable, :rememberable,
         :trackable, :validatable, :omniauthable

  has_many :notes

  validates :provider, presence: true
  validates :uid, presence: true

  def self.from_omniauth(auth)
    where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
      user.provider = auth.provider
      user.uid = auth.uid
      user.email = auth.info.email
      user.password = Devise.friendly_token[0, 20]
      user.remember_me = true
    end
  end
end
