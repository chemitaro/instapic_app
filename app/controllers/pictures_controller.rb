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
    if params[:back]
      render :new
    else
      if @picture.save
        PictureConfirmMailer.confirm_mail(@picture, User.find(current_user.id)).deliver
        redirect_to pictures_path, notice: "写真を投稿しました"
      else
        render :new
      end
    end
  end
  def confirm
    @picture = Picture.new(picture_params)
    @picture.user_id = current_user.id
  end
  def show
    @picture = Picture.find(params[:id]) 
    @users = User.select(:id, :name, :image)
    @favorite = current_user.favorites.find_by(picture_id: @picture.id)
  end
  def edit
    @picture = Picture.find(params[:id])
    redirect_to pictures_path, notice: "権限がありません" unless @picture.user_id == current_user.id
  end
  def update
    @picture = Picture.find(params[:id])
    if  @picture.user_id == current_user.id
      if @picture.update(picture_params)
        redirect_to pictures_path, notice: "投稿を修正しました"
      else
        render :edit
      end
    else
      redirect_to pictures_path, notice: "権限がありません"
    end
  end
  def destroy
    @picture = Picture.find(params[:id])
    if @picture.user_id == current_user.id
      if @picture.destroy
        redirect_to pictures_path, notice: "投稿を削除しました"
      else
        redirect_to pictures_path
      end
    else
      redirect_to pictures_path, notice: "権限がありません"
    end
  end
  private
  def picture_params
    params.require(:picture).permit(:title, :content, :content_picture, :content_picture_cache)
  end
end
