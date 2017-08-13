class PicturesController < ApplicationController

  # エラーメッセージを格納するグローバル変数
  $errors = []

  def index
    @pictures = Picture.all.sort.reverse
  end

  def new
    @picture = Picture.new
    set_errors
  end

  def create
    @picture = Picture.new(pictures_params)
    if @picture.save
      flash[:success] = "Picture を投稿しました！"
      redirect_to pictures_index_path
    else
      flash[:danger] = "Picture の投稿に失敗しました"
      $errors = @picture.errors
      redirect_to pictures_index_path
    end
  end

  def edit
    @picture = Picture.find_by(id: params[:id])
    set_errors
  end

  def update
    @picture = Picture.find_by(id: params[:id])
    if @picture.update(pictures_params)
      flash[:success] = "Picture を編集しました！"
      redirect_to pictures_index_path
    else
      flash[:danger] = "Picture の編集に失敗しました"
      redirect_to edit_picture_path
    end
  end

  def destroy
    @picture = Picture.find_by(id: params[:id])

    if @picture.destroy
      flash[:success] = "Picture を削除しました！"
      redirect_to pictures_index_path
    else
      flash[:danger] = "Picture の削除に失敗しました"
      redirect_to pictures_index_path
    end
  end



  protected

  def pictures_params
    # image_cache は投稿失敗後もファイルを保持するためのもの
    params.require(:picture).permit(:image, :description, :image_cache)
  end

  # エラーメッセージがあれば格納する
  def set_errors
    unless $errors.empty?
      @errors = $errors
      $errors = []
    end
  end
end
