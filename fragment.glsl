#ifdef GL_ES
precision mediump float;
#endif

#define PI 3.14159265359

uniform vec2 u_resolution;
uniform vec2 u_mouse;
uniform float u_time;

float getY (float x) {
    return sqrt(1.0 / 4.0 - pow(x * 2.0 - 1.0 / 2.0, 2.0));
    return 1.0 - pow(float(x - 0.5), 2.0) * 4.0;
    return sqrt(sin(PI * x));
}

float getY2 (float x) {
    return sqrt(1.0 / 8.0 - pow(x * 2.0 - 1.0 / 2.0, 2.0));
    return 1.0 - pow(float(x - 0.5), 2.0) * 8.0 - 0.5;
    return sqrt(sin(PI * x * 2.0 - 1.6)) / 2.0;
}

float getDist (vec2 v1, vec2 v2) {
    return sqrt( pow(v1.x - v2.x, 2.0) + pow(v1.y - v2.y, 2.0) );
}

vec3 getRainbowColor (float dist) {
    float r = pow(max(0.0, abs(dist - 3.0 / 6.0) * 6.0 - 1.0), 1.0);
    float g = 1.0 - pow(max(0.0, abs(dist - 2.0 / 6.0) * 6.0 - 1.0), 1.0);
    float b = 1.0 - pow(max(0.0, abs(dist - 4.0 / 6.0) * 6.0 - 1.0), 1.0);

    vec3 color = vec3(r, g, b);

    return color;
}

float pq(float p, float q) {
    float pHalf = - p / 2.0;
    return pHalf - sqrt(pow(pHalf, 2.0) - q);
}

float nullStelle(float a) {
    return pq(-1.0, 0.25 - (a / 4.0));
}

void main() {
    vec2 st = vec2(0.0, 0.0);
    st.x = gl_FragCoord.x / u_resolution.x;
    st.y = gl_FragCoord.y / u_resolution.y;

    float y1 = getY(st.x);
    float y2 = getY2(st.x);

    if (st.y <= y1) {

        float a = y1 - st.y;


        // float dist = getMinDist(st);
        vec3 color = getRainbowColor(a);
        gl_FragColor = vec4(color, 1.0);
    } else {
        gl_FragColor = vec4(0.0, 1.0, 1.0, 1.0);
    }
}
