class ProjectsController < ApplicationController
  allow_unauthenticated_access
  before_action :set_project, only: :show

  def index
    @projects = Project.featured_first
    fresh_when etag: @projects
  end

  def show
    fresh_when etag: @project
  end

  private
    def set_project = @project = Project.find_by!(slug: params[:id])
end
