# Controller for working on the request flow for estimations and baselines
class EstimationRequestsController < ApplicationController

  before_filter :load_estimator_using_perishable_token
  before_filter :load_estimation, :except=> [:index]
  before_filter :cancan_check


  def index
  end

  def show
  end

  def edit

  end

  def update

    @estimation.attributes =params[:estimation]
    @estimation.estimation_date=Date.today

    if @estimation.save then
      @estimation.estimate!
      flash[:notice] = "Successfully updated estimation."
        redirect_to baseline_requests_url
    end

  end


  private

  def load_estimation
    @estimation = Estimation.find(params[:id])
    set_view_by_estimation_type(@estimation)
    validate_user_access(@estimation)
    @task=@estimation.task
  end


  def validate_user_access (estimation)
    if  estimation.estimator!=current_user.becomes(Estimator) then
      flash[:notice] = "You must be logged in to access this page"
      redirect_to estimations_url
    end
  end

    def cancan_check
     unauthorized! if cannot? :all , @estimation
  end

end