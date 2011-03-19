# -*- coding: utf-8 -*-

class Question < ActiveRecord::Base

  belongs_to :questionnaire
  has_many :reponses, :dependent => :destroy
  accepts_nested_attributes_for :reponses, :reject_if => lambda { |a| a[:title].blank? }, :allow_destroy => true

  validates_presence_of :questionnaire, :message => "La question doit appartenir à un questionnaire"
  validates_presence_of :title, :message => "Question obligatoire"
  validates_numericality_of :points, :message => "Le nombre de points n'est pas un nombre..."
  validates_uniqueness_of :title

  def evaluate
    for reponse in reponses do
      if !reponse.evaluate then
	return 0
      end
    end
    return points
  end

end
