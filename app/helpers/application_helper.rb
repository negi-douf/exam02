module ApplicationHelper
  def profile_img(picture)
    return image_tag(picture.image) if picture.image?

    unless picture.image.blank?
      img_url = picture.image
    else
      img_url = 'no_image.png'
    end
    image_tag(img_url)
  end
end
