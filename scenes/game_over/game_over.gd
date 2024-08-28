extends Node2D
class_name GameOverController

@onready var fade: FadeRect = $CanvasLayer/Fade

@onready var edit: LineEdit = $CanvasLayer/LineEditName
@onready var score: Label = $CanvasLayer/LabelScore
@onready var status: Label = $CanvasLayer/LabelStatus

var data_sent: bool = false
var server_adr: String = '172.16.255.155:5000'

func _ready() -> void:
	var arg: String = get_server_adr_param()
	if arg:
		server_adr = arg#'127.0.0.1:5000'
	
	score.text = GameController.SCORE_FORMAT % GameController.total_score # 000000'
	status.visible = false
	
	fade.start_fade(1.0, 0.0, 1.0)

func get_server_adr_param() -> String:
	var arguments = {}
	for argument in OS.get_cmdline_args():
		if argument.contains("="):
			var key_value = argument.split("=")
			arguments[key_value[0].trim_prefix("--")] = key_value[1]
		else:
			arguments[argument.trim_prefix("--")] = ""	
	
	if arguments.has('server'):
		return arguments['server']
	else:
		return ''


func show_status(text: String, color: Color) -> void:
	status.text = text
	status.set("theme_override_colors/font_color", color)
	status.visible = true
	await get_tree().create_timer(4.0).timeout
	status.visible = false

func remove_special_chars(text: String, symbols: String) -> String:
	for sb in symbols:
		text = text.replace(sb, ' ')
	return text

func submit_score() -> void:
	var player_name: String = edit.text.lstrip(' ').rstrip(' ')
	
	player_name = remove_special_chars(player_name, ",;/?:@=&")
	if player_name:
		show_status("Sending data...", Color.GREEN)
		send_game_data(1, GameController.total_score, player_name.replace(' ','%'), "Optachiibas")
	else:
		show_status("Name cannot be empty", Color.RED)


func on_request_completed(result, _response_code, _headers, _body) -> void:
	if result == HTTPRequest.RESULT_SUCCESS:
		show_status("Data sent to score server", Color.GREEN)
		data_sent = true
		next_level()
	else:
		show_status("Could not send data to score server", Color.RED)


func next_level() -> void:
	await get_tree().create_timer(1.0).timeout
	fade.start_fade(0.0, 1.0, 1.0)
	fade.on_fade_done(GameController.load_title)
	
	
func generate_hmac(data: String, secret_key: String) -> String:
	var ctx = HMACContext.new()
	
	ctx.start(HashingContext.HASH_SHA256, secret_key.to_utf8_buffer())
	ctx.update(data.to_utf8_buffer())
	var res = ctx.finish()
	
	# Convert the hash to a hexadecimal string
	return res.hex_encode()


func send_game_data(game_id: int, _score: int, nickname: String, secret_key: String):
	var data = str(game_id) + nickname + str(_score)
	var hmac_hash = generate_hmac(data, secret_key)

	# Prepare the GET request URL
	nickname = nickname.replace(' ','%20')
	var url = "http://%s/send_score/%d/%s/%d/%s" % [server_adr, game_id, nickname, _score, hmac_hash]
	print('Request URL: ',url)

	var http_request = HTTPRequest.new()
	add_child(http_request)

	http_request.request_completed.connect(on_request_completed)
	http_request.request(url)
	print("Data sent with HMAC:", hmac_hash)	


func _on_line_edit_name_text_submitted(_new_text: String) -> void:
	if not data_sent:
		submit_score()
