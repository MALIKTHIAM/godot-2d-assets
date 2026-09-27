extends Node2D

const Player = preload("res://player.gd")
const Platform = preload("res://platform.gd")
const Enemy = preload("res://enemy.gd")

var player: CharacterBody2D
var score := 0
var game_over := false
var enemy_timer := 0.0
var score_timer := 0.0
var spawn_x := 980.0

func _ready() -> void:
    _create_level()
    player = Player.new()
    player.position = Vector2(150, 350)
    add_child(player)
    _create_hud()
    queue_redraw()

func _create_level() -> void:
    var positions := [Vector2(150, 500), Vector2(380, 420), Vector2(620, 340), Vector2(850, 260), Vector2(1080, 420), Vector2(1320, 330)]
    for position in positions:
        var platform := Platform.new()
        platform.setup(position)
        add_child(platform)

func _create_hud() -> void:
    var label := Label.new()
    label.name = "ScoreLabel"
    label.position = Vector2(24, 20)
    label.add_theme_font_size_override("font_size", 26)
    label.text = "Score : 0"
    add_child(label)

    var help := Label.new()
    help.position = Vector2(24, 55)
    help.text = "A/D ou ←/→ : bouger     ESPACE/W : sauter"
    help.add_theme_color_override("font_color", Color("#d6d8e7"))
    add_child(help)

func _process(delta: float) -> void:
    if game_over:
        queue_redraw()
        return

    enemy_timer += delta
    score_timer += delta
    if enemy_timer > 1.8:
        enemy_timer = 0.0
        _spawn_enemy()
    if score_timer > 0.25:
        score_timer = 0.0
        score += 1
        get_node("ScoreLabel").text = "Score : %d" % score

    if player.global_position.y > 620:
        _end_game()

func _spawn_enemy() -> void:
    var enemy := Enemy.new()
    enemy.setup(Vector2(spawn_x, randf_range(190.0, 470.0)))
    enemy.player_hit.connect(_end_game)
    add_child(enemy)

func _end_game() -> void:
    if game_over:
        return
    game_over = true
    player.set_physics_process(false)
    var message := Label.new()
    message.name = "GameOver"
    message.position = Vector2(320, 220)
    message.add_theme_font_size_override("font_size", 38)
    message.text = "ENNEMI TOUCHÉ !\nScore : %d\nAppuie sur R pour recommencer" % score
    add_child(message)

func _unhandled_input(event: InputEvent) -> void:
    if game_over and event is InputEventKey and event.pressed and event.keycode == KEY_R:
        get_tree().reload_current_scene()

func _draw() -> void:
    draw_rect(Rect2(0, 0, 960, 540), Color("#20233d"), true)
    draw_circle(Vector2(790, 100), 45.0, Color("#f7d98b"))
    for i in range(12):
        var x := float((i * 137) % 960)
        var y := float(100 + ((i * 73) % 280))
        draw_circle(Vector2(x, y), 2.0, Color("#ffffff88"))
