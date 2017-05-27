class HomeController < ApplicationController
  def index
  	@last_articles ||= []
  	@categories = Category.all
  	@categories.each do |category|
  		@articles = category.articles
  		@last_articles.push(@articles.last)
  	end
  end
end
