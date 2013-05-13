RedmineApp::Application.routes.draw do
  with_options :controller => 'attachments', :id => /\d+/, :filename => /.*/ do |a|
    scope '/attachments' do
      a.get '/download_inline/:id/:filename', :action => 'download_inline'
      a.get '/preview/:id/:filename', :action => 'preview'
      a.get '/preview_inline/:id/:filename', :action => 'preview_inline'
    end
  end
end
