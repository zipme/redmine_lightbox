require File.dirname(__FILE__) + '/../test_helper'

class IssuesControllerTest < ActionController::TestCase
  fixtures :users, :projects, :roles, :members, :member_roles,
           :enabled_modules, :issues, :issue_statuses, :trackers, :attachments,
           :versions, :wiki_pages, :wikis, :documents, :enumerations

  def setup
    @request.session[:user_id] = 2
  end

  def test_should_show_issue_with_attachments_and_previews
    get :show, id: 2
    assert_response :success
  end
end
