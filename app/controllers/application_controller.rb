class ApplicationController < ActionController::Base
 
  protect_from_forgery

  rescue_from CanCan::AccessDenied do |exception|
    flash[:error] = "Access denied!"
    redirect_to root_url
  end

  unless Rails.application.config.consider_all_requests_local
    rescue_from Exception, with: :render_500
    rescue_from ActiveRecord::RecordNotFound, 
                ActionController::RoutingError, with: :render_404 
  end


  def after_sign_in_path_for(resource)
    ideas_path
  end
  
  protected

  def login_required
    redirect_to new_user_session_path, notice: "You need to sign in " and return false unless current_user
  end
  
  def index
    if params[:tag]
      @articles = Article.tagged_with(params[:tag])
    else
      @articles = Article.all
    end
  end

  [404, 500].each do |code|
    define_method "render_#{code}" do
      render "errors/#{code}", :layout => 'error', :status => code
    end  
  end

end
