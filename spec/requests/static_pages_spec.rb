require 'spec_helper'

describe "Static pages" do

	subject {page}
	
	describe "Home page" do
		it "should have the h1 'Sample App'" do
			visit root_path
			page.should have_selector('h1', text: 'Sample App')
		end
		
		it "should have the base title" do
			visit root_path
			page.should have_selector('title', text: "Ruby on Rails Tutorial Sample App")
		end
		
		describe "for signed-in users" do
			let(:user) { FactoryGirl.create(:user) }
			before do
				FactoryGirl.create(:micropost, user: user, content: "micropost 1")
				FactoryGirl.create(:micropost, user: user, content: "micropost 2")
				sign_in user
				visit root_path
			end
			
			it "should render the user's feed" do
				user.feed.each do |item|
					page.should have_selector("li##{item.id}", text: item.content)
				end
			end
			
			describe "follower/following counts" do
				let(:other_user) { FactoryGirl.create(:user) }
				before do
					other_user.follow!(user)
					visit root_path
				end
				
				it { should have_link("0 following", href: following_user_path(user)) }
				it { should have_link("1 followers", href: followers_user_path(user)) }
			end
			
		end
	end
	
	describe "Help page" do
		it "should have the h1 'Help'" do
			visit help_path
			page.should have_selector('h1', text: 'Help')
		end
		
		it "should have the title 'Help'" do
			visit help_path
			page.should have_selector('title', text: "Ruby on Rails Tutorial Sample App | Help")
		end
	end
	
	describe "About page" do
		it "should have the h1 'About'" do
			visit about_path
			page.should have_selector('h1', text: 'About Us')
		end
		
		it "should have the content 'About US'" do
			visit about_path
			page.should have_selector('title', :text => "Ruby on Rails Tutorial Sample App | About Us")
		end
	end
	
	describe "Contact page" do
		it "should have the h1 'Contact'" do
			visit contact_path
			page.should have_selector('h1', text: 'Contact')
		end
		
		it "should have the title 'Contact'" do
		visit contact_path
		pages.should have_selector('title', text: "Ruby on Rails Tutorial Sample App | Contact")
		end
	end
	
end

#describe "StaticPages" do
#  describe "GET /static_pages" do
#    it "works! (now write some real specs)" do
#      # Run the generator again with the --webrat flag if you want to use webrat methods/matchers
#      get static_pages_index_path
#      response.status.should be(200)
#    end
#  end
#end
