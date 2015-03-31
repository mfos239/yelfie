namespace :yelfie do
  task :run_update => :environment do

    y = Yelper.find(1)
    y.run_update

  end

end
