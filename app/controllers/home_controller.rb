class HomeController < ApplicationController
  def welcome
    @latest_thoughts = Thought.all.order(created_at: :desc).limit(10)
  end

  def about
  end
end
