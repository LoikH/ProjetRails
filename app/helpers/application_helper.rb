# -*- coding: utf-8 -*-
module ApplicationHelper
    def signin_link
        user = session[:user]
        if user.nil? then
            return link_to("Se connecter", signin_path, :class => "lienmenu")
        else
          #link = "Bonjour, #{user.name} !"
          link = ""
          link << "#{link_to 'Se déconnecter', signout_path, :method => :delete, :class => "lienmenu"}"
          return link.html_safe
        end
    end
  def global_title
    base_title = "Titre"
    if @title.nil? then
      return base_title
    else
      return "#{@title}"
    end
  end
end
