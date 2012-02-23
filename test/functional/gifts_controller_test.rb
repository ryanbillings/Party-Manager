require 'test_helper'

class GiftsControllerTest < ActionController::TestCase
  def test_index
    get :index
    assert_template 'index'
  end

  def test_show
    get :show, :id => Gift.first
    assert_template 'show'
  end

  def test_new
    get :new
    assert_template 'new'
  end

  def test_create_invalid
    Gift.any_instance.stubs(:valid?).returns(false)
    post :create
    assert_template 'new'
  end

  def test_create_valid
    Gift.any_instance.stubs(:valid?).returns(true)
    post :create
    assert_redirected_to gift_url(assigns(:gift))
  end

  def test_edit
    get :edit, :id => Gift.first
    assert_template 'edit'
  end

  def test_update_invalid
    Gift.any_instance.stubs(:valid?).returns(false)
    put :update, :id => Gift.first
    assert_template 'edit'
  end

  def test_update_valid
    Gift.any_instance.stubs(:valid?).returns(true)
    put :update, :id => Gift.first
    assert_redirected_to gift_url(assigns(:gift))
  end

  def test_destroy
    gift = Gift.first
    delete :destroy, :id => gift
    assert_redirected_to gifts_url
    assert !Gift.exists?(gift.id)
  end
end
