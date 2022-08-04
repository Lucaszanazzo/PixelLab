class_name Meteorito
extends RigidBody2D


## Atributos Export 
export var vel_lineal_base: Vector2 = Vector2(300.0, 300.0)
export var vel_angular_base: float = 3.0
export var hitpoints_base: float = 10.0 


## Atributos 
var hitpoints: float

## Onready var 
onready var impacto_sfx: AudioStreamPlayer = $impacto_SFX
onready var animacion_impacto: AnimationPlayer = $AnimationPlayer



##Metodos
func _ready():
	angular_velocity = vel_angular_base

## Constructor 
func crear(pos: Vector2, dir: Vector2, tamanio: float) -> void:
	position = pos 
	#Calcular Masa, tamaño de Sprite y Colisionador
	mass *= tamanio
	$Sprite.scale = Vector2.ONE * tamanio
	# radio = diametro/2
	var radio: int = ($Sprite.texture.get_size().x / 2.4 * tamanio)
	var forma_colision: CircleShape2D = CircleShape2D.new()
	forma_colision.radius= radio
	$CollisionShape2D.shape = forma_colision
	#Calcular velocidades
	linear_velocity = (vel_lineal_base * dir / tamanio) * aleatorizar_velocidad()
	angular_velocity = (vel_angular_base/ tamanio) * aleatorizar_velocidad()
	hitpoints = hitpoints_base * tamanio


##MEtodos Custom 
func aleatorizar_velocidad() -> float: 
	randomize()
	return rand_range(0.2, 0.9)

func recibir_danio(danio: float) -> void:
	hitpoints -= danio
	if hitpoints <= 0.0:
		destruir()
	
	impacto_sfx.play()
	animacion_impacto.play("impacto")

func destruir() -> void:
	$CollisionShape2D.set_deferred("disable", true)
	Eventos.emit_signal("meteorito_destruido", global_position)
	queue_free()

