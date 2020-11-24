class LabelsController < ApplicationController
  before_action :authenticate_user!
  before_action :admin_user
  before_action :find_label_by_id, only: [:edit, :update, :destroy]
  before_action :set_search

  def index
    if @labels.nil?
      @labels = Label.all
    end
  end

  def new
    @label = Label.new
  end

  def create
    @label = Label.new(label_params)
    if @label.save
      flash[:success] = "Label created successfully!"
      redirect_to labels_url
    else
      render 'new'
    end
  end

  def edit; end

  def update
    if @label.update_attributes(label_params)
      flash[:success] = "Label has been updated!"
      redirect_to labels_url
    else
      render 'edit'
    end
  end

  def destroy
    if @label.destroy
      flash[:success] = "Label deleted successfully!"
      redirect_back(fallback_location: labels_url)
    else
      flash[:danger] = "Label deleted fail!"
      render 'index'
    end
  end

  private

    def label_params
      params.require(:label).permit(:name, :description)
    end
    
    def admin_user
      redirect_to(root_url) unless current_user.is_admin?
    end

    def find_label_by_id
      @label = Label.find(params[:id])
    end

    def set_search
      @q = Label.ransack(params[:q])
      @labels = @q.result(distinct: true)
    end
end
