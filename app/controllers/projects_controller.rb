# frozen_string_literal: true

# app/controllers/projects_controller.rb

# Controller for managing projects.
# Handles actions such as creating, updating, showing, and whitelisting users for projects.
class ProjectsController < ApplicationController
  before_action :authenticate_user!, unless: -> { current_admin }
  before_action :set_project, only: [:show, :edit, :update, :add_to_whitelist]
  before_action :authorize_user!, only: [:show, :edit, :update, :add_to_whitelist]

  # GET /projects
  # Retrieves and displays all projects.
  def index
    @projects = Project.all
  end

  # GET /projects/:id
  # Displays a specific project along with its comments and status changes.
  def show
    @comments = @project.comments
    @status_changes = @project.status_changes
  end

  # GET /projects/new
  # Initializes a new project.
  def new
    @project = Project.new
  end

  # POST /projects
  # Creates a new project and adds the current user to the whitelist.
  def create
    @project = Project.new(project_params)
    if @project.save
      @project.whitelisted_users << current_user
      redirect_to @project
    else
      render :new
    end
  end

  # GET /projects/:id/edit
  # Retrieves a project for editing.
  def edit
  end

  # PATCH/PUT /projects/:id
  # Updates a specific project and logs the status change.
  def update
    if @project.update(project_params)
      @project.status_changes.create(status: @project.status, user: current_user, admin: current_admin)
      respond_to do |format|
        format.html { redirect_to @project }
        format.json { render json: @project }
      end
    else
      render :edit
    end
  end

  # POST /projects/:id/add_to_whitelist
  # Adds a user to the project's whitelist based on their email.
  def add_to_whitelist
    return unless request.post?

    user = find_user_by_email(params[:email])
    return redirect_to add_to_whitelist_project_path, alert: 'User does not exist.' unless user

    if user_already_whitelisted?(user)
      redirect_to add_to_whitelist_project_path, alert: 'User has already been added to the whitelist.'
    else
      @project.whitelisted_users << user
      redirect_to @project, notice: 'User added to whitelist.'
    end
  end

  private

  # Finds a user by their email.
  # @param email [String] the email of the user to find
  # @return [User, nil] the user if found, otherwise nil
  def find_user_by_email(email)
    User.find_by(email: email)
  end

  # Checks if a user is already whitelisted for the project.
  # @param user [User] the user to check
  # @return [Boolean] true if the user is already whitelisted, otherwise false
  def user_already_whitelisted?(user)
    @project.whitelisted_users.exists?(user.id)
  end

  # Sets the project based on the provided ID.
  def set_project
    @project = Project.find(params[:id])
  end

  # Authorizes the user to ensure they have access to the project.
  def authorize_user!
    unless current_admin.is_a?(Admin) || @project.whitelisted_users.include?(current_user)
      redirect_to projects_path, alert: 'You are not authorized to view this project.'
    end
  end

  # Strong parameters for project creation and update.
  # @return [ActionController::Parameters] the permitted parameters
  def project_params
    params.require(:project).permit(:name, :status)
  end
end