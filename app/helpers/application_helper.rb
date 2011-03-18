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

   def link_to_remove_fields(name, f)  
      f.hidden_field(:_destroy) + link_to_function(name, "remove_fields(this)")  
   end 

   def link_to_add_fields(name, f, association) 
      new_object = f.object.class.reflect_on_association(association).klass.new  
      fields = f.fields_for(association, new_object, :child_index => "new_#{association}") do |builder|  
      render(association.to_s.singularize + "_fields", :f => builder)  
      end  
      link_to_function(name, "add_fields(this, \"#{association}\", \"#{escape_javascript(fields)}\")")  
   end  

end
