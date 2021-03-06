# -*- coding: utf-8 -*-
class CategoriesController < ApplicationController

  before_filter :get_auth, :only => [:new, :edit, :destroy]

  def get_auth
    user = session[:user]
    
    if user.nil? then
      flash[:error] = "Connexion requise pour continuer !"
      redirect_to signin_path
      return 
    end
    if not session_admin?
      flash[:error] = "Vous ne pouvez pas continuer, vous n'êtes pas admin !"
      redirect_to root_path
      return
    end
  end

  def index
    @categories = Category.order(:name)
    @title= "Liste des catégories"
  end

  def show
    @category = Category.find(params[:id])
    @title = "Liste des questionnaires de #{@category.name}"
  end

  def new
    @category = Category.new
    @title = "Nouvelle catégorie"
  end

  def edit
    @category = Category.find(params[:id])
    @title = "Editer une catégorie"
  end

  def create
    @category = Category.new(params[:category])
    @category.popularity = 0

    respond_to do |format|
      if @category.save
        format.html { redirect_to(@category, :notice => 'La catégorie a été ajoutée avec succès.') }
        format.xml  { render :xml => @category, :status => :created, :location => @category }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @category.errors, :status => :unprocessable_entity }
      end
    end
  end

  def update
    @category = Category.find(params[:id])
    respond_to do |format|
      if @category.update_attributes(params[:category])
        format.html { redirect_to(@category, :notice => 'La catégorie a été mise à jour avec succès.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @category.errors, :status => :unprocessable_entity }
      end
    end
  end

   def destroy
    @category = Category.find(params[:id])
    if @category.nil? then
      flash.now[:error] = "Cette categorie n'existe pas"
      redirect_to categories_path
      return
    end

    @category.destroy

    respond_to do |format|
      format.html { redirect_to(categories_url) }
      format.xml  { head :ok }
    end
  end

end
