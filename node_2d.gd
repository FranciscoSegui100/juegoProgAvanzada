extends Node

func _ready():
	# 1. Cargamos el archivo .ctex (cambiá la ruta por la de tu archivo real)
	var textura = load("res://imported/image-Photoroom (11).png-bbc33ae3346f8da40f6fe5994aeabb38.ctex")
	
	# 2. Obtenemos la imagen interna que está atrapada ahí adentro
	var imagen = textura.get_image()
	
	# 3. La guardamos como un archivo PNG nuevo
	imagen.save_png("res://imagen_rescatada.png")
	
	print("¡PNG rescatado con éxito!")
