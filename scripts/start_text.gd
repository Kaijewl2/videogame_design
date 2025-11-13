extends Control

@export var typewriter_text: Label

@onready var key_sfx: AudioStreamPlayer = $key_sfx
@onready var text_box: RichTextLabel = $RichTextLabel
@onready var timer: Timer = $Timer
var visible_characters := 0
var timer_active := false

func _process(delta: float) -> void:
	if text_box.visible_ratio < 1:
		text_box.visible_ratio += 0.1 * delta
	if visible_characters != text_box.visible_characters:
		visible_characters = text_box.visible_characters
		key_sfx.play()
		
	if Input.is_action_just_pressed("e"):
		typewriter_text.SetText("Winna")
		
		await get_tree().create_timer(1).timeout
		typewriter_text.SetText("Chicken Dinna")
	
	if text_box.visible_ratio >= 1.0 and timer.is_stopped():
		key_sfx.stop()
		timer_active = true
		timer.start()

func _on_timer_timeout() -> void:
	get_tree().change_scene_to_file("res://scenes/boss_battle.tscn")
