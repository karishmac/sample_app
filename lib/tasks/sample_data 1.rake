namespace :db do
	desc "Fill database with sample data"
	task populate: :environment do
		admin = User.create!(name: "New Example user",
							 email: "example_new@rails.org",
							 password: "rubyonrails",
							 password_confirmation: "rubyonrails")
		
		admin.toggle!(:admin)
		
		users = User.all(limit: 6)
		50.times do
			content = "Repeat this sentence."
			users.each { |user| user.microposts.create!(content: content) }
		end
	end
end