import 'rails_admin/src/rails_admin/base';
import '../stylesheets/rails_admin.scss';
// eslint-disable-next-line import/no-extraneous-dependencies
import $ from 'jquery';
import { tiny } from '../rails_admin/tinymce';

function setDisabledDraftSaveButton() {
  $('#draft_save').prop('disabled', true);
}

document.addEventListener('rails_admin.dom_ready', () => {
  // wysiwyg表示対象外の画面でもここは呼ばれる為、tinymce.init()を一度行うと次に呼び出した場合
  // 表示されない為、毎回削除する必要がある
  tiny.remove();
  tiny.initialize();

  if ($('#draft_save').length) {
    $('input').keyup(() => {
      setDisabledDraftSaveButton();
    });

    $('textarea').keyup(() => {
      setDisabledDraftSaveButton();
    });

    $('input[type=checkbox]').change(() => {
      setDisabledDraftSaveButton();
    });

    $('input[type=number]').change(() => {
      setDisabledDraftSaveButton();
    });

    $('input[type=file]').change(() => {
      setDisabledDraftSaveButton();
    });

    // 単一選択のselect box
    $("select[data-enumeration='true']").change(() => {
      setDisabledDraftSaveButton();
    });

    // 複数選択のselect box
    $("select[multiple='multiple']").change((e) => {
      // select 要素でmultipleが指定されている場合、要素クリックしただけイベントが発火する。
      // その為値が選択されたかの判定を実施する必要がある
      if (!$(e.target).val().length) {
        setDisabledDraftSaveButton();
      }
    });
  }

  // rails_admin側にて対応されるまでの一時的な対応
  // 対応内容: accepts_nested_attributes_forのインスタンス新規追加ボタン押下時に表示された要素にstyle="display:block"が設定され、
  // 非表示ボタン押下時に表示されたままになる為、新規作成ボタン押下時にstyle="display:block"を削除し、cssクラス: showを設定する
  // 参考ソース: https://github.com/railsadminteam/rails_admin/blob/687867035b3a917623a3ccb01e07af0e532f47fa/src/rails_admin/nested-form-hooks.js#L18
  $(document).on('nested:fieldAdded', 'form', (content) => {
    const parentGroup = content.field.closest('.control-group');
    const controls = parentGroup.children('.controls');
    const nav = controls.children('.nav');
    const tabContent = parentGroup.children('.tab-content');

    if (tabContent.css('display') === 'block') {
      tabContent.css('display', '');
      tabContent.addClass('show');
    }

    if (nav.css('display') === 'block') {
      nav.css('display', '');
      nav.addClass('show');
    }
  });

  $(() => {
    // eslint-disable-next-line func-names
    $(document).on('click', '[data-bs-target]', async function (content) {
      // 子要素・孫要素からclassを削除する為には、rails_admin側の処理が完了した後に行う必要があるため、スリープを実施
      // ローカル環境で試したところ、400msだと必ず削除できたので安全のため500msに設定
      const _sleep = (ms) => new Promise((resolve) => setTimeout(resolve, ms));
      await _sleep(500);

      // rails_admin側で修正が入った場合、初期表示時はコンテンツ・タブは非表示(v2の仕様も同様)になると思われるので、
      // 表示した要素より下位階層のaccepts_nested_attributes_forの要素を非表示する
      if (!$(this).hasClass('disabled')) {
        if ($(this).has('i.fa-chevron-down').length) {
          const parentGroup = content.target.closest('div.control-group');
          Array.from(parentGroup.children).forEach((e) => {
            if ($(e).attr('class').includes('tab-content')) {
              $(e)
                .find('.nav-tabs')
                .each((_, e3) => {
                  $(e3).removeClass('show');
                });

              $(e)
                .find('.tab-content')
                .each((index, e3) => {
                  $(e3).removeClass('show');
                });
            }
          });
        }
      }
    });
  });
});
