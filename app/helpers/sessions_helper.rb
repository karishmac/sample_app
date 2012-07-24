module SessionsHelper
	
	#using rails cookies utility
	def sign_in(user)
		#visit signin_path
		#fill_in "Email", with: user.email
		#fill_in "Password", with: user.password
		#click_button "Sign in"
		cookies.permanent[:remember_token] = user.remember_token  #sign in when not using capybara as well.
		self.current_user = user	#to make user accessible in both controllers and views to use instructions like <%= current_user.name %> and redirect_to current_user
		#if declared without "self", it will simply create a local variable called current_user
	end
	
	def signed_in?
		!current_user.nil?
	end
	
	def current_user=(user)
		@current_user = user
	end
	
	def current_user
		@current_user ||= User.find_by_remember_token(cookies[:remember_token])
	end
	#||= is "equals" operator, its effect is to set the @current_user instance variable to the user corresponding to the remember token, but only if @current_user is undefined.
	
	def current_user?(user)
		user == current_user
	end
	
	def signed_in_user
		unless signed_in?
			store_location
			redirect_to signin_path, notice: "Please sign in."
		end
	end
	
	def sign_out
		self.current_user = nil
		cookies.delete(:remember_token)
	end
	
	def redirect_back_or(default)
		redirect_to(session[:return_to] || default)
		session.delete(:return_to)
	end
	
	def store_location
		session[:return_to] = request.fullpath
	end
	
end