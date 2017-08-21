class PicturesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_picture, only: [:edit, :update, :destroy]
  before_action :set_errors, only: [:new, :edit]

  # エラーメッセージを格納するグローバル変数
  $errors = []

  def index
    @pictures = Picture.all.sort.reverse
  end

  def new
    @picture = Picture.new
  end

  def create
    @picture = Picture.new(pictures_params)
    @picture.user_id = current_user.id
    if @picture.save
      flash[:success] = "Picture を投稿しました！"
      redirect_to pictures_index_path
      NoticeMailer.sendmail_picture.deliver_now
    else
      flash[:danger] = "Picture の投稿に失敗しました"
      $errors = @picture.errors.full_messages
      set_errors
      render new_picture_path
    end
  end

  def edit
  end

  def update
    if @picture.update(pictures_params)
      flash[:success] = "Picture を編集しました！"
      redirect_to pictures_index_path
    else
      flash[:danger] = "Picture の編集に失敗しました"
      $errors = @picture.errors.full_messages
      redirect_to edit_picture_path(@picture.id)
    end
  end

  def destroy
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

  # id から picture を特定する
  def set_picture
    @picture = Picture.find_by(id: params[:id])
  end
end
