extends CharacterBody3D

var mouse_sense := 0.003
var boss = null
var t_bob = 0.0

var player_direction = Vector3.ZERO
var hp = 100

const BOB_FREQUENCY = 2.0
const BOB_AMPLITUDE = 0.08
const DAMAGE = 5
const REACH = 2.0
const BASE_FOV = 75.0
const FOV_CHANGE = 1.5
const DASH_SPEED = 122.0

@export var boss_path : NodePath
@export var speed = 4.0
@export var walk_speed = 4.0
@export var sprint_speed = 5.5
@export var jump_strength = 3.5
@export var gravity = 9.8

@onready var stamina_bar = $Stamina_UI
@onready var head = $Head
@onready var camera = $Head/Camera3D

func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	boss = get_node(boss_path)

func _process(delta: float):
	# Player HP GUI
	$HP_UI.text = "HP: " + str(hp)
	
	# Free mouse if 'esc' is pressed
	if Input.is_action_just_pressed("ui_cancel"):
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	
	if Input.is_action_pressed("ctrl") and stamina_bar.value > 0.0:
		$dash_sound.play()
		use_stamina()

# Gravity logic
func _physics_process(delta):
	# Applys gravity to player if not on floor
	if not is_on_floor():
		velocity.y -= gravity * delta

	# Handle jump
	if Input.is_action_just_pressed("space") and is_on_floor():
		velocity.y = jump_strength

	# Get input direction
	var input_dir = Input.get_vector("a", "d", "w", "s")
	var direction = (head.transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()

	# Inerta
	if is_on_floor():
		if direction:
			velocity.x = direction.x * speed
			velocity.z = direction.z * speed
		else:
			velocity.x = lerp(velocity.x, direction.x * speed, delta * 7.0)
			velocity.z = lerp(velocity.z, direction.z * speed, delta * 7.0)
	else:
		velocity.x = lerp(velocity.x, direction.x * speed, delta * 3.0)
		velocity.z = lerp(velocity.z, direction.z * speed, delta * 3.0)

	if Input.is_action_pressed("shift"):
		speed = sprint_speed
	else:
		speed = walk_speed

	# Head bob
	t_bob += delta * velocity.length() * float(is_on_floor())
	camera.transform.origin = _headbob(t_bob)
	
	# FOV movement change
	var velocity_clamped = clamp(velocity.length(), 0.5, speed * 2)
	var target_fov = BASE_FOV + FOV_CHANGE * velocity_clamped
	camera.fov = lerp(camera.fov, target_fov, delta * 8.8)

	move_and_slide()
	
func _unhandled_input(event: InputEvent):
	if event is InputEventMouseMotion:
		head.rotate_y(-event.relative.x * mouse_sense)
		camera.rotate_x(-event.relative.y * mouse_sense)
		camera.rotation.x = clamp(camera.rotation.x, deg_to_rad(-80), deg_to_rad(80))

func _headbob(time) -> Vector3:
	var pos = Vector3.ZERO
	pos.y = sin(time * BOB_FREQUENCY) * BOB_AMPLITUDE
	pos.x = cos(time * BOB_FREQUENCY / 2) * BOB_AMPLITUDE
	return pos

# Player takes damage
func hit(damage):
	hp -= damage

func use_stamina():
	stamina_bar.value -= 10
	print(stamina_bar.value)
	
	if stamina_bar.value > 0.0:
		speed = DASH_SPEED
	elif stamina_bar.value <= 0.0:
		speed = walk_speed
