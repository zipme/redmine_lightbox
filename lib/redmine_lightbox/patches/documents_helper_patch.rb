require_dependency 'application_helper'
require_dependency 'documents_helper'

unless DocumentsHelper.included_modules.include?(ApplicationHelper)
  DocumentsHelper.send(:include, ApplicationHelper)
end