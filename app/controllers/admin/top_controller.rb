class Admin::TopController < AdminController
  #before_action :set_log, only: [:show, :edit, :update, :destroy]
  layout 'application'

  def index
    redirect_to log_top_admin_privileged_applications_path
  end
end
