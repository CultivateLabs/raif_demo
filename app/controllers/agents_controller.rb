class AgentsController < ApplicationController
  def create
    if params[:task].present?
      RunAgentJob.perform_later(params[:task], current_user)
    end
  end
end
