-- modinfo read by stlrel from http://github.com/stellaris-mods/scripts
return {
	path = "autoass",
	name = "Autonomous Assembler",
	tags = { "Gameplay", "Spaceships" },
	picture = "thumb.png",
	supported_version = "1.8.*",
	remote_file_id = 1155987128,
	readme = "README.md",
	steambb = "steam.bbcode",
	-- Files and folders added in exclude will not be copied over to the Paradox Interactive
	-- local mod folder when you run `stlrel --steam`.
	exclude = {
		"source", ".git", "steam.bbcode", "README.md"
	}
}
