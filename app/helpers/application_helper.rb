module ApplicationHelper
  def show_image(picture)
    return image_tag(picture.image) if picture.image?

    unless picture.image.blank?
      img_url = picture.image
    else
      img_url = 'no_image.png'
    end
    image_tag(img_url)
  end

  def show_avatar(user)
    return image_tag(user.avatar, alt: user.name, :size => "50x50") unless user.avatar.blank?
    return image_tag(user.image_url, alt: user.name, :size => "50x50") if user.image_url != nil

    if ! user.image_url.blank?
      img_url = user.image_url
    elsif ! user.avatar.blank?
      img_url = user.avatar
    else
      img_url = 'no_image.png'
    end
    image_tag(img_url, alt: user.name, :size => "50x50")
  end

end
