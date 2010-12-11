class EstimationsController < ApplicationController

  before_filter :require_user

  before_filter :load_task
  before_filter :load_estimate, :except=> [:new, :create, :index]
  before_filter :load_organization

  before_filter :cancan_check


  def new

    @estimation=@task.estimations.new
    @estimation.estimator=@task.baseline.estimator
    @estimation.build_new_work_actuals

  end

  def create

    @estimation = @task.estimations.new(params[:estimation])

    if @estimation.save
      @estimation.request!
      @estimation.estimator.notify_estimator(@estimation)
      flash[:notice] = "Successfully created estimation request."
      redirect_to task_estimation_url(@task, @estimation)
    else
      render :action => 'new'
    end
  end


  def index
  end

  def show
  end


  def edit

  end

  def update

    if @estimation.update_attributes(params[:estimation])
      flash[:notice] = "Successfully updated Estimate."
      redirect_to task_estimation_url(@task, @estimation)
    else
      render :action => 'edit'
    end
  end

  def destroy

    @estimation.destroy
    flash[:notice] = "Successfully destroyed estimate."
    redirect_to @task.project
  end

  private

  def cancan_check
     unauthorized! if cannot? :all, @task
  end

  def load_task
    @task = Task.find(params[:task_id])
  end


  def load_estimate
    @estimation = Estimation.find(params[:id])
       set_view_by_estimation_type(@estimation)
  end

  def load_organization
     @organization= @task.project.organization
  end
end
