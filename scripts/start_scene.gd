extends Control

@onready var typewriter_text: Label = $Label
var running: bool = false
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if running == true:
		await get_tree().create_timer(3).timeout
		typewriter_text.SetText("hi")
		await get_tree().create_timer(3).timeout
		typewriter_text.SetText("I hope this works!")
		await get_tree().create_timer(3).timeout
		typewriter_text.SetText("Why is this so?")


func _on_timer_timeout() -> void:
	running = !running
