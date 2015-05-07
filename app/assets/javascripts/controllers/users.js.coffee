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


jQuery.fn.toggleOption = (show) ->
  $(this).toggle show
  if show
    if $(this).parent('span.toggleOption').length
      $(this).unwrap()
  else
    if $(this).parent('span.toggleOption').length == 0
      $(this).wrap '<span class="toggleOption" style="display: none;" />'
  return

$('#user_contest_id').on 'change', ->
  val = $(this).val()
  $('#user_category_id option').each ->
    $option = $(this)
    $option.toggleOption $option.hasClass(val)
    return
  $('#nil_option').toggleOption(true)
  return
  
set_category_blank = ->
  $('#user_category_id').val ''
  
$(document).ready(filter_categories)
$(document).on('page:load', filter_categories)

$('#user_contest_id').change(filter_categories)
$('#user_contest_id').change(set_category_blank)
