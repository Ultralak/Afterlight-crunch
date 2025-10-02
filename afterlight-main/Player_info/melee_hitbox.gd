extends Area2D

@export var player_reference: CharacterBody2D
var is_active: bool = false

func _ready():
	monitoring = false
	monitorable = false

func activate_hitbox():
	monitoring = true
	monitorable = true
	is_active = true

func deactivate_hitbox():
	monitoring = false
	monitorable = false
	is_active = false
	
func _on_body_entered(body: Node2D):
	if is_active and body.is_in_group("Enemy"):
		if body.has_method("take_damage"):
			var damage_to_deal = 3
			body.take_damage(damage_to_deal)
			
		deactivate_hitbox()
