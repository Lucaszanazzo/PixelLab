#Nivel
class_name Nivel
extends Node2D

## Atributos Onready
onready var contenedor_proyectiles: Node

## Metodos
func _ready():
	conectar_seniales()
	crear_contenedores()


##Metodos Custom
func conectar_seniales():
	Eventos.connect("disparo", self, "_on_disparo")

func crear_contenedores():
	contenedor_proyectiles = Node.new()
	contenedor_proyectiles.name = "ContenedorProyectiles"
	add_child(contenedor_proyectiles)


func _on_disparo(proyectil: Proyectil):
	contenedor_proyectiles.add_child(proyectil)
