class_name SectorMeteoritos
extends Node2D


##Atributos 
var cantidad_meteoritos: int = 10 
var intervalo_spawn: float = 0.5
var spawners: Array

## Constructor 
func crear(pos: Vector2, meteoritos: int) -> void: 
	global_position = pos
	cantidad_meteoritos = meteoritos

##Metodos
func _ready() -> void:
	almacenar_spawners()
	conectar_seniales_detectores()
	$AnimationPlayer.play("default")
	$Timer.wait_time = intervalo_spawn


##Metodos custom 
func conectar_seniales_detectores() ->void:
	for detector in $DetectorFueraZona.get_children():
		detector.connect("body_entered", self, "_on_detector_body_entered")

func almacenar_spawners()->void:
	for spawner in $Spawners.get_children():
		spawners.append(spawner)

func spawner_aletorio() -> int:
	randomize()
	return randi() % spawners.size()

## Señales Internas 
func _on_Timer_timeout() -> void:
	if cantidad_meteoritos == 0:
		$Timer.stop()
		return
	
	spawners[spawner_aletorio()].spawner_meteorito()
	cantidad_meteoritos -= 1 

func _on_detector_body_entered(body: Node) -> void:
	body.set_esta_en_sector(false)
