shader_type canvas_item;

uniform vec4 taint : hint_color = vec4(0.);
uniform int radius  : hint_range(0, 4) = 2;
uniform float opacity : hint_range(0., 1.)  = 0.4;

// simple blur with parameter for neighbouring rows/columns named size
vec4 blur_with_size(vec2 fragCoord, sampler2D tex, vec2 px_size, int size) {
    vec4 color = vec4(0, 0, 0, 0);     
    // sum the pixels colors
    for(int x=-size; x <= size; x++) {
        for(int y = -size; y <= size; y++) {           
            // get the pixel coordinates at offset (x, y)
            vec2 coordinate = fragCoord + vec2(float(x), float(y))*px_size;         
            // sum the color
            color += texture(tex, coordinate);
        }
    }
    // divide the color by the number of colors you sumed up
    int num_neighbours = (size * 2 + 1) * (size * 2 + 1);
    color /= float(num_neighbours);   
    return color;
}

vec4 colorize(in vec4 grayscale, in vec4 color)
{
    return (grayscale * color);
}

vec4 toDotGrayscale(vec4 color){
	return vec4(dot(color.rgb, vec3(0.299, 0.587, 0.114)));
}

vec4 toGrayscale(in vec4 color)
{
  float average = (color.r + color.g + color.b) / 3.0;
  return vec4(average, average, average, 1.0);
}

// main function
void fragment( )
{
    vec3 color = blur_with_size(SCREEN_UV , SCREEN_TEXTURE , SCREEN_PIXEL_SIZE, radius).rgb;
    color = mix(taint.rgb, color.rgb, opacity);
    COLOR = vec4(color,1.);
}