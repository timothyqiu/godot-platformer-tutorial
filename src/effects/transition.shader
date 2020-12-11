shader_type canvas_item;

uniform float cutoff: hint_range(0.0, 1.0) = 0.5;
uniform float feather: hint_range(0.0, 1.0) = 0.1;
uniform sampler2D mask;

void fragment()
{
	vec4 col = vec4(0.0, 0.0, 0.0, 1.0);
	vec4 v = texture(mask, UV);
	
	col.a = smoothstep(cutoff - feather, cutoff, v.r * (1.0 - feather));
	
	COLOR = col;
}