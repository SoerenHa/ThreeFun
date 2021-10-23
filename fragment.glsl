#ifdef GL_ES
precision mediump float;
#endif

#define PI 3.14159265359

uniform vec2 u_resolution;
uniform vec2 u_mouse;
uniform float u_time;

float getY (float x) {
    return 1.0 - pow(float(x - 0.5), 2.0) * 4.0;
    return sqrt(sin(PI * x));
}

float getY2 (float x) {
    return 1.0 - pow(float(x - 0.5), 2.0) * 8.0 - 0.5;
    return sqrt(sin(PI * x * 2.0 - 1.6)) / 2.0;
}

float getDist (vec2 v1, vec2 v2) {
    return sqrt( pow(v1.x - v2.x, 2.0) + pow(v1.y - v2.y, 2.0) );
}

float getMinDist (vec2 foo) {
    float dist = 2.0;
    for ( int x = 0; x <= 1600; x++ ) {
        float y = getY(float(x) / u_resolution.x);
        vec2 bar = vec2(float(x) / u_resolution.x, float(y));
        float tmpDist = getDist(foo, bar);

        if ( tmpDist < dist ) {
            dist = tmpDist;
        }
    }

    return fract((dist * u_time));
}

vec3 getRainbowColor (float dist) {
    float r = pow(max(0.0, abs(dist - 3.0 / 6.0) * 6.0 - 1.0), 1.0);
    float g = 1.0 - pow(max(0.0, abs(dist - 2.0 / 6.0) * 6.0 - 1.0), 1.0);
    float b = 1.0 - pow(max(0.0, abs(dist - 4.0 / 6.0) * 6.0 - 1.0), 1.0);

    vec3 color = vec3(r, g, b);

    return color;
}

void main() {
    vec2 st = vec2(0.0, 0.0);
    st.x = gl_FragCoord.x/u_resolution.x;
    st.y = gl_FragCoord.y/u_resolution.y;

    float y1 = getY(st.x);

    if ( st.y <= getY(st.x) && st.y >= getY2(st.x) ) {
        float dist = getMinDist(st);
        vec3 color = getRainbowColor(dist);
        gl_FragColor = vec4(color, 1.0);
    } else {
        gl_FragColor = vec4(0.0, 1.0, 1.0, 1.0);
    }
}
