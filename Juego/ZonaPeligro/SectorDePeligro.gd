class_name SectorDePeligro
extends Area2D

##Atributos Export
export (String, "vacio", "Meteorito", "Enemigo") var tipo_peligro
export var numero_peligros = 10


## Señales  

func _on_SectorDePeligro_body_entered(_body: Node) -> void:
	$CollisionShape2D.set_deferred("disable", true)
	yield(get_tree().create_timer(0.1), "timeout")
	enviar_senial()

func enviar_senial() -> void:
	Eventos.emit_signal("nave_en_sector_peligro",
	$Position2D.global_position,
	tipo_peligro,
	numero_peligros)
	queue_free()
