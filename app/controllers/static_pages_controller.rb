class StaticPagesController < ApplicationController
  def home
    unless user_signed_in?
      render 'static_pages/home'
    else
      redirect_to tasks_url
    end
  end
end
