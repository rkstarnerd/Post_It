class SessionsController <ApplicationController 

  def new
  end

  def create
    user = User.find_by(username: params[:username])
    
    if user && user.authenticate(params[:password])
      if user.two_factor_auth?
        session[:two_factor] = true
        user.generate_pin!
        user.send_pin_to_twilio
        redirect_to pin_path
      else
        log_in(user)
      end
      
    else
      flash[:error] = "Your username and/or password was incorrect.  Please try again."
      redirect_to login_path
    end
  end

  def pin
    access_denied if session[:two_factor].nil?

    if request.post?
      user = User.find_by pin: params[:pin]
        if user
          session[:two_factor] = nil
          user.remove_pin!
          log_in(user)
      else
        flash[:error] = "Incorrect pin, please try again"
        redirect_to pin_path
      end
    end
  end

  def destroy
    session[:user_id] = nil
    flash[:notice] = "You've logged out!"
    redirect_to root_path
  end
end