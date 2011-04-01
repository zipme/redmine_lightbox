ActionController::Routing::Routes.draw do |map|
  map.connect 'attachments/download_inline/:id/:filename', 
  :controller => 'attachments', :action => 'download_inline', :id => /\d+/, :filename => /.*/
end