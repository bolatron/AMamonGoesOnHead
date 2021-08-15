shader_type canvas_item;
render_mode unshaded;

uniform float pixels: hint_range(0.0, 640.0);
uniform bool pixelation_s = false;

void fragment() {
	if (pixelation_s == true) {
		float dx = 8.0 * (1.0 / pixels);
		float dy = 8.0 * (1.0 / pixels);
		vec2 Coord = vec2(dx * floor(SCREEN_UV.x / dx), dy * floor(SCREEN_UV.y / dy));
		COLOR = texture(SCREEN_TEXTURE, Coord);
	} else {
		COLOR = texture(SCREEN_TEXTURE, SCREEN_UV);
	}
}