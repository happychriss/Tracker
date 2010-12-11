class Work < ActiveRecord::Base
  belongs_to :baseline

  def self.after_initialize

    if new_record?

      self.workhours=0 if workhours.nil?

    end

  end
end
