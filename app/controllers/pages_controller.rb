class PagesController < ApplicationController
  allow_unauthenticated_access
  def home
    @posts = Post.newest_first.recent(3)
    @featured_project = Project.where(featured: true).first || Project.first
  end

  def about
  end

  def contact
  end
end
