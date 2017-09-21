$(document).on 'click', 'a', (event) ->
	if $.attr(this, 'href').substring(0, 1) == '#'
		event.preventDefault()
		$('html, body').stop().animate {
			scrollTop: $($.attr(this, 'href')).offset().top
			easing: 'swing'
		}, 500
	return