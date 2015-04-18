# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$(document).on 'page:load', ->
  $('#new_attachment').validate
    onkeyup: false,
    onclick: false,
    onfocusout: false,
    errorClass:'control-label help-inline',
    rules: 'attachment[attachment]':
      required: true
      extension: 'csv'
    messages: 'attachment[attachment]':
      required: '&nbsp;- Required'
      extension: '&nbsp;- Only .csv files are allowed'
    submitHandler: (form) ->
      form.submit()
      return
    errorPlacement: (error, element) ->
      $(element).prev('.form-label').after(error)
      return
    highlight: (element) ->
      $(element).parent('div').addClass 'has-error'
      return
    unhighlight: (element) ->
      $(element).parent('div').removeClass 'has-error'
      return
  return
  