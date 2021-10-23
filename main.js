class Rainbow {
    fShader;
    vShader;

    constructor() {
        this.container = document.getElementById('container');
        this.loader = new THREE.FileLoader();

        this.loader.load('fragment.glsl', data => {
            this.fShader = data;
            this.init();
        });

        this.loader.load('vertex.glsl', data => {
            this.vShader = data;
            this.init();
        });
    }

    init() {
        if (!this.fShader || !this.vShader) {
            return;
        }

        this.camera = new THREE.Camera();
        this.camera.position.z = 1;

        this.scene = new THREE.Scene();

        const geometry = new THREE.PlaneBufferGeometry(2, 2);

        this.uniforms = {
            u_time: { type: "f", value: 5 },
            u_resolution: { type: "v2", value: new THREE.Vector2() },
            u_mouse: { type: "v2", value: new THREE.Vector2() }
        };

        const material = new THREE.ShaderMaterial({
            uniforms: this.uniforms,
            vertexShader: this.vShader,
            fragmentShader: this.fShader
        });

        const mesh = new THREE.Mesh(geometry, material);
        this.scene.add(mesh);

        this.renderer = new THREE.WebGLRenderer();
        this.renderer.setPixelRatio(window.devicePixelRatio);

        this.renderer.setSize(1600, 800);
        this.uniforms.u_resolution.value.x = 1600;
        this.uniforms.u_resolution.value.y = this.renderer.domElement.height;

        container.appendChild(this.renderer.domElement);

        // document.onmousemove = function (e) {
        //     this.uniforms.u_mouse.value.x = e.pageX
        //     this.uniforms.u_mouse.value.y = e.pageY
        // }

        this.animate();
    }

    animate() {
        this.render();
        // this.uniforms.u_time.value += .5;
        // requestAnimationFrame(() => this.animate());
    }

    render() {
        this.renderer.render(this.scene, this.camera);
    }
}
