FactoryGirl.define do
	factory :user do
		name "user1"
		email "user1@rails.com"
		password "rails"
		password_confirmation "rails"
		
		factory :admin do
			admin true
		end
	end
end