class ModifyColumnNameInMKeyword < ActiveRecord::Migration[7.0]
  def change
    rename_column :m_keywords, :keyowrd, :keyword
  end
end
