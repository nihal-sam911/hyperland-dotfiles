#version 300 es
precision mediump float;

in vec2 v_texcoord;
out vec4 fragColor;
uniform sampler2D tex;

void main() {
    vec4 color = texture(tex, v_texcoord);

    // --- 1. CONTRAST (The Deep Blacks) ---
    float contrast = 1.11; 
    color.rgb = (color.rgb - 0.5) * contrast + 0.5;

    // --- 2. VIBRANCE (The Color Punch) ---
    // A simple vibrance approximation for performance
    float vibrance = 0.15; 
    float avg = (color.r + color.g + color.b) / 3.0;
    float mx = max(color.r, max(color.g, color.b));
    float amt = (mx - avg) * (-vibrance * 3.0);
    color.rgb = mix(color.rgb, vec3(mx), amt);

    fragColor = color;
}
