class FavoritesController < ApplicationController
  def create
    favorite = current_user.favorites.create(picture_id: params[:picture_id])
    redirect_to pictures_path, notice: "#{favorite.picture.user.name}さんの投稿をお気に入りに登録しました"
  end
  def destroy
    favorite = current_user.favorites.find_by(id: params[:id]).destroy
    redirect_to pictures_path, notice: "#{favorite.picture.user.name}さんの投稿をお気に入りから削除しました"
  end
  def show
    @favorite_pictures = Picture.where(id: Favorite.where(user_id: params[:id]).select(:picture_id))
    @users = User.select(:id, :name, :image)
  end  
end
