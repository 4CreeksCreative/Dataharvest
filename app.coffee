axis         = require 'axis'
rupture      = require 'rupture'
autoprefixer = require 'autoprefixer-stylus'
js_pipeline  = require 'js-pipeline'
css_pipeline = require 'css-pipeline'
contentful   = require 'roots-contentful'

module.exports =
	ignores: ['readme.md', '**/layout.*', '**/_*', '.gitignore', 'ship.*conf']

	extensions: [
		js_pipeline(files: ['assets/js/*.coffee','assets/js/*.js']),
		css_pipeline(files: ['assets/css/*.css','assets/css/*.styl'])
	# contentful
	# 		access_token: 'e75ea3d56e9c47e422e060239a57fa84d6e0dea64478f3edae4e674f65308a60'
	# 		space_id: 'kzkzhu5buy40'
	# 		content_types:
	# 			Rates:
	# 				id: 'loanRates'
	# 				##template: 'views/partial/_cf_post.jade'
	# 				##filters: { 'fields.environment[in]': ['staging', 'production'] }
	# 				##path: (e) -> "blogging/#{e.category}/#{slugify(e.title)}"
	# 				##write: 'data.json'
	# 				##sort: compareFunction
	# 				##transform: transformFunction
	# 			##press_links:
	# 			##	id: 'xxxxxx'
	# 			Home:
	# 				id: 'homePage'
	# 				##template: 'views/partial/_cf_post.jade'
		contentful
			access_token:'3edc60740190cee0efc026e74e6d9b30aec916c017195c73cec7e8625f7b7fff'
			space_id: 'tltr1w0m8ryi'
			content_types:
				tech:
					id:'techPosts'
					template:'views/partials/_tech_template.jade'
					path: (e) -> 'tech/'+e.url
				team:
					id:'teamMembers'
				advisors:
					id:'advisor'
				AVIP:
					id:'avip'
				partners:
					id:'partnersPage'

	]

	stylus:
		use: [axis(), rupture(), autoprefixer()]
		sourcemap: true

	'coffee-script':
		sourcemap: true

	jade:
		pretty: true
		basedir: 'views'
	server:
		clean_urls: true
	locals:
		basedir: 'views'
