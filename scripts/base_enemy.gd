extends CharacterBody3D

var player = null
var hp = 150.0
var state_machine
var currentVel = Vector3.ZERO
var dir: Vector3

const SPEED = 2.0
const ATTACK_RANGE = 1.7
const MELEE_DAMAGE = 2

@export var player_path : NodePath

@onready var repulsor_sfx: AudioStreamPlayer = $repulsor_sfx
@onready var healthBarMax = $HealthBar.max_value
@onready var healthBar = $HealthBar
@onready var nav_agent = $NavigationAgent3D
@onready var anim_tree = $AnimationTree
@onready var collisionShape = $CollisionShape3D
@onready var raycast = $RayCast3D
@onready var timer: Timer = $Timer

func _ready() -> void:
	player = get_node(player_path)
	state_machine = anim_tree.get("parameters/playback")
	healthBar.max_value = hp
	healthBar.value = healthBar.max_value
	
func _physics_process(delta: float) -> void:
	match state_machine.get_current_node():
		"run":
			velocity = Vector3.ZERO
			nav_agent.set_target_position(player.global_position)
			var next_nav_point = nav_agent.get_next_path_position()
			velocity = (next_nav_point - global_position).normalized() * SPEED
			look_at(Vector3(next_nav_point.x, global_position.y, next_nav_point.z), Vector3.UP)
			anim_tree.set("parameters/conditions/melee", target_in_range())
			move_and_slide()
		"melee":
			anim_tree.set("parameters/conditions/run", !target_in_range())
			look_at(Vector3(player.global_position.x, global_position.y, player.global_position.z), Vector3.UP)
		"hit":
			look_at(Vector3(player.global_position.x, global_position.y, player.global_position.z), Vector3.UP)
			anim_tree.set("parameters/conditions/hit", false)	
		"death":
			collisionShape.disabled = true

	$HealthBar/Label.text = str(int(hp)) + " / " + str(int(healthBar.max_value))

func hit_player():
	if target_in_range():
		player.hit(MELEE_DAMAGE)

func hit(damage):
	hp -= damage
	if hp <= 0:
		anim_tree.set("parameters/conditions/death", true)
	else:
		anim_tree.set("parameters/conditions/hit", true)
	healthBar.value = hp


func target_in_range():
	return global_position.distance_to(player.global_position) < ATTACK_RANGE

func choose(arr):
	arr.shuffle()
	return arr.front()
