class RessourcesController < ApplicationController

  before_filter :load_project
  before_filter :cancan_check

   def index
    @ressources = @project.ressources.all
  end

  def show
    @ressource = @project.ressources.find(params[:id])
  end

  def new
    @ressource = @project.ressources.new
  end

  def create
    @ressource = @project.ressources.new(params[:ressource])

    if  @ressource.save
      params[:budget_types].each do |bt|
        @ressource.budget_types<<BudgetType.find(bt.to_i)
      end

      flash[:notice] = "Successfully created ressource."
      redirect_to project_ressources_url(@project)
    else
      render :action => 'new'
    end
  end

  def edit
    @ressource = @project.ressources.find(params[:id])
  end

  def update
    @ressource = @project.ressources.find(params[:id])


    if @ressource.update_attributes(params[:ressource])

      @ressource.budget_types.clear
      @ressource.save

      params[:budget_types].each do |bt|
        @ressource.budget_types<<BudgetType.find(bt.to_i)
      end
      flash[:notice] = "Successfully updated ressource."


      redirect_to project_ressource_url(@project,@ressource)
    else
      render :action => 'edit'
    end
  end

  def destroy
    @ressource = @project.ressources.find(params[:id])
    @ressource.destroy
    flash[:notice] = "Successfully destroyed ressource."
    redirect_to project_ressources_url(@project)
  end

 private

   def load_project
    @project = Project.find(params[:project_id])
  end

   def cancan_check
     unauthorized! if cannot? :all, @project
  end

end
