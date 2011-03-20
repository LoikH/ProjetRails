# -*- coding: utf-8 -*-

class QuestionnairesController < ApplicationController

before_filter :is_user, :is_admin, :only => [:new, :edit, :destroy, :show]
before_filter :is_user, :only => [:play]

  def is_user
    user = session[:user]

    if user.nil? then
      flash[:error] = "Connexion requise pour continuer !"
      redirect_to signin_path
      return
    end
  end
  
  def is_admin
    if not session_admin?
      flash[:error] = "Vous ne pouvez pas continuer, vous n'êtes pas admin !"
      redirect_to root_path
      return
    end
  end

  def index
    @questionnaires = Questionnaire.all
    @title= "Liste des questionnaires"
  end

  def show
    @questionnaire = Questionnaire.find(params[:id])
    @title = @questionnaire.title
  end

  def new
    @questionnaire = Questionnaire.new
    if params[:cat]
      @category = Category.find(params[:cat])
    end
    @title = "Nouveau questionnaire"
  end

  def edit
    @questionnaire = Questionnaire.find(params[:id])
    @title = "Editer le questionnaire #{@questionnaire.title}"
  end

  def create
    @category = Category.find(params[:questionnaire][:category_id])

    @questionnaire = @category.questionnaires.new
    @questionnaire.title = params[:questionnaire][:title]
    @questionnaire.difficulty = params[:questionnaire][:difficulty]
    @questionnaire.popularity = 0
    @questionnaire.cost = params[:questionnaire][:cost]
    @questionnaire.point = 0

    @questionnaire.save

    respond_to do |format|
      if @questionnaire.update_attributes(params[:questionnaire])
        format.html { redirect_to(@questionnaire, :notice => 'Le questionnaire a été ajouté avec succès.') }
        format.xml  { render :xml => @questionnaire, :status => :created, :location => @questionnaire }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @questionnaire.errors, :status => :unprocessable_entity }
      end
    end
  end

  def update
    @questionnaire = Questionnaire.find(params[:id])

    respond_to do |format|
      if @questionnaire.update_attributes(params[:questionnaire])
        format.html { redirect_to(@questionnaire, :notice => 'Le questionnaire a été mis à jour avec succès.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @questionnaire.errors, :status => :unprocessable_entity }
      end
    end
  end

   def destroy
    @questionnaire = Questionnaire.find(params[:id])
    if @questionnaire.nil? then
      flash.now[:error] = "Ce questionnaire n'existe pas"
      redirect_to questionnaires_path
      return
    end

    @questionnaire.destroy

    respond_to do |format|
      format.html { redirect_to(questionnaires_url) }
      format.xml  { head :ok }
    end
  end


  def nouveautes
    @title = "Liste des nouveautés"
    @nouveautes = Questionnaire.order(:created_at).limit(10).reverse_order
  end

  def play
    @questionnaire = Questionnaire.find(params[:id])
    @title = @questionnaire.title
    user = session[:user]
    if user.score < @questionnaire.cost then
      flash[:error] = "Vous n'avez pas assez de points pour jouer à ce questionnaire"
      cat = Category.find(@questionnaire.category_id)
      redirect_to cat
      return
    end
    if user.questionnaires.exists?(@questionnaire.id) then
      flash[:error] = "Vous avez déja jouer à ce questionnaire"
      cat = Category.find(@questionnaire.category_id)
      redirect_to cat
      return
    end

  end

  def validate
    @questionnaire = Questionnaire.find(params[:id])
    for question in @questionnaire.questions do
      for reponse in question.reponses do
	reponse.rep = params[:questionnaire][:question][:"#{question.id}"][:reponse][:"#{reponse.id}"][:rep]	
      end
    end
    
    @res = @questionnaire.evaluate 
    @user = session[:user]
    score = @user.score + @res
    @user.update_attribute :score, score
    
    popularity_q = @questionnaire.popularity + 1
    @questionnaire.update_attribute :popularity, popularity_q

    category = Category.find(@questionnaire.category_id)
    popularity_c = category.popularity + 1

    category.update_attribute :popularity, popularity_c
    user2 = User.find(@user.id)
    user2.questionnaires.push(@questionnaire)


  end


end
