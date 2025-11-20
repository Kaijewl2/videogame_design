extends Node2D

@onready var typewriter_text: Label = $Label

func _ready() -> void:
	text_process()

func text_process() -> void:
	await get_tree().create_timer(1).timeout
	typewriter_text.SetText("YOU HAVE BEEN BORN AND TRAINED TO AID IN THE DECADE LONG WAR AGAINST THE ZAPHBROX")
	await get_tree().create_timer(8).timeout
	typewriter_text.SetText("ENTER THE QUANTUM TRANSPORTER AND PRESS 'E' TO SERVE PLANET EARTH")
