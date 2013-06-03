SCRIPT_NAME = socialServices

default:

	@echo "* compiling jade templates..."
	@jade -P -o ./example/ ./example/jade/index.jade

	@echo "* compiling sass..."
	@sass --compass --style expanded ./example/sass/style.sass ./example/stylesheets/style.css

	# @echo "* compiling coffeescript..."
	# @coffee -p ./src/${SCRIPT_NAME}.coffee > ${SCRIPT_NAME}.js

	@echo "* linting coffeescript..."
	@coffeelint ./src/${SCRIPT_NAME}.coffee

	@echo "* linting javascript..."
	@jshint ${SCRIPT_NAME}.js --show-non-errors

	@echo "* minifying..."
	@uglifyjs ${SCRIPT_NAME}.js \
						--output ${SCRIPT_NAME}.min.js \
						--source-map ${SCRIPT_NAME}.min.js.map  \
						--compress \
						--mangle \
						--comments '/^!\s/'