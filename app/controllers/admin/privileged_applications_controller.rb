class Admin::PrivilegedApplicationsController < ApplicationController
  before_action :set_privileged_application, only: [:show]

  def index
    @privileged_applications = PrivilegedApplication.all
  end

  def show
    @privileged_application = PrivilegedApplication.find(params[:id])
  end

  def new
    @privileged_application = PrivilegedApplication.new
  end

  def edit
    @privileged_application = PrivilegedApplication.find(params[:id])
  end

  def create
    @privileged_application = PrivilegedApplication.new(privileged_application_params)

    if @privileged_application.save
      flash[:notice] = "アプリケーションを登録しました。"
      redirect_to admin_privileged_applications_path
    else
      render :action => 'new'
    end
  end

  def update
    @privileged_application = PrivilegedApplication.find(params[:id])

    if @privileged_application.update(privileged_application_params)
      flash[:notice] = "アプリケーションの名前を変更しました。"
      redirect_to admin_privileged_applications_path
    else
      render :action => 'edit'
    end
  end

  def destroy
    @privileged_application = PrivilegedApplication.find(params[:id])
    @privileged_application.destroy
    redirect_to admin_privileged_applications_path
  end

  def log_top
    @privileged_applications = PrivilegedApplication.all
  end

  private
    def set_privileged_application
      @privileged_application = PrivilegedApplication.find(params[:id])
    end

    def privileged_application_params
      params.require(:privileged_application).permit(:name)
    end
end
