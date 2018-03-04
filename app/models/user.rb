class User < ActiveRecord::Base
	has_secure_password

	validates :username, presence: true
	validates :username, uniqueness: true
	validates :email, presence: true
	validates :email, uniqueness: true

	has_many :stacks
	has_many :flashcards, through: :stacks

	

	def slug
		self.username.downcase.gsub(" ", "-")
	end

	def self.find_by_slug(slug)
		User.all.find{|user| user.slug == slug}
	end

end