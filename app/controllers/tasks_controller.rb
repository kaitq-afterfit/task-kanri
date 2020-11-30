class TasksController < ApplicationController
  before_action :authenticate_user!
  before_action :correct_owner, only: [:edit, :update, :destroy]
  before_action :users_list, only: [:new, :edit]
  before_action :find_task_by_id, only: [:show, :edit, :update, :destroy]
  before_action :set_search

  def index
    if @tasks.nil?
      @tasks = Task.all
    end
    @todo_tasks = @tasks.where(status: Task.statuses[:todo])
    @doing_tasks = @tasks.where(status: Task.statuses[:doing])
    @done_tasks = @tasks.where(status: Task.statuses[:done])
  end

  def show; end

  def new
    @task = Task.new
  end

  def create
    puts @task
    @task = Task.new(task_params)
    @task.user = current_user
    if @task.save
      flash[:success] = "Task created successfully!"
      redirect_to tasks_url
    else
      render 'new'
    end
  end

  def edit; end

  def update
    if @task.update_attributes(task_params)
      flash[:success] = "Task has been updated!"
      redirect_to tasks_url
    else
      render 'edit'
    end
  end

  def destroy
    if @task.destroy
      flash[:success] = "Task deleted successfully!"
      redirect_back(fallback_location: tasks_url)
    else
      flash.now[:danger] = "Task delete failed!"
      render 'index'
    end
  end

  def change_status
    @task = Task.find(params[:t_id])
    prev_status = @task.status
    respond_to do |format|
      if @task.update_attributes(status: params[:t_des_status])
        format.json { render json: @task, status: 200, location: @task }
      else
        format.json { render json: @task.errors, status: :unprocessable_entity }
      end
    end
  end
  
  private

    def task_params
      params.require(:task).permit(:name, :start_date, :due_date, :description, :status, assignee_ids: [])
    end

    def users_list
      @users = User.all
    end

    def find_task_by_id
      @task = Task.find(params[:id])
    end

    def correct_owner
      @task = current_user.tasks.find_by(id: params[:id])
      redirect_to root_url if @task.nil?
    end

    def set_search
      @q = Task.ransack(params[:q])
      @tasks = @q.result(distinct: true).includes(:labels, :assignees)
    end
end
