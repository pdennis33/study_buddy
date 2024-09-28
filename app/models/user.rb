class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :database_authenticatable, :registerable, :rememberable, :confirmable,
  # :recoverable, :validatable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :omniauthable, omniauth_providers: [:google_oauth2, :github]

  has_many :topics, dependent: :destroy
  has_many :flashcards, through: :topics

  def self.from_omniauth(auth)
    find_or_create_by(provider: auth.provider, uid: auth.uid) do |user|
      user.email = auth.info.email
      user.password = Devise.friendly_token[0, 20]
      user.name = auth.info.name   # assuming the user model has a name
      # If you are using confirmable and the provider(s) you use validate emails,
      # uncomment the line below to skip the confirmation emails.
      # user.skip_confirmation!
    end
  end
end
