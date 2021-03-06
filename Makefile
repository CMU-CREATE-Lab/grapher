CONCAT_PATH=build/grapher.concat.js
MINIFY_PATH=build/grapher.min.js
TEMP_PATH=build/tmp.js
CLOSURE=closure-compiler/compiler.jar
BUILD=build
DOCS_PATH=docs

all: clean concat minify-simple
#	clean concat minify-simple
clean:
	rm -f ${MINIFY_PATH} ${CONCAT_PATH}
concat:
	[ -d ${BUILD} ] || mkdir ${BUILD}
	cat Util.js Polyfill.js Vector2.js Basis.js LabelFormatter.js TickGenerator.js \
	IterableTickGenerator.js GraphAxis.js TimeGraphAxis.js Glb.js TileIdx.js \
	TileLoader.js TileView.js DataStoreTile.js CanvasTile.js \
	DataStoreTileLayer.js Shaders.js TouchUtils.js Plot.js \
	SeriesPlotContainer.js Grapher.js TileConstants.js TimeConstants.js \
	Uuid.js MidnightLine.js MouseState.js > ${CONCAT_PATH}
minify-simple: clean concat
	java -jar ${CLOSURE} --compilation_level SIMPLE_OPTIMIZATIONS --js ${CONCAT_PATH} --js_output_file ${MINIFY_PATH} --language_in=ECMASCRIPT5 --warning_level=QUIET
	cat ${MINIFY_PATH} > ${TEMP_PATH} && mv ${TEMP_PATH} ${MINIFY_PATH}
docs:
	rm -rf ${DOCS_PATH}
	jsdoc *.js -d ${DOCS_PATH}
#minify-advanced:
#	clean concat
#	java -jar ${CLOSURE} --compilation_level ADVANCED_OPTIMIZATIONS --js ${CONCAT_PATH} --js_output_file ${MINIFY_PATH}
#	cat ${MINIFY_PATH} > ${TEMP_PATH} && mv ${TEMP_PATH} ${MINIFY_PATH}
.PHONY: docs
