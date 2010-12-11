require 'test_helper'

class WorksControllerTest < ActionController::TestCase
  def test_index
    get :index
    assert_template 'index'
  end
  
  def test_show
    get :show, :id => Work.first
    assert_template 'show'
  end
  
  def test_new
    get :new
    assert_template 'new'
  end
  
  def test_create_invalid
    Work.any_instance.stubs(:valid?).returns(false)
    post :create
    assert_template 'new'
  end
  
  def test_create_valid
    Work.any_instance.stubs(:valid?).returns(true)
    post :create
    assert_redirected_to work_url(assigns(:work))
  end
  
  def test_edit
    get :edit, :id => Work.first
    assert_template 'edit'
  end
  
  def test_update_invalid
    Work.any_instance.stubs(:valid?).returns(false)
    put :update, :id => Work.first
    assert_template 'edit'
  end
  
  def test_update_valid
    Work.any_instance.stubs(:valid?).returns(true)
    put :update, :id => Work.first
    assert_redirected_to work_url(assigns(:work))
  end
  
  def test_destroy
    work = Work.first
    delete :destroy, :id => work
    assert_redirected_to works_url
    assert !Work.exists?(work.id)
  end
end
