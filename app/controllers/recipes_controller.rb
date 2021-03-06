class RecipesController < ApplicationController


  def index
    recipe = Recipe.all
    render json: recipe.to_json(
      {:except => [:created_at, :updated_at], :include => [:ingredients, :reviews, :users]})
  end

  def show
    recipe = Recipe.find(params[:id])
    render json: recipe.to_json(
      {:except => [:created_at, :updated_at], :include => [:ingredients, :reviews, :users]})
  end

  def create
    recipe = Recipe.create(title: params[:title], cook_time: params[:cookTime], instructions: params[:instructions], picture: params[:picture], gluten_free: params[:gluten], vegetarian: params[:vegetarian], dairy_free: params[:dairy], vegan: params[:vegan])
    recipe.ingredient_ids = params[:ingredients].map {|ing| ing[:id]}
    render json: recipe
  end

  def recipe_ingredient
    recipe_ingredient = RecipeIngredients.create(ingredient_id: params[:ingredient_id] , recipe_id: params[:recipe_id])
    render json: recipe_ingredient.ingredient
  end

  def favorite
    favorite_recipe = Favorite.find_or_create_by(user_id: params[:user_id], recipe_id: params[:recipe_id])
    render json: favorite_recipe.recipe
  end

  def destroy
    user_id = params[:user_id]
    recipe_id = params[:recipe_id]
    favRecipe = Favorite.find_by(:user_id => user_id, :recipe_id => recipe_id)
    favRecipe.destroy
  end
end
