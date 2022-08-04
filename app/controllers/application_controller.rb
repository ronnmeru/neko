class ApplicationController < ActionController::Base
before_action :configure_permitted_parameters, if: :devise_controller?
before_action :set_search
def set_search
  #@search = Article.search(params[:q])
  @search = Post.ransack(params[:q]) #ransackメソッド推奨
  @search_post = @search.result
end

    def after_sign_in_path_for(resource)
         user_path(current_user.id)
    end


    private

    def configure_permitted_parameters
         devise_parameter_sanitizer.permit(:sign_up,keys:[:email, :password, :password_confirmation])
    end
end
