class PostsController < ApplicationController
  allow_unauthenticated_access
  before_action :set_post, only: :show

  def index
    @posts = Post.newest_first
    fresh_when etag: @posts
  end

  def show
    fresh_when etag: @post
  end

  private
    def set_post = @post = Post.find_by!(slug: params[:id])
end
