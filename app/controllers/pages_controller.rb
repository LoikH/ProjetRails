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
    @categories = Category.order(:popularity).limit(10)
    @questionnaires = Questionnaire.order(:popularity).limit(10)
    @utilisateurs = User.order(:score).limit(10)
  end

end
