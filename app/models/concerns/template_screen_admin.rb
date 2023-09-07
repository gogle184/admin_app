class TemplateScreen < ApplicationRecord
  extend ActiveSupport::Concern

  included do
    rails_admin do
      object_label_method do
        :position
      end
      edit do
        field :title
        field :template do
          partial :tinymce_full  # TinyMCE パーシャルの名前に変更する
        end
      end
    end
  end
end
