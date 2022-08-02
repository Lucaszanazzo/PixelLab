class_name Escudo 
extends Area2D

##Variables export
export var energia: float= 8.0
export var radio_desgaste: float = -1.6
## Variables 
var esta_activado: bool = false setget ,get_esta_activado

##Setters y Getters
func get_esta_activado():
	return esta_activado

#Metodos
func _ready():
	set_process(false)
	controlar_colisionador(true)

func _process(delta):
	energia += radio_desgaste * delta
	if energia <= 0.0:
		desactivar()

#Metodos custom 
func controlar_colisionador(esta_desactivado: bool):
	$CollisionShape2D.set_deferred("disabled", esta_desactivado)

func activar():
	if energia <= 0.0:
		return
	
	print("activar")
	esta_activado = true
	controlar_colisionador(false)
	$AnimationPlayer.play("default")

func desactivar():
	set_process(false)
	esta_activado = false
	controlar_colisionador(true)
	$AnimationPlayer.play_backwards("default")

##Señales internas 
func _on_AnimationPlayer_animation_finished(anim_name):
	if anim_name == "default" and esta_activado:
		$AnimationPlayer.play("activado")
		set_process(true)


func _on_Escudo_body_entered(body):
	body.queue_free()



func _on_Escudo_area_shape_entered(_area_rid, area, _area_shape_index, _local_shape_index):
	area.queue_free()
