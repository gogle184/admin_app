class CreateTemplateWysiwygs < ActiveRecord::Migration[7.0]
  def change
    create_table :template_wysiwygs do |t|
      t.text :title, null: false, default: "", comment: "タイトル"
      t.text :template, null: false, default: "", comment: "テンプレート"

      t.timestamps
    end
  end
end
