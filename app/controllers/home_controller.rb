class HomeController < ApplicationController
  def welcome
    @latest_thoughts = Thought.all.order(:created_at).limit(5)
  end

  def about
  end
end
