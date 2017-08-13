class RenamePictureToPicture < ActiveRecord::Migration
  def change
    rename_column :pictures, :picture, :picture_url
  end
end
