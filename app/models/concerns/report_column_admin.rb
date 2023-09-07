module ReportColumnAdmin
  extend ActiveSupport::Concern
  included do
    rails_admin do
      edit do
        field :position
        field :title
        field :template do
          partial :tinymce_full
          help { bindings[:view].t("admin.form.wysiwyg_help") }
        end
        field :report_columns_content
      end
    end
  end
end
