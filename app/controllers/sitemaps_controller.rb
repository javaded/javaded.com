class SitemapsController < ApplicationController
  allow_unauthenticated_access

  def show
    @posts = Post.published.newest_first
    @projects = Project.featured_first

    fresh_when etag: [ @posts, @projects ]
  end
end
