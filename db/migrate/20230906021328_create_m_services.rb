class CreateMServices < ActiveRecord::Migration[7.0]
  def change
    create_table :m_services do |t|
      t.boolean :is_royalty, null: false, default: true, comment: "ロイヤリティ"
      t.boolean :is_browsing_history, null: false, default: true, comment: "閲覧履歴"
      t.boolean :is_japan_concierge, null: false, default: true, comment: "お気に入り履歴"
      t.boolean :is_ai_concierge, null: false, default: true, comment: "AIコンシェルジュ"
      t.boolean :is_questionnaire, null: false, default: true, comment: "募集アンケート"
      t.boolean :is_keyword, null: false, default: true, comment: "キーワード"

      t.timestamps
    end
  end
end
