class SessionsController <ApplicationController 
  before_action :set_user, only: [:create, :forgot_password?]

  def new
  end

  def create
    user = User.find_by(username: params[:username])
    if user && user.authenticate(params[:password])
      if user.two_factor_auth?
        session[:two_factor] = true
        user.generate_pin!
         if TWILIO_CONFIG['token'].blank?
          flash[:error]= "Please contact an administrator for assistance."
          redirect_to pin_path
        else
          user.send_pin_to_twilio
          redirect_to pin_path
        end
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
        flash[:error] = "Incorrect pin. Please try again or contact an administrator for assistance."
        redirect_to pin_path
      end
    end
  end

  def forgot_password
  end

  def reset_password
    user = User.find_by(username: params[:username])

    if user && user.two_factor_auth?
      session[:two_factor] = true
      user.generate_pin!
       if TWILIO_CONFIG['token'].blank?
        flash[:error]= "Please contact an administrator for assistance."
        redirect_to pin_path
      else
        user.send_pin_to_twilio
        redirect_to pin_path
      end
    else
      flash[:notice]= "Enter your username."
      redirect_to forgot_password_path
    end
  end

  def destroy
    session[:user_id] = nil
    flash[:notice] = "You've logged out!"
    redirect_to root_path
  end

  private

    def set_user
      
    end
end