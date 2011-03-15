# -*- coding: utf-8 -*-
class Category < ActiveRecord::Base
  validates_presence_of :name, :popularity, :message => "Nom obligatoire"
  validates_numericality_of :popularity
  validates_uniqueness_of :name
  has_many :questionnaires
end
