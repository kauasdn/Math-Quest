extends Control

func _ready():
    $VBoxContainer/ScoreLabel.text = "Pontuação: %d" % GameManager.score
    $VBoxContainer/ContinueButton.pressed.connect(_on_continue_pressed)

func _on_continue_pressed():
    get_tree().change_scene_to_file("res://scenes/KingdomSelect.tscn")
