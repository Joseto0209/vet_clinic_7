# Override the default Rails field_with_errors wrapper to add Bootstrap's
# is-invalid class directly to the input element instead of wrapping
# it in a <div class="field_with_errors"> which breaks Bootstrap layouts.
ActionView::Base.field_error_proc = proc do |html_tag, _instance|
  if html_tag.include?('class="')
    html_tag.sub('class="', 'class="is-invalid ').html_safe
  else
    html_tag.sub(/>/, ' class="is-invalid">').html_safe
  end
end
