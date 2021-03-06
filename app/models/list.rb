class List < ActiveRecord::Base
	has_many :notes
	has_many :list_users
	has_many :users, through: :list_users
	accepts_nested_attributes_for :notes
end
