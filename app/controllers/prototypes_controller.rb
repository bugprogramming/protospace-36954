class PrototypesController < ApplicationController

  before_action :authenticate_user!, only: [:new, :create, :edit, :destroy]
  before_action :move_to_index, except: [:index, :show]
  def index
    @prototype = Prototype.all
  end

  def show
    @prototype = Prototype.find(params[:id])
    @comment = Comment.new
    @comments = @prototype.comments.includes(:user)
  end

  def edit
    @prototype = Prototype.find(params[:id])
  end

  def new
    @prototype = Prototype.new
  end

  def destroy
  end


  def create
    #binding.pry
    @prototype = Prototype.new(prototype_params)
    #@prototype.save
    if @prototype.save
      redirect_to prototypes_path
    else
      render :index
    end
  end

  def update
    @prototype = Prototype.find(params[:id])
    if @prototype.update(prototype_params)
      redirect_to prototypes_path(@prototype)
    else
      render :edit
    end
  end


  def destroy
    @prototype = Prototype.find(params[:id])
    if @prototype.destroy
      redirect_to prototypes_path
    else
      render:edit
    end
  end

  private
  def prototype_params
    params.require(:prototype).permit(:title, :catch_copy, :concept, :image).merge(user_id: current_user.id)
  end

  def move_to_index
    unless user_signed_in?
      redirect_to action: :index
    end
  end
end
