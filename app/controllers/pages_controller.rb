class PagesController < ApplicationController
  allow_unauthenticated_access
  def home
    @posts = Post.newest_first.recent(3)
  end

  def about
  end

  def contact
  end
end
