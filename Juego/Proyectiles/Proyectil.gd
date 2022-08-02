#Proyectil.gd
class_name Proyectil
extends Area2D

##Atributos
var velocidad: Vector2 = Vector2.ZERO
var danio: float

## Metodos
func crear(pos: Vector2, dir: float, vel: float, danio_p: int):
	position = pos
	rotation = dir
	velocidad = Vector2(vel, 0).rotated(dir)
	danio = danio_p

func _physics_process(delta):
	position += velocidad * delta

##Metodos custom 
func daniar(otro_cuerpo: CollisionObject2D):
	if otro_cuerpo.has_method("recibir_danio"):
		otro_cuerpo.recibir_danio(danio)
		queue_free()


## Señales internas
func _on_VisibilityNotifier2D_screen_exited():
	queue_free()

func _on_area_entered(area):
	daniar(area)

func _on_body_entered(body):
	daniar(body)
