extends Node2D

@onready var typewriter_text: Label = $Label

func _ready() -> void:
	text_process()

func text_process() -> void:
	await get_tree().create_timer(1).timeout
	typewriter_text.SetText("YOU ARE CLASSIFIED AS AN A-RANK SOLDIER, BORN TO AID IN THE DECADE LONG WAR AGAINST THE ZAPHBROX")
	await get_tree().create_timer(10).timeout
	get_tree().change_scene_to_file("res://scenes/boss_battle.tscn")
