class CustomAuthenticationFailure < Devise::FailureApp 
  protected 

    def redirect_url 
      '/users/auth/facebook' 
    end 

end 