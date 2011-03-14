# -*- coding: utf-8 -*-
class QuestionsController < ApplicationController

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
    @questions = Question.all
    @title= "Liste des questions"
  end

  def show
    @question = Question.find(params[:id])
	@title = "Question n°" + @question.id.to_s()
  end

  def new
    @question = Question.new
    if params[:quizz] 
      @questionnaire = Questionnaire.find(params[:quizz])
    end
    @title = "Nouvelle question"
  end

  def edit
    @question = Question.find(params[:id])
    @title = "Editer une question"
  end

  def create
    @questionnaire = Questionnaire.find(params[:question][:questionnaire_id])
    @question = @questionnaire.questions.new
    
    @question.title = params[:question][:title]
    @question.points = params[:question][:points]

    respond_to do |format|
      if @question.save
        format.html { redirect_to(@question, :notice => 'La question a été ajoutée avec succès.') }
        format.xml  { render :xml => @question, :status => :created, :location => @question }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @question.errors, :status => :unprocessable_entity }
      end
    end
  end

  def update
    @question = Question.find(params[:id])

    respond_to do |format|
      if @question.update_attributes(params[:question])
        format.html { redirect_to(@question, :notice => 'La question a été mise à jour avec succès.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @question.errors, :status => :unprocessable_entity }
      end
    end
  end

   def destroy
    @question = Question.find(params[:id])
    if @question.nil? then
      flash.now[:error] = "Cette question n'existe pas"
      redirect_to questions_path
      return
    end

    @question.destroy

    respond_to do |format|
      format.html { redirect_to(questions_url) }
      format.xml  { head :ok }
    end
  end

end
