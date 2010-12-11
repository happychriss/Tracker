class UsersController < ApplicationController


  before_filter :load_user, :except=> [:create, :index, :new]
  load_and_authorize_resource

  def index

    @users = User.get_team(current_user)

  end


### Normal user creation

  def new
    @user = User.new
  end


  def create
    @user = User.new(params[:user])
    if @user.save
      flash[:notice] = "Registration successful."
      redirect_to users_path
    else
      render :action => 'new'
    end
  end

  def edit
  end

  def show
  end

  def update
    if @user.update_attributes(params[:user])
      flash[:notice] = "Successfully updated profile."
      if current_user.is_pm? then
      redirect_to users_path
      else
        redirect_to baseline_requests_path
      end
    else
      render :action => 'edit'
    end
  end

  def destroy
    @user.destroy
    flash[:notice] = "Successfully destroyed user."
    redirect_to users_url
  end

  private

  def load_user
    @user = User.find(params[:id])
  end

  def cancan_check
    unauthorized! if cannot? :all, @user
  end

end

