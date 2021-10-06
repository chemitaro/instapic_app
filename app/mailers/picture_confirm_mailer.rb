class PictureConfirmMailer < ApplicationMailer
  def confirm_mail(confirm, user)
    @confirm = confirm
    @user = user
    mail to: user.email, subject: "投稿の確認" 
  end
  
end
