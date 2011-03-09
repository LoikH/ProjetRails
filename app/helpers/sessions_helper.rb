# -*- coding: utf-8 -*-


module SessionsHelper

  def signout
    session.delete :user
    flash[:notice] = "Vous avez été déconnecté !"
  end

  def session_admin?
    if session[:user] then
      return session[:user].admin
    else
      return false
    end
  end

end
