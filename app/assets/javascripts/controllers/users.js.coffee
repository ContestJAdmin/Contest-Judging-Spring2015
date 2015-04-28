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