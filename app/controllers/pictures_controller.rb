class PicturesController < ApplicationController

  # エラーメッセージを格納するグローバル変数
  $errors = []

  def index
    @pictures = Picture.all.sort.reverse
  end

  def new
    @picture = Picture.new

    # エラーメッセージがある場合は
    # その内容を渡す
    unless $errors.empty?
      @errors = $errors
      $errors = []
    end
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


  protected

  def pictures_params
    # picture_cache も必要？
    params.require(:picture).permit(:image, :description, :image_cache)
  end
end
