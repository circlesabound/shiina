class SearchController < ApplicationController
  def search
    @special = ["(",")","@","#","^"]
    @stopwords = ["(",")","@","#","^"]
    route = File.join(Rails.root, 'app', 'assets', 'other', 'stopwords');
    @stopwords = File.read(route)
    @arr = Array.new()
    

    @test = params[:q];
  end
end
