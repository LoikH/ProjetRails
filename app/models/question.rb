class Question < ActiveRecord::Base
  validates_presence_of :title, :message => "Question obligatoire"
  validates_numericality_of :points, :message => "Le nombre de points n'est pas un nombre..."
  validates_uniqueness_of :title
end