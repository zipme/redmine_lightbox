require File.dirname(__FILE__) + '/../test_helper'

class IssuesControllerTest < ActionController::TestCase
  fixtures :issues, :projects, :attachments, :users, :issue_statuses,
    :enumerations, :trackers

  def setup
    set_fixtures_attachments_directory

    @some_file = Attachment.find_by_filename("source.rb")

    @some_file.create_attachment_preview(:file_type => "pdf")

    @request.session[:user_id] = 2
    User.stubs(:current).returns(User.find_by_id(2))
    User.any_instance.stubs(:allowed_to?).returns(true)
  end

  def test_should_show_issue_with_attachments_and_previews
    @issue_with_file_id = @some_file.container_id
  
    get :show, :id => @issue_with_file_id
    assert_response :success
  end
end
