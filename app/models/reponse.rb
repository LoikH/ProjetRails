# -*- coding: utf-8 -*-
class Reponse < ActiveRecord::Base
  belongs_to :question
  
  attr_accessor :rep
  attr_accessible :rep, :title

  validates_presence_of :question, :message => "La réponse doit appartenir à une question"
  validates_presence_of :title, :message => "Réponse obligatoire"
end
