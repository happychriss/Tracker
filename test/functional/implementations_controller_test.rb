require 'test_helper'

class ImplementationsControllerTest < ActionController::TestCase
  def test_index
    get :index
    assert_template 'index'
  end
  
  def test_show
    get :show, :id => Implementation.first
    assert_template 'show'
  end
  
  def test_new
    get :new
    assert_template 'new'
  end
  
  def test_create_invalid
    Implementation.any_instance.stubs(:valid?).returns(false)
    post :create
    assert_template 'new'
  end
  
  def test_create_valid
    Implementation.any_instance.stubs(:valid?).returns(true)
    post :create
    assert_redirected_to implementation_url(assigns(:implementation))
  end
  
  def test_edit
    get :edit, :id => Implementation.first
    assert_template 'edit'
  end
  
  def test_update_invalid
    Implementation.any_instance.stubs(:valid?).returns(false)
    put :update, :id => Implementation.first
    assert_template 'edit'
  end
  
  def test_update_valid
    Implementation.any_instance.stubs(:valid?).returns(true)
    put :update, :id => Implementation.first
    assert_redirected_to implementation_url(assigns(:implementation))
  end
  
  def test_destroy
    implementation = Implementation.first
    delete :destroy, :id => implementation
    assert_redirected_to implementations_url
    assert !Implementation.exists?(implementation.id)
  end
end
