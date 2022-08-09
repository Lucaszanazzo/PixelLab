#NaveBase
class_name NaveBase
extends RigidBody2D

##Enums
enum ESTADO {SPAWN, VIVO, INVENCIBLE, MUERTO}

##Atributos Export
export var hitpoints: float = 20.0
export var num_explosiones : int = 1
## Atributos 
var estado_actual: int = ESTADO.SPAWN


## Onready Atributos 
onready var canion: Canion = $Canion
onready var colisionador: CollisionShape2D = $CollisionShape2D
onready var impacto_sfx: AudioStreamPlayer = $ImpactoSFX


## Metodos 
func _ready():
	controlador_estados(estado_actual)

## Metodos custom 
func controlador_estados(nuevo_estado: int):
	match nuevo_estado:
		ESTADO.SPAWN:
			colisionador.set_deferred("disable", true)
			canion.set_puede_disparar(false)
		ESTADO.VIVO:
			colisionador.set_deferred("disable", false)
			canion.set_puede_disparar(true)
		ESTADO.INVENCIBLE:
			colisionador.set_deferred("disable", true)
		ESTADO.MUERTO:
			colisionador.set_deferred("disable", true)
			canion.set_puede_disparar(false)
			Eventos.emit_signal("nave_destruida", self,  global_position, num_explosiones)
			queue_free()
		_:
			printerr("Error de estado")
	estado_actual = nuevo_estado


func destruir():
	controlador_estados(ESTADO.MUERTO)

func recibir_danio(danio: float):
	hitpoints -= danio
	if hitpoints <= 0.0:
		destruir()
	impacto_sfx.play()


## Señales internas 
func _on_AnimationPlayer_animation_finished(anim_name):
	if anim_name == "spawn":
		controlador_estados(ESTADO.VIVO)


func _on_Player_body_entered(body: Node) -> void:
	if body is Meteorito: 
		body.destruir()
		destruir()
