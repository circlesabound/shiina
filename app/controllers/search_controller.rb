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
    $key = $test.split.delete_if{|x| @stopwords.include?(x.downcase) || @special.include?(x) }.join(' ')
    @keywords = $key.split

    @keyword = Weighting.all
    $test = @keyword.inspect
  end
end
