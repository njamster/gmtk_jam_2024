shader_type canvas_item;

uniform sampler2D noise1 : repeat_enable;

uniform float tides_magnitude : hint_range(0.0, 0.3);
uniform float tides_speed : hint_range(0.0, 20.0);

uniform float noise_factor : hint_range(0.0, 0.15);


void fragment() {
  float wave = 0.2 + sin(TIME * tides_speed) * tides_magnitude - texture(noise1, UV).r * noise_factor;

  vec4 noise_color = texture(noise1, UV + vec2(0.005) * TIME);

  COLOR = 0.8 * mix(vec4(0), noise_color, step(wave, UV.y));
}