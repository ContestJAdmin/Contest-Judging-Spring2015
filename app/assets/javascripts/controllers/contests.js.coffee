# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

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
    $(tableId+' tr.header-row th.sorted').find('span').remove()
    $(tableId+' tr.header-row th.sorted').removeClass 'sorted'
    col = $(this).parent().children().index($(this))
    $(this).addClass 'sorted'
    sortTable tableId, col
    $(this).append '<span class=\'order dropup\'><span class=\'caret\'></span></span>'
    return

