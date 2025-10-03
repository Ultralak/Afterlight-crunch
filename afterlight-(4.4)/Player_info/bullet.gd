extends CharacterBody2D

var bullet_impact_effect = preload("res://enemy_stuff/bullet_impac_effect.tscn")
var velocity_bullet: Vector2 = Vector2.ZERO

@export var speed: int = 800
@export var damage_amount: int = 1

func set_velocity_bullet(new_velocity: Vector2):
	velocity_bullet = new_velocity

func _physics_process(_delta: float):
	velocity = velocity_bullet
	var collision = move_and_slide()
	
	if collision:
		bullet_impact()
		

func _on_timer_timeout() -> void:
	queue_free()

func get_damage_amount() -> int:
	return damage_amount


func _on_damage_area_area_entered(area: Area2D) -> void:
	if area.is_in_group("Enemy"):

		area.take_damage(damage_amount)

		bullet_impact()
	
func bullet_impact():
	var bullet_impact_effect_instance = bullet_impact_effect.instantiate() as Node2D
	bullet_impact_effect_instance.global_position = global_position
	get_parent().add_child(bullet_impact_effect_instance)
	queue_free()
