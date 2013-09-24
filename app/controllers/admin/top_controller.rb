class Admin::TopController < AdminController
  #before_action :set_log, only: [:show, :edit, :update, :destroy]
  layout 'application'

  def index
    @logs = Log.all
  end
end
