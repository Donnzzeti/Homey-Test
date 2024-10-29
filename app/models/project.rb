# app/models/project.rb
class Project < ApplicationRecord
  has_many :comments, dependent: :destroy
  has_many :status_changes, dependent: :destroy
  has_many :project_whitelists, dependent: :destroy
  has_many :whitelisted_users, through: :project_whitelists, source: :user
end