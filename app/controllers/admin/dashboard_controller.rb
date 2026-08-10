class Admin::DashboardController < Admin::BaseController
  def show
    @posts = Post.newest_first.recent(5)
    @projects = Project.featured_first
  end
end
