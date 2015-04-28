# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$('#searchbutton').click ->
  $('.project').each ->
    if !$('#searchbox').val()
       $(this).removeAttr 'hidden'
    else if !$(this).hasClass($('#searchbox').val().toLowerCase())
      $(this).attr 'hidden', 'true'
    else
      $(this).removeAttr 'hidden'
    return
  return

$('#searchbox').keyup (event) ->
  if event.keyCode == 13
    $('#searchbutton').click()
  return


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
