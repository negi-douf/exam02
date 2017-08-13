module PicturesHelper
  def choose_new_or_edit
    if action_name == "edit"
      picture_path
    end
  end
end
