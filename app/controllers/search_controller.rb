class SearchController < ApplicationController
  def search
    @special = ["(",")","@","#","^"]
    route = File.join(Rails.root, 'app', 'assets', 'other', 'stopwords');
    @stopwords = []
    File.open(route) do |file|
      file.lines.each do |line|
        @stopwords << line.chomp
      end
    end

    $test = params[:q];
    $key = $test.split.delete_if { |x|
      @stopwords.include?(x.downcase) || @special.include?(x)
    }.join(' ')
    @keywords = $key.split

    @weightings = Hash.new(0)
    @keyword_ids = Array.new()
    @keywords.each do |keyword|
      keyword_obj = Keyword.where(word: keyword).take
      # words without skills attached are ignored
      if keyword_obj.nil?
        next
      end
      @keyword_ids << keyword_obj["id"]
      @keyword_ids.each do |keyword_id|
        Weighting.where(keyword_id: keyword_id).find_each do |weighting|
          skill_name = Skill.where(id: weighting["skill_id"]).take["skill"]
          # apply exponential scale to raw weightings
          scaled_weighting = 2 ** weighting["raw_weighting"].to_i
          @weightings[skill_name] += scaled_weighting
          # if key already existed beforehand, we have double match
          # increase weighting by 1.3x
          if @weightings[skill_name] != scaled_weighting
            @weightings[skill_name] *= 1.3
            @weightings[skill_name] = @weightings[skill_name].round
          end
        end
      end
    end

    # display the 7 most highly ranked skills
    @results = @weightings.sort_by { |key, value|
      value
    }.reverse[0..6].map { |arr| arr[0] }
  end
end
