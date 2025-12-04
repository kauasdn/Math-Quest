extends Control

@onready var controls_layer = $ControlsLayer

@onready var close_button = $ControlsLayer/Panel/CloseButton

func _ready():
	$VBoxContainer/StartButton.pressed.connect(_on_start_pressed)
	$VBoxContainer/QuitButton.pressed.connect(_on_quit_pressed)
	
	if $VBoxContainer.has_node("ReviewButton"):
		$VBoxContainer/ReviewButton.pressed.connect(_on_review_pressed)
	
	if $VBoxContainer.has_node("Controles"):
		$VBoxContainer/Controles.pressed.connect(_on_controls_pressed)
	
	close_button.pressed.connect(_on_close_controls_pressed)
	
	controls_layer.visible = false

func _on_start_pressed():
	get_tree().change_scene_to_file("res://scenes/map.tscn")

func _on_quit_pressed():
	get_tree().quit()

func _on_review_pressed():
	OS.shell_open("https://docs.google.com/forms/d/e/1FAIpQLSf4sb7wxwtNTo1Hn0-GET9Y53EpcISWgqIg2JWZCqQqJoqSCA/viewform?classId=f184dc01-5c99-4209-8d14-4f506994e2a8&assignmentId=a098d4d0-0414-425d-a5a1-b1b51ef087ab&submissionId=60a29655-16f0-b27f-73d6-507af02a9178")

func _on_controls_pressed():
	controls_layer.visible = true

func _on_close_controls_pressed():
	controls_layer.visible = false

func _unhandled_input(event):
	if controls_layer.visible and event.is_action_pressed("ui_cancel"):
		_on_close_controls_pressed()
