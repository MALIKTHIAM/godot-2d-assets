extends StaticBody2D

var platform_size := Vector2(150, 20)

func setup(position: Vector2, size: Vector2 = Vector2(150, 20)) -> void:
    global_position = position
    platform_size = size
    var collision := CollisionShape2D.new()
    var shape := RectangleShape2D.new()
    shape.size = platform_size
    collision.shape = shape
    add_child(collision)
    queue_redraw()

func _draw() -> void:
    draw_rect(Rect2(-platform_size / 2.0, platform_size), Color("#7a4d32"), true)
    draw_rect(Rect2(-platform_size.x / 2.0, -platform_size.y / 2.0, platform_size.x, 6), Color("#68b85d"), true)
