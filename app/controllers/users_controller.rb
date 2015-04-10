class UsersController < ApplicationController
  
  before_action :authenticate_user!
  
  def index
    @users = User.includes(:tasks).includes(tasks: :sub_tasks).all
  end

  def show
    @user = User.with_public_tasks.where(id: params[:id]).first
    redirect_to users_path, notice: "Desculpe, este usuário não tem funções públicas" unless @user.present?
  end

private

  def task_params
    params.require(:task).permit(:ddd, :celular, :genero, :graduacao, :matricula)
  end
end
