# -*- coding: utf-8 -*-


module ApplicationHelper
    def signin_link
        user = session[:user]
        if user.nil? then
            return link_to("Se connecter", signin_path, :class => "lienmenu")
        else
            link = "#{link_to 'Se déconnecter', signout_path, :method => :delete, :class => "lienmenu"}"
            return link.html_safe
        end
    end    

	def global_title
		base_title = "Bienvenue !"
		if @title.nil? then
			return base_title
		else 
			return "#{@title}"
		end
	end    
end
