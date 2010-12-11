require 'test_helper'

class EstimationsControllerTest < ActionController::TestCase
  def test_index
    get :index
    assert_template 'index'
  end
  
  def test_show
    get :show, :id => Estimation.first
    assert_template 'show'
  end
  
  def test_new
    get :new
    assert_template 'new'
  end
  
  def test_create_invalid
    Estimation.any_instance.stubs(:valid?).returns(false)
    post :create
    assert_template 'new'
  end
  
  def test_create_valid
    Estimation.any_instance.stubs(:valid?).returns(true)
    post :create
    assert_redirected_to estimation_url(assigns(:estimation))
  end
  
  def test_edit
    get :edit, :id => Estimation.first
    assert_template 'edit'
  end
  
  def test_update_invalid
    Estimation.any_instance.stubs(:valid?).returns(false)
    put :update, :id => Estimation.first
    assert_template 'edit'
  end
  
  def test_update_valid
    Estimation.any_instance.stubs(:valid?).returns(true)
    put :update, :id => Estimation.first
    assert_redirected_to estimation_url(assigns(:estimation))
  end
  
  def test_destroy
    estimation = Estimation.first
    delete :destroy, :id => estimation
    assert_redirected_to estimations_url
    assert !Estimation.exists?(estimation.id)
  end
end
