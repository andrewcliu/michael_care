class RegistrationsController < Devise::RegistrationsController

  # before_action :one_admin_registered?, only: [:new, :create]
  skip_before_action :require_no_authentication, only: [:create,:cancel]
  # after_action :redirect_root, only: [:update]


  protected

  # def one_admin_registered?
  #   if admin_signed_in?
  #     redirect_to root_path
  #   else
  #     redirect_to new_admin_session_path
  #   end
  # end  
	def sign_up_params
    params.require(:admin).permit(:name, :email, :password, :password_confirmation, :current_password)
  end
  def account_update_params
    params.require(:admin).permit(:name, :email, :password, :password_confirmation, :current_password)
  end

end