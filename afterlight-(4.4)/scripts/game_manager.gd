extends Node
var PAUSE_MENU_SCREEN = preload("res://UI/ui_scenes/pause_menu_screen.tscn")
var MAIN_MENU_SCREEN = preload("res://UI/ui_scenes/main_menu_screen.tscn")
var SETTINS_MENU_SCREEN = preload("res://UI/ui_scenes/settins_menu_screen.tscn")
# Called when the node enters the scene tree for the first time.
func _ready() :
	RenderingServer.set_default_clear_color(Color(0.44,0.12,0.53,1.00))
	SettingsManager.load_settings()
func exit_game():
	get_tree().quit()
	
func main_menu():
	var main_menu_screen_instance = MAIN_MENU_SCREEN.instantiate()
	get_tree().get_root().add_child(main_menu_screen_instance)
# loads the first level, probably will be used to transistion scenes
func start_game():
	if get_tree().paused:
		continue_game()
		return
	
	SceneManager.transition_to_scene("Level1")
	
func continue_game():
	get_tree().paused =  false
	
func settings_menu():
		# Create a instance
	var settings_menu_screen_instance =SETTINS_MENU_SCREEN.instantiate()
	get_tree().get_root().add_child(settings_menu_screen_instance)

func pause_game():
	get_tree().paused  = true
	var pause_menu_screen_instance = PAUSE_MENU_SCREEN.instantiate()
	get_tree().get_root().add_child(pause_menu_screen_instance)
