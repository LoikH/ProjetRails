# -*- coding: utf-8 -*-


class PagesController < ApplicationController
  def home
	@title = "Bienvenue !"
  end

  def contact
	@title = "Contact"
  end

  def top10
    @title = "Top 10"
    @categories = Category.order(:popularity).limit(10).reverse_order 
    @questionnaires = Questionnaire.order(:popularity).limit(10).reverse_order 
    @utilisateurs = User.order(:score).limit(10).reverse_order
  end

end
