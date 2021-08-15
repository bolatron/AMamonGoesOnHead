shader_type canvas_item;
render_mode unshaded;

uniform float alpha = 1.0;

void fragment() {
	COLOR = vec4(COLOR.rgb, alpha);
}