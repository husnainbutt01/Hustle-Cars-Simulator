extends Control

var game: Node
var status: Label

func _ready() -> void:
    var panel := PanelContainer.new()
    panel.set_anchors_and_offsets_preset(Control.PRESET_CENTER)
    panel.custom_minimum_size = Vector2(430,350)
    add_child(panel)
    var layout := VBoxContainer.new()
    layout.add_theme_constant_override("separation",12)
    panel.add_child(layout)
    var title := Label.new()
    title.text = "HUSTLE CARS • DEALERSHIP"
    title.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
    title.add_theme_font_size_override("font_size",22)
    layout.add_child(title)
    var intro := Label.new()
    intro.text = "Browse stock, buy a vehicle, then sell it for profit."
    intro.autowrap_mode = TextServer.AUTOWRAP_WORD_SMART
    layout.add_child(intro)
    _add_car(layout,"Compact • City Runner",6500,8200)
    _add_car(layout,"Sport • Vortex GT",14500,18100)
    _add_car(layout,"SUV • TrailMaster",19000,23200)
    status = Label.new()
    status.text = "Welcome to your dealership."
    layout.add_child(status)
    var close := Button.new()
    close.text = "Close showroom  [E]"
    close.pressed.connect(func(): visible = false; if game: game.get_node("PlayerCar").set_physics_process(true))
    layout.add_child(close)

func set_game(g: Node) -> void:
    game = g

func _add_car(parent: VBoxContainer, car_name: String, cost: int, resale: int) -> void:
    var row := HBoxContainer.new()
    parent.add_child(row)
    var label := Label.new()
    label.text = "%s  |  Buy $%d" % [car_name,cost]
    label.size_flags_horizontal = Control.SIZE_EXPAND_FILL
    row.add_child(label)
    var buy := Button.new()
    buy.text = "Buy"
    buy.pressed.connect(func():
        if game and game.buy_car(cost):
            game.sell_car(resale)
            status.text = "Test trade completed: +$%d net value." % (resale-cost)
        else:
            status.text = "Not enough cash for this vehicle."
    )
    row.add_child(buy)
