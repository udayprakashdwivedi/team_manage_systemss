class CreateTeamMembers < ActiveRecord::Migration[7.2]
  def change
    create_table :team_members do |t|
      t.references :team, null: false, foreign_key: true
      t.references :user, null: false, foreign_key: true
      t.string :role

      t.timestamps
    end
  end
end
