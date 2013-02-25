class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :invitable, :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :omniauthable

  has_many :hunt_participants
  has_many :hunts, :through => :hunt_participants do
    def judging
      where(:hunt_participants => { :status_cd => HuntParticipant.judge })
    end

    def playing
      where(:hunt_participants => { :status_cd => HuntParticipant.player })
    end
  end

  has_many :invitations
  has_many :teams
  has_many :submissions

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation,
                  :remember_me, :name, :uid, :provider,
                  :image

  validates_presence_of :email, :name

  def self.find_for_facebook_oauth(auth, signed_in_resource = nil)
    user = User.where(:provider => auth.provider, :uid => auth.uid).first
    user ||= User.create(
      :name => auth.info.name,
      :provider => auth.provider,
      :uid => auth.uid,
      :email => auth.info.email,
      :image => auth.info.image,
      :password => Devise.friendly_token[0,20]
    )
  end

  def self.new_with_session(params, session)
    super.tap do |user|
      if data = session["devise.facebook_data"] && session["devise.facebook_data"]["extra"]["raw_info"]
        user.email = data["email"] if user.email.blank?
      end
    end
  end

end
