-------------------------------------------------------------------------------
-- Contains various tests that can be run to experiment with UI or simulate
-- different combat situations to make sure the addon functions as expected
-------------------------------------------------------------------------------

SAMURAI = SAMURAI or { }
TEST_HARNESS = TEST_HARNESS or { }
local sam = SAMURAI
local th = TEST_HARNESS

function th.registerNotiTest()
	d("creating...")
	th.noti1 = sam.TimerNotification:New("test1", "FFCC00", EVENT_COMBAT_EVENT, {999999})
	th.noti2 = sam.TimerNotification:New("test2", "00FF00", EVENT_COMBAT_EVENT, {1000000})
	th.noti3 = sam.TimerNotification:New("test3", "0000FF", EVENT_COMBAT_EVENT, {1000001})

	d("registering...")
	th.noti1:Register()
	th.noti2:Register()
	th.noti3:Register()
end

function th.unregisterNotiTest()
	th.noti1:Unregister()
	th.noti2:Unregister()
	th.noti3:Unregister()
end

function th.timedNotiTest()


	d("running...")
	th.noti1:Handler(nil, ACTION_RESULT_BEGIN, nil, nil, nil, nil, nil, nil, nil, COMBAT_UNIT_TYPE_PLAYER, 12200, nil, nil, nil, nil, nil, 999999)
	--th.noti1:Handler(nil, ACTION_RESULT_BEGIN, nil, nil, nil, nil, nil, nil, nil, COMBAT_UNIT_TYPE_PLAYER, 13900, nil, nil, nil, nil, nil, 999999)
	--th.noti1:Handler(nil, ACTION_RESULT_BEGIN, nil, nil, nil, nil, nil, nil, nil, COMBAT_UNIT_TYPE_PLAYER, 12300, nil, nil, nil, nil, nil, 999999)
	th.noti2:Handler(nil, ACTION_RESULT_BEGIN, nil, nil, nil, nil, nil, nil, nil, COMBAT_UNIT_TYPE_PLAYER, 8200, nil, nil, nil, nil, nil, 1000000)
	--th.noti2:Handler(nil, ACTION_RESULT_BEGIN, nil, nil, nil, nil, nil, nil, nil, COMBAT_UNIT_TYPE_PLAYER, 21900, nil, nil, nil, nil, nil, 1000000)
	--th.noti2:Handler(nil, ACTION_RESULT_BEGIN, nil, nil, nil, nil, nil, nil, nil, COMBAT_UNIT_TYPE_PLAYER, 9200, nil, nil, nil, nil, nil, 1000000)
	th.noti3:Handler(nil, ACTION_RESULT_BEGIN, nil, nil, nil, nil, nil, nil, nil, COMBAT_UNIT_TYPE_PLAYER, 15400, nil, nil, nil, nil, nil, 1000001)
	--th.noti3:Handler(nil, ACTION_RESULT_BEGIN, nil, nil, nil, nil, nil, nil, nil, COMBAT_UNIT_TYPE_PLAYER, 11800, nil, nil, nil, nil, nil, 1000001)
	--th.noti3:Handler(nil, ACTION_RESULT_BEGIN, nil, nil, nil, nil, nil, nil, nil, COMBAT_UNIT_TYPE_PLAYER, 22500, nil, nil, nil, nil, nil, 1000001)

	--d("unregistering...")
	--th.noti1:Unregister()
	--th.noti2:Unregister()
	--th.noti3:Unregister()

	d("done")
end

function sam.setupTestHarness()
	SLASH_COMMANDS["/registertimedtest"] = th.registerNotiTest
	SLASH_COMMANDS["/unregistertimedtest"] = th.unregisterNotiTest
	SLASH_COMMANDS["/testtimedalerts"] = th.timedNotiTest
end
