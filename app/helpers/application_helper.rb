# -*- coding: utf-8 -*-


module ApplicationHelper
    def signin_link
        user = session[:user]
        if user.nil? then
            return link_to("Se connecter", signin_path)
        else
            link = "Bonjour, #{user.name} ! Vous êtes connecté en tant"
	    if user.admin then
	      link << " qu' administrateur."
	    else
	      link << " que joueur."
	    end
            link << " - #{link_to 'Se déconnecter', signout_path, :method => :delete}"
            return link.html_safe
        end
    end        
end
