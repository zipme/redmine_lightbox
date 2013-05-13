require 'application_helper'

module RedmineLightbox
  module Patches
    module ApplicationHelperPatch
      extend ActiveSupport::Concern

      included do
        include RedmineLightboxHelper
        alias_method_chain :link_to_attachment, :preview
      end
    end
  end
end

unless ApplicationHelper.included_modules.include?(RedmineLightbox::Patches::ApplicationHelperPatch)
  ApplicationHelper.send(:include, RedmineLightbox::Patches::ApplicationHelperPatch)
end
