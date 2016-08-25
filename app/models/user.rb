class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  devise :omniauthable, :omniauth_providers => [:facebook, :twitter]

  validates :email, presence: true


  def self.from_omniauth(auth)
    where(provider: auth.provider, uid: auth.uid).first_or_create do |user|

      if auth.provider == "twitter"
        user.email = auth.info.description
      else
        user.email = auth.info.email
      end

      user.password = Devise.friendly_token[0,20]
      user.name = auth.info.name   # assuming the user model has a name
      #user.image = auth.info.image # assuming the user model has an image
      
    end
  end

  def self.new_with_session(params, session)
    super.tap do |user|
      if data = session["devise.facebook_data"] && session["devise.facebook_data"]["extra"]["raw_info"]
        
        user.email = data["email"] if user.email.blank?

      #TODO

      elsif data = session["devise.twitter_data"] #&& session["devise.twitter_data"]["extra"]["raw_info"]
        
        user.email = data["info"]["description"] if user.email.blank?
        user.name = data["info"]["name"] if user.name.blank?
      end
    end
  end
end
