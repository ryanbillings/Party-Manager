require 'test_helper'

class HostTest < ActiveSupport::TestCase
  def new_host(attributes = {})
    attributes[:username] ||= 'foo'
    attributes[:email] ||= 'foo@example.com'
    attributes[:password] ||= 'abc123'
    attributes[:password_confirmation] ||= attributes[:password]
    host = Host.new(attributes)
    host.valid? # run validations
    host
  end

  def setup
    Host.delete_all
  end

  def test_valid
    assert new_host.valid?
  end

  def test_require_username
    assert new_host(:username => '').errors[:username]
  end

  def test_require_password
    assert new_host(:password => '').errors[:password]
  end

  def test_require_well_formed_email
    assert new_host(:email => 'foo@bar@example.com').errors[:email]
  end

  def test_validate_uniqueness_of_email
    new_host(:email => 'bar@example.com').save!
    assert new_host(:email => 'bar@example.com').errors[:email]
  end

  def test_validate_uniqueness_of_username
    new_host(:username => 'uniquename').save!
    assert new_host(:username => 'uniquename').errors[:username]
  end

  def test_validate_odd_characters_in_username
    assert new_host(:username => 'odd ^&(@)').errors[:username]
  end

  def test_validate_password_length
    assert new_host(:password => 'bad').errors[:password]
  end

  def test_require_matching_password_confirmation
    assert new_host(:password_confirmation => 'nonmatching').errors[:password]
  end

  def test_generate_password_hash_and_salt_on_create
    host = new_host
    host.save!
    assert host.password_hash
    assert host.password_salt
  end

  def test_authenticate_by_username
    Host.delete_all
    host = new_host(:username => 'foobar', :password => 'secret')
    host.save!
    assert_equal host, Host.authenticate('foobar', 'secret')
  end

  def test_authenticate_by_email
    Host.delete_all
    host = new_host(:email => 'foo@bar.com', :password => 'secret')
    host.save!
    assert_equal host, Host.authenticate('foo@bar.com', 'secret')
  end

  def test_authenticate_bad_username
    assert_nil Host.authenticate('nonexisting', 'secret')
  end

  def test_authenticate_bad_password
    Host.delete_all
    new_host(:username => 'foobar', :password => 'secret').save!
    assert_nil Host.authenticate('foobar', 'badpassword')
  end
end
