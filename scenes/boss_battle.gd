extends Node3D

var boss = null

@export var boss_path : NodePath

@onready var boss_music: AudioStreamPlayer = $AudioStreamPlayer

func _ready() -> void:
	boss = get_node(boss_path)
	boss_music.play()

func _process(delta: float) -> void:
	if boss.hp <= 0:
		boss_music.stop()
