class_name EnemigoDummy
extends Area2D



func _on_EnemigoDummy_body_entered(body):
	if body is Player:
		body.destruir()
