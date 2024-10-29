# frozen_string_literal: true

# app/controllers/comments_controller.rb

# Controller for managing comments on projects.
# Handles actions such as creating comments.
class CommentsController < ApplicationController
  before_action :authenticate_user!, unless: -> { current_admin }

  # POST /projects/:project_id/comments
  # Creates a new comment for a specific project.
  def create
    @project = Project.find(params[:project_id])
    @comment = @project.comments.build(comment_params)
    if current_user
      @comment.user = current_user
    elsif current_admin
      @comment.admin = current_admin
    end
    if @comment.save
      respond_to do |format|
        format.html { redirect_to @project }
        format.json { render json: @comment }
      end
    else
      render 'projects/show'
    end
  end

  private

  # Strong parameters for comment creation.
  # @return [ActionController::Parameters] the permitted parameters
  def comment_params
    params.require(:comment).permit(:content)
  end
end