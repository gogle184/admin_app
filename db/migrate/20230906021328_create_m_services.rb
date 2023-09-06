class CreateMServices < ActiveRecord::Migration[7.0]
  def change
    create_table :m_services do |t|
      t.boolean :is_royalty
      t.boolean :is_browsing_history
      t.boolean :is_japan_concierge
      t.boolean :is_ai_concierge
      t.boolean :is_questionnaire
      t.boolean :is_keyword

      t.timestamps
    end
  end
end
