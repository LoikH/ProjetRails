# -*- coding: utf-8 -*-


class UsersController < ApplicationController

  before_filter :get_auth_edit, :only => [:edit]
  before_filter :get_auth_destroy, :only => [:destroy]

  def get_auth_edit
    #get_user_session
    user = session[:user]
    
    if user.nil? then
      flash[:error] = "Connexion requise pour continuer !"
      redirect_to signin_path
      return 
    end
      if user.id.to_i() != params[:id].to_i() then
	flash[:error] = "Ce n'est pas votre profil !"
	redirect_to users_path
	return
      end
  end

  def get_auth_destroy
    #get_user_session
    user = session[:user]
    
    if user.nil? then
      flash[:error] = "Connexion requise pour continuer !"
      redirect_to signin_path
      return 
    end
    if not session_admin?
      if user.id.to_i() != params[:id].to_i() then
	flash[:error] = "Ce n'est pas votre profil !"
	redirect_to users_path
	return
      end
    end
  end


  # GET /users
  # GET /users.xml
  def index
    @users = User.all
	@title = "Liste des utilisateurs"

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @users }
    end
  end

  # GET /users/1
  # GET /users/1.xml
  def show
    @user = User.find(params[:id])
	@title = @user.name

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @user }
    end
  end

  # GET /users/new
  # GET /users/new.xml
  def new
    @user = User.new
	@title = "Nouvel utilisateur"

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @user }
    end
  end

  # GET /users/1/edit
  def edit
    @user = User.find(params[:id])
	@title = "Editer le profil de #{@user.name}"
  end

  # POST /users
  # POST /users.xml
  def create
    @user = User.new(params[:user])
    @user.score = 0
    if User.count == 0
      @user.admin = true
    else
      @user.admin = false
    end

    if params[:user][:admin]=="1" then
      @user.admin = true
    end
    if params[:user][:admin]=="0" then
      @user.admin = false
    end


    respond_to do |format|
      if @user.save
        format.html { redirect_to(@user, :notice => "L'utilisateur a été créé avec succès !") }
        format.xml  { render :xml => @user, :status => :created, :location => @user }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @user.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /users/1
  # PUT /users/1.xml
  def update
    @user = User.find(params[:id])

    respond_to do |format|
      if @user.update_attributes(params[:user])
        format.html { redirect_to(@user, :notice => "L'utilisateur a été mis à jour avec succès !") }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @user.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /users/1
  # DELETE /users/1.xml
  def destroy
    @user = User.find(params[:id])
    @user.destroy
    #signout

    respond_to do |format|
      format.html { redirect_to(users_url) }
      format.xml  { head :ok }
    end
  end
end
