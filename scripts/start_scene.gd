extends Control

@onready var typewriter_text: Label = $Label

func _ready() -> void:
	text_process()

func text_process() -> void:
	await get_tree().create_timer(1).timeout
	typewriter_text.SetText("SAVE THE LAST HUMAN FAMILY")
	await get_tree().create_timer(3).timeout
	typewriter_text.SetText("YOU ARE THE LAST HOPE OF MANKIND.")
	await get_tree().create_timer(3).timeout
	typewriter_text.SetText("YOUR MISSION IS TO STOP THE ROBOTRONS")
	await get_tree().create_timer(3).timeout
	typewriter_text.SetText("SAVING THE LAST HUMAN FAMILY IN THE PROCESS")
	await get_tree().create_timer(3).timeout
	typewriter_text.SetText("OPENING SHUTTLE IN")
	await get_tree().create_timer(1.5).timeout
	typewriter_text.SetText("3")
	await get_tree().create_timer(2.3).timeout
	typewriter_text.SetText("2")
	await get_tree().create_timer(3.1).timeout
	typewriter_text.SetText("1")
	await get_tree().create_timer(3.5).timeout
	get_tree().change_scene_to_file("res://scenes/boss_battle.tscn")
