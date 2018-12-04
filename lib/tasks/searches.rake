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

      new_results = results[:prices].select do |result|
      # ap result
        result[:publication_date].to_date > 1.day.ago
      end

      # UserMailer.welcome(search.user, new_results).deliver_now
      # binding.pry
      # Send this results to user

      # Send email with results
      UserMailer.welcome(search.user, new_results).deliver_now
    end
  end
end
