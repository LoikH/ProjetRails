module ApplicationHelper
    def signin_link
        user = session[:user]
        if user.nil? then
            return link_to("Se connecter", signin_path)
        else
            link = "Bonjour, #{user.name} !"
            link << "#{link_to 'Se deconnecter', signout_path, :method => :delete}"
            return link.html_safe
        end
    end
end
