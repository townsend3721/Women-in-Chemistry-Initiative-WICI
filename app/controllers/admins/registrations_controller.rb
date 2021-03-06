class Admins::RegistrationsController < Devise::RegistrationsController
  include Accessible
  before_action :set_admin, only: [:approve, :destroy]
  before_action -> {authenticate_admin!(force: true)}, only: [:approve, :index, :destroy]
  skip_before_action :check_user, except: [:new, :create]


  def index
    @admins = Admin.list_by_approval
    @volunteers = Volunteer.list_by_approval
  end

  def approve
    @admin.approve
    redirect_to accounts_path, notice: "Admin approved."
  end

  def destroy
    if current_admin == @admin
      redirect_to accounts_path, notice: "Cannot delete the logged in admin."
    else
      @admin.destroy
      redirect_to accounts_path, notice: "Admin deleted."
    end
  end

  def toggle_donation_show
    Donation.show_toggle
    redirect_to accounts_path
  end

  private

  def set_admin
    @admin = Admin.find(params[:id])
  end
end
