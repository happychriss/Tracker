class ProjectsController < ApplicationController

  helper :sparklines
  before_filter :load_project, :except => [:index, :new, :create]
  before_filter :cancan_check , :except => [:index, :new, :create]
    
  def index
    is_admin? ? @projects = Project.all : @projects = current_user.becomes(Pm).projects

  end
  
  def show
  @report=@project.reports.first
  end
  
  def new
    @project = Project.new
  end
  
  def create
    @project = Project.new(params[:project])
    @project.organization=current_user.organization unless  is_admin?
    @project.pm=current_user.becomes(Pm)

    
#    if @project.user.blank? then @project.user=current_user end

    if @project.save
      @report = @project.reports.create(:name=>'DEFAULT')
      flash[:notice] = "Successfully created project."
      redirect_to @project
    else
      render :action => 'new'
    end
  end
  
  def edit
  end
  
  def update
    if @project.update_attributes(params[:project])
      flash[:notice] = "Successfully updated project."
      redirect_to projects_url
    else
      render :action => 'edit'
    end
  end
  
  def destroy
    @project.destroy
    flash[:notice] = "Successfully destroyed project."
    redirect_to projects_url
  end

  private

  def load_project
     @project = Project.find(params[:id])
  end

   def cancan_check
     unauthorized! if cannot? :all, @project
  end

end
