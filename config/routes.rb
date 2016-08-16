RedmineApp::Application.routes.draw do
  with_options controller: 'attachments', id: /\d+/, filename: /.*/ do |a|
    scope '/attachments' do
      a.get '/text_preview/:id/:filename', action: 'text_preview'
      a.get '/pdf_preview/:id/:filename', action: 'pdf_preview'
    end
  end
end
