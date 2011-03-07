module ApplicationHelper
    def signin_link
        user = session[:user]
        if user.nil? then
            return link_to("Se connecter", signin_path)
        else
            #link = "Bonjour, #{user.name} !"
			link = ""
            link << "#{link_to 'Se déconnecter', signout_path, :method => :delete}"
            return link.html_safe
        end
    end        
end
