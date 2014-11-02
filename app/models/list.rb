class List < ActiveRecord::Base
	has_many :notes
	has_many :listusers
	has_many :users, :through => :listusers
end
