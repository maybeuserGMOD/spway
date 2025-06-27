net.Receive("CheckAdminFirst", function(len, ply)
	if ply:IsAdmin() or table.HasValue(PHE.SVAdmins, ply:GetUserGroup()) then
		net.Start("CheckAdminResult")
		net.Send(ply)
	end
end)

net.Receive("SvCommandReq", function(len, ply)
	local cmd = net.ReadString()
	local valbool = net.ReadInt(2)
	if ply:IsAdmin() or table.HasValue(PHE.SVAdmins, ply:GetUserGroup()) then
		RunConsoleCommand(cmd, math.Round(valbool))
		printVerbose("[ADMIN CVAR NOTIFY] Commands: " .. cmd .. " has been changed (Player: " .. ply:Nick() .. " (" .. ply:SteamID() .. ")")
	else
		game.KickID(ply:SteamID(), "Illegal command access found by: " .. ply:Nick())
		printVerbose("[ADMIN CVAR NOTIFY] An user " .. ply:Nick() .. "(" ..  ply:SteamID() .. ") is attempting to access " .. cmd .. ", kicked!")
	end
end)

net.Receive("SvCommandBoxReq", function(len, ply)
	local cmd = net.ReadString()
	local valstring = net.ReadString()
	if ply:IsAdmin() or table.HasValue(PHE.SVAdmins, ply:GetUserGroup()) then
		RunConsoleCommand(cmd, valstring)
		printVerbose("[ADMIN CVAR NOTIFY] Commands: " .. cmd .. " has been changed (Player: " .. ply:Nick() .. " (" .. ply:SteamID() .. ")")
	else
		game.KickID(ply:SteamID(), "Illegal command access found by: " .. ply:Nick())
		printVerbose("[ADMIN CVAR NOTIFY] An user " .. ply:Nick() .. "(" ..  ply:SteamID() .. ") is attempting to access " .. cmd .. ", kicked!")
	end
end)

net.Receive("SvCommandSliderReq", function(len, ply)
	local cmd = net.ReadString()
	local bool = net.ReadBool()
	local val
	if bool then
		val = net.ReadFloat()
	else
		val = net.ReadInt(16)
	end
	if ply:IsAdmin() or table.HasValue(PHE.SVAdmins, ply:GetUserGroup()) then
		RunConsoleCommand(cmd, val)
		printVerbose("[ADMIN CVAR SLIDER NOTIFY] Commands: " .. cmd .. " has been changed (Player: " .. ply:Nick() .. " (" .. ply:SteamID() .. ")")
	else
		game.KickID(ply:SteamID(), "Illegal command access found by: " .. ply:Nick())
		printVerbose("[ADMIN CVAR NOTIFY] An user " .. ply:Nick() .. "(" ..  ply:SteamID() .. ") is attempting to access " .. cmd .. ", kicked!")
	end
end)

net.Receive("SendTauntStateCmd", function(len, ply)
	local cmdval = net.ReadString()

	if ply:IsAdmin() or table.HasValue(PHE.SVAdmins, ply:GetUserGroup()) then
		RunConsoleCommand("ph_enable_custom_taunts", cmdval)
		printVerbose("[ADMIN CVAR TAUNT NOTIFY] Commands: " .. cmdval .. " has been changed (Player: " .. ply:Nick() .. " (" .. ply:SteamID() .. ")")
	else
		game.KickID(ply:SteamID(), "Illegal command access found by: " .. ply:Nick())
		printVerbose("[ADMIN CVAR NOTIFY] An user " .. ply:Nick() .. "(" ..  ply:SteamID() .. ") is attempting to access " .. cmdval .. ", kicked!")
	end
end)


net.Receive("ResetRotateTeams", function(len, ply)
	if ply:IsAdmin() or table.HasValue(PHE.SVAdmins, ply:GetUserGroup()) then
		SetGlobalInt("RotateTeamsOffset", 0)
	else
		ply:ChatError(PHE.LANG.ERROR_ADMIN_ONLY, "PH:E - Admin")
	end
end)

net.Receive("ForceHunterAsProp", function(len, ply)
	if ply:IsAdmin() or table.HasValue(PHE.SVAdmins, ply:GetUserGroup()) then
		local hunter = Player(net.ReadUInt(16))
		local hunterName = hunter:GetName()

		if not hunter:GetVar("ForceAsProp", false) then
			hunter:SetVar("ForceAsProp", true)

			for _, plyr in ipairs(player.GetAll()) do
				plyr:ChatInfo(hunterName .. PHE.LANG.FORCEHUNTERASPROP.WILL_BE, "PH:E - Admin")
			end
		else
			ply:ChatError(hunterName .. PHE.LANG.FORCEHUNTERASPROP.ALREADY, "PH:E - Admin")
		end
	else
		ply:ChatError(PHE.LANG.ERROR_ADMIN_ONLY, "PH:E - Admin")
	end
end)
