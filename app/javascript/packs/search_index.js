$(document).on('change', '.course-search', function() {
  form = $('.course-search-form')[0];
  Rails.fire(form, "submit");
});