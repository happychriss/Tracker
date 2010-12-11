class Project < ActiveRecord::Base
has_many :tasks,:dependent => :destroy
has_many :ressources,:dependent => :destroy
belongs_to :pm, :foreign_key => 'pm_id'
belongs_to :organization
has_many :reports,:dependent => :destroy
validates_presence_of :name

accepts_nested_attributes_for :tasks, :allow_destroy => true
accepts_nested_attributes_for :reports, :allow_destroy => true

end
