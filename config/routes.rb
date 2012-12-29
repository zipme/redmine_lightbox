if Gem::Version.new("3.0") > Gem::Version.new(Rails.version) then
  #Redmine 1.x
  ActionController::Routing::Routes.draw do |map|
    map.with_options :controller => 'attachments', :id => /\d+/, :filename => /.*/ do |a|
      a.connect 'attachments/download_inline/:id/:filename', :action => 'download_inline'
      a.connect 'attachments/preview/:id/:filename', :action => 'preview'
      a.connect 'attachments/preview_inline/:id/:filename', :action => 'preview_inline'
    end
  end

else
  #Redmine 2.x
  RedmineApp::Application.routes.draw do
    with_options :controller => 'attachments', :id => /\d+/, :filename => /.*/ do |a|
      scope '/attachments' do
        a.get '/download_inline/:id/:filename', :action => 'download_inline'
        a.get '/preview/:id/:filename', :action => 'preview'
        a.get '/preview_inline/:id/:filename', :action => 'preview_inline'
      end
    end
  end
end
