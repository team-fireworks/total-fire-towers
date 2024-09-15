local Installer = require("../install/installer")
local process = require("@lune/process")
local fs = require("@lune/fs")
local task = require("@lune/task")
local path = require("../utils/path")
local summon = require("../utils/summon")

local WALLY_DIRS = {
	Packages = true,
	-- DevPackages = true,
	-- ServerPackages = true,
}

local Compiler = {}

local function intoEnvBoolean(boolean: unknown): string
	return boolean and "true" or "false"
end

function Compiler.compile(options: {
	shouldWatch: boolean,
	channel: string,
})
	for dir in WALLY_DIRS do
		if not fs.isDir(path(process.cwd, dir)) then
			Installer.installPackages()
			break
		end
	end

	if options.shouldWatch then
		task.spawn(summon, "rojo", "sourcemap", "default.project.json", "-o", "sourcemap.json", "--watch")
		task.spawn(process.spawn, "darklua", {
			"process",
			"--config",
			".darklua.json",
			"--watch",
			"src",
			"dist",
		}, {
			env = {
				ROBLOX_DEV = intoEnvBoolean(options.channel == "development"),
			},
		})
		task.spawn(summon, "rojo", "serve", "dist.project.json")
	else
		summon("rojo", "sourcemap", "default.project.json", "-o", "sourcemap.json", "--watch")
		process.spawn("darklua", { "process", "--config", ".darklua.json", "src", "dist" }, {
			env = {
				ROBLOX_DEV = intoEnvBoolean(options.channel == "development"),
			},
		})
		summon("rojo", "build", "dist.project.json", "-o", "total-fire-towers.rbxl")
	end
end

return Compiler
