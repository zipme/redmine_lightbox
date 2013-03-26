require_dependency 'application_helper'
require_dependency 'wiki_helper'

unless WikiHelper.included_modules.include?(ApplicationHelper)
  WikiHelper.send(:include, ApplicationHelper)
end
