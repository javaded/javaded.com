class PagesController < ApplicationController
  def home
    @posts = Post.newest_first.recent(3)
    @featured_project = Project.where(featured: true).first || Project.first
  end

  def about
  end

  def contact
  end
end
