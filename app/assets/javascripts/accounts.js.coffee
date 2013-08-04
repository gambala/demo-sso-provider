# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

$(document).ready ->

	yaml_field = $('textarea[name=info]')
	if yaml_field.length
		container = document.getElementById("jsoneditor");
		options = {
		    mode: 'tree'
		};
		editor = new jsoneditor.JSONEditor(container, options);
		yaml_field.hide()

		json = JSON.parse $('input[name=json]').attr('value')
		editor.set(json);

		submit_button = $('input[type=submit]')
		json_save_button = submit_button.after('
			<p><a id="json-save-button" class="btn" href="javascript:;"></a></p>
		').next().find('#json-save-button')

		json_save_button.text(submit_button.attr('value'))
		json_save_button.on 'click', ->
			json = JSON.stringify(editor.get())
			$('input[name=json]').attr('value', json)
			$('input[name=update_from_json]').attr('value', true)
			$('form').submit()
		submit_button.hide()