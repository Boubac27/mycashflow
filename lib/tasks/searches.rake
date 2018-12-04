namespace :searches do
  desc "Get new results from searches and notify user by email"
  task update: :environment do
    Search.all.each do |search|
      # Launch a scrap
      results = Collecteur.new(
        city: search.city,
        zipcode: search.zipcode,
        budget: search.budget
      ).collecter

      # Get only results from last 24 hours

      # Send this results to user

      # Send email with results
    end
  end
end
