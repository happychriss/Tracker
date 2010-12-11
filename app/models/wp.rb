class Wp < ActiveRecord::Base
belongs_to :baseline
has_one :wp_actual

validate :pert_estimate

after_initialize :init_wp

def init_wp

    if new_record?
      self.p_estimate=0 if p_estimate.nil?
      self.m_estimate=0 if m_estimate.nil?
      self.o_estimate=0 if o_estimate.nil?      
    end
  end

def pert_average
  (self.p_estimate+4*self.m_estimate+self.o_estimate).to_f/6
end

def pert_variance
    ((self.p_estimate-self.o_estimate).to_f/6)**2
end

private

def pert_estimate

  errors.add_to_base("Estimation must be: Optimistic <= Likely <= Pessimistic ") unless   (self.p_estimate >= self.m_estimate and self.m_estimate >= self.o_estimate)

end

end
