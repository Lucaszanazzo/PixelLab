class_name EnemigoDummy
extends Area2D

##Atributos
var hitpoints: float = 10.0

func _process(delta):
	$Canion.set_esta_disparando(true)

func _on_EnemigoDummy_body_entered(body):
	if body is Player:
		body.destruir()

func recibir_danio(danio: float):
	hitpoints -= danio
	if hitpoints <= 0.0:
		queue_free()
