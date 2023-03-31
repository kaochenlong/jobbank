class AddUserIdToResume < ActiveRecord::Migration[6.1]
  def change
    # add_column :resumes, :user_id, :integer, index: true
    add_belongs_to :resumes, :user
  end
end
