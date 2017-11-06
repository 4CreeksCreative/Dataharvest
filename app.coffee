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
			access_token:'caacb39437ae868c0168c78fb39c55113ec9751275b035cc5226078a981e1744'
			space_id: '57t5vobpd4ou'
			content_types:
				tech_post:
					id:'techPosts'
					template:'views/partials/_tech_template.jade'
					path: (e) -> 'tech/'+e.url
				team:
					id:'teamPage'
				AVIP:
					id:'avip'
				partners:
					id:'partnersPage'
				tech:
					id:'techPage'
				home:
					id:'homePage'
				contact:
					id:'contactPage'

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
