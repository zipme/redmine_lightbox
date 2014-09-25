module RedmineLightbox
  module Services
    class DocumentConverter
      # https://github.com/dagwieers/unoconv
      CONVERTER = 'unoconv'

      class << self
        def convert(filename, output_format)
          if filename.present? && File.exist?(filename)
            `#{CONVERTER} -f #{output_format} #{filename}`
          end
        end

        def preview_filename_for(filename, format)
          name, splitter, original_format = filename.rpartition('.')
          [name, splitter, format].join
        end

        def converter_available?
          `#{CONVERTER} --version`.present? rescue false
        end
      end
    end
  end
end
