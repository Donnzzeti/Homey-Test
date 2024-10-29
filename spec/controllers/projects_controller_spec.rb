# spec/controllers/projects_controller_spec.rb
require 'rails_helper'

RSpec.describe ProjectsController, type: :controller do
  let(:user) { create(:user) }
  let(:admin) { create(:admin) }
  let(:project) { create(:project) }
  let(:whitelisted_user) { create(:project_whitelist, project_id: project.id, user_id: user.id) }

  before do
    sign_in user
    allow(controller).to receive(:current_user).and_return(user)
    allow_any_instance_of(Project).to receive(:whitelisted_users).and_return([user])
  end

  describe 'GET #index' do
    it 'returns a success response' do
      get :index
      expect(response).to be_successful
    end
  end

  describe 'GET #show' do
    it 'returns a success response' do
      get :show, params: { id: project.id }
      expect(response).to be_successful
    end
  end

  describe 'POST #create' do
    context 'with valid params' do
      it 'creates a new Project' do
        expect {
          post :create, params: { project: attributes_for(:project) }
        }.to change(Project, :count).by(1)
      end

      it 'redirects to the created project' do
        post :create, params: { project: attributes_for(:project) }
        expect(response).to redirect_to(Project.last)
      end
    end
  end

  describe 'PATCH #update' do
    context 'with valid params' do
      it 'updates the requested project' do
        patch :update, params: { id: project.id, project: { name: 'Updated Name' } }
        project.reload
        expect(project.name).to eq('Updated Name')
      end

      it 'redirects to the project' do
        patch :update, params: { id: project.id, project: { name: 'Updated Name' } }
        expect(response).to redirect_to(project)
      end
    end
  end

  describe 'POST #add_to_whitelist' do
    context 'when user does not exist' do
      it 'redirects with an alert' do
        post :add_to_whitelist, params: { id: project.id, email: 'nonexistent@example.com' }
        expect(response).to redirect_to(add_to_whitelist_project_path)
        expect(flash[:alert]).to eq('User does not exist.')
      end
    end
  end
end