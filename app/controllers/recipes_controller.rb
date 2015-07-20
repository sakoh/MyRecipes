class RecipesController < ApplicationController
  before_action :set_recipe, only: [:show, :edit, :update, :like]
  
  def index
    @recipes = Recipe.all.sort_by{|likes| likes.thumbs_up_total}.reverse
  end
  
  def show
  end
  
  def new
    @recipe = Recipe.new
  end
  
  def create
    @recipe = Recipe.new(recipe_params)
    @recipe.chef = Chef.first
    
    if @recipe.save
      flash[:success] = "New Recipe created"
      redirect_to recipes_path
    else
      render :new
    end
  end
  
  def edit
  end
  
  def update
    if @recipe.update(recipe_params)
      flash[:success] = "Recipe successfully updated"
      redirect_to recipe_path(@recipe)      
    else
      render :edit
    end
  end
  
  def like
    like = Like.create(liked: params[:liked], chef: Chef.first, recipe: @recipe)
    
    if like.valid?
      flash[:success] = "Your selection was successful"
      redirect_to :back
    else
      flash[:danger] = "You can only like a recipe once"
      redirect_to :back
    end
    
  end

  private
    def set_recipe
      @recipe = Recipe.find(params[:id])
    end
  
    def recipe_params
      params.require(:recipe).permit(:name, :summary, :description, :picture)
    end
end