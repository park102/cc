local meta = {}
parallel.waitForAny(
	--- This loop just pulls user input. It handles a couple of function keys, as well as
	--- setting the "hover" field to true/false.
	---
	--- We recommend running [with the keyboard in your neural interface](../items/keyboard.html#using-with-the-neural-interface),
	--- as this allows you to navigate without having the interface open.
	function()
		while true do
			local event, key = os.pullEvent()
			if event == "key" and key == keys.g then
				modules.launch(meta.yaw, meta.pitch, 3)
			end
		end
	end,
    function()
		while true do
			meta = modules.getMetaOwner()
		end
	end,

)
