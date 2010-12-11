module PertBaseline
  #################### PERT  #################################################
# pessimistic eac

  def get_baseline_eac
    (self.get_baseline_eac_mean+3*self.get_baseline_sigma).round
  end

  # pert average from all workpackages
  def get_baseline_eac_mean
    tmp_eac=0

    self.wps.each { |wp| tmp_eac+=wp.pert_average }

    return tmp_eac
  end

  def get_baseline_variance
    tmp_pert_variance_sum=0

    if self.task.pm_contingency=='sigma_3' then

      self.wps.each do |wp|
        tmp_pert_variance_sum+=wp.pert_variance
      end

      return tmp_pert_variance_sum
    else

      return 0
    end
  end



end
