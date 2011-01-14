module LinearEstimation
  ####PERT #######################################################
  def pert_per_complete
    eac=self.baseline.eac_hours.to_f
    return 0 if eac==0
    return self.ev.to_f/eac
  end

  ####PERT #######################################################
### based on wp_actuals
# res_ev = self.baseline.eac_hours * (self.complete_per.to_r/100)

#### common interfaces

  # ev is same as planned value
  def ev
    return self.baseline.pv(self)
  end

  def get_eac
    self.get_etc+self.total_actual_hours
  end

  # this is special calculation to consider that  for linear task variance reduces over time
  def get_etc
    self.baseline.eac_hours-self.ev+Math.sqrt(self.get_variance*(1-self.pert_per_complete))
  end
 ## todo: sigma_x

  # pert average from all workpackages
  def get_mean
    res_etc=0

    self.baseline.wps.each do |wp|
      res_etc+=wp.pert_average
    end

    return res_etc
  end

  def get_variance
    tmp_sum_variance=0

    if self.task.pm_contingency!='normal' then
      self.baseline.wps.each do |wp|
        tmp_sum_variance+=wp.pert_variance
      end
    end
    return tmp_sum_variance
  end


end
