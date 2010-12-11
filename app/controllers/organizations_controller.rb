class OrganizationsController < ApplicationController
  def index
    @organizations = Organization.all
  end
  
  def show
    @organization = Organization.find(params[:id])
  end
  
  def new
    @organization = Organization.new
  end
  
  def create
    @organization = Organization.new(params[:organization])
    if @organization.save
      flash[:notice] = "Successfully created organization."
      redirect_to organizations_url
    else
      render :action => 'new'
    end
  end
  
  def edit
    @organization = Organization.find(params[:id])
  end
  
  def update
    @organization = Organization.find(params[:id])
    if @organization.update_attributes(params[:organization])
      flash[:notice] = "Successfully updated organization."
      redirect_to @organization
    else
      render :action => 'edit'
    end
  end
  
  def destroy
    @organization = Organization.find(params[:id])
    @organization.destroy
    flash[:notice] = "Successfully destroyed organization."
    redirect_to organizations_url
  end
end
