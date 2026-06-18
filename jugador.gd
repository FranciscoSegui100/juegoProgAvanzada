extends CharacterBody2D

const VELOCIDAD = 240.0
const FUERZA_SALTO = -480.0
const GRAVEDAD = 1100.0

func _physics_process(delta):
	if not is_on_floor():
		velocity.y += GRAVEDAD * delta

	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = FUERZA_SALTO

	if Input.is_action_pressed("ui_left"):
		velocity.x = -VELOCIDAD
	elif Input.is_action_pressed("ui_right"):
		velocity.x = VELOCIDAD
	else:
		velocity.x = 0

	move_and_slide()

	var mundo = get_parent()

	# Recoger frijol
# Recoger frijol
	if mundo.intentos < 9:
		var dist_frijol = global_position.distance_to(mundo.posicion_frijol)
		if dist_frijol < 40 :
			mundo.intentos += 1
			# 1. Le avisamos al mundo que cambie la posición del frijol HOY MISMO
			mundo.actualizar_posicion_frijol()

	# Llegar a la meta
	var dist_meta = global_position.distance_to(Vector2(3020, 320))
	if dist_meta < 40:
		
		get_tree().quit()
		
		

	# Caer al vacio
	if global_position.y > 600:
		mundo.vidas -= 1
		global_position = Vector2(80, 340)
		velocity = Vector2.ZERO
		if mundo.vidas <= 0:
			get_tree().quit()
			
			# Esta función detecta cuando un Area2D toca al jugador
# Esta función ahora se ejecuta cuando el enemigo toca al jugador
func _on_body_entered(body):
	# "self" significa que el enemigo revisará si te tocó a ti (el jugador)
	var mundo = get_parent()
	mundo.vidas -= 1
	global_position = Vector2(80, 340) # Reaparecer al inicio
	velocity = Vector2.ZERO
	
	if mundo.vidas <= 0:
		get_tree().quit()
