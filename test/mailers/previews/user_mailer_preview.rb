class UserMailerPreview < ActionMailer::Preview

  def new_user
    UserMailer.new_user(User.first).deliver_now
  end

end