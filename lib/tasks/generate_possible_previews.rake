namespace :redmine do
  task :generate_possible_previews => :environment do
    Attachment.find_each do |attachment|
      attachment.try_to_generate_preview
    end
  end
end
