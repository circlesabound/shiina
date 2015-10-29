class Fetcher
  # fetches keyword and skill data from the Freelancer API
  include Sidekiq::Worker
  require 'net/http'
  require 'json'
  def perform (params)
    # load stopwords array
    stopwords = Array.new()
    f = File.new("app/assets/other/stopwords")
    while line = f.gets
      stopwords << line.chomp
    end
    f.close()

    urlString = "https://www.freelancer.com/api/projects/0.1/projects/active/?compact&job_details=true"

    params.each do |key, value|
      urlString << "@" << key.to_s() << "=" << value.to_s()
    end

    url = URI.parse("https://www.freelancer.com/api/projects/0.1/projects/active/?compact&job_details=true")
    http = Net::HTTP.new(url.host, url.port)
    http.use_ssl = true
    req = Net::HTTP::Get.new(url.request_uri)
    response = http.request(req)
    data = JSON.parse(response.body)
    projects = data["result"]["projects"]
    projects.each do |project|
      keywords = project["seo_url"].to_s().split(/\/|-/)
      keywords.each do |word|
        if word =~ /\D/
          word.downcase!
          if stopwords.include?(word)
            puts "Skipping stopword #{word}"
          else
            puts "Importing word #{word}"
            currentWord = Keyword.find_or_create_by(word: word)

            project["jobs"].each do |job|
              puts "Importing skill #{job['name']} for word #{word}"
              currentSkill = Skill.find_or_create_by(
                skill: job["name"],
                description: "placeholder")
              currentWeighting = Weighting.find_or_create_by(
                keyword_id: currentWord.id,
                skill_id: currentSkill.id)
              if currentWeighting.raw_weighting.nil?
                currentWeighting.raw_weighting = 1
              else
                currentWeighting.raw_weighting += 1
              end
              currentWeighting.save
            end
          end
        end
      end
    end
  end
end
