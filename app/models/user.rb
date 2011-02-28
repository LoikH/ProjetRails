require 'digest'


class User < ActiveRecord::Base
	attr_accessor :password
	attr_accessible :name, :email, :password, :password_confirmation


	validates_presence_of :name
	validates_length_of :name, :within => 2..30 
	validates_uniqueness_of :name, :case_sensitive => false


	validates_presence_of :email
	validates_format_of :email, :with => /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
	validates_uniqueness_of :email, :case_sensitive => false

	validates_confirmation_of :password

	before_save :encode_password

	def encode_password
		self.salt = encode("#{Time.now.utc}:#{password}") if new_record?
		self.secure_password = encode("#{salt}:#{password}")
	end

	def encode(string)
		return Digest::SHA2.hexdigest(string)
	end

	def password_ok?(password)
		return (secure_password = encode("#{salt}:#{password}"))
	end

	def self.authenticate(name, password)
		user = User.find_by_name(name)
		return nil if user.nil?
		return user if user.password_ok?(password)
	end


end
