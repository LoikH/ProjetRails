# -*- coding: utf-8 -*-
class Category < ActiveRecord::Base
  validates_presence_of :name, :popularity, :nb_mcq, :message => "Nom obligatoire"
  validates_numericality_of :popularity, :nb_mcq
  validates_uniqueness_of :name
  has_many :questionnaires
end
