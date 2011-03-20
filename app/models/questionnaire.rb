# -*- coding: utf-8 -*-


class Questionnaire < ActiveRecord::Base

  has_and_belongs_to_many :users
  belongs_to :category
  has_many :questions, :dependent => :destroy
  accepts_nested_attributes_for :questions, :reject_if => lambda { |a| a[:title].blank? }, :allow_destroy => true
  
  validates_presence_of :category, :message => "Le questionnaire doit appartenir à une catégorie"
  validates_presence_of :title, :message => "Titre obligatoire"
  validates_presence_of :popularity, :point
  validates_presence_of :difficulty, :message => "Difficulté obligatoire"
  validates_presence_of :cost, :message => "Coût obligatoire"
  validates_numericality_of :popularity, :point
  validates_numericality_of :cost, :message => "Le coût n'est pas un nombre..."
  validates_numericality_of :difficulty, :greater_than_or_equal_to => 0, :less_than => 5, :message => "La difficulté doit être comprise entre 0 et 4 compris"

  def evaluate
    points = 0
    for question in questions do
      points = points + question.evaluate
    end
    return points
  end


end
