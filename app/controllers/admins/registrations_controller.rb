# frozen_string_literal: true

class Admins::RegistrationsController < Devise::RegistrationsController
  include Accessible
  before_action :set_admin, only: [:approve, :destroy]
  before_action :authenticate, only: [:approve, :index, :destroy]
  skip_before_action :check_user, except: [:new, :create]


  def index
    @admins = Admin.all.order(:approved)
    @volunteers = Volunteer.all.order(:approved)
  end

  def approve
    @admin.approve
    redirect_to accounts_path, notice: "Admin approved."
  end

  def destroy
    @admin.destroy
    redirect_to accounts_path, notice: "Admin deleted." if @admin.destroy
  end

  private

  def set_admin
    @admin = Admin.find(params[:id])
  end


  def authenticate
    redirect_to root_path if not admin_signed_in?
  end
end
