desc "Fetches data from all active Freelancer projects"
task :importall => :environment do
  puts "Importing data from Freelancer projects"
  Fetcher.new.perform
  puts "done."
end
