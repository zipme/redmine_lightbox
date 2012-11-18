module RedmineLightbox
  module Services
    class DocumentConverter
      CONVERTER = "unoconv"

      def initialize(output_format)
        @output_format = output_format
      end

      def convert(filename)
        system "#{CONVERTER} -f #{@output_format} #{filename}"
      end

      class << self
        def preview_filename_for(filename, format)
          name, splitter, original_format = filename.rpartition(".")
          [name, splitter, format].join
        end
      end
    end
  end
end
