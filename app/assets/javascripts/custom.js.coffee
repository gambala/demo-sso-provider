
$(document).ready ->
	alerts = $('.alert')
	if ( alerts.length )
		alerts.each ->
			$(this).alert()
