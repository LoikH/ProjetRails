# -*- coding: utf-8 -*-
class Category < ActiveRecord::Base
  validates_presence_of :name, :popularity, :nb_mcq
  validates_numericality_of :popularity, :nb_mcq
  validates_uniqueness_of :name
  validates_format_of :name, :with => /\A[A-Z]+[a-z]*\z/, :message => "Le nom doit seulement contenir des lettres et commencer par une majuscule"
end
