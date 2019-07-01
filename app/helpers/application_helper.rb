module ApplicationHelper
  def correct_user
    @task = current_user.tasks.find_by(id: params[:id])
      unless @task
        redirect_to root_url
      end
  end
end