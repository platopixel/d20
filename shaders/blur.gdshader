shader_type canvas_item;
uniform vec2 pivot = vec2(0.0);
uniform float amount = 0.0;
uniform int quality = 4;
uniform bool marginDebug = false;
uniform vec4 color: source_color;
const float ROOT_TWO = 1.41421356237;

void vertex(){
	vec2 vertex = TEXTURE_PIXEL_SIZE * VERTEX;
	// commented out these lines because they were adding a huge margin to the texture
	// vertex = vertex * (2.0 * length(pivot) + ROOT_TWO) + pivot;
	VERTEX = vertex / TEXTURE_PIXEL_SIZE;
	VERTEX += pivot;
	// UV = (UV - 0.5) * (2.0 * length(pivot) + ROOT_TWO) + pivot + 0.5;
}

float insideUnitSquare(vec2 v) {
    vec2 s = step(vec2(0.0), v) - step(vec2(1.0), v);
    return s.x * s.y;
}

vec2 rotate(vec2 uv, vec2 p, float angle)
{
	mat2 rotation = mat2(vec2(cos(angle), -sin(angle)),
						vec2(sin(angle), cos(angle)));
	uv -= p;
	uv = uv * rotation;
	uv += p;
	return uv;
}

void fragment(){
	float inSquare = insideUnitSquare(UV);
	float numSamples = inSquare;
	vec4 texture_color = texture(TEXTURE, UV);
	vec3 blended_rgb = color.rgb * color.a + texture_color.rgb * (1.0 - color.a);
    COLOR = vec4(blended_rgb, texture_color.a) * inSquare;
	// COLOR = texture(TEXTURE, UV) * inSquare;
	float stepSize = amount/(float(quality));
	vec2 uv;
	for(int i = 1; i <= quality; i++){
		uv = rotate(UV, pivot + 0.5, float(i)*stepSize);
		inSquare = insideUnitSquare(uv);
		numSamples += inSquare;
		COLOR += texture(TEXTURE, uv) * inSquare;

		uv = rotate(UV, pivot + 0.5, -float(i)*stepSize);
		inSquare = insideUnitSquare(uv);
		numSamples += inSquare;
		COLOR += texture(TEXTURE, uv) * inSquare;
	}

	//vec4 result = color + texture_color;
	//COLOR = result;
	
	COLOR.rgb /= numSamples;
	COLOR.a /= float(quality)*2.0 + 1.0;
	if(marginDebug) COLOR += 0.1;
}