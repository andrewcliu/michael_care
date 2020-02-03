class SessionsController < Devise::SessionsController
	def create
    self.resource = warden.authenticate!(auth_options)
    sign_in(resource_name, resource)
    yield resource if block_given?
    redirect_to admins_path
	end
  def after_sign_in_path_for(resource)
    sign_in_url = new_admin_session_url
    if request.referer == sign_in_url
      super
    else
			redirect_to admins_path
    end
  end
end