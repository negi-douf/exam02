class Users::RegistrationsController < Devise::RegistrationsController
  # uid には unique: true 制約がある
  # SNS でログインすると値が代入されるが、
  # 通常のログインでは "" のまま
  # → 制約に反する
  # そこで、通常のログインではランダムな値を設定するようにする
  def build_resource(hash=nil)
    hash[:uid] = User.create_unique_string
    super
  end
end
