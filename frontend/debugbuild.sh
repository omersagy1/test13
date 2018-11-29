js_out="../server/templates/main.min.js"

echo "building (debug mode)..."

elm make src/Main.elm --output=$js_out