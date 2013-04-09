require_dependency 'wiki_controller'

module RedmineLightbox
  module Patches
    module WikiControllerPatch
      extend ActiveSupport::Concern

      included do
        unloadable

        helper :redmine_lightbox
      end
    end
  end
end

unless WikiController.included_modules.include?(RedmineLightbox::Patches::WikiControllerPatch)
  WikiController.send(:include, RedmineLightbox::Patches::WikiControllerPatch)
end
