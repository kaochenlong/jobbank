class AddTagToResume < ActiveRecord::Migration[6.1]
  def change
    add_column :resumes, :tag, :string
  end
end
