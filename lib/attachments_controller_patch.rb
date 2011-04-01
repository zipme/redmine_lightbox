module AttachmentsControllerPatch
  def self.included(base) # :nodoc:
    base.extend(ClassMethods)

    base.send(:include, InstanceMethods)

    # Same as typing in the class
    base.class_eval do
      unloadable # Send unloadable so it will not be unloaded in development
    end

  end
  
  module ClassMethods
    
  end
  
  module InstanceMethods
    def download_inline
      send_file @attachment.diskfile, :filename => filename_for_content_disposition(@attachment.filename),
                                      :type => detect_content_type(@attachment), 
                                      :disposition => 'inline'   
    end
  end
end

# Add module to Issue
# AttachmentsController.send(:include, AttachmentsControllerPatch)