extends NodeState

var bullet = preload("res://Player_info/bullet.tscn")
@export var character_body_2d : CharacterBody2D
@export var animated_sprite_2d : AnimatedSprite2D
@export var attack_duration: float = 1.0
@onready var animation_timer: Timer = Timer.new()

@export_category("Slash State")
@export var slash_forward_force: float = 100.0

func _ready():
	add_child(animation_timer)
	animation_timer.one_shot = true
	animation_timer.timeout.connect(_on_animation_timer_timeout)

func on_process(_delta : float):
	pass
	
func on_physics_process(_delta : float):
	# Movement will be handled by the velocity set in enter()
	character_body_2d.move_and_slide()
	
	# Transition checks (usually only fall or force-interrupts here)
	if not character_body_2d.is_on_floor():
		transition.emit("fall")
		return
	
func enter():
	animated_sprite_2d.play("attack_one")
	
	var direction_multiplier = 1.0
	if animated_sprite_2d.flip_h:
		direction_multiplier = -1.0
		
	character_body_2d.velocity.x = slash_forward_force * direction_multiplier
	
	var hitbox = character_body_2d.get_node("MeleeHitBox")
	if hitbox and hitbox.has_method("activate_hitbox"):
		hitbox.activate_hitbox()
		
	animation_timer.start(attack_duration)
	
func exit():
	animated_sprite_2d.stop()
	character_body_2d.velocity.x = 0
	
	var hitbox = character_body_2d.get_node("MeleeHitBox")
	if hitbox and hitbox.has_method("deactivate_hitbox"):
		hitbox.deactivate_hitbox()

func _on_animation_timer_timeout():
	transition.emit("idle")
