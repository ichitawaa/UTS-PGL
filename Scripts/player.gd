extends CharacterBody2D

const SPEED = 300.0
const JUMP_VELOCITY = -380.0

@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D


func _physics_process(delta: float) -> void:
	if not is_on_floor():
		velocity += get_gravity() * delta

	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	var direction := Input.get_axis("move_left", "move_right")
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()

	update_animation(direction)


func update_animation(direction: float) -> void:
	if direction > 0:
		animated_sprite.flip_h = false  
	elif direction < 0:
		animated_sprite.flip_h = true   

	if not is_on_floor():
		if velocity.y < 0:
			animated_sprite.play("jump")   
		else:
			animated_sprite.play("fall")   
	elif direction != 0:
		animated_sprite.play("run")        
	else:
		animated_sprite.play("idle")       
