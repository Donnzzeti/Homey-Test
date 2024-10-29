# app/models/project_whitelist.rb
class ProjectWhitelist < ApplicationRecord
  belongs_to :project
  belongs_to :user
end