# -*- coding: utf-8 -*-
class ReponsesController < ApplicationController

  before_filter :is_admin
  
  def is_admin
    if not session_admin?
      flash[:error] = "Vous ne pouvez pas continuer, vous n'êtes pas admin !"
      redirect_to root_path
      return
    end
  end

def index
    @reponses = Reponse.all
    @title= "Liste des réponses"
  end

  def show
    @reponse = Reponse.find(params[:id])
	@title = "Réponse n°" + @reponse.id.to_s()
  end

  def new
    @reponse = Reponse.new
    if params[:quest] 
      @question = Question.find(params[:quest])
    end

	@title = "Nouvelle réponse"
  end

  def edit
    @reponse = Reponse.find(params[:id])
	@title = "Editer une réponse"
  end

  def create
    @question = Question.find(params[:reponse][:question_id])
    @reponse = @question.reponses.new
    
    @reponse.title = params[:reponse][:title]

    if params[:reponse][:correct]=="1" then
      @reponse.correct = true
    end
    if params[:reponse][:correct]=="0" then
      @reponse.correct = false
    end

    respond_to do |format|
      if @reponse.save
        format.html { redirect_to(@reponse, :notice => 'La réponse a été ajoutée avec succès.') }
        format.xml  { render :xml => @reponse, :status => :created, :location => @reponse }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @reponse.errors, :status => :unprocessable_entity }
      end
    end
  end

  def update
    @reponse = Reponse.find(params[:id])

    respond_to do |format|
      if @reponse.update_attributes(params[:reponse])
        format.html { redirect_to(@reponse, :notice => 'La réponse a été mise à jour avec succès.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @reponse.errors, :status => :unprocessable_entity }
      end
    end
  end

   def destroy
    @reponse = Reponse.find(params[:id])
    if @reponse.nil? then
      flash.now[:error] = "Cette réponse n'existe pas"
      redirect_to reponses_path
      return
    end

    @reponse.destroy

    respond_to do |format|
      format.html { redirect_to(reponses_url) }
      format.xml  { head :ok }
    end
  end

end
