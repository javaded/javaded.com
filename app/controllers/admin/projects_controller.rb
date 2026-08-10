class Admin::ProjectsController < Admin::BaseController
  before_action :set_project, only: %i[ edit update destroy ]

  def index
    @projects = Project.featured_first
  end

  def new
    @project = Project.new
  end

  def create
    @project = Project.new(project_params)
    if @project.save
      redirect_to edit_admin_project_path(@project), notice: "Project saved."
    else
      render :new, status: :unprocessable_content
    end
  end

  def edit
  end

  def update
    if @project.update(project_params)
      redirect_to edit_admin_project_path(@project), notice: "Project updated."
    else
      render :edit, status: :unprocessable_content
    end
  end

  def destroy
    @project.destroy
    redirect_to admin_projects_path, notice: "Project deleted."
  end

  private
    def set_project
      @project = Project.find_by!(slug: params[:id])
    end

    def project_params
      params.expect(project: [ :title, :slug, :tagline, :description, :status, :featured, :url ])
    end
end
