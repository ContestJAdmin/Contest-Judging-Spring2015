# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/


# judge project assignment search
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
  
# hacky category filter
jQuery.fn.toggleOption = (show) ->
  $(this).toggle show
  if show
    if $(this).parent('span.toggleOption').length
      $(this).unwrap()
  else
    if $(this).parent('span.toggleOption').length == 0
      $(this).wrap '<span class="toggleOption" style="display: none;" />'
  return

filter_categories = -> 
  val = $('#user_contest_id').val()
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


# judge project assignment table sorting
reverseTable = (tableId) ->
  rows = $(tableId + ' tbody.data-rows  tr').get().reverse()
  $.each rows, (index, row) ->
    $(tableId).children('tbody.data-rows').append row
    return
  return

sortTable = (tableId, col) ->
  rows = $(tableId + ' tbody.data-rows  tr').get()
  rows.sort (a, b) ->
    A = $(a).children('td').eq(col).text().toUpperCase()
    B = $(b).children('td').eq(col).text().toUpperCase()
    if A < B
      return -1
    if A > B
      return 1
    0
  $.each rows, (index, row) ->
    $(tableId).children('tbody.data-rows').append row
    return
  return

$('tr.header-row th').click ->
  tableId = '#' + $(this).closest('table').attr('id')
  if $(this).hasClass('sorted')
    reverseTable tableId
    $(this).find('span.order').toggleClass("dropdown dropup");
  else
    $('tr.header-row th.sorted').find('span').remove()
    $('tr.header-row th.sorted').removeClass 'sorted'
    col = $(this).parent().children().index($(this))
    $(this).addClass 'sorted'
    sortTable tableId, col
    $(this).append '<span class=\'order dropup\'><span class=\'caret\'></span></span>'
    return
