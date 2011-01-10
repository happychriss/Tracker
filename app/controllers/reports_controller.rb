class ReportsController < ApplicationController
  require 'reporter'
  before_filter :load_project
  before_filter :cancan_check

  def load_project
    if params[:project_id].nil? then
    @project = Project.find(params[:url][:project_id])
    else
@project = Project.find(params[:project_id])
    end

  end

  def index
    @reports = Report.all
  end

  def show
    @report = Report.find(params[:id])
  end

  def new
    @report = @project.reports.new
  end

  def create
    @report = @project.reports.new(params[:report])
    if @report.save
      flash[:notice] = "Successfully created report."
      redirect_to project_reports_url(@project)
    else
      render :action => 'new'
    end
  end

  def edit
    @report = Report.find(params[:id])
  end

  def update
    @report = Report.find(params[:id])
    if @report.update_attributes(params[:report])
      flash[:notice] = "Successfully updated report."
      redirect_to project_reports_url(@project)
    else
      render :action => 'edit'
    end
  end

  def destroy
    @report = Report.find(params[:id])
    @report.destroy
    flash[:notice] = "Successfully destroyed report."
    redirect_to project_reports_url(@project)
  end

  ##  Ajax Request for drat & drop reports
  ## todo: fix tracker_development.budget_groups_tasks' doesn't exist: describe `budget_groups_tasks` on delete

  def delete_report_line
    cparams=clean_params(params)
    @report = Report.find(cparams[:report_id])
    rl=@report.report_lines.find_by_id(cparams[:id].to_i)
    rl.remove_from_list
    rl.delete

    render :partial => "update_report", :locals => { :report => @report, :project =>@project}

  end

  def insert_report_line
    cparams=clean_params(params)
    @report = Report.find(cparams[:report_id])

    selected_group=BudgetGroup.find(cparams[:group_id])
    @report.report_lines.new(:budget_group => selected_group).save

    render :partial => "update_report", :locals => { :report => @report, :project =>@project}
  end

  private

   def clean_params(params)
     if  params[:url].nil? then
       return params
     else
       return params[:url]
     end
   end

   def cancan_check
     unauthorized! if cannot? :all, @project
  end

end
