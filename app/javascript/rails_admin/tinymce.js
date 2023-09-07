import tinymce from 'tinymce/tinymce';

import 'tinymce/icons/default';
import 'tinymce/themes/silver';

import 'tinymce/plugins/advlist';
import 'tinymce/plugins/autolink';
import 'tinymce/plugins/anchor';
import 'tinymce/plugins/charmap';
import 'tinymce/plugins/code';
import 'tinymce/plugins/emoticons/js/emojis';
import 'tinymce/plugins/fullscreen';
import 'tinymce/plugins/image';
import 'tinymce/plugins/insertdatetime';
import 'tinymce/plugins/hr';
// The following deprecated features are currently enabled, these will be removed in TinyMCE 6.0.
// imagetoolsは6.0よりプレミアムプランへ移行される為、無料版で利用できるのはv5系まで
// import 'tinymce/plugins/imagetools';
import 'tinymce/plugins/nonbreaking';
import 'tinymce/plugins/link';
import 'tinymce/plugins/lists';
import 'tinymce/plugins/preview';
// import 'tinymce/plugins/quickbars';
import 'tinymce/plugins/searchreplace';
import 'tinymce/plugins/table';
import 'tinymce/plugins/wordcount';

import 'tinymce/skins/ui/oxide/skin.css';

import 'tinymce-i18n/langs/ja';
import 'tinymce-i18n/langs5/ja';

// tiny-i18nには曜日の翻訳がない為追加
tinymce.addI18n('ja', {
  Mon: '月',
  Tue: '火',
  Wed: '水',
  Thu: '木',
  Fri: '金',
  Sat: '土',
  Sun: '日',
  Monday: '月曜日',
  Tuesday: '火曜日',
  Wednesday: '水曜日',
  Thursday: '木曜日',
  Friday: '金曜日',
  Saturday: '土曜日',
  Sunday: '日曜日',
});

// eslint-disable-next-line import/prefer-default-export
export const tiny = {
  remove() {
    tinymce.remove();
  },
  initialize() {
    // 参考サイト: https://www.tiny.cloud/docs/configure/file-image-upload/
    tinymce.init({
      automatic_uploads: true, // falseに設定すると画像が挿入されたタイミングで非同期通信を行わない
      block_formats: '段落=p;見出し 1=h2;見出し 2=h3;見出し 3=h4;見出し 4=h5;見出し 5=h6',
      content_css: false,
      file_picker_types: 'image',
      forced_root_block: 'p',
      image_class_list: [
        { title: '指定なし', value: '' },
        { title: '横幅100%', value: 'w-100' },
      ],
      images_upload_url: '/wysiwyg/upload_image',
      images_file_types: 'jpg,svg,webp,jpeg,png',
      images_reuse_filename: true,
      images_upload_credentials: true,
      insertdatetime_formats: ['%Y/%m/%d', '%Y/%m/%d(%a)', '%A', '%H:%M:%S', '%p %I:%M:%S'],
      min_height: 500,
      language: 'ja',
      plugins:
        'advlist anchor autolink charmap code fullscreen hr insertdatetime link lists nonbreaking preview searchreplace table wordcount',
      menubar: 'file edit view insert format tools table',
      relative_urls: false, // これをfalseにしないと相対パスで保存されてしまう
      selector: '.tinymce',
      skin: false,
      valid_children: "+body[style]",
      extended_valid_elements: "script[async|src]",
      toolbar:
        'undo redo | code | bold italic underline strikethrough | alignleft aligncenter alignright alignjustify | numlist bullist | fontselect fontsizeselect formatselect | forecolor backcolor removeformat | outdent indent | table tabledelete | charmap | fullscreen preview | image link anchor | image_right_text_left image_left_text_right',
      file_picker_callback: (cb) => {
        // このカスタマイズがないとローカル画像を登録する際の方法が1つ(plugin: quickbars)しかなく分かりにくい
        // 標準のままだとローカル画像の取り込みが出来ずURL指定となる。
        // plugin: quickbarsを利用するとtextarea内をクリック or 改行すると画像とテーブルの挿入アイコンが表示され、そこからローカル画像が取り込める
        // 以下のカスタマイズは標準の画像ダイアログにボタンを配置しローカル画像を取り込めるようにする
        // 参考サイト: https://www.tiny.cloud/docs/configure/file-image-upload/#file_picker_types の上部にあるexample jsを利用
        const input = document.createElement('input');
        input.setAttribute('type', 'file');
        input.setAttribute('accept', 'image/*');

        /*
          Note: In modern browsers input[type="file"] is functional without
          even adding it to the DOM, but that might not be the case isn some older
          or quirky browsers like IE, so you might want to add it to the DOM
          just in case, and visually hide it. And do not forget do remove it
          once you do not need it anymore.
        */

        input.onchange = function f() {
          const file = this.files[0];

          const reader = new FileReader();
          reader.onload = function _f() {
            /*
              Note: Now we need to register the blob in TinyMCEs image blob
              registry. In the next release this part hopefully won't be
              necessary, as we are looking to handle it internally.
            */
            const id = `blobid${new Date().getTime()}`;
            const { blobCache } = tinymce.activeEditor.editorUpload;
            const base64 = reader.result.split(',')[1];
            const blobInfo = blobCache.create(id, file, base64);
            blobCache.add(blobInfo);

            /* call the callback and populate the Title field with the file name */
            cb(blobInfo.blobUri(), { title: file.name });
          };
          reader.readAsDataURL(file);
        };

        input.click();
      },
      setup: (editor) => {
        editor.on('change', () => {
          $('#draft_save').prop('disabled', true);
        });
      },
    });
  },
};
