filter_categories = ->
  $('#user_category_id option').each ->
    if !$(this).hasClass($('#user_contest_id').val())
      $(this).hide()
    else
      $(this).show()
    return
  $('#nil_option').show()
  
$(document).ready(filter_categories)
$(document).on('page:load', filter_categories)

$('#user_contest_id').change(filter_categories)
