# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

$(document).ready ->
	form = $('form')
	if ( form.length )
		submit = $('#submit')
		if ( submit.length )
			console.log '1'
			submit.show()
			form.find('#standard-submit').hide()
			submit.click =>
				form.submit()
				return false
