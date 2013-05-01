require 'test_helper'

class NotificationsTest < ActionMailer::TestCase
  test "submission" do
    @expected.subject = 'Notifications#submission'
    @expected.body    = read_fixture('submission')
    @expected.date    = Time.now

    assert_equal @expected.encoded, Notifications.create_submission(@expected.date).encoded
  end

  test "finance_approved" do
    @expected.subject = 'Notifications#finance_approved'
    @expected.body    = read_fixture('finance_approved')
    @expected.date    = Time.now

    assert_equal @expected.encoded, Notifications.create_finance_approved(@expected.date).encoded
  end

  test "admin_approved" do
    @expected.subject = 'Notifications#admin_approved'
    @expected.body    = read_fixture('admin_approved')
    @expected.date    = Time.now

    assert_equal @expected.encoded, Notifications.create_admin_approved(@expected.date).encoded
  end

end
