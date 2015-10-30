class WelcomeController < ApplicationController

  def index
    respond_to do |format|
      format.html
      format.js
    end
  end
  def search
    respond_to do |format|
        format.html
        format.js { render :layout=>false }
        format.json { render json;  @search }
    end
  end

  def show_results
  end
end
