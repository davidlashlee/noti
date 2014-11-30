class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
  :recoverable, :rememberable, :trackable, :validatable
  devise :omniauthable, :omniauth_providers => [:facebook, :twitter]

  has_many :list_users
  has_many :lists, through: :list_users
  accepts_nested_attributes_for :lists

  after_create :seed_list

  def seed_list
  	list_name = %w(Journal Movies\ to\ Watch Music\ to\ Listen Deleted)
    list_name.each_with_index do |list_instance, list_index|
      temp =  List.new
     temp.name = list_instance
     if temp.save == false
      return puts "error saving, check app/models/user.rb, seed_list method"
    else
      @user = User.last 
     @user.lists << temp
     @user.save
    end
  end
end

def self.from_omniauth(auth)
 where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
  user.email = auth.info.email
  user.password = Devise.friendly_token[0,20]
			user.name = auth.info.name   # assuming the user model has a name
			user.image = auth.info.image # assuming the user model has an image
		end
	end

	def self.new_with_session(params, session)
		super.tap do |user|
			if data = session["devise.facebook_data"] && session["devise.facebook_data"]["extra"]["raw_info"]
				user.email = data["email"] if user.email.blank?
			end
		end
	end



end
