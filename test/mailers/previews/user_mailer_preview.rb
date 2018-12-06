# Preview all emails at http://localhost:3000/rails/mailers/user_mailer
class UserMailerPreview < ActionMailer::Preview

  # Preview this email at http://localhost:3000/rails/mailers/user_mailer/welcome
  def welcome
    user = User.last
    # annonces = Favorite.all
    annonces = [{:price=>13000,
      :url=>"https://www.leboncoin.fr/vi/1520169829.htm",
      :image=>"https://img0.leboncoin.fr/ad-small/d631ee628b555d622bd32bb3864fd2d00ca52a4a.jpg",
      :rooms=>"3",
      :surface=>"55",
      :lat=>45.44536,
      :lng=>4.38411,
      :city=>"Saint-Etienne",
      :zipcode=>"",
      :publication_date=>"2018-11-08 10:42:01",
      :subject=>"F2 rez-de-jardin rue Marengo en IMMO-INTERACTIF",
      :avg_rents=>622.17770609319,
      :returns=>57.43178825475599,
      :precision=>0.017626894224452815},
     {:price=>8200,
      :url=>"https://www.leboncoin.fr/vi/1535233508.htm",
      :image=>"https://img1.leboncoin.fr/ad-small/3b69ff48a2f861bf06ed59691a0f4e85bf78f877.jpg",
      :rooms=>"2",
      :surface=>"30",
      :lat=>45.43988,
      :lng=>4.39554,
      :city=>"Saint-Etienne",
      :zipcode=>"",
      :publication_date=>"2018-12-06 14:07:49",
      :subject=>"Investissement lofts rentabilité 14%",
      :avg_rents=>267.75084579873004,
      :returns=>39.183050604692205,
      :precision=>0.044804956199067415}]
    UserMailer.welcome(user, annonces)
  end
end
