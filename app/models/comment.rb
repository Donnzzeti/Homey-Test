class Comment < ApplicationRecord
  belongs_to :project
  belongs_to :user, optional: true
  belongs_to :admin, optional: true
end
