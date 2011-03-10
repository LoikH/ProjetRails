# -*- coding: utf-8 -*-


class SessionsController < ApplicationController
  def new
    @title = "Connexion"
  end

  def create
    data = params[:session]
    user = User.authenticate(data[:name], data[:password])
    if user.nil? then
      flash[:error] = "Mot de passe ou login invalide !"
      redirect_to signin_path
    else
      session[:user] = user
      redirect_to root_path
    end

  end

  def destroy
    #signout
    session.delete :user
    flash[:notice] = "Vous avez ete deconnecté !"
    redirect_to root_path
  end

end
