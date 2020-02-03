class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  include Pundit
  include ApplicationHelper

  rescue_from Pundit::NotAuthorizedError, with: :admin_not_authorized
  # $browser = Browser.new("Some User Agent", accept_language: "en-us")
  def need_authorization 
    unless no_auth.map{|e|e.downcase.pluralize}.include?(params[:controller])
      authorize this
    end
  end

  def form_field
    %w''
  end

  def self.form_field 
    %w''
  end

  def index
    need_authorization
  end

  def create
    authorize this
    ab=this.create(priv_params) 
    if ab.valid?
      flash[:notice]='Item successfully created'
        redirect_to send("admins_path")
      flash[:notice]='Item successfully created'
    else 
      flash[:error]=ab.errors.full_messages
    end
  end

  def new
    need_authorization
  end

  def update
    model_name=this.find(params[:id])
    authorize model_name
    model_name.update_attributes(priv_params)
    # this==Task ? path=admins_path : path=send("#{controller_name}_path")
    redirect_to admins_path
  end

  def edit
    need_authorization
  end

  def destroy
    model_name=this.find(params[:id])
    authorize model_name
    model_name.destroy
    # unless this==Task
    #   respond_to do |format|
    #     format.html { redirect_to send("#{controller_name}_path"), notice: "#{model_name} was successfully destroyed." }
    #   end
    # else
    redirect_to admins_path 
    # end
  end


  private 

  def priv_params
    p=this.model_name.singular.to_sym
    params.require(p).permit(
      attribute_keys(this).each do |f| 
        f
      end
    ) 
  end

  def admin_not_authorized
    unless current_admin.present?
      redirect_to root_path
      flash[:notice] = 'You are not authorized'
    end
  end
end
