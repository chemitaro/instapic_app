class PicturesController < ApplicationController
  def index
    @pictures = Picture.all
    @users = User.select(:id, :name, :image)
  end
  def new
    @picture = Picture.new
  end
  def create
    @picture = Picture.new(picture_params)
    @picture.user_id = current_user.id
    if @picture.save
      redirect_to pictures_path, notice: "写真を投稿しました"
    else
      render :new
    end
  end
  def confirm
    @picture = Picture.new(picture_params)
    @picture.user_id = current_user.id
    binding.irb
  end
  
  def show
    @picture = Picture.find(params[:id]) 
    @users = User.select(:id, :name, :image)
  end
  def edit
    @picture = Picture.find(params[:id])
  end
  def update
    @picture = Picture.find(params[:id])
    if @picture.update(picture_params)
      redirect_to pictures_path, notice: "投稿を修正しました"
    else
      render :edit
    end
  end
  def destroy
    @picture = Picture.find(params[:id])
    if @picture.destroy
      redirect_to pictures_path, notice: "投稿を削除しました"
    else
      render :index
    end
  end
  private
  def picture_params
    params.require(:picture).permit(:title, :content, :content_picture, :content_picture_cache)
  end
end
