extends Area2D

var entered = false

func _process(delta: float) -> void:
	if entered == true:
		if Input.is_action_just_pressed("e"):
			get_tree().change_scene_to_file("res://scenes/boss_battle.tscn")

func _on_body_entered(body: PhysicsBody2D) -> void:
	entered = true

func _on_body_exited(body: PhysicsBody2D) -> void:
	entered = false
