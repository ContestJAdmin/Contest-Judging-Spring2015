# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$(document).on 'page:load', ->
  $('#new_attachment').validate
    errorClass:'control-label help-inline',
    rules: 'attachment[attachment]':
      required: true
      extension: 'csv'
    messages: 'attachment[attachment]':
      required: 'Please provide a CSV file'
      extension: 'Only CSV files are allowed'
    submitHandler: (form) ->
      form.submit()
      return
    highlight: (element) ->
      $(element).parent('div').addClass 'has-error'
      return
    unhighlight: (element) ->
      $(element).parent('div').removeClass 'has-error'
      return
  return