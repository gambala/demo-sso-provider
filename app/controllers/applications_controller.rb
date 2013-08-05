class ApplicationsController < ApplicationController
  before_filter :check_authentication

  def index
    @account = Account.find(session[:account_id])
  end
  def show
    @account = Account.find(session[:account_id])
    @application = @account.applications.find(params[:id])
  end
  def new
    @account = Account.find(session[:account_id])
    @application = Application.new
  end
  def edit
    @account = Account.find(session[:account_id])
    @application = @account.applications.find(params[:id])
  end
  def create
    @application = Application.new(params[:application].merge( {account_id: session[:account_id]} ))

    if @application.save
      redirect_to @application, notice: 'Application was successfully created.'
    else
      render action: "new"
    end
  end
  def update
    @account = Account.find(session[:account_id])
    @application = @account.applications.find(params[:id])

    if @application.update_attributes(params[:application])
      redirect_to @application, notice: 'Application was successfully updated.'
    else
      render action: "edit"
    end
  end
  def destroy
    @application = Application.find(params[:id])
    @application.destroy

    redirect_to applications_url
  end
end
