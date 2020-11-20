class TasksController < ApplicationController
  def index
    @todo_tasks = Task.where(status: 1)
    @doing_tasks = Task.where(status: 2)
    @done_tasks = Task.where(status: 3)
  end

  def show
    @task = Task.find(params[:id])
  end

  def edit
    @task = Task.find(params[:id])
  end

  def update
    @task = Task.find(params[:id])
    if @task.update_attributes(task_params)
      flash[:success] = "Task has been updated!"
      redirect_to root_url
    else
      render 'edit'
    end
  end

  private

    def task_params
      params.require(:task).permit(:name, :start_date, :due_date, :description, :status)
    end
end
