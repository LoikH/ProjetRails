# -*- coding: utf-8 -*-


class Questionnaire < ActiveRecord::Base

  belongs_to :category
  has_many :questions
  
  validates_presence_of :category, :message => "Le questionnaire doit appartenir à une catégorie"
  validates_presence_of :title, :message => "Titre obligatoire"
  validates_presence_of :difficulty, :popularity, :cost, :point, :message => "Difficulté obligatoire"
  validates_numericality_of :popularity, :cost, :point
  validates_numericality_of :difficulty, :greater_than_or_equal_to => 0, :less_than => 5, :message => "La difficulté doit être comprise entre 0 et 4 compris"
end
