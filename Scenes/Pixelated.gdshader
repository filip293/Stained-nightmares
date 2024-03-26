shader_type spatial;
uniform sampler2D SCREEN_TEXTURE : hint_screen_texture, filter_linear;
const int pixel_size = 4;

void vertex() {
    // Called for every vertex the material is visible on.
}

void fragment() {
    float x = FRAGCOORD.x - mod(FRAGCOORD.x, float(pixel_size)) + float(pixel_size) / 2.0;
    float y = FRAGCOORD.y - mod(FRAGCOORD.y, float(pixel_size)) + float(pixel_size) / 2.0;

    vec3 texColor = texture(SCREEN_TEXTURE, vec2(x, y) / VIEWPORT_SIZE).xyz;

    // Simple diffuse lighting
    vec3 lightDir = vec3(0.0, 0.0, 1.0); // Directional light coming from the camera
    float diff = max(dot(normalize(lightDir), vec3(0.0, 0.0, 1.0)), 0.0); // Dot product of light direction and normal
    vec3 diffuse = diff * vec3(1.0); // Basic diffuse lighting color
    
    ALBEDO = texColor * diffuse;
}

//void light() {
    // Called for every pixel for every light affecting the material.
    // Uncomment to replace the default light processing function with this one.
//}
