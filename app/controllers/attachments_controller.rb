class AttachmentsController < ApplicationController
  unloadable
  def download_inline
    send_file @attachment.diskfile, :filename => filename_for_content_disposition(@attachment.filename),
                                    :type => detect_content_type(@attachment), 
                                    :disposition => 'inline'   
  end
end