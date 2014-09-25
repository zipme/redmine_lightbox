module Workers
  class DocumentConverter

    class DocumentConvertError < StandardError
    end

    @queue = :document_converter_queue

    class << self

      def defer(source_filename, preview_format)
        if RedmineLightbox::DEFER_CONVERT
          perform_async source_filename: source_filename, preview_format: preview_format
        else
          RedmineLightbox::Services::DocumentConverter.convert(source_filename, preview_format)
        end
      rescue Exception => e
        Rails.logger.error "#{self.class}.defer: #{e.class} => #{e.message}"
        raise DocumentConvertError.new("Can't create or defer preview for #{source_filename}. See log for details.")
      end

      def perform_async(options)
        Resque.enqueue(Workers::DocumentConverter, options)
      end

      def perform(options)
        RedmineLightbox::Services::DocumentConverter.convert(
            options.with_indifferent_access[:source_filename],
            options.with_indifferent_access[:preview_format]
        )
      end
    end
  end
end
