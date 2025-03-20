class AgentsController < ApplicationController
  def create
    if params[:task].present?
      RunAgentJob.perform_later(params[:task], Current.user)
    end
  end
end
