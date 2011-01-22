# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ :name => 'Chicago' }, { :name => 'Copenhagen' }])
#   Mayor.create(:name => 'Daley', :city => cities.first)
BudgetType.delete_all
BudgetGroup.delete_all
User.delete_all
Organization.delete_all

o=Organization.create!(:name => 'MASTER')
o.users.create!(:username =>'admin', :email => 'admin@yrr.de', :password => 'admin', :password_confirmation => 'admin', :is_admin => true)

bg=BudgetGroup.create!(:group_name => 'Costtype')
bg.BudgetTypes.create!(:name => 'External')
bg.BudgetTypes.create!(:name => 'Internal')
bg.BudgetTypes.create!(:name => 'Offshore')

bg=BudgetGroup.create!(:group_name => 'Department')
bg.BudgetTypes.create!(:name => 'Design')
bg.BudgetTypes.create!(:name => 'Backend')
bg.BudgetTypes.create!(:name => 'Test')

bg=BudgetGroup.create!(:group_name => 'Team')
bg.BudgetTypes.create!(:name => 'Onsite')
bg.BudgetTypes.create!(:name => 'Offshore')