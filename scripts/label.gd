extends Label

var full_text: String
var character_pos: int

@onready var text_display: Label = $"."
@onready var timer: Timer = $Timer
@onready var key_sfx: AudioStreamPlayer = $key_sfx

func _on_timer_timeout() -> void:
	text_display.text = full_text
	character_pos += 1
	key_sfx.play()
	text_display.text = full_text.substr(0, character_pos)
	if character_pos == full_text.length():
		timer.stop()
		key_sfx.stop()

func SetText(new_text: String):
	full_text = new_text
	character_pos = 0
	timer.start()
	
