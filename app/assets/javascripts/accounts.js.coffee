# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

$(document).ready ->

	# Run script if there is #jsoneditor div on page
	editor_container = document.getElementById("jsoneditor")
	if editor_container

		# Create info data interactive editor instead of yaml textarea
		$('textarea[name=info]').hide()
		editor = new jsoneditor.JSONEditor(editor_container, {
		    mode: 'tree'
		})
		json_source = $('input[name=info_json]')
		json = JSON.parse json_source.attr('value')
		editor.set(json);

		# Create submit button with special function instead of standard
		submit_button = $('input[type=submit]')
		json_save_button = submit_button.after('
			<p><a id="json-save-button" class="btn" href="javascript:;"></a></p>
		').next().find('#json-save-button')
		submit_button.hide()
		json_save_button.text(submit_button.attr('value'))
		json_save_button.on 'click', ->
			# Save json from editor to our hidden field
			json = JSON.stringify(editor.get())
			json_source.attr('value', json)
			# Rails will watched this field to choose, how save the info
			$('input[name=update_from_json]').attr('value', true)
			$('form').submit()