class Estimator < User
  has_many :tasks
  has_many :estimations
  has_many :baselines

  def notify_estimator(request)
    reset_perishable_token!
    if request.class.to_s=='Estimation' then
      Notifier.estimation_request(self, request)
      return
    end

    if request.class.to_s=='Baseline' then
      Notifier.baseline_request(self, request)
      return
    end

    raise "notify_estimator called with wrong object class"
  end

end