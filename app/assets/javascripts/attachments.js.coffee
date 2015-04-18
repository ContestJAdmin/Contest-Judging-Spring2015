# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$ ->
  # Setup form validation on the #register-form element
  $('#new_attachment').validate
    rules: 'attachment[attachment]':
      required: true
      accept: 'csv'
    messages: 'attachment[attachment]':
      required: 'Please provide a CSV file'
      accept: 'Only CSV files are allowed'
    submitHandler: (form) ->
      form.submit()
      return
  return