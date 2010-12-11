class Organization < ActiveRecord::Base
  attr_accessible :name, :users_attributes

  has_many :projects, :dependent => :destroy
  has_many :users, :dependent => :destroy
  accepts_nested_attributes_for :users, :allow_destroy => true
  validates_presence_of :name
end
