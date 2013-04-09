RedmineApp::Application.routes.draw do
  with_options :controller => 'attachments', :id => /\d+/, :filename => /.*/ do |a|
    scope '/attachments' do
      a.get '/download_inline/:id/:filename', :action => 'download_inline'
    end
  end
end
