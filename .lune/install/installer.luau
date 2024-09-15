local process = require("@lune/process")
local fs = require("@lune/fs")
local path = require("../utils/path")
local summon = require("../utils/summon")

local WALLY_DIRS = {
	Packages = true,
	DevPackages = true,
	ServerPackages = true,
}

local Installer = {}

function Installer.installPackages()
	summon("wally", "install")
	summon("rojo", "sourcemap", "default.project.json", "-o", "sourcemap.json")

	if fs.isDir(path(process.cwd, "WallyPatches")) then
		summon("wally-patch-package")
	end

	for dir in WALLY_DIRS do
		if fs.isDir(path(process.cwd, dir)) then
			summon("wally-package-types", "--sourcemap", "sourcemap.json", dir .. "/")
		end
	end
end

return Installer
