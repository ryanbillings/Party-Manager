require 'test_helper'

class PartyTypesControllerTest < ActionController::TestCase
  def test_index
    get :index
    assert_template 'index'
  end

  def test_show
    get :show, :id => PartyType.first
    assert_template 'show'
  end

  def test_new
    get :new
    assert_template 'new'
  end

  def test_create_invalid
    PartyType.any_instance.stubs(:valid?).returns(false)
    post :create
    assert_template 'new'
  end

  def test_create_valid
    PartyType.any_instance.stubs(:valid?).returns(true)
    post :create
    assert_redirected_to party_type_url(assigns(:party_type))
  end

  def test_edit
    get :edit, :id => PartyType.first
    assert_template 'edit'
  end

  def test_update_invalid
    PartyType.any_instance.stubs(:valid?).returns(false)
    put :update, :id => PartyType.first
    assert_template 'edit'
  end

  def test_update_valid
    PartyType.any_instance.stubs(:valid?).returns(true)
    put :update, :id => PartyType.first
    assert_redirected_to party_type_url(assigns(:party_type))
  end

  def test_destroy
    party_type = PartyType.first
    delete :destroy, :id => party_type
    assert_redirected_to party_types_url
    assert !PartyType.exists?(party_type.id)
  end
end
