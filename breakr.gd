extends Node2D

signal work_time
signal break_time


@export var work_hours : int
@export var work_minutes : int
@export var work_seconds : float

var break_hours : int
var break_minutes : int
var break_seconds : float

var hours_left : int
var minutes_left : int
var seconds_left : float

var on_break := true
#TODO: stopwatch
var break_ticker #: Timer
var work_timer : Timer

func _ready():
	var total_work_seconds : float = work_seconds + work_minutes*60 + work_hours*60*60
	var total_break_seconds : float = break_seconds + break_minutes*60 + break_hours*60*60
	if total_work_seconds <= 0:
		printerr("INVALID WORK TIME ENTERED")
	work_timer = Timer.new()
	work_timer.one_shot = true
	work_timer.wait_time = total_work_seconds
	add_child(work_timer)
	work_time.connect(start_work)
	work_timer.timeout.connect(work_timeout)
	

func start_work():
	# TODO: called when button pressed emits work_time signal
	work_timer.start()
	on_break = false

func start_break():
	break_ticker.start()
	on_break = true

func work_timeout():
	pass
	# TODO: signal to alert to start break. press button to begin break which emits break_time signal













