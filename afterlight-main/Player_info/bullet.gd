extends AnimatedSprite2D


var bullet_impact_effect = preload("res://enemy_stuff/bullet_impac_effect.tscn")

var speed : int = 600
var damage_amount : int = 1
var direction : int
var  move_x_direction : bool


func _physics_process(delta: float):
	#bullet can be fired horizontally or vertically
	if move_x_direction:
		move_local_x(direction * speed * delta)
	else:
		move_local_y(direction * speed * delta)
	
func _on_timer_timeout() -> void:
	queue_free()


func _on_hitbox_area_entered(_area: Area2D) -> void:
	print("Bullet_area_entered")
	bullet_impact()
func get_damage_amount():
	return damage_amount

func _on_hitbox_body_entered(_body: Node2D) -> void:
#	print("bullet_body_entered")
	bullet_impact()
	
func bullet_impact():
	var bullet_impact_effect_instance = bullet_impact_effect.instantiate() as Node2D
	bullet_impact_effect_instance.global_position = global_position
	get_parent().add_child(bullet_impact_effect_instance)
	queue_free()
