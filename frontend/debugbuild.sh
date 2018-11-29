js_out="../server/static/js/main.min.js"

echo "building (debug mode)..."

elm make src/Main.elm --output=$js_out