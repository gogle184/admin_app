module ReportAdmin
  extend ActiveSupport::Concern

  included do
    rails_admin do
      list do
        checkboxes false
        sort_by :created_at
        search_by :custom_search

        field :preview_button do
          formatted_value do
            bindings[:view].render "preview_icon", object: bindings[:object]
          end
        end
        field :title do
          filterable false
          queryable true
          pretty_value do
            path = bindings[:view].edit_path(model_name: @abstract_model.to_param, id: bindings[:object].id)
            bindings[:view].content_tag(:a, value, href: path)
          end
        end
        field :author_name do
          queryable true
        end
        field :list_body do
          visible false
          filterable false
          queryable true
        end
        field :update_administrator do
          visible { bindings[:view].current_administrator.administrator_status.authority == 1 }
        end
        field :report_accesses do
          label "週間PV"
          pretty_value do
            value.from_last_week.map(&:count).sum
          end
          visible { bindings[:view].current_administrator.administrator_status.authority == 1 }
        end
        field :report_accesses_total do
          label "合計PV"
          pretty_value do
            bindings[:object].report_accesses.map(&:count).sum
          end
          visible { bindings[:view].current_administrator.administrator_status.authority == 1 }
        end
        field :is_public
        field :pub_term do
          label "掲載期間"
          formatted_value do
            "#{bindings[:object].pub_date_from&.strftime("%Y/%m/%d %H:%M")} 〜 \
            #{bindings[:object].pub_date_to&.strftime("%Y/%m/%d %H:%M")}"
          end
        end
        field :updated_at
        # 検索用
        field :m_article_categories, :enum do
          enum do
            MArticleCategory.order(:position).map { |t| [t.name, t.id] }.to_a
          end
          visible false
          filterable true
          searchable [{ MArticleCategory => :id }]
          eager_load true
        end
        field :m_seasons, :enum do
          enum do
            MSeason.order(:position).map { |t| [t.name, t.id] }.to_a
          end
          visible false
          searchable [{ MSeason => :id }]
          filterable true
          eager_load true
        end
        field :m_areas, :enum do
          enum do
            MArea.order(:position).map { |t| [t.name, t.id] }.to_a
          end
          visible false
          searchable [{ MArea => :id }]
          filterable true
          eager_load true
        end
        field :is_pr do
          visible false
          filterable true
          queryable true
        end
        field :is_smart_news do
          visible false
          filterable true
          queryable true
        end
        field :is_enjoy_mie do
          visible false
          filterable true
          queryable true
        end
        field :is_camera_bu do
          visible false
          filterable true
          queryable true
        end
        field :keyword do
          visible false
          filterable false
          queryable true
          searchable true
        end
        field :administrator do
          visible false
          filterable true
          queryable true
          searchable [:name]
        end
        field :pub_date_from do
          visible false
          queryable true
        end
        field :pub_date_to do
          visible false
          queryable true
        end
      end

      show do
        field :is_public
        field :admin_update_memo do
          visible { bindings[:view].current_administrator.administrator_status.authority == 1 }
        end
        field :created_at_with_create_administrator do
          visible { bindings[:view].current_administrator.administrator_status.authority == 1 }
        end
        field :update_at_with_update_administrator do
          visible { bindings[:view].current_administrator.administrator_status.authority == 1 }
        end
        field :created_at
        field :updated_at
        field :administrator
        field :is_enjoy_mie
        field :is_camera_bu
        field :is_smart_news
        field :smart_news_end_date
        field :origin_url
        field :display_created_at
        field :pub_date_from
        field :pub_date_to
        field :interview_date
        field :title
        field :lead
        field :list_body
        field :meta_description
        field :is_display_date
        field :m_areas
        field :m_article_categories
        field :m_seasons
        field :keyword
        field :image do
          pretty_value do
            bindings[:view].render "image_list", images: [value] if value.present?
          end
        end
        field :report_files
        field :lat, :map do
          default_zoom_level 12
          google_api_key ENV["GOOGLE_API_KEY_FOR_ADMIN"]
          longitude_field :lng
          map_height 400
          map_label "地図"
          visible { value.present? }
        end
        field :spots
        # コラムをパーシャルで表示。パーシャルなしだとタイトルのみ表示
        field :report_columns do
          pretty_value do
            bindings[:view].render "report_columns", columns: value
          end
        end
        field :author_image
        field :author_name
        field :author_comment
        group :pr do
          field :is_pr
          field :ad_fee
          field :ad_date_from
          field :ad_date_to
        end
      end

      edit do
        field :submit_buttons do
          partial :submit_buttons
          help ""
        end

        field :is_public do
          read_only { bindings[:view].current_administrator.administrator_status.authority != 1 }
          help "公開する場合はチェックしてください"
        end
        field :admin_update_memo do
          visible { bindings[:view].current_administrator.administrator_status.authority == 1 }
          html_attributes rows: 10
        end
        field :create_administrator do
          visible { bindings[:view].current_administrator.administrator_status.authority == 1 }
          read_only true
          help ""
        end
        field :update_administrator do
          visible { bindings[:view].current_administrator.administrator_status.authority == 1 }
          read_only true
          help ""
        end
        field :create_administrator_id, :hidden do
          default_value do
            bindings[:view].current_administrator.id
          end
        end
        field :update_administrator_id, :hidden do
          def value
            bindings[:view].current_administrator.id
          end
        end
        field :created_at do
          read_only true
          help ""
        end
        field :updated_at do
          read_only true
          help ""
        end
        field :administrator_id, :enum do
          enum do
            if bindings[:view].current_administrator.administrator_status.authority == 1
              Administrator.where(has_privilege: false).order(:name).map { |a| [a.name, a.id] }.to_a
            else
              [[bindings[:view].current_administrator.name, bindings[:view].current_administrator.id]]
            end
          end
          required true
          formatted_value do
            if bindings[:object].administrator.present?
              [bindings[:object].administrator.name, bindings[:object].administrator.id]
            else
              [bindings[:view].current_administrator.name, bindings[:view].current_administrator.id]
            end
          end
          help { bindings[:view].content_tag(:span, bindings[:view].t("admin.form.required"), class: "text-danger") }
        end

        field :is_enjoy_mie do
          visible { bindings[:view].current_administrator.administrator_status.authority == 1 }
        end
        field :is_camera_bu do
          visible { bindings[:view].current_administrator.administrator_status.authority == 1 }
        end
        field :is_smart_news do
          visible { bindings[:view].current_administrator.administrator_status.authority == 1 }
        end
        field :smart_news_end_date do
          visible { bindings[:view].current_administrator.administrator_status.authority == 1 }
        end
        field :origin_url do
          visible { bindings[:view].current_administrator.administrator_status.authority == 1 }
          help {
            bindings[:view].tag(:span) + "オリジナル記事が存在する際に重複コンテンツを回避するため使用します。" +
              bindings[:view].tag(:br) + "入力された内容がcanonicalタグに設定されURLが正規化されます。"
          }
        end
        field :display_created_at do
          default_value do
            Time.zone.now
          end
        end
        field :pub_date_from do
          default_value do
            Time.zone.now
          end
          help { bindings[:view].content_tag(:span, bindings[:view].t("admin.form.required"), class: "text-danger") }
        end
        field :pub_date_to
        field :interview_date
        field :title do
          help { bindings[:view].content_tag(:span, bindings[:view].t("admin.form.required"), class: "text-danger") }
        end
        field :lead do
          help { bindings[:view].content_tag(:span, bindings[:view].t("admin.form.required"), class: "text-danger") }
        end
        field :list_body do
          help {
            bindings[:view].content_tag(:span, bindings[:view].t("admin.form.required"), class: "text-danger") +
              bindings[:view].tag(:br) +
              "空欄の場合、リード文が入ります。リード文が長いときに、一覧表示用として短く分かりやすくした説明（60～70文字を目安）を入力してください"
          }
          html_attributes rows: 10
        end
        field :meta_description do
          help {
            bindings[:view].tag(:span) + I18n.t("admin.form.meta_description") +
              bindings[:view].tag(:br) + "空欄の場合、リード文が入ります"
          }
          html_attributes rows: 5
        end
        field :is_display_date do
          visible { bindings[:view].current_administrator.administrator_status.authority == 1 }
        end
        field :m_areas do
          inline_add do
            bindings[:view].current_administrator.has_privilege
          end
        end
        field :m_article_categories do
          inline_add do
            bindings[:view].current_administrator.has_privilege
          end
        end
        field :m_seasons do
          inline_add do
            bindings[:view].current_administrator.has_privilege
          end
        end
        field :keyword do
          help {
            bindings[:view].content_tag(:span, "任意のキーワードを検索対象とする場合にスペース区切りで入力してください。") +
              bindings[:view].tag(:br) + "追加キーワードはMETAタグにも使用されます。"
          }
        end
        field :report_image
        field :report_files
        field :lat, :map do
          default_latitude ENV.fetch("START_LAT")
          default_longitude ENV.fetch("START_LNG")
          default_zoom_level 12
          google_api_key ENV["GOOGLE_API_KEY_FOR_ADMIN"]
          longitude_field :lng
          map_height 400
          map_label "位置情報"
        end
        field :spots
        field :report_columns
        field :author_image, :active_storage do
          delete_method :remove_asset
          help {
            bindings[:view].tag(:span) + I18n.t("admin.form.image_format") +
              bindings[:view].tag(:br) + I18n.t("admin.form.image_size") +
              bindings[:view].tag(:br) + "著者画像を設定する場合は著者名も入力してください"
          }
          image true
        end
        field :author_name
        field :author_comment do
          html_attributes rows: 10
        end
        field :user_update_memo do
          html_attributes rows: 10
        end

        group :pr do
          active false
          label "広告・PR設定"
          help "広告・PR記事の場合は入力してください"

          field :is_pr do
            help "広告・PR記事の場合はチェックを入れてください"
          end
          field :ad_fee
          field :ad_date_from do
            default_value { Time.zone.now }
          end
          field :ad_date_to
        end
      end

      export do
        field :is_public
        field :create_administrator, :string do
          pretty_value do
            value.name
          end
        end
        field :update_administrator, :string do
          pretty_value do
            value.name
          end
        end
        field :created_at
        field :updated_at
        field :administrator, :string do
          pretty_value do
            value.name
          end
        end
        field :is_enjoy_mie
        field :is_camera_bu
        field :is_smart_news
        field :smart_news_end_date
        field :origin_url
        field :display_created_at
        field :pub_date_from
        field :pub_date_to
        field :interview_date
        field :title
        field :lead
        field :list_body
        field :meta_description
        field :is_display_date
        field :m_areas, :string do
          pretty_value do
            value.map { |t| t.name }.join(" ")
          end
        end
        field :m_article_categories, :string do
          pretty_value do
            value.map { |t| t.name }.join(" ")
          end
        end
        field :m_seasons, :string do
          pretty_value do
            value.map { |t| t.name }.join(" ")
          end
        end
        field :keyword
        field :lat
        field :lng
        field :report_columns
        field :is_pr
        field :ad_fee
        field :ad_date_from
        field :ad_date_to
        field :admin_update_memo
        field :user_update_memo
        # listでフィルター用にeager_loadしている関連モデルは、exportでもeager_loadが必要
        %i[update_administrator m_article_categories m_seasons m_areas].each do |associate|
          configure associate do
            eager_load true
          end
        end
      end
    end
  end
end
