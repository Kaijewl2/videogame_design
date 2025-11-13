extends Label

@export var text_display: Label
@export var timer: Timer

var full_text: String
var character_pos: int
var animating: bool

func _ready() -> void:
	pass

func _process(delta: float) -> void:
	pass

func _on_timer_timeout() -> void:
	text_display.text = full_text
	character_pos += 1
	text_display.text = full_text.substr(0, character_pos)
	if character_pos == full_text.length():
		timer.stop()
		animating = false

func SetText(new_text: String):
	full_text = new_text
	character_pos = 0
	animating = true
	timer.start()
