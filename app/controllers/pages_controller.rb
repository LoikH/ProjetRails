class PagesController < ApplicationController
  def home
	@title = "Bienvenue !"
  end

  def contact
	@title = "Contact"
  end

end
