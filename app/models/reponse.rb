class Reponse < ActiveRecord::Base
  validates_presence_of :title, :message => "Réponse obligatoire"
end
