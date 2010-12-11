class BaselinesController < ApplicationController
  
  before_filter :require_user
  before_filter :load_task_baseline
  before_filter :cancan_check
  

  def new
    #      @baseline = @task.baseline.clone #to make sure, its a new object
    @baseline=@task.baselines.new
    @baseline.estimator=@task.latest_baseline.estimator unless @task.latest_baseline.nil_or.estimator.nil?
    @baseline.build_new_works
    @baseline.build_new_wps(@task.latest_baseline)
    @baseline.request_only_effort if not params[:only_effort].nil?

  end
  
  def create
    
    @baseline = @task.baselines.new(params[:baseline])

    if @baseline.save
      @baseline.estimator.notify_estimator(@baseline)
      @baseline.request!
      flash[:notice] = "Successfully created estimation request."
      redirect_to task_baseline_url(@task,@baseline)
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
    if @baseline.update_attributes(params[:baseline])
      flash[:notice] = "Successfully updated Baseline."
      redirect_to task_baseline_url(@task,@baseline)
    else
      render :action => 'edit'
    end
  end
  
  def destroy
    @baseline.destroy
    flash[:notice] = "Successfully destroyed Baseline."
    redirect_to @task.project
  end
  
  private 

def load_task_baseline
    @task = Task.find(params[:task_id])
    @baseline = Baseline.find(params[:id]) unless params[:id].nil?
    @project=@task.project
   @organization= @project.organization
  end


   def cancan_check
     unauthorized! if cannot? :all , @task
  end
  
end
