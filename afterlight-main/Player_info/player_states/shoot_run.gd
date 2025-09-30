extends NodeState

var bullet  =  preload("res://Player_info/bullet.tscn")
@export var character_body_2d : CharacterBody2D
@export var animated_sprite_2d : AnimatedSprite2D
@export var muzzle : Marker2D


@export_category("Run State")
@export var speed : int = 1000
@export var max_horizontal_speed : int = 300


var muzzle_position : Vector2
func on_process(delta : float):
	pass
	
func on_physics_process(delta : float):
	var direction : float  = GameInputEvents.movement_input()
	
	gun_muzzle_position(direction)
	
	if direction:
		character_body_2d.velocity.x += direction  * speed
		character_body_2d.velocity.x = clamp(character_body_2d.velocity.x ,-max_horizontal_speed, max_horizontal_speed	)
		
	if direction!= 0:
		animated_sprite_2d.flip_h = false if direction > 0 else true
	
	if GameInputEvents.shoot_input():
		gun_shooting(direction)
	character_body_2d.move_and_slide()
#transition states

# fall state
	if !character_body_2d.is_on_floor():
		transition.emit("fall")
#idle state
	if direction == 0:
		transition.emit("idle")
# jump state		
	if GameInputEvents.jump_input():
		transition.emit("jump")
func enter():
	muzzle.position = Vector2(15, -27)
	muzzle_position = muzzle.position
	animated_sprite_2d.play("shoot-run")
	
func exit():
	animated_sprite_2d.stop()

func gun_shooting(direction : float):
	#instantiate bullet
	var bullet_instance = bullet.instantiate()
	# pass direction to bullet instance
	bullet_instance.direction = direction
	bullet_instance.move_x_direction = true
	bullet_instance.global_position = muzzle.global_position
	get_parent().add_child(bullet_instance)
	
func gun_muzzle_position(direction : float):
	if direction > 0:
		muzzle.position.x = muzzle_position.x
	elif direction < 0:
		muzzle.position.x = -muzzle_position.x	
	


	
	
