# -*- coding: utf-8 -*-


require 'digest'


class User < ActiveRecord::Base
  attr_accessor :password
  attr_accessible :name, :email, :score, :password, :password_confirmation, :admin

  validates_presence_of :name, :message => "Nom obligatoire"
  validates_length_of :name, :within => 2..30, :message => "Le nom doit avoir entre 2 et 30 caractères" 
  validates_uniqueness_of :name, :case_sensitive => false

  validates_presence_of :email, :message => "Email obligatoire" 
  validates_format_of :email, :with => /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i, :message => "Email incorrect"
  validates_uniqueness_of :email, :case_sensitive => false

  validates_presence_of :password, :message => "Absence de mot de passe"
  validates_confirmation_of :password, :message => "Absence de la confirmation du mot de passe"

  before_save :encode_password 

  def encode_password
    self.salt = encode("#{Time.now.utc}:#{password}") if new_record?
    self.secure_password = encode("#{salt}:#{password}") if !self.password.nil?
  end

  def encode(string)
    return Digest::SHA2.hexdigest(string)
  end

  def password_ok?(password)
    return (secure_password == encode("#{salt}:#{password}"))
  end

  def self.authenticate(name, password)
    user = User.find_by_name(name)
    return nil if user.nil?
    return user if user.password_ok?(password)
  end
end
