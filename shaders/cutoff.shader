shader_type canvas_item;
render_mode unshaded;

uniform float cutoff: hint_range(0.0, 1.0);
uniform float smooth_size: hint_range(0.0, 1.0);
uniform sampler2D mask: hint_albedo;

uniform bool cutoff_s = false;

void fragment() {
	if (cutoff_s == true) {
		float value = texture(mask, UV).x;
		float alpha = smoothstep(cutoff, cutoff + smooth_size, value * (1.0 - smooth_size) + smooth_size);
		COLOR = vec4(COLOR.rgb, alpha);
	}
}