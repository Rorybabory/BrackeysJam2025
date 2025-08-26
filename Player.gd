
extends CharacterBody3D

const GRAVITY = 9.81

var mouseDelta
@export var speed = 7.0
@export var jumpVelocity = 3.0;
@export var gravityMultiplier = 2.0;
var mouse_sens = 0.1
@onready var head = $head
var headbob = 0.0
var headbobTimer = 0.0


var camera

var screenshake = Vector3(0,0,0)
var shake_value = 0
var health = 10.0
var healthbar

var alive = true

var push_force = 1.0;

# Called when the node enters the scene tree for the first time.
func _ready():

	mouseDelta = Vector2(0,0)
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)

	camera = get_node("head/Camera3D")
	pass # Replace with function body.

func when_hit(damage):
	print("HIT PLAYER")
	shake_value = damage*4
	health -= damage
	pass

func _physics_process(delta):

	velocity.y -= GRAVITY * gravityMultiplier * delta
	var input_dir = Input.get_vector("move_left", "move_right", "move_forward", "move_backward");
	var direction = (transform.basis * Vector3(input_dir.x, 0, input_dir.y).normalized());
	head.rotation.z = lerp(head.rotation.z, -input_dir.x*0.065, delta*5.0);
	headbobTimer +=delta
	if (direction):
		var lerpspeed = 6
		if (not is_on_floor()):
			lerpspeed = 4
		velocity.x = lerpf(velocity.x, direction.x * speed, delta*lerpspeed)
		velocity.z = lerpf(velocity.z, direction.z * speed, delta*lerpspeed)
		var headbob_target = 0
		if (is_on_floor()):
			headbob_target = sin(headbobTimer*15.0) * 0.08
		else:
			headbob_target = velocity.y*0.05
		headbob = lerp(headbob, headbob_target, delta * 14)
	else:
		if (is_on_floor()):	
			velocity.x = lerpf(velocity.x, 0, delta*13)
			velocity.z = lerpf(velocity.z, 0, delta*13)
		else:
			velocity.x = lerpf(velocity.x, 0, delta*2)
			velocity.z = lerpf(velocity.z, 0, delta*2)
		headbob = lerpf(headbob, 0, delta*15)
	if (Input.is_action_just_pressed("move_jump") and is_on_floor()):
		velocity.y = jumpVelocity
	move_and_slide()
	
	for i in get_slide_collision_count():
		var collision = get_slide_collision(i)
		if collision.get_collider() is RigidBody3D:
			collision.get_collider().apply_central_impulse(-collision.get_normal() * push_force)
func _input(event):
	if event is InputEventMouseMotion:
		if (alive == false):
			return
		rotate_y(deg_to_rad(-event.relative.x * mouse_sens))
		head.rotate_x(deg_to_rad(-event.relative.y * mouse_sens))
		var range = (3.1415/2.0)*0.85
		if (head.rotation.x > range):
			head.rotation.x = range
		if (head.rotation.x < -range):
			head.rotation.x = -range
	if event is InputEventMouseButton and event.pressed and event.button_index == 1:
		var camera3d = camera
		var from = camera3d.project_ray_origin(event.position)
		var to = from + camera3d.project_ray_normal(event.position) * 20
		var space_state = get_world_3d().direct_space_state
		var query = PhysicsRayQueryParameters3D.create(from, to)
		query.collision_mask = 2
		var result = space_state.intersect_ray(query)
		if (not result):
			return
		if (not result.collider):
			return
		if (result.collider.is_in_group("Interactable")):
			result.collider._on_use(self)

func _process(delta):
	if (alive == false):
		rotation.z = lerp(rotation.z, -PI*0.5, delta*5)
		return
	screenshake = Vector3(randf_range(-1, 1), randf_range(-1, 1), randf_range(-1, 1)) * delta
	head.position.y = 1.5+headbob
	head.position.x = 0
	head.position.z = 0
	head.position += screenshake * shake_value
	shake_value = lerpf(shake_value, 0.0, delta*4.5)

	if (health <= 0):
		alive = false
