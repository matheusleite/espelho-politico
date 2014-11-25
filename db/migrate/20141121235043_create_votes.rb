class CreateVotes < ActiveRecord::Migration
  def change
    create_table :votes do |t|
      t.references :user
      t.references :proposition
      t.references :parliamentarian
      t.references :themes
      t.boolean :approved? , default: false
    end
    add_index(
      :votes,
      [:user_id, :proposition_id],
      unique: true
    )
  end
end
