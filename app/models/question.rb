# -*- coding: utf-8 -*-

class Question < ActiveRecord::Base

  belongs_to :questionnaire
  has_many :reponses

  validates_presence_of :questionnaire, :message => "La question doit appartenir à un questionnaire"
  validates_presence_of :title, :message => "Question obligatoire"
  validates_numericality_of :points, :message => "Le nombre de points n'est pas un nombre..."
  validates_uniqueness_of :title
end
