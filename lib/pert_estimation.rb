module PertEstimation
  ####PERT #######################################################
  def pert_per_complete
  eac=self.get_etc+self.ev
  return 0 if eac==0
    (self.ev.to_f/eac)
  end

  ####PERT #######################################################
### based on wp_actuals
# res_ev = self.baseline.eac_hours * (self.complete_per.to_r/100)

#### common interfaces

  def ev
    res_ev=0
    self.wp_actuals.each do |actual_wp|
      case actual_wp.status
        when 'ongoing'
          res_ev+=actual_wp.wp.m_estimate*0.5
        when 'closed'
          res_ev+=actual_wp.wp.m_estimate
        when 'open'
          res_ev=res_ev
        else
          raise "error - actual status not defined for EV calculation"
      end
    end
    return res_ev

  end

  def get_eac
    self.get_etc+self.total_actual_hours
  end

  # etc based on open wp and sigma
  def get_etc
    self.get_mean+3*self.get_sigma
  end


    # pert average from all workpackages open or ongoing
  def get_mean
  res_etc=0

    self.wp_actuals.each do |actual_wp|
      case actual_wp.status
        when 'ongoing'
          res_etc+=actual_wp.wp.pert_average*0.5
        when 'closed'
          res_etc=res_etc
        when 'open'
          res_etc+=actual_wp.wp.pert_average
        else
          raise "error - actual status not defined etc calculation"
      end
    end

    return res_etc
  end

  # pert sum all variants of the open wp
  def get_variance

    tmp_sum_variance=0

    if self.task.pm_contingency=='sigma_3' then

      self.wp_actuals.each do |actual_wp|
        case actual_wp.status
          when 'ongoing'
            tmp_sum_variance+=actual_wp.wp.pert_variance*0.5
          when 'closed'
            tmp_sum_variance=tmp_sum_variance
          when 'open'
            tmp_sum_variance+=actual_wp.wp.pert_variance
          else
            raise "error - actual status not defined etc calculation"
        end
      end
      return tmp_sum_variance
    else

      return 0
    end

  end

  
end
