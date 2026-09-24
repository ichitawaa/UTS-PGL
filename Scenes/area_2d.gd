extends Area2D

@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D
@onready var collision_shape: CollisionShape2D = $CollisionShape2D

func _ready() -> void:
	# Mainkan animasi buah di awal (misal: "Bananas")
	animated_sprite.play("Bananas")


func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("player") or body is CharacterBody2D:
		# Matikan collision agar tidak tersentuh 2 kali
		collision_shape.set_deferred("disabled", true)
		
		# Mainkan animasi efek diambil (collectible)
		animated_sprite.play("collectible")


func _on_animated_sprite_2d_animation_finished() -> void:
	# Hapus node HANYA setelah animasi "collectible" selesai diputar
	if animated_sprite.animation == "collectible":
		queue_free()
