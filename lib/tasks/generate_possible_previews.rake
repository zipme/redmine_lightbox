namespace :redmine do
  task generate_possible_previews: :environment do
    Attachment.find_each do |attachment|
      attachment.generate_pdf_preview
    end
  end
end
