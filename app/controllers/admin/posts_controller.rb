class Admin::PostsController < Admin::BaseController
  before_action :set_post, only: %i[ edit update destroy ]

  def index
    @posts = Post.newest_first
  end

  def new
    @post = Post.new
  end

  def create
    @post = Post.new(post_params)
    if @post.save
      redirect_to edit_admin_post_path(@post), notice: "Post saved."
    else
      render :new, status: :unprocessable_content
    end
  end

  def edit
  end

  def update
    if @post.update(post_params)
      redirect_to edit_admin_post_path(@post), notice: "Post updated."
    else
      render :edit, status: :unprocessable_content
    end
  end

  def destroy
    @post.destroy
    redirect_to admin_posts_path, notice: "Post deleted."
  end

  private
    def set_post
      @post = Post.find_by!(slug: params[:id])
    end

    def post_params
      params.expect(post: [ :title, :slug, :excerpt, :body, :published_at, :reading_time ])
    end
end
