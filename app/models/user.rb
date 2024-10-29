class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :comments, dependent: :destroy
  has_many :status_changes, dependent: :destroy
  has_many :project_whitelists, dependent: :destroy
  has_many :whitelisted_projects, through: :project_whitelists, source: :project

  def admin?
    admin
  end
end
