class UserMailer < ApplicationMailer

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.user_mailer.welcome.subject
  #
  def welcome(user, annonces)
    @user = user
    @annonces = annonces
    mail to: user.email, subject: "Welcome, voici votre recap"
  end
end
