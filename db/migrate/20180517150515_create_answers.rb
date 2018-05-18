class CreateAnswers < ActiveRecord::Migration[5.2]
  def change
    create_table :answers do |t|
      t.integer :question_id, null: false
      t.text :description, null: false
      t.boolean :best_answer

      t.timestamps null: false
    end
  end
end
