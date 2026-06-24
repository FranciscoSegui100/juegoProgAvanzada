extends CharacterBody2D

const VELOCIDAD = 240.0
const FUERZA_SALTO = -480.0
const GRAVEDAD = 1100.0

var es_inmortal = false # Controla si el jugador es invulnerable

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

	# --- EFECTO VISUAL DE INMORTALIDAD ---
	if has_node("Polygon2D"):
		if es_inmortal:
			$Polygon2D.modulate.a = 0.5 if Engine.get_frames_drawn() % 10 < 5 else 1.0
		else:
			$Polygon2D.modulate.a = 1.0

	var mundo = get_parent()

	# Recoger frijol
	if mundo.intentos < 9:
		var dist_frijol = global_position.distance_to(mundo.posicion_frijol)
		if dist_frijol < 40 :
			mundo.intentos += 1
			mundo.actualizar_posicion_frijol()

	# Llegar a la meta
	var dist_meta = global_position.distance_to(Vector2(3020, 320))
	if dist_meta < 40:
		mundo.finalizar_juego(true) # Llama al cartel de victoria

	# Caer al vacio
	if global_position.y > 600:
		recibir_danio(true)

# --- FUNCIÓN PARA PROCESAR EL DAÑO E INMORTALIDAD ---
func recibir_danio(por_vacio: bool = false):
	if es_inmortal and not por_vacio:
		return 
		
	var mundo = get_parent()
	mundo.vidas -= 1
	global_position = Vector2(80, 340)
	velocity = Vector2.ZERO
	
	if mundo.vidas <= 0:
		mundo.finalizar_juego(false) # Llama al cartel de derrota
		return
		
	es_inmortal = true
	if has_node("TimerInmortal"):
		$TimerInmortal.start()

func _on_body_entered(body: Node2D) -> void:
	if body.name == "Jugador" or body.has_method("recibir_danio"):
		recibir_danio()
		
	await get_tree().create_timer(1.5).timeout
	es_inmortal = false
