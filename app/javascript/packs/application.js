import { create } from 'tinymce';

document.addEventListener('DOMContentLoaded', () => {
  const textareas = document.querySelectorAll('textarea.tinymce');
  textareas.forEach((textarea) => {
    create({
      target: textarea,
      skin: false,
      content_css: false,
      branding: false,
      menubar: false,
      ...YOUR_OTHER_TINYMCE_OPTIONS_HERE // 必要に応じて他のオプションを追加
    });
  });
});
