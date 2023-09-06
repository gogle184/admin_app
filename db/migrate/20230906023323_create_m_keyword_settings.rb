class CreateMKeywordSettings < ActiveRecord::Migration[7.0]
  def change
    create_table :m_keyword_settings do |t|
      t.text :exclud_url, null: false, default: "", comment: "除外URL"
      t.string :exclud_tag, null: false, default: "", comment: "除外HTMLタグ"

      t.timestamps
    end
  end
end

#【マスタ】コンテンツを検索するための情報(キーワード) m_keyword_setting
