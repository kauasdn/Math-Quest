extends CharacterBody2D

@onready var animated_sprite = $AnimatedSprite2D
@onready var step_sound = $StepSound

@export var move_speed: float = 200.0

func _ready():
	SkinManager.skin_atualizada.connect(_on_skin_atualizada)
	_on_skin_atualizada()

	if GameManager.player_position_on_map != Vector2.ZERO:
		global_position = GameManager.player_position_on_map
		
		GameManager.player_position_on_map = Vector2.ZERO
	
func _physics_process(_delta):
	var direction = Input.get_vector("move_left", "move_right", "move_up", "move_down")
	velocity = direction * move_speed
	move_and_slide()
	
	update_animation(direction)

func _on_skin_atualizada():
	var novas_frames = SkinManager.get_sprite_frames_skin_atual()
	if novas_frames:
		animated_sprite.sprite_frames = novas_frames
	animated_sprite.play("idle")

func update_animation(direction: Vector2):
	if velocity.length() > 0:
		animated_sprite.play("walk")
		
		if not step_sound.playing:
			step_sound.play()
	else:
		animated_sprite.play("idle")
		
		if step_sound.playing:
			step_sound.stop()
		
	if direction.x != 0:
		animated_sprite.flip_h = direction.x < 0
