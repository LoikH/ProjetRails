class CategoriesController < ApplicationController

  def index
    @categories = Category.all
	@title= "Liste des catégories"
  end

  def top10
    @categories = Category.order(:popularity).limit(10)
  end

  def show
    @category = Category.find(params[:id])
  end

  def new
    @category = Category.new
	@title = "Nouvelle catégorie"
  end

  def edit
    @category = Category.find(params[:id])
  end

  def create
    @category = Category.new(params[:category])
    @category.popularity = 0
    @category.nb_mcq = 0

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
