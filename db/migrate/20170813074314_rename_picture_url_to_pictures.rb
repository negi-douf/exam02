class RenamePictureUrlToPictures < ActiveRecord::Migration
  def change
    rename_column :pictures, :picture_url, :image
  end
end
