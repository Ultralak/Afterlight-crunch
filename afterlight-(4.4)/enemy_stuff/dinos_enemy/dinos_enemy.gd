extends CharacterBody2D
@export var health_amount : int = 6
@export var damage_amount : float = 0.5
var enemy_death_effect = preload("res://enemy_stuff/enemy_death_effect.tscn")
func take_damage(damage: int):
	health_amount -= damage
	print("Health amount: ", health_amount)
	if health_amount <= 0:
		var enemy_death_fx_instance = enemy_death_effect.instantiate()
		enemy_death_fx_instance.global_position = global_position
		get_parent().add_child(enemy_death_fx_instance)
		queue_free()
func _on_hurbox_area_entered(area: Area2D) -> void:
	print("Hurtbox_area_entered")
	if area.get_parent().has_method("get_damage_amount") :
		var node = area.get_parent() as Node
		health_amount -= node.get_damage_amount()
		print("Health amount: ", health_amount)
		if health_amount <= 0:
			var enemy_death_fx_instance = enemy_death_effect.instantiate()
			enemy_death_fx_instance.global_position = global_position
			get_parent().add_child(enemy_death_fx_instance)
			queue_free()

	elif  area.has_method("get_damage_amount"):
		var node = area as Node
		health_amount -= node.get_damage_amount()
		print("Health amount: ", health_amount)
		if health_amount <= 0:
			var enemy_death_fx_instance = enemy_death_effect.instantiate()
			enemy_death_fx_instance.global_position = global_position
			get_parent().add_child(enemy_death_fx_instance)
			queue_free()
