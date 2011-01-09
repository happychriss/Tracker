class TasksController < ApplicationController


  before_filter :load_project
  before_filter :cancan_check


  def index
    @tasks = @project.tasks.all
  end

  def show
    @task = @project.tasks.find(params[:id])
  end

  def new
    @task = @project.tasks.new


  end

  def create
    @task = @project.tasks.new(params[:task])
    if @task.save
      flash[:notice] = "Successfully created task."

      if  @task.request_allowed?(:baseline)
        redirect_to new_task_baseline_path(@task)
      else
        redirect_to new_task_baseline_path(@task, :only_effort => "true")
      end
    else
      render :action => 'new'
    end
  end

  def edit
    @task = @project.tasks.find(params[:id])
  end

  def update
    @task = @project.tasks.find(params[:id])
    if @task.update_attributes(params[:task])
      flash[:notice] = "Successfully updated task."
      redirect_to @project
    else
      render :action => 'edit'
    end
  end

  def destroy
    @task = @project.tasks.find(params[:id])
    @task.destroy
    flash[:notice] = "Successfully destroyed task."
    redirect_to @project
  end

  private

  def cancan_check
    unauthorized! if cannot? :all, @project
  end

  def load_project
    @project = Project.find(params[:project_id])
  end

end
