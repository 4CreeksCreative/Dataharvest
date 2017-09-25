THREE.IcosahedronGeometry = function(radius, detail) {
  var t = (1 + Math.sqrt(5)) / 2;
  var vertices = [-1, t, 0, 1, t, 0, -1, -t, 0, 1, -t, 0,
    0, -1, t, 0, 1, t, 0, -1, -t, 0, 1, -t,
    t, 0, -1, t, 0, 1, -t, 0, -1, -t, 0, 1
  ];
  var indices = [
    0, 11, 5, 0, 5, 1, 0, 1, 7, 0, 7, 10, 0, 10, 11,
    1, 5, 9, 5, 11, 4, 11, 10, 2, 10, 7, 6, 7, 1, 8,
    3, 9, 4, 3, 4, 2, 3, 2, 6, 3, 6, 8, 3, 8, 9,
    4, 9, 5, 2, 4, 11, 6, 2, 10, 8, 6, 7, 9, 8, 1
  ];
  THREE.PolyhedronGeometry.call(this, vertices, indices, radius, detail);
  this.type = 'IcosahedronGeometry';
  this.parameters = {
    radius: radius,
    detail: detail
  };
};



THREE.IcosahedronGeometry.prototype = Object.create(THREE.PolyhedronGeometry.prototype);
THREE.IcosahedronGeometry.prototype.constructor = THREE.IcosahedronGeometry;

// Scene
var h
var scene = new THREE.Scene();
var camera = new THREE.PerspectiveCamera(50, window.innerWidth / window.innerHeight, 1, 1000);
camera.position.z = 200

var renderer = new THREE.WebGLRenderer({
  antialias: 1,
  alpha: true
});
var sprite = new THREE.TextureLoader().load("/img/disk.png")

renderer.setClearColor(0x000000, 0);
renderer.setSize(window.innerWidth, window.innerHeight);
//document.body.appendChild(renderer.domElement);
$('.orb-container').append(renderer.domElement)

scene.fog = new THREE.Fog(0xd1e028, 8, 20);

// Create vertex points
var mesh = new THREE.IcosahedronGeometry(10, 1); // radius, detail
var vertices = mesh.vertices;
var positions = new Float32Array(vertices.length * 3);
for (var i = 0, l = vertices.length; i < l; i++) {
  vertices[i].toArray(positions, i * 3);
}

var geometry = new THREE.BufferGeometry();
geometry.addAttribute('position', new THREE.BufferAttribute(positions, 3));

var material = new THREE.PointsMaterial({
  size: 0.25,
  map: sprite,
  transparent: true,
  //vertexColors: THREE.VertexColors,
  color: 0x1aa829
});
//material.color.setHSL( 1.0, 0.3, 0.7 );
var points = new THREE.Points(geometry, material);

var object = new THREE.Object3D();

object.add(points);



object.add(new THREE.Mesh(
  mesh,
  new THREE.MeshPhongMaterial({
    color: 0xffffff,
    emissive: 0x1aa829,
    wireframe: true,
    wireframeLinewidth: 1,
    fog: 5
  })

));

scene.add(object);

camera.position.z = 20;

var render = function() {
    var time = Date.now() * 0.00005;
  requestAnimationFrame(render);
  // h = ( 360 * ( 1.0 + time ) % 360 ) / 360;
  // material.color.setHSL( h, 0.5, 0.5 );
  object.rotation.x += 0.0005;
  object.rotation.y += 0.0005;

  renderer.render(scene, camera);
};

function onWindowResize() {
        windowHalfX = window.innerWidth / 2;
        windowHalfY = window.innerHeight / 2;
        width = window.innerWidth;
        height = window.innerHeight;
        camera.aspect = width / height;
        camera.updateProjectionMatrix();
        renderer.setSize( width, height );
        postprocessing.composer.setSize( width, height );
    }

window.addEventListener( 'resize', onWindowResize, false );

render();
