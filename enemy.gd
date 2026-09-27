extends Area2D

signal player_hit
var speed := 105.0

func setup(position: Vector2) -> void:
    global_position = position
    var collision := CollisionShape2D.new()
    var shape := RectangleShape2D.new()
    shape.size = Vector2(34, 34)
    collision.shape = shape
    add_child(collision)
    body_entered.connect(_on_body_entered)
    queue_redraw()

func _process(delta: float) -> void:
    position.x -= speed * delta
    if position.x < -60:
        queue_free()

func _on_body_entered(body: Node) -> void:
    if body is CharacterBody2D:
        player_hit.emit()

func _draw() -> void:
    var points := PackedVector2Array([Vector2(-20, 15), Vector2(-12, -12), Vector2(0, 0), Vector2(12, -12), Vector2(20, 15)])
    draw_colored_polygon(points, Color("#db4c5e"))
    draw_circle(Vector2(-7, -2), 3.0, Color.WHITE)
    draw_circle(Vector2(7, -2), 3.0, Color.WHITE)
    draw_circle(Vector2(-7, -2), 1.5, Color("#29202a"))
    draw_circle(Vector2(7, -2), 1.5, Color("#29202a"))
