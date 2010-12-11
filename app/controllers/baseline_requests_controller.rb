# Controller for working on the request flow for estimations and baselines
class BaselineRequestsController < ApplicationController

  before_filter :load_estimator_using_perishable_token
  before_filter :load_baseline, :except=> [:index]
  before_filter :cancan_check, :except=> [:index]

  def index
  end

  def show
  end

  def edit
  end

  def update

    @baseline.attributes =params[:baseline]

    if not @baseline.valid? then

      render :action => "edit"

      return
    end


### Pert Estimation    

    if params[:commit]=='Save' then
      if @baseline.save then
        @baseline.estimate!
        flash[:notice] = "Successfully updated Baseline."
        redirect_to baseline_requests_url
        return
      end

      @mode=:step0
      render :action => "edit"

    end

    if params[:commit]=='Next Step >>' then
      @mode=:step2
      render :action => "edit"
      return
    end

    if params[:commit]=='<< Back' then
      @mode=:step1
      render :action => "edit"
      return
    end


    if params[:commit]=='Finish >>' then
      @baseline.estimation_date=Date.today

      if @baseline.get_baseline_eac.round-@baseline.get_works_total_hours!=0 then
        flash[:error] = "Estimation must match hours"
        @mode=:step2
        render :action => "edit"
        return
      end

      if @baseline.save then
        @baseline.estimate!
        flash[:notice] = "Successfully updated Baseline."
        redirect_to baseline_requests_url
        return
      end

      @mode=:step2
      render :action => "edit"

    end

  end


  private

  def load_baseline
    @baseline = Baseline.find(params[:id])
    @task=@baseline.task

    if @mode.nil? then
    if @baseline.status==:requested_only_effort
      @mode=:step0
    else
      @mode=:step1
    end
    end

#    set_view_by_estimation_type

  end


  def validate_user_access (baseline)
    if  baseline.estimator!=current_user.becomes(Estimator) then
      flash[:notice] = "You must be logged in to access this page"
      redirect_to baselines_url
    end
  end


  def cancan_check
    unauthorized! if cannot? :all, @baseline
  end


end
