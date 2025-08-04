extends Control


@onready var cookies_per_sec_timer: Timer = $CookiesPerSecTimer



# === Game Variables ===
var cookies := 0
var cookies_per_click := 2
var cookies_per_second := 100

# === Upgrade Definitions ===
var upgrades = [
	{
		"name": "+1 per click",
		"cost": 10,
		"increase_click": 1,
		"increase_cps": 0
	},
	{
		"name": "+5 per click",
		"cost": 50,
		"increase_click": 5,
		"increase_cps": 0
	},
	{
		"name": "+1 per second",
		"cost": 10,
		"increase_click": 0,
		"increase_cps": 1
	}
]



# === Lifecycle ===
func _ready():
	var  btn = $CookieButton
	_on_cookie_button_pressed()
	_on_cookies_per_sec_timer_timeout()
	create_shop_items()
	update_ui()


# === Shop Button Logic ===
func _on_upgrade_pressed(upgrade):
	if cookies >= upgrade.cost:
		cookies -= upgrade.cost
		cookies_per_click += upgrade.increase_click
		cookies_per_second += upgrade.increase_cps
		update_ui()




#  Refresh  label with cookies
func update_ui()-> void:
	$CookieCountLabel.text = "Cookies: %d" % cookies

# Shop Creation
func create_shop_items():
	for upgrade in upgrades:
		var btn = Button.new()
		btn.text = "%s - %d cookies" % [upgrade.name, upgrade.cost]
		btn.pressed.connect(_on_upgrade_pressed.bind(upgrade))
		$ShopContainer.add_child(btn)  # add btn to container


func _on_cookie_button_pressed() -> void:
	cookies += cookies_per_click
	update_ui()
	
	

# === Passive Cookies ===
func _on_cookies_per_sec_timer_timeout() -> void:
	cookies += cookies_per_second
	update_ui()
