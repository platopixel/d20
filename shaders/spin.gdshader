shader_type canvas_item;

uniform vec4 quaternion = vec4(0.0, 0.0, 0.0, 1.0); // Default: identity quaternion

// Function to rotate a vector using a quaternion
vec3 rotate_with_quaternion(vec3 v, vec4 q) {
    vec3 t = 2.0 * cross(q.xyz, v);
    return v + q.w * t + cross(q.xyz, t);
}

void fragment() {
    // Map UVs to normalized coordinates (-1, 1)
    float px = 2.0 * (UV.x - 0.5);
    float py = 2.0 * (UV.y - 0.5);

    if (px * px + py * py > 1.0) {
        COLOR.a = 0.0; // Outside of sphere
    } else {
        // Map to a 3D unit sphere
        float pz = sqrt(max(0.0, 1.0 - px * px - py * py));
        vec3 sphere_pos = vec3(px, py, pz);

        // Apply quaternion rotation
        sphere_pos = rotate_with_quaternion(sphere_pos, quaternion);

        // Convert rotated position to UV coordinates
        float theta = atan(sphere_pos.z, sphere_pos.x);
        float phi = acos(clamp(sphere_pos.y, -1.0, 1.0));

        // Map spherical coordinates to UV space
        vec2 spherical_uv = vec2(0.5 + theta / (2.0 * PI), phi / PI);

        // Sample texture using spherical coordinates
        COLOR = texture(TEXTURE, spherical_uv);
    }
}
