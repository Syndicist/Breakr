extends Control

signal minutes_increased
signal hours_increased
signal clear_time

@onready var num_regex := RegEx.new()

func _ready():
	num_regex.compile("[a-zA-Z0-9]+")
	for child in $TimeContainer.get_children():
		var textbox : TextEdit = child
		textbox.text_set.connect(on_time_changed.bind(textbox))
	hours_increased.connect(_hours_increased)
	minutes_increased.connect(_minutes_imcreased)

func on_time_changed(textbox : TextEdit):
	var text : String = textbox.text
	var matches = num_regex.search_all(text)
	if matches:
		for r_match in matches:
			text += r_match.get_string()
	text = text.substr(0,1)
	var t = int(text)
	if textbox.name == "Hours":
		if t > 24:
			text = '0'
		if t < 0:
			text = '24'
	elif t > 60:
		if textbox.name == "Minutes":
			hours_increased.emit()
		if textbox.name == "Seconds":
			minutes_increased.emit()
	elif t < 0:
		text = '60'
	t = int(text)
	
	if t < 10:
		text = '0' + str(t)
	
	textbox.text = text

func _hours_increased():
	var textbox : TextEdit = $TimeContainer/Hours
	var t : int = int(textbox.text)
	t += 1
	var text : String = str(t)
	if t < 10:
		text = '0' + text
	textbox.text = text



















