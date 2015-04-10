class TasksController < ApplicationController

  before_action :authenticate_user!

  before_action :set_task, only: [:update, :destroy, :change]


  respond_to :html
  respond_to :json

  def index
    # @to_do = current_user.tasks.where(state: "to_do")
    # @doing = current_user.tasks.where(state: "doing")
    # @done = current_user.tasks.where(state: "done")
    respond_to do |format|
      format.html 
      format.json { render json: current_user.tasks.with_sub_tasks.to_json(include: :sub_tasks ) }
     end
  end

  def create
    respond_with current_user.tasks.with_sub_tasks.create(task_params)
  end

  def change
    @task.update_attributes(state: params[:state])
      respond_to do |format|
      format.html {redirect_to tasks_path, notice: "Task Update"}
    end
  end

   def sort
     params[:order].each do |key,value|
       Task.find(value[:id]).update_attribute(:priority,value[:position])
     end
     render :nothing => true
   end

  def update
    respond_with @task.update(task_params), location: '' 
  end

  def destroy
    respond_with @task.destroy!
  end

  private

  def set_task
    @task = current_user.tasks.with_sub_tasks.find(params[:id])
    # @task = Task.find(params[:id])

  end

  def task_params
    params.require(:task).permit(:body, :public, :completed, :sort_order, :sub_tasks, :state ,sub_tasks_attributes: [:id, :body,  :_destroy])
  end
end
