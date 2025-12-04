extends Node

signal skin_atualizada

const SKINS_DATABASE = {
	"default": {
		"frames": "res://scenes/player/assets/black_warrior.tres",
		"preview": "res://scenes/player/assets/black_warrior.png"
	},
	"RedWarrior": {
		"frames": "res://scenes/player/assets/red_warrior.tres",
		"preview": "res://scenes/player/assets/red_warrior.png"
	},
	"BlueWarrior": {
		"frames": "res://scenes/player/assets/blue_warrior.tres",
		"preview": "res://scenes/player/assets/blue_warrior.png"
	},
	"YellowWarrior": {
		"frames": "res://scenes/player/assets/yellow_warrior.tres",
		"preview": "res://scenes/player/assets/yellow_warrior.png"
	},
	"RedMonk": {
		"frames": "res://scenes/player/assets/red_monk.tres",
		"preview": "res://scenes/player/assets/red_monk.png"
	},
	"BlackArcher": {
		"frames": "res://scenes/player/assets/black_archer.tres",
		"preview": "res://scenes/player/assets/black_archer.png"
	}
}

var skins_desbloqueadas = ["default"]
var skin_atual = "default"

# --- Funções ---
func desbloquear_skin(skin_id : String):
	if not SKINS_DATABASE.has(skin_id):
		print("Erro! Skin '%s' não existe no SKINS_DATABASE." % skin_id)
		return
	if not skin_id in skins_desbloqueadas:
		skins_desbloqueadas.append(skin_id)
		print("Nova skin desbloqueada: ", skin_id)

func set_skin_atual(skin_id : String):
	if not skin_id in skins_desbloqueadas:
		print("Erro! Tentando usar skin bloqueada: ", skin_id)
		return
	if skin_atual != skin_id:
		skin_atual = skin_id
		skin_atualizada.emit()

func get_sprite_frames_skin_atual() -> SpriteFrames:
	if SKINS_DATABASE.has(skin_atual):
		return load(SKINS_DATABASE[skin_atual]["frames"])
	else:
		return load(SKINS_DATABASE["default"]["frames"])

func get_preview_icon_por_id(skin_id: String) -> Texture2D:
	if SKINS_DATABASE.has(skin_id):
		return load(SKINS_DATABASE[skin_id]["preview"])
	
	return null
