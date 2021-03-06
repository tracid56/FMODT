godmode = false; godmodeCount = 0; playerVisible = true; playerVisibleCount = 1; nowantedlevel = false; nowantedlevelCount = 0
superjump = false; stamina = false; supermanmode = false; WantedLevel = 0; maxWantedLevel = 5; Run = 1.0; Swim = 1.0
local animPlay, animDict, animName, pistol, changePedByName, mChar, fChar, skin
local AddOnPedsTable = {}

Citizen.CreateThread(function() --Player Menu
	while true do
		local playerPed = GetPlayerPed(-1)
		if (playerMenu) then
		
			if not IsDisabledControlPressed(1, 173) and not IsDisabledControlPressed(1, 172) then
				currentOption = lastSelectionplayerMenu
			else
				lastSelectionplayerMenu = currentOption
			end
		
			TriggerEvent("FMODT:Title", "~y~ " .. PlayerMenuTitle)

			TriggerEvent("FMODT:Option", ArmorHealWashTitle, function(cb)
				if (cb) then
					SetPedArmour(playerPed, 100)
					SetEntityHealth(playerPed, 200)
					ClearPedBloodDamage(playerPed)
					ResetPedVisibleDamage(playerPed)
					ClearPedLastWeaponDamage(playerPed)
					drawNotification("~g~" .. ArmorHealWashMessage .. "!")
				end
			end)

			TriggerEvent("FMODT:Option", "~y~>> ~s~" .. AnimationsTitle .. "", function(cb)
				if (cb) then
					playerMenu = false
					animationMenu = true
				end
			end)

			TriggerEvent("FMODT:Option", "~y~>> ~s~" .. ChangePedTitle .. "", function(cb)
				if (cb) then
					playerMenu = false
					skinMenu = true
				end
			end)

			TriggerEvent("FMODT:Option", "~y~>> ~s~" .. ComponentChangerTitle .. "", function(cb)
				if (cb) then
					playerMenu = false
					componentChangerMenu = true
				end
			end)

			TriggerEvent("FMODT:Bool", PlayerGodmodeTitle, godmode, function(cb)
				godmode = cb
				if godmode then
					godmodeCount = 1
					SetPedArmour(playerPed, 100)
					SetEntityHealth(playerPed, 200)
					drawNotification("~g~" .. PlayerGodmodeEnableMessage .. "!")
				else
					godmodeCount = 0
					drawNotification("~r~" .. PlayerGodmodeDisableMessage .. "!")
				end
			end)

			TriggerEvent("FMODT:Bool", InfiniteStaminaTitle, stamina, function(cb)
				stamina = cb
				if stamina then
					drawNotification("~g~" .. InfiniteStaminaEnableMessage .. "!")
				else
					drawNotification("~r~" .. InfiniteStaminaDisableMessage .. "!")
				end
			end)

			TriggerEvent("FMODT:Option", "~y~>> ~s~" .. OutfitsTitle .. "", function(cb)
				if (cb) then
					playerMenu = false
					outfitMenu = true
				end
			end)

			TriggerEvent("FMODT:Float", RunSpeedMultiplierTitle, Run, 1.0, 2.0, 0.1, 1, function(cb) --Run Speed Multiplier
				Run = cb
			end)

			TriggerEvent("FMODT:Option", "~y~>> ~s~" .. ScenariosTitle .. "", function(cb)
				if (cb) then
					playerMenu = false
					scenarioMenu = true
				end
			end)

			TriggerEvent("FMODT:Bool", SuperJumpTitle, superjump, function(cb)
				superjump = cb
				if superjump then
					drawNotification("~g~" .. SuperJumpEnableMessage .. "!")
				else
					drawNotification("~r~" .. SuperJumpDisableMessage .. "!")
				end
			end)

			TriggerEvent("FMODT:Option", "Suicide", function(cb)
				if (cb) then
					SetEntityHealth(playerPed, 0)
				end
			end)

			TriggerEvent("FMODT:Bool", SupermanModeTitle, supermanmode, function(cb)
				supermanmode = cb
				if supermanmode then
					drawNotification("~g~" .. SupermanModeEnableMessage .. "!")
				else
					drawNotification("~r~" .. SupermanModeDisableMessage .. "!")
				end
			end)

			TriggerEvent("FMODT:Float", SwimSpeedMultiplierTitle, Swim, 1.0, 2.0, 0.1, 2, function(cb) --Swim Speed Multiplier
				Swim = cb
			end)

			TriggerEvent("FMODT:Option", "~y~>> ~s~" .. WantedLevelTitle .. "", function(cb)
				if (cb) then
					playerMenu = false
					wantedMenu = true
				end
			end)

			TriggerEvent("FMODT:Bool", PlayerVisibleTitle, playerVisible, function(cb)
				playerVisible = cb
				if playerVisible then
					playerVisibleCount = 1
					drawNotification("~g~" .. PlayerVisibleEnableMessage .. "!")
				else
					playerVisibleCount = 0
					drawNotification("~r~" .. PlayerVisibleDisableMessage .. "!")
				end
			end)

			TriggerEvent("FMODT:Update")
		end

		Citizen.Wait(0)
	end
end)

Citizen.CreateThread(function() --Animation Menu						[Multiple Pages]
	while true do
		if (animationMenu) then
		
			if not IsDisabledControlPressed(1, 173) and not IsDisabledControlPressed(1, 172) then
				currentOption = lastSelectionanimationMenu
			else
				lastSelectionanimationMenu = currentOption
			end

			TriggerEvent("FMODT:Title", "~y~" .. AnimationsTitle .. "")

			TriggerEvent("FMODT:Option", "~y~>> ~s~" .. SexActsTitle .. "", function(cb)
				if (cb) then
					animationMenu = false
					sexactAnimationMenu = true
				end
			end)

			TriggerEvent("FMODT:Option", "~y~>> ~s~" .. StripsTitle .. "", function(cb)
				if (cb) then
					animationMenu = false
					stripAnimationMenu = true
				end
			end)

			TriggerEvent("FMODT:Option", "~y~>> ~s~" .. SuicideTitle .. "", function(cb)
				if (cb) then
					animationMenu = false
					suicideAnimationMenu = true
				end
			end)

			TriggerEvent("FMODT:Update")
			
		elseif (sexactAnimationMenu) then
		
			if not IsDisabledControlPressed(1, 173) and not IsDisabledControlPressed(1, 172) then
				currentOption = lastSelectionsexactAnimationMenu
			else
				lastSelectionsexactAnimationMenu = currentOption
			end

			TriggerEvent("FMODT:Title", "~y~" .. SexActsTitle .. "")

			TriggerEvent("FMODT:Option", StopSexActsTitle, function(cb)
				if (cb) then
					ClearPedTasksImmediately(GetPlayerPed(-1))
				end
			end)

			TriggerEvent("FMODT:Option", AnalFuckedTitle, function(cb)
				if (cb) then
					animDict = "rcmpaparazzo_2"
					animName = "shag_loop_poppy"
					animPlay = true
				end
			end)

			TriggerEvent("FMODT:Option", AnalFuckerTitle, function(cb)
				if (cb) then
					animDict = "rcmpaparazzo_2"
					animName = "shag_loop_a"
					animPlay = true
				end
			end)

			TriggerEvent("FMODT:Option", CarBJGetterTitle, function(cb)
				if (cb) then
					animDict = "mini@prostitutes@sexnorm_veh"
					animName = "bj_loop_male"
					animPlay = true
				end
			end)

			TriggerEvent("FMODT:Option", CarBJGiverTitle, function(cb)
				if (cb) then
					animDict = "mini@prostitutes@sexnorm_veh"
					animName = "bj_loop_prostitute"
					animPlay = true
				end
			end)

			TriggerEvent("FMODT:Option", CarSexGetterTitle, function(cb)
				if (cb) then
					animDict = "mini@prostitutes@sexnorm_veh"
					animName = "sex_loop_male"
					animPlay = true
				end
			end)

			TriggerEvent("FMODT:Option", CarSexGiverTitle, function(cb)
				if (cb) then
					animDict = "mini@prostitutes@sexnorm_veh"
					animName = "sex_loop_prostitute"
					animPlay = true
				end
			end)

			TriggerEvent("FMODT:Update")
			
		elseif (stripAnimationMenu) then
		
			if not IsDisabledControlPressed(1, 173) and not IsDisabledControlPressed(1, 172) then
				currentOption = lastSelectionstripAnimationMenu
			else
				lastSelectionstripAnimationMenu = currentOption
			end

			TriggerEvent("FMODT:Title", "~y~" .. StripsTitle .. "")

			TriggerEvent("FMODT:Option", StopStripTitle, function(cb)
				if (cb) then
					ClearPedTasksImmediately(GetPlayerPed(-1))
				end
			end)

			TriggerEvent("FMODT:Option", PoleDance1Title, function(cb)
				if (cb) then
					animDict = "mini@strip_club@pole_dance@pole_dance1"
					animName = "pd_dance_01"
					animPlay = true
				end
			end)

			TriggerEvent("FMODT:Option", PoleDance2Title, function(cb)
				if (cb) then
					animDict = "mini@strip_club@pole_dance@pole_dance2"
					animName = "pd_dance_02"
					animPlay = true
				end
			end)

			TriggerEvent("FMODT:Option", PoleDance3Title, function(cb)
				if (cb) then
					animDict = "mini@strip_club@pole_dance@pole_dance3"
					animName = "pd_dance_03"
					animPlay = true
				end
			end)

			TriggerEvent("FMODT:Option", LapDanceTitle, function(cb)
				if (cb) then
					animDict = "mp_am_stripper"
					animName = "lap_dance_girl"
					animPlay = true
				end
			end)

			TriggerEvent("FMODT:Option", PrivateDanceTitle, function(cb)
				if (cb) then
					animDict = "mini@strip_club@private_dance@part1"
					animName = "priv_dance_p1"
					animPlay = true
				end
			end)

			TriggerEvent("FMODT:Update")
			
		elseif (suicideAnimationMenu) then
		
			if not IsDisabledControlPressed(1, 173) and not IsDisabledControlPressed(1, 172) then
				currentOption = lastSelectionsuicideAnimationMenu
			else
				lastSelectionsuicideAnimationMenu = currentOption
			end

			TriggerEvent("FMODT:Title", "~y~" .. SuicideTitle .. "")

			TriggerEvent("FMODT:Option", StopSuicideTitle, function(cb)
				if (cb) then
					ClearPedTasksImmediately(GetPlayerPed(-1))
					SetCurrentPedWeapon(GetPlayerPed(-1), GetHashKey("WEAPON_UNARMED"), true)
				end
			end)

			TriggerEvent("FMODT:Option", PillSuicideTitle, function(cb)
				if (cb) then
					animDict = "mp_suicide"
					animName = "pill"
					animPlay = true
				end
			end)

			TriggerEvent("FMODT:Option", PistolSuicideTitle, function(cb)
				if (cb) then
					animDict = "mp_suicide"
					animName = "pistol"
					animPlay = true
					pistol = true
				end
			end)

			TriggerEvent("FMODT:Update")
		end

		Citizen.Wait(0)
	end
end)

Citizen.CreateThread(function() --Skin Menu								[Multiple Pages]
	while true do
	
		local skinName = { "Abigail Mathers (CS)", "Abigail Mathers (IG)", "Abner", "African American Male", "Agent (CS)", "Agent (IG)", "Agent 14 (CS)", "Agent 14 (IG)", "Air Hostess", "Air Worker Male", "Al Di Napoli Male", "Alien", "Altruist Cult Mid-Age Male", "Altruist Cult Old Male", "Altruist Cult Old Male 2", "Altruist Cult Young Male", "Altruist Cult Young Male 2", "Amanda De Santa (CS)", "Amanda De Santa (IG)", "Ammu-Nation City Clerk", "Ammu-Nation Rural Clerk", "Andreas Sanchez (CS)", "Andreas Sanchez (IG)", "Anita Mendoza", "Anton Beaudelaire", "Anton Beaudelaire", "Armenian Boss", "Armenian Goon", "Armenian Goon 2", "Armenian Lieutenant", "Armoured Van Security", "Armoured Van Security", "Armoured Van Security 2", "Army Mechanic", "Ashley Butler (CS)", "Ashley Butler (IG)", "Autopsy Tech", "Autoshop Worker", "Autoshop Worker 2", "Azteca", "Baby D", "Ballas East Male", "Ballas Female", "Ballas OG", "Ballas OG (IG)", "Ballas Original Male (IG)", "Ballas South Male", "Bank Manager (CS)", "Bank Manager (IG)", "Bank Manager Male", "Barber Female", "Barman", "Barry (CS)", "Barry (IG)", "Bartender", "Bartender (Rural)", "Baywatch Female", "Baywatch Male", "Beach Female", "Beach Male", "Beach Male 2", "Beach Muscle Male", "Beach Muscle Male 2", "Beach Old Male", "Beach Tramp Female", "Beach Tramp Male", "Beach Young Female", "Beach Young Male", "Beach Young Male 2", "Beach Young Male 3", "Benny", "Best Man (IG)", "Beverly Felton (CS)", "Beverly Felton (IG)", "Beverly Hills Female", "Beverly Hills Female 2", "Beverly Hills Male", "Beverly Hills Male 2", "Beverly Hills Young Female", "Beverly Hills Young Female 2", "Beverly Hills Young Female 3", "Beverly Hills Young Female 4", "Beverly Hills Young Male", "Beverly Hills Young Male 2", "Bigfoot (CS)", "Bigfoot (IG)", "Bike Hire Guy", "Biker Chic Female", "Black Ops Soldier", "Black Ops Soldier 2", "Black Ops Soldier 3", "Black Street Male", "Black Street Male 2", "Bodybuilder Female", "Bouncer", "Brad (CS)", "Brad (IG)", "Brad's Cadaver (CS)", "Breakdancer Male", "Bride", "Bride (IG)", "Burger Drug Worker", "Burger Drug Worker", "Busboy", "Business Casual", "Business Female 2", "Business Male", "Business Young Female", "Business Young Female 2", "Business Young Female 3", "Business Young Female 4", "Business Young Male", "Business Young Male 2", "Business Young Male 3", "Busker", "Car 3 Guy 1", "Car 3 Guy 1 (IG)", "Car 3 Guy 2", "Car 3 Guy 2 (IG)", "Car Buyer (CS)", "Casey (CS)", "Casey (IG)", "Chef", "Chef", "Chef (CS)", "Chef (IG)", "Chef (IG)", "Chemical Plant Security", "Chemical Plant Worker", "Chinese Boss", "Chinese Goon", "Chinese Goon", "Chinese Goon 2", "Chinese Goon Older", "Chip", "Claude Speed", "Clay Jackson (The Pain Giver) (IG)", "Clay Simons (The Lost) (CS)", "Clay Simons (The Lost) (IG)", "Cletus", "Cletus (IG)", "Clown", "Construction Worker", "Construction Worker 2", "Cop", "Cop Female", "Cop Male", "Corpse Female", "Corpse Young Female", "Corpse Young Female 2", "Crew Member", "Cris Formage (CS)", "Cris Formage (IG)", "Customer", "Cyclist Male", "Cyclist Male", "Dale (CS)", "Dale (IG)", "Dave Norton (CS)", "Dave Norton (IG)", "Dead Hooker", "Dealer", "Debra (CS)", "Denise (CS)", "Denise (IG)", "Denise's Friend", "Devin (CS)", "Devin (IG)", "Devin's Security", "Dima Popov (CS)", "Dima Popov (IG)", "DOA Man", "Dock Worker", "Dock Worker", "Doctor", "Dom Beasley (CS)", "Dom Beasley (IG)", "Doorman", "Downhill Cyclist", "Downtown Female", "Downtown Male", "Dr. Friedlander (CS)", "Dr. Friedlander (IG)", "Dressy Female", "DW Airport Worker", "DW Airport Worker 2", "East SA Female", "East SA Female 2", "East SA Male", "East SA Male 2", "East SA Young Female", "East SA Young Female 2", "East SA Young Female 3", "East SA Young Male", "East SA Young Male 2", "Ed Toh", "Epsilon Female", "Epsilon Male", "Epsilon Male 2", "Epsilon Tom (CS)", "Epsilon Tom (IG)", "Ex-Army Male", "Ex-Mil Bum", "Fabien (CS)", "Fabien (IG)", "Factory Worker Female", "Factory Worker Male", "Families CA Male", "Families DD Male", "Families DNF Male", "Families Female", "Families FOR Male", "Families Gang Member?", "Families Gang Member? (IG)", "Farmer", "Fat Black Female", "Fat Cult Female", "Fat Latino Male", "Fat White Female", "Female Agent", "Ferdinand Kerimov (Mr. K) (CS)", "Ferdinand Kerimov (Mr. K) (IG)", "FIB Architect", "FIB Mugger", "FIB Office Worker", "FIB Office Worker 2", "FIB Security", "FIB Security", "FIB Suit (CS)", "FIB Suit (IG)", "Financial Guru", "Fireman Male", "Fitness Female", "Fitness Female 2", "Floyd Hebert (CS)", "Floyd Hebert (IG)", "FOS Rep?", "Gaffer", "Garbage Worker", "Gardener", "Gay Male", "Gay Male 2", "General Fat Male", "General Fat Male 2", "General Hot Young Female", "General Street Old Female", "General Street Old Male", "General Street Young Male", "General Street Young Male 2", "Gerald", "GLENSTANK? Male", "Golfer Male", "Golfer Young Female", "Golfer Young Male", "Griff", "Grip", "Groom", "Groom (IG)", "Grove Street Dealer", "Guadalope (CS)", "Guido", "Gun Vendor", "GURK? (CS)", "Hairdresser Male", "Hao", "Hao (IG)", "Hasidic Jew Male", "Hasidic Jew Young Male", "Hick", "Hick (IG)", "High Security", "High Security 2", "Highway Cop", "Hiker Female", "Hiker Male", "Hillbilly Male", "Hillbilly Male 2", "Hippie Female", "Hippie Male", "Hippie Male", "Hipster", "Hipster (IG)", "Hipster Female", "Hipster Female 2", "Hipster Female 3", "Hipster Female 4", "Hipster Male", "Hipster Male 2", "Hipster Male 3", "Hooker", "Hooker 2", "Hooker 3", "Hospital Scrubs Female", "Hot Posh Female", "Hugh Welsh", "Hunter (CS)", "Hunter (IG)", "IAA Security", "Impotent Rage", "Imran Shinowa", "Indian Male", "Indian Old Female", "Indian Young Female", "Indian Young Male", "Jane", "Janet (CS)", "Janet (IG)", "Janitor", "Janitor", "Jay Norris (IG)", "Jesco White (Tapdancing Hillbilly)", "Jesus", "Jetskier", "Jewel Heist Driver", "Jewel Heist Gunman", "Jewel Heist Hacker", "Jewel Thief", "Jeweller Assistant", "Jeweller Assistant (CS)", "Jeweller Assistant (IG)", "Jeweller Security", "Jimmy Boston (CS)", "Jimmy Boston (IG)", "Jimmy De Santa (CS)", "Jimmy De Santa (IG)", "Jogger Female", "Jogger Male", "Jogger Male 2", "John Marston", "Johnny Klebitz (CS)", "Johnny Klebitz (IG)", "Josef (CS)", "Josef (IG)", "Josh (CS)", "Josh (IG)", "Juggalo Female", "Juggalo Male", "Justin", "Karen Daniels (CS)", "Karen Daniels (IG)", "Kerry McIntosh (IG)", "Kifflom Guy", "Korean Boss", "Korean Female", "Korean Female 2", "Korean Lieutenant", "Korean Male", "Korean Old Female", "Korean Old Male", "Korean Young Male", "Korean Young Male", "Korean Young Male 2", "Korean Young Male 2", "Lamar Davis (CS)", "Lamar Davis (IG)", "Latino Handyman Male", "Latino Street Male 2", "Latino Street Young Male", "Latino Young Male", "Lazlow (CS)", "Lazlow (IG)", "Lester Crest (CS)", "Lester Crest (IG)", "Life Invader (CS)", "Life Invader (IG)", "Life Invader 2 (IG)", "Life Invader Male", "Line Cook", "Love Fist Willy", "LS Metro Worker Male", "Magenta (CS)", "Magenta (IG)", "Maid", "Malibu Male", "Mani", "Manuel (CS)", "Manuel (IG)", "Mariachi", "Marine", "Marine", "Marine 2", "Marine Young", "Marine Young 2", "Marine Young 3", "Mark Fostenburg", "Marnie Allen (CS)", "Marnie Allen (IG)", "Martin Madrazo (CS)", "Mary-Ann Quinn (CS)", "Mary-Ann Quinn (IG)", "Maude", "Maude (IG)", "Maxim Rashkovsky (CS)", "Maxim Rashkovsky (IG)", "Mechanic", "Mechanic 2", "Merryweather Merc", "Meth Addict", "Mexican", "Mexican (IG)", "Mexican Boss", "Mexican Boss 2", "Mexican Gang Member", "Mexican Goon", "Mexican Goon 2", "Mexican Goon 3", "Mexican Labourer", "Mexican Rural", "Mexican Thug", "Michelle (CS)", "Michelle (IG)", "Migrant Female", "Migrant Male", "Milton McIlroy (CS)", "Milton McIlroy (IG)", "Mime Artist", "Minuteman Joe (CS)", "Minuteman Joe (IG)", "Miranda", "Mistress", "Misty", "Molly (CS)", "Molly (IG)", "Money Man (CS)", "Money Man (IG)", "Motocross Biker", "Motocross Biker 2", "Movie Astronaut", "Movie Director", "Movie Premiere Female", "Movie Premiere Female (CS)", "Movie Premiere Male", "Movie Premiere Male (CS)", "Movie Star Female", "Mrs. Phillips (CS)", "Mrs. Phillips (IG)", "Mrs. Thornhill (CS)", "Mrs. Thornhill (IG)", "Natalia (CS)", "Natalia (IG)", "Nervous Ron (CS)", "Nervous Ron (IG)", "Nigel (CS)", "Nigel (IG)", "Niko Bellic", "OG Boss", "Old Man 1 (CS)", "Old Man 1 (IG)", "Old Man 2 (CS)", "Old Man 2 (IG)", "Omega (CS)", "Omega (IG)", "O'Neil Brothers (IG)", "Ortega", "Ortega (IG)", "Oscar", "Paige Harris (CS)", "Paige Harris (IG)", "Paparazzi Male", "Paparazzi Young Male", "Paramedic", "Party Target", "Partygoer", "Patricia (CS)", "Patricia (IG)", "Pest Control", "Peter Dreyfuss (CS)", "Peter Dreyfuss (IG)", "Pilot", "Pilot", "Pilot 2", "Pogo the Monkey", "Polynesian", "Polynesian Goon", "Polynesian Goon 2", "Polynesian Young", "Poppy Mitchell", "Porn Dude", "Postal Worker Male", "Postal Worker Male 2", "Priest (CS)", "Priest (IG)", "Princess", "Prison Guard", "Prisoner", "Prisoner", "Prisoner (Muscular)", "Prologue Driver", "Prologue Driver", "Prologue Host Female", "Prologue Host Male", "Prologue Host Old Female", "Prologue Mourner Female", "Prologue Mourner Male", "Prologue Security", "Prologue Security", "Prologue Security 2 (CS)", "Prologue Security 2 (IG)", "PROS?", "Ranger Female", "Ranger Male", "Reporter", "Republican Space Ranger", "Rival Paparazzo", "Road Cyclist", "Robber", "Rocco Pelosi", "Rocco Pelosi (IG)", "Rural Meth Addict Female", "Rural Meth Addict Male", "Russian Drunk (CS)", "Russian Drunk (IG)", "Sales Assistant (High-End)", "Sales Assistant (Low-End)", "Sales Assistant (Mask Stall)", "Sales Assistant (Mid-Price)", "Salton Female", "Salton Male", "Salton Male 2", "Salton Male 3", "Salton Male 4", "Salton Old Female", "Salton Old Male", "Salton Young Male", "Salvadoran Boss", "Salvadoran Goon", "Salvadoran Goon 2", "Salvadoran Goon 3", "Scientist", "Screenwriter", "Screenwriter (IG)", "Security Guard", "Sheriff Female", "Sheriff Male", "Shopkeeper", "Simeon Yetarian (CS)", "Simeon Yetarian (IG)", "Skater Female", "Skater Male", "Skater Young Male", "Skater Young Male 2", "Skid Row Female", "Skid Row Male", "Snow Cop Male", "Solomon Richards (CS)", "Solomon Richards (IG)", "South Central Female", "South Central Female 2", "South Central Latino Male", "South Central Male", "South Central Male 2", "South Central Male 3", "South Central Male 4", "South Central MC Female", "South Central Old Female", "South Central Old Female 2", "South Central Old Male", "South Central Old Male 2", "South Central Old Male 3", "South Central Young Female", "South Central Young Female 2", "South Central Young Female 3", "South Central Young Male", "South Central Young Male 2", "South Central Young Male 3", "South Central Young Male 4", "Sports Biker", "Spy Actor", "Spy Actress", "Stag Party Groom", "Steve Haines (CS)", "Steve Haines (IG)", "Street Performer", "Street Preacher", "Street Punk", "Street Punk 2", "Street Vendor", "Street Vendor Young", "Stretch (CS)", "Stretch (IG)", "Stripper", "Stripper", "Stripper 2", "Stripper 2", "Stripper Lite", "Stripper Lite", "Sunbather Male", "Surfer", "SWAT", "Sweatshop Worker", "Sweatshop Worker Young", "Talina (IG)", "Tanisha (CS)", "Tanisha (IG)", "Tao Cheng (CS)", "Tao Cheng (IG)", "Tao's Translator (CS)", "Tao's Translator (IG)", "Tattoo Artist", "Tennis Coach (CS)", "Tennis Coach (IG)", "Tennis Player Female", "Tennis Player Male", "Terry (CS)", "Terry (IG)", "The Lost MC Female", "The Lost MC Male", "The Lost MC Male 2", "The Lost MC Male 3", "Tom (CS)", "Tonya", "Tonya (IG)", "Topless", "Tourist Female", "Tourist Male", "Tourist Young Female", "Tourist Young Female 2", "Tracey De Santa (CS)", "Tracey De Santa (IG)", "Traffic Warden", "Traffic Warden (IG)", "Tramp Female", "Tramp Male", "Tramp Old Male", "Tramp Old Male", "Transport Worker Male", "Transvestite Male", "Transvestite Male 2", "Trucker Male", "Tyler Dixon (IG)", "Undercover Cop", "United Paper Man (CS)", "United Paper Man (IG)", "UPS Driver", "UPS Driver 2", "US Coastguard", "Vagos Female", "Vagos Male (CS)", "Vagos Male (IG)", "Vagos Male 2", "Valet", "Vespucci Beach Male", "Vespucci Beach Male 2", "Vinewood Douche", "Vinewood Female", "Vinewood Female 2", "Vinewood Female 3", "Vinewood Female 4", "Vinewood Male", "Vinewood Male 2", "Vinewood Male 3", "Vinewood Male 4", "Wade(CS)", "Wade(IG)", "Waiter", "Wei Cheng(CS)", "Wei Cheng(IG)", "White Street Male", "White Street Male 2", "Window Cleaner", "Yoga Female", "Yoga Male", "Zimbor(CS)", "Zimbor(IG)", "Zombie" }
		local skinModelName = { "csb_abigail", "ig_abigail", "u_m_y_abner", "a_m_m_afriamer_01", "csb_agent", "ig_agent", "csb_mp_agent14", "ig_mp_agent14", "s_f_y_airhostess_01", "s_m_y_airworker", "u_m_m_aldinapoli", "s_m_m_movalien_01", "a_m_m_acult_01", "a_m_o_acult_01", "a_m_o_acult_02", "a_m_y_acult_01", "a_m_y_acult_02", "cs_amandatownley", "ig_amandatownley", "s_m_y_ammucity_01", "s_m_m_ammucountry", "cs_andreas", "ig_andreas", "csb_anita", "csb_anton", "u_m_y_antonb", "g_m_m_armboss_01", "g_m_m_armgoon_01", "g_m_y_armgoon_02", "g_m_m_armlieut_01", "mp_s_m_armoured_01", "s_m_m_armoured_01", "s_m_m_armoured_02", "s_m_y_armymech_01", "cs_ashley", "ig_ashley", "s_m_y_autopsy_01", "s_m_m_autoshop_01", "s_m_m_autoshop_02", "g_m_y_azteca_01", "u_m_y_babyd", "g_m_y_ballaeast_01", "g_f_y_ballas_01", "csb_ballasog", "ig_ballasog", "g_m_y_ballaorig_01", "g_m_y_ballasout_01", "cs_bankman", "ig_bankman", "u_m_m_bankman", "s_f_m_fembarber", "s_m_y_barman_01", "cs_barry", "ig_barry", "s_f_y_bartender_01", "s_m_m_cntrybar_01", "s_f_y_baywatch_01", "s_m_y_baywatch_01", "a_f_m_beach_01", "a_m_m_beach_01", "a_m_m_beach_02", "a_m_y_musclbeac_01", "a_m_y_musclbeac_02", "a_m_o_beach_01", "a_f_m_trampbeac_01", "a_m_m_trampbeac_01", "a_f_y_beach_01", "a_m_y_beach_01", "a_m_y_beach_02", "a_m_y_beach_03", "ig_benny", "ig_bestmen", "cs_beverly", "ig_beverly", "a_f_m_bevhills_01", "a_f_m_bevhills_02", "a_m_m_bevhills_01", "a_m_m_bevhills_02", "a_f_y_bevhills_01", "a_f_y_bevhills_02", "a_f_y_bevhills_03", "a_f_y_bevhills_04", "a_m_y_bevhills_01", "a_m_y_bevhills_02", "cs_orleans", "ig_orleans", "u_m_m_bikehire_01", "u_f_y_bikerchic", "s_m_y_blackops_01", "s_m_y_blackops_02", "s_m_y_blackops_03", "a_m_y_stbla_01", "a_m_y_stbla_02", "a_f_m_bodybuild_01", "s_m_m_bouncer_01", "cs_brad", "ig_brad", "cs_bradcadaver", "a_m_y_breakdance_01", "csb_bride", "ig_bride", "csb_burgerdrug", "u_m_y_burgerdrug_01", "s_m_y_busboy_01", "a_m_y_busicas_01", "a_f_m_business_02", "a_m_m_business_01", "a_f_y_business_01", "a_f_y_business_02", "a_f_y_business_03", "a_f_y_business_04", "a_m_y_business_01", "a_m_y_business_02", "a_m_y_business_03", "s_m_o_busker_01", "csb_car3guy1", "ig_car3guy1", "csb_car3guy2", "ig_car3guy2", "cs_carbuyer", "cs_casey", "ig_casey", "s_m_y_chef_01", "csb_chef", "csb_chef2", "ig_chef", "ig_chef2", "s_m_m_chemsec_01", "g_m_m_chemwork_01", "g_m_m_chiboss_01", "g_m_m_chigoon_01", "csb_chin_goon", "g_m_m_chigoon_02", "g_m_m_chicold_01", "u_m_y_chip", "mp_m_claude_01", "ig_claypain", "cs_clay", "ig_clay", "csb_cletus", "ig_cletus", "s_m_y_clown_01", "s_m_y_construct_01", "s_m_y_construct_02", "csb_cop", "s_f_y_cop_01", "s_m_y_cop_01", "u_f_m_corpse_01", "u_f_y_corpse_01", "u_f_y_corpse_02", "s_m_m_ccrew_01", "cs_chrisformage", "ig_chrisformage", "csb_customer", "a_m_y_cyclist_01", "u_m_y_cyclist_01", "cs_dale", "ig_dale", "cs_davenorton", "ig_davenorton", "mp_f_deadhooker", "s_m_y_dealer_01", "cs_debra", "cs_denise", "ig_denise", "csb_denise_friend", "cs_devin", "ig_devin", "s_m_y_devinsec_01", "csb_popov", "ig_popov", "u_m_m_doa_01", "s_m_m_dockwork_01", "s_m_y_dockwork_01", "s_m_m_doctor_01", "cs_dom", "ig_dom", "s_m_y_doorman_01", "a_m_y_dhill_01", "a_f_m_downtown_01", "a_m_y_downtown_01", "cs_drfriedlander", "ig_drfriedlander", "a_f_y_scdressy_01", "s_m_y_dwservice_01", "s_m_y_dwservice_02", "a_f_m_eastsa_01", "a_f_m_eastsa_02", "a_m_m_eastsa_01", "a_m_m_eastsa_02", "a_f_y_eastsa_01", "a_f_y_eastsa_02", "a_f_y_eastsa_03", "a_m_y_eastsa_01", "a_m_y_eastsa_02", "u_m_m_edtoh", "a_f_y_epsilon_01", "a_m_y_epsilon_01", "a_m_y_epsilon_02", "cs_tomepsilon", "ig_tomepsilon", "mp_m_exarmy_01", "u_m_y_militarybum", "cs_fabien", "ig_fabien", "s_f_y_factory_01", "s_m_y_factory_01", "g_m_y_famca_01", "mp_m_famdd_01", "g_m_y_famdnf_01", "g_f_y_families_01", "g_m_y_famfor_01", "csb_ramp_gang", "ig_ramp_gang", "a_m_m_farmer_01", "a_f_m_fatbla_01", "a_f_m_fatcult_01", "a_m_m_fatlatin_01", "a_f_m_fatwhite_01", "a_f_y_femaleagent", "cs_mrk", "ig_mrk", "u_m_m_fibarchitect", "u_m_y_fibmugger_01", "s_m_m_fiboffice_01", "s_m_m_fiboffice_02", "mp_m_fibsec_01", "s_m_m_fibsec_01", "cs_fbisuit_01", "ig_fbisuit_01", "u_m_o_finguru_01", "s_m_y_fireman_01", "a_f_y_fitness_01", "a_f_y_fitness_02", "cs_floyd", "ig_floyd", "csb_fos_rep", "s_m_m_gaffer_01", "s_m_y_garbage", "s_m_m_gardener_01", "a_m_y_gay_01", "a_m_y_gay_02", "a_m_m_genfat_01", "a_m_m_genfat_02", "a_f_y_genhot_01", "a_f_o_genstreet_01", "a_m_o_genstreet_01", "a_m_y_genstreet_01", "a_m_y_genstreet_02", "csb_g", "u_m_m_glenstank_01", "a_m_m_golfer_01", "a_f_y_golfer_01", "a_m_y_golfer_01", "u_m_m_griff_01", "s_m_y_grip_01", "csb_groom", "ig_groom", "csb_grove_str_dlr", "cs_guadalope", "u_m_y_guido_01", "u_m_y_gunvend_01", "cs_gurk", "s_m_m_hairdress_01", "csb_hao", "ig_hao", "a_m_m_hasjew_01", "a_m_y_hasjew_01", "csb_ramp_hic", "ig_ramp_hic", "s_m_m_highsec_01", "s_m_m_highsec_02", "s_m_y_hwaycop_01", "a_f_y_hiker_01", "a_m_y_hiker_01", "a_m_m_hillbilly_01", "a_m_m_hillbilly_02", "a_f_y_hippie_01", "u_m_y_hippie_01", "a_m_y_hippy_01", "csb_ramp_hipster", "ig_ramp_hipster", "a_f_y_hipster_01", "a_f_y_hipster_02", "a_f_y_hipster_03", "a_f_y_hipster_04", "a_m_y_hipster_01", "a_m_y_hipster_02", "a_m_y_hipster_03", "s_f_y_hooker_01", "s_f_y_hooker_02", "s_f_y_hooker_03", "s_f_y_scrubs_01", "u_f_y_hotposh_01", "csb_hugh", "cs_hunter", "ig_hunter", "s_m_m_ciasec_01", "u_m_y_imporage", "csb_imran", "a_m_m_indian_01", "a_f_o_indian_01", "a_f_y_indian_01", "a_m_y_indian_01", "u_f_y_comjane", "cs_janet", "ig_janet", "csb_janitor", "s_m_m_janitor", "ig_jay_norris", "u_m_o_taphillbilly", "u_m_m_jesus_01", "a_m_y_jetski_01", "hc_driver", "hc_gunman", "hc_hacker", "u_m_m_jewelthief", "u_f_y_jewelass_01", "cs_jewelass", "ig_jewelass", "u_m_m_jewelsec_01", "cs_jimmyboston", "ig_jimmyboston", "cs_jimmydisanto", "ig_jimmydisanto", "a_f_y_runner_01", "a_m_y_runner_01", "a_m_y_runner_02", "mp_m_marston_01", "cs_johnnyklebitz", "ig_johnnyklebitz", "cs_josef", "ig_josef", "cs_josh", "ig_josh", "a_f_y_juggalo_01", "a_m_y_juggalo_01", "u_m_y_justin", "cs_karen_daniels", "ig_karen_daniels", "ig_kerrymcintosh", "u_m_y_baygor", "g_m_m_korboss_01", "a_f_m_ktown_01", "a_f_m_ktown_02", "g_m_y_korlieut_01", "a_m_m_ktown_01", "a_f_o_ktown_01", "a_m_o_ktown_01", "g_m_y_korean_01", "a_m_y_ktown_01", "g_m_y_korean_02", "a_m_y_ktown_02", "cs_lamardavis", "ig_lamardavis", "s_m_m_lathandy_01", "a_m_m_stlat_02", "a_m_y_stlat_01", "a_m_y_latino_01", "cs_lazlow", "ig_lazlow", "cs_lestercrest", "ig_lestercrest", "cs_lifeinvad_01", "ig_lifeinvad_01", "ig_lifeinvad_02", "s_m_m_lifeinvad_01", "s_m_m_linecook", "u_m_m_willyfist", "s_m_m_lsmetro_01", "cs_magenta", "ig_magenta", "s_f_m_maid_01", "a_m_m_malibu_01", "u_m_y_mani", "cs_manuel", "ig_manuel", "s_m_m_mariachi_01", "csb_ramp_marine", "s_m_m_marine_01", "s_m_m_marine_02", "s_m_y_marine_01", "s_m_y_marine_02", "s_m_y_marine_03", "u_m_m_markfost", "cs_marnie", "ig_marnie", "cs_martinmadrazo", "cs_maryann", "ig_maryann", "csb_maude", "ig_maude", "csb_rashcosvki", "ig_rashcosvki", "s_m_y_xmech_01", "s_m_y_xmech_02", "csb_mweather", "a_m_y_methhead_01", "csb_ramp_mex", "ig_ramp_mex", "g_m_m_mexboss_01", "g_m_m_mexboss_02", "g_m_y_mexgang_01", "g_m_y_mexgoon_01", "g_m_y_mexgoon_02", "g_m_y_mexgoon_03", "a_m_m_mexlabor_01", "a_m_m_mexcntry_01", "a_m_y_mexthug_01", "cs_michelle", "ig_michelle", "s_f_y_migrant_01", "s_m_m_migrant_01", "cs_milton", "ig_milton", "s_m_y_mime", "cs_joeminuteman", "ig_joeminuteman", "u_f_m_miranda", "u_f_y_mistress", "mp_f_misty_01", "cs_molly", "ig_molly", "csb_money", "ig_money", "a_m_y_motox_01", "a_m_y_motox_02", "s_m_m_movspace_01", "u_m_m_filmdirector", "s_f_y_movprem_01", "cs_movpremf_01", "s_m_m_movprem_01", "cs_movpremmale", "u_f_o_moviestar", "cs_mrsphillips", "ig_mrsphillips", "cs_mrs_thornhill", "ig_mrs_thornhill", "cs_natalia", "ig_natalia", "cs_nervousron", "ig_nervousron", "cs_nigel", "ig_nigel", "mp_m_niko_01", "a_m_m_og_boss_01", "cs_old_man1a", "ig_old_man1a", "cs_old_man2", "ig_old_man2", "cs_omega", "ig_omega", "ig_oneil", "csb_ortega", "ig_ortega", "csb_oscar", "csb_paige", "ig_paige", "a_m_m_paparazzi_01", "u_m_y_paparazzi", "s_m_m_paramedic_01", "u_m_m_partytarget", "u_m_y_party_01", "cs_patricia", "ig_patricia", "s_m_y_pestcont_01", "cs_dreyfuss", "ig_dreyfuss", "s_m_m_pilot_01", "s_m_y_pilot_01", "s_m_m_pilot_02", "u_m_y_pogo_01", "a_m_m_polynesian_01", "g_m_y_pologoon_01", "g_m_y_pologoon_02", "a_m_y_polynesian_01", "u_f_y_poppymich", "csb_porndudes", "s_m_m_postal_01", "s_m_m_postal_02", "cs_priest", "ig_priest", "u_f_y_princess", "s_m_m_prisguard_01", "s_m_y_prisoner_01", "u_m_y_prisoner_01", "s_m_y_prismuscl_01", "u_m_y_proldriver_01", "csb_prologuedriver", "a_f_m_prolhost_01", "a_m_m_prolhost_01", "u_f_o_prolhost_01", "u_f_m_promourn_01", "u_m_m_promourn_01", "csb_prolsec", "u_m_m_prolsec_01", "cs_prolsec_02", "ig_prolsec_02", "mp_g_m_pros_01", "s_f_y_ranger_01", "s_m_y_ranger_01", "csb_reporter", "u_m_y_rsranger_01", "u_m_m_rivalpap", "a_m_y_roadcyc_01", "s_m_y_robber_01", "csb_roccopelosi", "ig_roccopelosi", "a_f_y_rurmeth_01", "a_m_m_rurmeth_01", "cs_russiandrunk", "ig_russiandrunk", "s_f_m_shop_high", "s_f_y_shop_low", "s_m_y_shop_mask", "s_f_y_shop_mid", "a_f_m_salton_01", "a_m_m_salton_01", "a_m_m_salton_02", "a_m_m_salton_03", "a_m_m_salton_04", "a_f_o_salton_01", "a_m_o_salton_01", "a_m_y_salton_01", "g_m_y_salvaboss_01", "g_m_y_salvagoon_01", "g_m_y_salvagoon_02", "g_m_y_salvagoon_03", "s_m_m_scientist_01", "csb_screen_writer", "ig_screen_writer", "s_m_m_security_01", "s_f_y_sheriff_01", "s_m_y_sheriff_01", "mp_m_shopkeep_01", "cs_siemonyetarian", "ig_siemonyetarian", "a_f_y_skater_01", "a_m_m_skater_01", "a_m_y_skater_01", "a_m_y_skater_02", "a_f_m_skidrow_01", "a_m_m_skidrow_01", "s_m_m_snowcop_01", "cs_solomon", "ig_solomon", "a_f_m_soucent_01", "a_f_m_soucent_02", "a_m_m_socenlat_01", "a_m_m_soucent_01", "a_m_m_soucent_02", "a_m_m_soucent_03", "a_m_m_soucent_04", "a_f_m_soucentmc_01", "a_f_o_soucent_01", "a_f_o_soucent_02", "a_m_o_soucent_01", "a_m_o_soucent_02", "a_m_o_soucent_03", "a_f_y_soucent_01", "a_f_y_soucent_02", "a_f_y_soucent_03", "a_m_y_soucent_01", "a_m_y_soucent_02", "a_m_y_soucent_03", "a_m_y_soucent_04", "u_m_y_sbike", "u_m_m_spyactor", "u_f_y_spyactress", "u_m_y_staggrm_01", "cs_stevehains", "ig_stevehains", "s_m_m_strperf_01", "s_m_m_strpreach_01", "g_m_y_strpunk_01", "g_m_y_strpunk_02", "s_m_m_strvend_01", "s_m_y_strvend_01", "cs_stretch", "ig_stretch", "csb_stripper_01", "s_f_y_stripper_01", "csb_stripper_02", "s_f_y_stripper_02", "s_f_y_stripperlite", "mp_f_stripperlite", "a_m_y_sunbathe_01", "a_m_y_surfer_01", "s_m_y_swat_01", "s_f_m_sweatshop_01", "s_f_y_sweatshop_01", "ig_talina", "cs_tanisha", "ig_tanisha", "cs_taocheng", "ig_taocheng", "cs_taostranslator", "ig_taostranslator", "u_m_y_tattoo_01", "cs_tenniscoach", "ig_tenniscoach", "a_f_y_tennis_01", "a_m_m_tennis_01", "cs_terry", "ig_terry", "g_f_y_lost_01", "g_m_y_lost_01", "g_m_y_lost_02", "g_m_y_lost_03", "cs_tom", "csb_tonya", "ig_tonya", "a_f_y_topless_01", "a_f_m_tourist_01", "a_m_m_tourist_01", "a_f_y_tourist_01", "a_f_y_tourist_02", "cs_tracydisanto", "ig_tracydisanto", "csb_trafficwarden", "ig_trafficwarden", "a_f_m_tramp_01", "a_m_m_tramp_01", "u_m_o_tramp_01", "a_m_o_tramp_01", "s_m_m_gentransport", "a_m_m_tranvest_01", "a_m_m_tranvest_02", "s_m_m_trucker_01", "ig_tylerdix", "csb_undercover", "cs_paper", "ig_paper", "s_m_m_ups_01", "s_m_m_ups_02", "s_m_y_uscg_01", "g_f_y_vagos_01", "csb_vagspeak", "ig_vagspeak", "mp_m_g_vagfun_01", "s_m_y_valet_01", "a_m_y_beachvesp_01", "a_m_y_beachvesp_02", "a_m_y_vindouche_01", "a_f_y_vinewood_01", "a_f_y_vinewood_02", "a_f_y_vinewood_03", "a_f_y_vinewood_04", "a_m_y_vinewood_01", "a_m_y_vinewood_02", "a_m_y_vinewood_03", "a_m_y_vinewood_04", "cs_wade", "ig_wade", "s_m_y_waiter_01", "cs_chengsr", "ig_chengsr", "a_m_y_stwhi_01", "a_m_y_stwhi_02", "s_m_y_winclean_01", "a_f_y_yoga_01", "a_m_y_yoga_01", "cs_zimbor", "ig_zimbor", "u_m_y_zombie_01" }

		if skinMenu then
			
			TriggerServerEvent("GetAddOnPeds")
			
			if not IsDisabledControlPressed(1, 173) and not IsDisabledControlPressed(1, 172) then
				currentOption = lastSelectionskinMenu
			else
				lastSelectionskinMenu = currentOption
			end

			TriggerEvent("FMODT:Title", "~y~" .. ChangePedTitle .. "")

			TriggerEvent("FMODT:Option",  ChangePedByNameTitle, function(cb)
				if (cb) then
					changePedByName = true
				end
			end)

			if AddOnPedsTable[1] ~= nil then
				TriggerEvent("FMODT:Option", "~y~>> ~s~" .. AddOnPedsTitle .. "", function(cb)
					if (cb) then
						skinMenu = false
						AddOnPedsSpawn1 = true
					end
				end)
			end

			TriggerEvent("FMODT:Option", "~y~>> ~s~" .. AnimalsTitle .. "", function(cb)
				if (cb) then
					skinMenu = false
					animalSkinMenu1 = true
				end
			end)
			
			TriggerEvent("FMODT:Option", "~y~>> ~s~" .. FemalePedsTitle .. "", function(cb)
				if (cb) then
					skinMenu = false
					femalePedSkinMenu = true
				end
			end)

			TriggerEvent("FMODT:Option", "~y~>> ~s~" .. MalePedsTitle .. "", function(cb)
				if (cb) then
					skinMenu = false
					malePedSkinMenu = true
				end
			end)

			TriggerEvent("FMODT:Option", "~y~>> ~s~" .. PlayerPedsTitle .. "", function(cb)
				if (cb) then
					skinMenu = false
					playerPedSkinMenu = true
				end
			end)

			TriggerEvent("FMODT:Option", "~y~>> ~s~" .. EveryPedTitle .. "", function(cb)
				if (cb) then
					skinMenu = false
					if lasteveryPedSite == 1 then
						everyPedSkinMenu1 = true
					elseif lasteveryPedSite == 2 then
						everyPedSkinMenu2 = true
					elseif lasteveryPedSite == 3 then
						everyPedSkinMenu3 = true
					elseif lasteveryPedSite == 4 then
						everyPedSkinMenu4 = true
					elseif lasteveryPedSite == 5 then
						everyPedSkinMenu5 = true
					elseif lasteveryPedSite == 6 then
						everyPedSkinMenu6 = true
					elseif lasteveryPedSite == 7 then
						everyPedSkinMenu7 = true
					elseif lasteveryPedSite == 8 then
						everyPedSkinMenu8 = true
					elseif lasteveryPedSite == 9 then
						everyPedSkinMenu9 = true
					elseif lasteveryPedSite == 10 then
						everyPedSkinMenu10 = true
					elseif lasteveryPedSite == 11 then
						everyPedSkinMenu11 = true
					elseif lasteveryPedSite == 12 then
						everyPedSkinMenu12 = true
					elseif lasteveryPedSite == 13 then
						everyPedSkinMenu13 = true
					elseif lasteveryPedSite == 14 then
						everyPedSkinMenu14 = true
					elseif lasteveryPedSite == 15 then
						everyPedSkinMenu15 = true
					elseif lasteveryPedSite == 16 then
						everyPedSkinMenu16 = true
					elseif lasteveryPedSite == 17 then
						everyPedSkinMenu17 = true
					elseif lasteveryPedSite == 18 then
						everyPedSkinMenu18 = true
					elseif lasteveryPedSite == 19 then
						everyPedSkinMenu19 = true
					elseif lasteveryPedSite == 20 then
						everyPedSkinMenu20 = true
					elseif lasteveryPedSite == 21 then
						everyPedSkinMenu21 = true
					elseif lasteveryPedSite == 22 then
						everyPedSkinMenu22 = true
					elseif lasteveryPedSite == 23 then
						everyPedSkinMenu23 = true
					elseif lasteveryPedSite == 24 then
						everyPedSkinMenu24 = true
					elseif lasteveryPedSite == 25 then
						everyPedSkinMenu25 = true
					elseif lasteveryPedSite == 26 then
						everyPedSkinMenu26 = true
					elseif lasteveryPedSite == 27 then
						everyPedSkinMenu27 = true
					elseif lasteveryPedSite == 28 then
						everyPedSkinMenu28 = true
					elseif lasteveryPedSite == 29 then
						everyPedSkinMenu29 = true
					elseif lasteveryPedSite == 30 then
						everyPedSkinMenu30 = true
					elseif lasteveryPedSite == 31 then
						everyPedSkinMenu31 = true
					elseif lasteveryPedSite == 32 then
						everyPedSkinMenu32 = true
					elseif lasteveryPedSite == 33 then
						everyPedSkinMenu33 = true
					elseif lasteveryPedSite == 34 then
						everyPedSkinMenu34 = true
					end
				end
			end)

			TriggerEvent("FMODT:Update")
			
		elseif AddOnPedsSpawn1 then
			
			TriggerServerEvent("GetAddOnPeds")
			
			if not IsDisabledControlPressed(1, 173) and not IsDisabledControlPressed(1, 172) then
				currentOption = lastSelectionAddOnPedsSpawn1
			else
				lastSelectionAddOnPedsSpawn1 = currentOption
			end
		
			if not FloatIntArray and AddOnPedsTable[i] ~= nil then
				if IsDisabledControlJustReleased(1, 174)then
					if AddOnPedsTable[41] ~= nil then
						AddOnPedsSpawn1 = false
						AddOnPedsSpawn3 = true
					else
						AddOnPedsSpawn1 = false
						AddOnPedsSpawn2 = true
					end
				elseif IsDisabledControlJustReleased(1, 175)then
					AddOnPedsSpawn1 = false
					AddOnPedsSpawn2 = true
				end
			end
		
			TriggerEvent("FMODT:Title", "~y~" .. AddOnPedsTitle .. "")
			
			for i = 1, 20 do
				
				if AddOnPedsTable[i] ~= nil then
					TriggerEvent("FMODT:Option", AddOnPedsTable[i][2], function(cb)
						if (cb) then
							drawNotification(AddOnPedsTable[i][1])
							skin = GetHashKey(AddOnPedsTable[i][1])
						end
					end)
				end
			end

			if AddOnPedsTable[21] ~= nil then
				TriggerEvent("FMODT:Option", "~r~" .. PageIndicator .. " 1", function(cb)
					if (cb) then
						drawNotification("~r~" .. PageIndicator .. " 1")
					end
				end)
			end

			TriggerEvent("FMODT:Update")
			
		elseif AddOnPedsSpawn2 then
			
			TriggerServerEvent("GetAddOnPeds")
			
			if not IsDisabledControlPressed(1, 173) and not IsDisabledControlPressed(1, 172) then
				currentOption = lastSelectionAddOnPedsSpawn2
			else
				lastSelectionAddOnPedsSpawn2 = currentOption
			end
		
			if not FloatIntArray then
				if IsDisabledControlJustReleased(1, 174)then
					AddOnPedsSpawn2 = false
					AddOnPedsSpawn1 = true
				elseif IsDisabledControlJustReleased(1, 175)then
					if AddOnPedsTable[41] ~= nil then
						AddOnPedsSpawn2 = false
						AddOnPedsSpawn3 = true
					else
						AddOnPedsSpawn2 = false
						AddOnPedsSpawn1 = true
					end
				end
			end
		
			TriggerEvent("FMODT:Title", "~y~" .. AddOnPedsTitle .. "")

			for i = 21, 40 do
				if AddOnPedsTable[i] ~= nil then
					TriggerEvent("FMODT:Option", AddOnPedsTable[i][2], function(cb)
						if (cb) then
							skin = GetHashKey(AddOnPedsTable[i][1])
						end
					end)
				end
			end

			TriggerEvent("FMODT:Option", "~r~" .. PageIndicator .. " 2", function(cb)
				if (cb) then
					drawNotification("~r~" .. PageIndicator .. " 2")
				end
			end)

			TriggerEvent("FMODT:Update")
			
		elseif AddOnPedsSpawn3 then
			
			TriggerServerEvent("GetAddOnPeds")
			
			if not IsDisabledControlPressed(1, 173) and not IsDisabledControlPressed(1, 172) then
				currentOption = lastSelectionAddOnPedsSpawn3
			else
				lastSelectionAddOnPedsSpawn3 = currentOption
			end
		
			if not FloatIntArray then
				if IsDisabledControlJustReleased(1, 174)then
					AddOnPedsSpawn3 = false
					AddOnPedsSpawn2 = true
				elseif IsDisabledControlJustReleased(1, 175)then
					AddOnPedsSpawn3 = false
					AddOnPedsSpawn1 = true
				end
			end
		
			TriggerEvent("FMODT:Title", "~y~" .. AddOnPedsTitle .. "")

			for i = 41, 60 do
				if AddOnPedsTable[i] ~= nil then
					TriggerEvent("FMODT:Option", AddOnPedsTable[i][2], function(cb)
						if (cb) then
							skin = GetHashKey(AddOnPedsTable[i][1])
						end
					end)
				end
			end

			TriggerEvent("FMODT:Option", "~r~" .. PageIndicator .. " 3", function(cb)
				if (cb) then
					drawNotification("~r~" .. PageIndicator .. " 3")
				end
			end)

			TriggerEvent("FMODT:Update")
			
		elseif animalSkinMenu1 then
		
			if not IsDisabledControlPressed(1, 173) and not IsDisabledControlPressed(1, 172) then
				currentOption = lastSelectionanimalSkinMenu1
			else
				lastSelectionanimalSkinMenu1 = currentOption
			end

			if not FloatIntArray then
				if IsDisabledControlJustReleased(1, 174)then
					animalSkinMenu1 = false
					animalSkinMenu2 = true
				elseif IsDisabledControlJustReleased(1, 175)then
					animalSkinMenu1 = false
					animalSkinMenu2 = true
				end
			end
		
			TriggerEvent("FMODT:Title", "~y~" .. AnimalsTitle .. "")

			TriggerEvent("FMODT:Option", BoarTitle, function(cb)
				if (cb) then
					skin = GetHashKey("a_c_boar")
				end
			end)

			TriggerEvent("FMODT:Option", CatTitle, function(cb)
				if (cb) then
					skin = GetHashKey("a_c_cat_01")
				end
			end)

			TriggerEvent("FMODT:Option", ChickenhawkTitle, function(cb)
				if (cb) then
					skin = GetHashKey("a_c_chickenhawk")
				end
			end)

			TriggerEvent("FMODT:Option", ChimpTitle, function(cb)
				if (cb) then
					skin = GetHashKey("a_c_chimp")
				end
			end)

			TriggerEvent("FMODT:Option", ChopTitle, function(cb)
				if (cb) then
					skin = GetHashKey("a_c_chop")
				end
			end)

			TriggerEvent("FMODT:Option", CormorantTitle, function(cb)
				if (cb) then
					skin = GetHashKey("a_c_cormorant")
				end
			end)

			TriggerEvent("FMODT:Option", CowTitle, function(cb)
				if (cb) then
					skin = GetHashKey("a_c_cow")
				end
			end)

			TriggerEvent("FMODT:Option", CoyoteTitle, function(cb)
				if (cb) then
					skin = GetHashKey("a_c_coyote")
				end
			end)

			TriggerEvent("FMODT:Option", CrowTitle, function(cb)
				if (cb) then
					skin = GetHashKey("a_c_crow")
				end
			end)

			TriggerEvent("FMODT:Option", DeerTitle, function(cb)
				if (cb) then
					skin = GetHashKey("a_c_deer")
				end
			end)

			TriggerEvent("FMODT:Option", DolphinTitle, function(cb)
				if (cb) then
					skin = GetHashKey("a_c_dolphin")
				end
			end)

			TriggerEvent("FMODT:Option", FishTitle, function(cb)
				if (cb) then
					skin = GetHashKey("a_c_fish")
				end
			end)

			TriggerEvent("FMODT:Option", HenTitle, function(cb)
				if (cb) then
					skin = GetHashKey("a_c_hen")
				end
			end)

			TriggerEvent("FMODT:Option", HammerheadSharkTitle, function(cb)
				if (cb) then
					skin = GetHashKey("a_c_sharkhammer")
				end
			end)

			TriggerEvent("FMODT:Option", HumpbackTitle, function(cb)
				if (cb) then
					skin = GetHashKey("a_c_humpback")
				end
			end)

			TriggerEvent("FMODT:Option", HuskyTitle, function(cb)
				if (cb) then
					skin = GetHashKey("a_c_husky")
				end
			end)

			TriggerEvent("FMODT:Option", KillerWhaleTitle, function(cb)
				if (cb) then
					skin = GetHashKey("a_c_killerwhale")
				end
			end)

			TriggerEvent("FMODT:Option", MountainLionTitle, function(cb)
				if (cb) then
					skin = GetHashKey("a_c_mtlion")
				end
			end)

			TriggerEvent("FMODT:Option", PigTitle, function(cb)
				if (cb) then
					skin = GetHashKey("a_c_pig")
				end
			end)

			TriggerEvent("FMODT:Option", PigeonTitle, function(cb)
				if (cb) then
					skin = GetHashKey("a_c_pigeon")
				end
			end)

			TriggerEvent("FMODT:Option", "~r~" .. PageIndicator .. " 1", function(cb)
				if (cb) then
					drawNotification("~r~" .. PageIndicator .. " 1")
				end
			end)

			TriggerEvent("FMODT:Update")
			
		elseif animalSkinMenu2 then
		
			if not IsDisabledControlPressed(1, 173) and not IsDisabledControlPressed(1, 172) then
				currentOption = lastSelectionanimalSkinMenu2
			else
				lastSelectionanimalSkinMenu2 = currentOption
			end

			if not FloatIntArray then
				if IsDisabledControlJustReleased(1, 174)then
					animalSkinMenu2 = false
					animalSkinMenu1 = true
				elseif IsDisabledControlJustReleased(1, 175)then
					animalSkinMenu2 = false
					animalSkinMenu1 = true
				end
			end
		
			TriggerEvent("FMODT:Title", "~y~" .. AnimalsTitle .. "")

			TriggerEvent("FMODT:Option", PoodleTitle, function(cb)
				if (cb) then
					skin = GetHashKey("a_c_poodle")
				end
			end)

			TriggerEvent("FMODT:Option", PugTitle, function(cb)
				if (cb) then
					skin = GetHashKey("a_c_pug")
				end
			end)

			TriggerEvent("FMODT:Option", RabbitTitle, function(cb)
				if (cb) then
					skin = GetHashKey("a_c_rabbit_01")
				end
			end)

			TriggerEvent("FMODT:Option", RatTitle, function(cb)
				if (cb) then
					skin = GetHashKey("a_c_rat")
				end
			end)

			TriggerEvent("FMODT:Option", RetrieverTitle, function(cb)
				if (cb) then
					skin = GetHashKey("a_c_retriever")
				end
			end)

			TriggerEvent("FMODT:Option", RhesusTitle, function(cb)
				if (cb) then
					skin = GetHashKey("a_c_rhesus")
				end
			end)

			TriggerEvent("FMODT:Option", RottweilerTitle, function(cb)
				if (cb) then
					skin = GetHashKey("a_c_rottweiler")
				end
			end)

			TriggerEvent("FMODT:Option", SeagullTitle, function(cb)
				if (cb) then
					skin = GetHashKey("a_c_seagull")
				end
			end)

			TriggerEvent("FMODT:Option", ShepherdTitle, function(cb)
				if (cb) then
					skin = GetHashKey("a_c_shepherd")
				end
			end)

			TriggerEvent("FMODT:Option", StingrayTitle, function(cb)
				if (cb) then
					skin = GetHashKey("a_c_stingray")
				end
			end)

			TriggerEvent("FMODT:Option", TigerSharkTitle, function(cb)
				if (cb) then
					skin = GetHashKey("a_c_sharktiger")
				end
			end)

			TriggerEvent("FMODT:Option", WestyTitle, function(cb)
				if (cb) then
					skin = GetHashKey("a_c_westy")
				end
			end)

			TriggerEvent("FMODT:Option", "~r~" .. PageIndicator .. " 2", function(cb)
				if (cb) then
					drawNotification("~r~" .. PageIndicator .. " 2")
				end
			end)

			TriggerEvent("FMODT:Update")
			
		elseif femalePedSkinMenu then

			if not IsDisabledControlPressed(1, 173) and not IsDisabledControlPressed(1, 172) then
				currentOption = lastSelectionfemalePedSkinMenu
			else
				lastSelectionfemalePedSkinMenu = currentOption
			end

			TriggerEvent("FMODT:Title", "~y~" .. FemalePedsTitle .. "")

			TriggerEvent("FMODT:Option", BusinessFemaleTitle, function(cb)
				if (cb) then
					skin = GetHashKey("a_f_m_business_02")
				end
			end)

			TriggerEvent("FMODT:Option", CopFemaleTitle, function(cb)
				if (cb) then
					skin = GetHashKey("s_f_y_cop_01")
				end
			end)

			TriggerEvent("FMODT:Option", EpsilonFemaleTitle, function(cb)
				if (cb) then
					skin = GetHashKey("a_f_y_epsilon_01")
				end
			end)

			TriggerEvent("FMODT:Option", FattyFemaleTitle, function(cb)
				if (cb) then
					skin = GetHashKey("a_f_m_fatwhite_01")
				end
			end)

			TriggerEvent("FMODT:Option", GolferFemaleTitle, function(cb)
				if (cb) then
					skin = GetHashKey("a_f_y_golfer_01")
				end
			end)

			TriggerEvent("FMODT:Option", HipsterFemaleTitle, function(cb)
				if (cb) then
					skin = GetHashKey("a_f_y_hipster_01")
				end
			end)

			TriggerEvent("FMODT:Option", Hooker1Title, function(cb)
				if (cb) then
					skin = GetHashKey("s_f_y_hooker_01")
				end
			end)

			TriggerEvent("FMODT:Option", Hooker2Title, function(cb)
				if (cb) then
					skin = GetHashKey("s_f_y_hooker_02")
				end
			end)

			TriggerEvent("FMODT:Option", Hooker3Title, function(cb)
				if (cb) then
					skin = GetHashKey("s_f_y_hooker_03")
				end
			end)

			TriggerEvent("FMODT:Option", MaidTitle, function(cb)
				if (cb) then
					skin = GetHashKey("s_f_m_maid_01")
				end
			end)

			TriggerEvent("FMODT:Option", RangerFemaleTitle, function(cb)
				if (cb) then
					skin = GetHashKey("s_f_y_ranger_01")
				end
			end)

			TriggerEvent("FMODT:Option", SheriffFemaleTitle, function(cb)
				if (cb) then
					skin = GetHashKey("s_f_y_sheriff_01")
				end
			end)

			TriggerEvent("FMODT:Option", Stripper1Title, function(cb)
				if (cb) then
					skin = GetHashKey("s_f_y_stripper_01")
				end
			end)

			TriggerEvent("FMODT:Option", Stripper2Title, function(cb)
				if (cb) then
					skin = GetHashKey("s_f_y_stripper_02")
				end
			end)

			TriggerEvent("FMODT:Update")
			
		elseif malePedSkinMenu then
		
			if not IsDisabledControlPressed(1, 173) and not IsDisabledControlPressed(1, 172) then
				currentOption = lastSelectionmalePedSkinMenu
			else
				lastSelectionmalePedSkinMenu = currentOption
			end

			TriggerEvent("FMODT:Title", "~y" .. MalePedsTitle .. "")

			TriggerEvent("FMODT:Option", BusinessMaleTitle, function(cb)
				if (cb) then
					skin = GetHashKey("a_m_m_business_01")
				end
			end)

			TriggerEvent("FMODT:Option", CopMaleTitle, function(cb)
				if (cb) then
					skin = GetHashKey("s_m_y_cop_01")
				end
			end)

			TriggerEvent("FMODT:Option", EpsilonMaleTitle, function(cb)
				if (cb) then
					skin = GetHashKey("a_m_y_epsilon_01")
				end
			end)

			TriggerEvent("FMODT:Option", FattyMaleTitle, function(cb)
				if (cb) then
					skin = GetHashKey("a_m_m_fatlatin_01")
				end
			end)

			TriggerEvent("FMODT:Option", FiremanTitle, function(cb)
				if (cb) then
					skin = GetHashKey("s_m_y_fireman_01")
				end
			end)

			TriggerEvent("FMODT:Option", GolferMaleTitle, function(cb)
				if (cb) then
					skin = GetHashKey("a_m_m_golfer_01")
				end
			end)

			TriggerEvent("FMODT:Option", HighwayCopTitle, function(cb)
				if (cb) then
					skin = GetHashKey("s_m_y_hwaycop_01")
				end
			end)

			TriggerEvent("FMODT:Option", HipsterMaleTitle, function(cb)
				if (cb) then
					skin = GetHashKey("a_m_y_hipster_01")
				end
			end)

			TriggerEvent("FMODT:Option", PrisonerTitle, function(cb)
				if (cb) then
					skin = GetHashKey("s_m_y_prisoner_01")
				end
			end)

			TriggerEvent("FMODT:Option", Marine1Title, function(cb)
				if (cb) then
					skin = GetHashKey("s_m_y_marine_01")
				end
			end)

			TriggerEvent("FMODT:Option", Marine2Title, function(cb)
				if (cb) then
					skin = GetHashKey("s_m_y_marine_02")
				end
			end)

			TriggerEvent("FMODT:Option", Marine3Title, function(cb)
				if (cb) then
					skin = GetHashKey("s_m_y_marine_03")
				end
			end)

			TriggerEvent("FMODT:Option", RangerMaleTitle, function(cb)
				if (cb) then
					skin = GetHashKey("s_m_y_ranger_01")
				end
			end)

			TriggerEvent("FMODT:Option", SheriffMaleTitle, function(cb)
				if (cb) then
					skin = GetHashKey("s_m_y_sheriff_01")
				end
			end)

			TriggerEvent("FMODT:Update")
			
		elseif playerPedSkinMenu then
		
			if not IsDisabledControlPressed(1, 173) and not IsDisabledControlPressed(1, 172) then
				currentOption = lastSelectionplayerPedSkinMenu
			else
				lastSelectionplayerPedSkinMenu = currentOption
			end

			TriggerEvent("FMODT:Title", "~y~" .. PlayerPedsTitle .. "")

			TriggerEvent("FMODT:Option", MPCharacterFemaleTitle, function(cb)
				if (cb) then
					skin = GetHashKey("mp_f_freemode_01")
				end
			end)

			TriggerEvent("FMODT:Option", MPCharacterMaleTitle, function(cb)
				if (cb) then
					skin = GetHashKey("mp_m_freemode_01")
				end
			end)

			TriggerEvent("FMODT:Option", FranklinTitle, function(cb)
				if (cb) then
					skin = GetHashKey("player_one")
				end
			end)

			TriggerEvent("FMODT:Option", MichaelTitle, function(cb)
				if (cb) then
					skin = GetHashKey("player_zero")
				end
			end)

			TriggerEvent("FMODT:Option", TrevorTitle, function(cb)
				if (cb) then
					skin = GetHashKey("player_two")
				end
			end)

			TriggerEvent("FMODT:Update")
			
		elseif everyPedSkinMenu1 then
		
			lasteveryPedSite = 1
			
			if not FloatIntArray then
				if IsDisabledControlJustReleased(1, 174)then
					everyPedSkinMenu1 = false
					everyPedSkinMenu34 = true
				elseif IsDisabledControlJustReleased(1, 175)then
					everyPedSkinMenu1 = false
					everyPedSkinMenu2 = true
				end
			end
		
			if not IsDisabledControlPressed(1, 173) and not IsDisabledControlPressed(1, 172) then
				currentOption = lastSelectioneveryPedSkinMenu1
			else
				lastSelectioneveryPedSkinMenu1 = currentOption
			end

			TriggerEvent("FMODT:Title", "~y~" .. EveryPedTitle .. "")

			for i = 1, 20 do
				TriggerEvent("FMODT:Option", skinName[i], function(cb)
					if (cb) then
						skin = GetHashKey(skinModelName[i])
						end
				end)
			end
			
			TriggerEvent("FMODT:Option", "~r~" .. PageIndicator .. " 1", function(cb)
				if (cb) then
					drawNotification("~r~" .. PageIndicator .. " 1")
				end
			end)

			TriggerEvent("FMODT:Update")

		elseif everyPedSkinMenu2 then
		
			lasteveryPedSite = 2

			if not FloatIntArray then
				if IsDisabledControlJustReleased(1, 174)then
					everyPedSkinMenu2 = false
					everyPedSkinMenu1 = true
				elseif IsDisabledControlJustReleased(1, 175)then
					everyPedSkinMenu2 = false
					everyPedSkinMenu3 = true
				end
			end
		
			if not IsDisabledControlPressed(1, 173) and not IsDisabledControlPressed(1, 172) then
				currentOption = lastSelectioneveryPedSkinMenu2
			else
				lastSelectioneveryPedSkinMenu2 = currentOption
			end

			TriggerEvent("FMODT:Title", "~y~" .. EveryPedTitle .. "")

			for i = 21, 40 do
				TriggerEvent("FMODT:Option", skinName[i], function(cb)
					if (cb) then
						skin = GetHashKey(skinModelName[i])
						end
				end)
			end
			
			TriggerEvent("FMODT:Option", "~r~" .. PageIndicator .. " 2", function(cb)
				if (cb) then
					drawNotification("~r~" .. PageIndicator .. " 2")
				end
			end)

			TriggerEvent("FMODT:Update")

		elseif everyPedSkinMenu3 then
		
			lasteveryPedSite = 3

			if not FloatIntArray then
				if IsDisabledControlJustReleased(1, 174)then
					everyPedSkinMenu3 = false
					everyPedSkinMenu2 = true
				elseif IsDisabledControlJustReleased(1, 175)then
					everyPedSkinMenu3 = false
					everyPedSkinMenu4 = true
				end
			end
		
			if not IsDisabledControlPressed(1, 173) and not IsDisabledControlPressed(1, 172) then
				currentOption = lastSelectioneveryPedSkinMenu3
			else
				lastSelectioneveryPedSkinMenu3 = currentOption
			end

			TriggerEvent("FMODT:Title", "~y~" .. EveryPedTitle .. "")

			for i = 41, 60 do
				TriggerEvent("FMODT:Option", skinName[i], function(cb)
					if (cb) then
						skin = GetHashKey(skinModelName[i])
						end
				end)
			end
			
			TriggerEvent("FMODT:Option", "~r~" .. PageIndicator .. " 3", function(cb)
				if (cb) then
					drawNotification("~r~" .. PageIndicator .. " 3")
				end
			end)

			TriggerEvent("FMODT:Update")

		elseif everyPedSkinMenu4 then
		
			lasteveryPedSite = 4

			if not FloatIntArray then
				if IsDisabledControlJustReleased(1, 174)then
					everyPedSkinMenu4 = false
					everyPedSkinMenu3 = true
				elseif IsDisabledControlJustReleased(1, 175)then
					everyPedSkinMenu4 = false
					everyPedSkinMenu5 = true
				end
			end
		
			if not IsDisabledControlPressed(1, 173) and not IsDisabledControlPressed(1, 172) then
				currentOption = lastSelectioneveryPedSkinMenu4
			else
				lastSelectioneveryPedSkinMenu4 = currentOption
			end

			TriggerEvent("FMODT:Title", "~y~" .. EveryPedTitle .. "")

			for i = 61, 80 do
				TriggerEvent("FMODT:Option", skinName[i], function(cb)
					if (cb) then
						skin = GetHashKey(skinModelName[i])
						end
				end)
			end
			
			TriggerEvent("FMODT:Option", "~r~" .. PageIndicator .. " 4", function(cb)
				if (cb) then
					drawNotification("~r~" .. PageIndicator .. " 4")
				end
			end)

			TriggerEvent("FMODT:Update")

		elseif everyPedSkinMenu5 then
		
			lasteveryPedSite = 5

			if not FloatIntArray then
				if IsDisabledControlJustReleased(1, 174)then
					everyPedSkinMenu5 = false
					everyPedSkinMenu4 = true
				elseif IsDisabledControlJustReleased(1, 175)then
					everyPedSkinMenu5 = false
					everyPedSkinMenu6 = true
				end
			end
		
			if not IsDisabledControlPressed(1, 173) and not IsDisabledControlPressed(1, 172) then
				currentOption = lastSelectioneveryPedSkinMenu5
			else
				lastSelectioneveryPedSkinMenu5 = currentOption
			end

			TriggerEvent("FMODT:Title", "~y~" .. EveryPedTitle .. "")

			for i = 81, 100 do
				TriggerEvent("FMODT:Option", skinName[i], function(cb)
					if (cb) then
						skin = GetHashKey(skinModelName[i])
						end
				end)
			end
			
			TriggerEvent("FMODT:Option", "~r~" .. PageIndicator .. " 5", function(cb)
				if (cb) then
					drawNotification("~r~" .. PageIndicator .. " 5")
				end
			end)

			TriggerEvent("FMODT:Update")

		elseif everyPedSkinMenu6 then
		
			lasteveryPedSite = 6

			if not FloatIntArray then
				if IsDisabledControlJustReleased(1, 174)then
					everyPedSkinMenu6 = false
					everyPedSkinMenu5 = true
				elseif IsDisabledControlJustReleased(1, 175)then
					everyPedSkinMenu6 = false
					everyPedSkinMenu7 = true
				end
			end
		
			if not IsDisabledControlPressed(1, 173) and not IsDisabledControlPressed(1, 172) then
				currentOption = lastSelectioneveryPedSkinMenu6
			else
				lastSelectioneveryPedSkinMenu6 = currentOption
			end

			TriggerEvent("FMODT:Title", "~y~" .. EveryPedTitle .. "")

			for i = 101, 120 do
				TriggerEvent("FMODT:Option", skinName[i], function(cb)
					if (cb) then
						skin = GetHashKey(skinModelName[i])
						end
				end)
			end
			
			TriggerEvent("FMODT:Option", "~r~" .. PageIndicator .. " 6", function(cb)
				if (cb) then
					drawNotification("~r~" .. PageIndicator .. " 6")
				end
			end)

			TriggerEvent("FMODT:Update")

		elseif everyPedSkinMenu7 then
		
			lasteveryPedSite = 7

			if not FloatIntArray then
				if IsDisabledControlJustReleased(1, 174)then
					everyPedSkinMenu7 = false
					everyPedSkinMenu6 = true
				elseif IsDisabledControlJustReleased(1, 175)then
					everyPedSkinMenu7 = false
					everyPedSkinMenu8 = true
				end
			end
		
			if not IsDisabledControlPressed(1, 173) and not IsDisabledControlPressed(1, 172) then
				currentOption = lastSelectioneveryPedSkinMenu7
			else
				lastSelectioneveryPedSkinMenu7 = currentOption
			end

			TriggerEvent("FMODT:Title", "~y~" .. EveryPedTitle .. "")

			for i = 121, 140 do
				TriggerEvent("FMODT:Option", skinName[i], function(cb)
					if (cb) then
						skin = GetHashKey(skinModelName[i])
						end
				end)
			end
			
			TriggerEvent("FMODT:Option", "~r~" .. PageIndicator .. " 7", function(cb)
				if (cb) then
					drawNotification("~r~" .. PageIndicator .. " 7")
				end
			end)

			TriggerEvent("FMODT:Update")

		elseif everyPedSkinMenu8 then
		
			lasteveryPedSite = 8

			if not FloatIntArray then
				if IsDisabledControlJustReleased(1, 174)then
					everyPedSkinMenu8 = false
					everyPedSkinMenu7 = true
				elseif IsDisabledControlJustReleased(1, 175)then
					everyPedSkinMenu8 = false
					everyPedSkinMenu9 = true
				end
			end
		
			if not IsDisabledControlPressed(1, 173) and not IsDisabledControlPressed(1, 172) then
				currentOption = lastSelectioneveryPedSkinMenu8
			else
				lastSelectioneveryPedSkinMenu8 = currentOption
			end

			TriggerEvent("FMODT:Title", "~y~" .. EveryPedTitle .. "")

			for i = 141, 160 do
				TriggerEvent("FMODT:Option", skinName[i], function(cb)
					if (cb) then
						skin = GetHashKey(skinModelName[i])
						end
				end)
			end
			
			TriggerEvent("FMODT:Option", "~r~" .. PageIndicator .. " 8", function(cb)
				if (cb) then
					drawNotification("~r~" .. PageIndicator .. " 8")
				end
			end)

			TriggerEvent("FMODT:Update")

		elseif everyPedSkinMenu9 then
		
			lasteveryPedSite = 9

			if not FloatIntArray then
				if IsDisabledControlJustReleased(1, 174)then
					everyPedSkinMenu9 = false
					everyPedSkinMenu8 = true
				elseif IsDisabledControlJustReleased(1, 175)then
					everyPedSkinMenu9 = false
					everyPedSkinMenu10 = true
				end
			end
		
			if not IsDisabledControlPressed(1, 173) and not IsDisabledControlPressed(1, 172) then
				currentOption = lastSelectioneveryPedSkinMenu9
			else
				lastSelectioneveryPedSkinMenu9 = currentOption
			end

			TriggerEvent("FMODT:Title", "~y~" .. EveryPedTitle .. "")

			for i = 161, 180 do
				TriggerEvent("FMODT:Option", skinName[i], function(cb)
					if (cb) then
						skin = GetHashKey(skinModelName[i])
						end
				end)
			end
			
			TriggerEvent("FMODT:Option", "~r~" .. PageIndicator .. " 9", function(cb)
				if (cb) then
					drawNotification("~r~" .. PageIndicator .. " 9")
				end
			end)

			TriggerEvent("FMODT:Update")

		elseif everyPedSkinMenu10 then
		
			lasteveryPedSite = 10

			if not FloatIntArray then
				if IsDisabledControlJustReleased(1, 174)then
					everyPedSkinMenu10 = false
					everyPedSkinMenu9 = true
				elseif IsDisabledControlJustReleased(1, 175)then
					everyPedSkinMenu10 = false
					everyPedSkinMenu11 = true
				end
			end
		
			if not IsDisabledControlPressed(1, 173) and not IsDisabledControlPressed(1, 172) then
				currentOption = lastSelectioneveryPedSkinMenu10
			else
				lastSelectioneveryPedSkinMenu10 = currentOption
			end

			TriggerEvent("FMODT:Title", "~y~" .. EveryPedTitle .. "")

			for i = 181, 200 do
				TriggerEvent("FMODT:Option", skinName[i], function(cb)
					if (cb) then
						skin = GetHashKey(skinModelName[i])
						end
				end)
			end
			
			TriggerEvent("FMODT:Option", "~r~" .. PageIndicator .. " 10", function(cb)
				if (cb) then
					drawNotification("~r~" .. PageIndicator .. " 10")
				end
			end)

			TriggerEvent("FMODT:Update")

		elseif everyPedSkinMenu11 then
		
			lasteveryPedSite = 11

			if not FloatIntArray then
				if IsDisabledControlJustReleased(1, 174)then
					everyPedSkinMenu11 = false
					everyPedSkinMenu10 = true
				elseif IsDisabledControlJustReleased(1, 175)then
					everyPedSkinMenu11 = false
					everyPedSkinMenu12 = true
				end
			end
		
			if not IsDisabledControlPressed(1, 173) and not IsDisabledControlPressed(1, 172) then
				currentOption = lastSelectioneveryPedSkinMenu11
			else
				lastSelectioneveryPedSkinMenu11 = currentOption
			end

			TriggerEvent("FMODT:Title", "~y~" .. EveryPedTitle .. "")

			for i = 201, 220 do
				TriggerEvent("FMODT:Option", skinName[i], function(cb)
					if (cb) then
						skin = GetHashKey(skinModelName[i])
						end
				end)
			end
			
			TriggerEvent("FMODT:Option", "~r~" .. PageIndicator .. " 11", function(cb)
				if (cb) then
					drawNotification("~r~" .. PageIndicator .. " 11")
				end
			end)

			TriggerEvent("FMODT:Update")

		elseif everyPedSkinMenu12 then
		
			lasteveryPedSite = 12

			if not FloatIntArray then
				if IsDisabledControlJustReleased(1, 174)then
					everyPedSkinMenu12 = false
					everyPedSkinMenu11 = true
				elseif IsDisabledControlJustReleased(1, 175)then
					everyPedSkinMenu12 = false
					everyPedSkinMenu13 = true
				end
			end
		
			if not IsDisabledControlPressed(1, 173) and not IsDisabledControlPressed(1, 172) then
				currentOption = lastSelectioneveryPedSkinMenu12
			else
				lastSelectioneveryPedSkinMenu12 = currentOption
			end

			TriggerEvent("FMODT:Title", "~y~" .. EveryPedTitle .. "")

			for i = 221, 240 do
				TriggerEvent("FMODT:Option", skinName[i], function(cb)
					if (cb) then
						skin = GetHashKey(skinModelName[i])
						end
				end)
			end
			
			TriggerEvent("FMODT:Option", "~r~" .. PageIndicator .. " 12", function(cb)
				if (cb) then
					drawNotification("~r~" .. PageIndicator .. " 12")
				end
			end)

			TriggerEvent("FMODT:Update")

		elseif everyPedSkinMenu13 then
		
			lasteveryPedSite = 13

			if not FloatIntArray then
				if IsDisabledControlJustReleased(1, 174)then
					everyPedSkinMenu13 = false
					everyPedSkinMenu12 = true
				elseif IsDisabledControlJustReleased(1, 175)then
					everyPedSkinMenu13 = false
					everyPedSkinMenu14 = true
				end
			end
		
			if not IsDisabledControlPressed(1, 173) and not IsDisabledControlPressed(1, 172) then
				currentOption = lastSelectioneveryPedSkinMenu13
			else
				lastSelectioneveryPedSkinMenu13 = currentOption
			end

			TriggerEvent("FMODT:Title", "~y~" .. EveryPedTitle .. "")

			for i = 241, 260 do
				TriggerEvent("FMODT:Option", skinName[i], function(cb)
					if (cb) then
						skin = GetHashKey(skinModelName[i])
						end
				end)
			end
			
			TriggerEvent("FMODT:Option", "~r~" .. PageIndicator .. " 13", function(cb)
				if (cb) then
					drawNotification("~r~" .. PageIndicator .. " 13")
				end
			end)

			TriggerEvent("FMODT:Update")

		elseif everyPedSkinMenu14 then
		
			lasteveryPedSite = 14

			if not FloatIntArray then
				if IsDisabledControlJustReleased(1, 174)then
					everyPedSkinMenu14 = false
					everyPedSkinMenu13 = true
				elseif IsDisabledControlJustReleased(1, 175)then
					everyPedSkinMenu14 = false
					everyPedSkinMenu15 = true
				end
			end
		
			if not IsDisabledControlPressed(1, 173) and not IsDisabledControlPressed(1, 172) then
				currentOption = lastSelectioneveryPedSkinMenu14
			else
				lastSelectioneveryPedSkinMenu14 = currentOption
			end

			TriggerEvent("FMODT:Title", "~y~" .. EveryPedTitle .. "")

			for i = 261, 280 do
				TriggerEvent("FMODT:Option", skinName[i], function(cb)
					if (cb) then
						skin = GetHashKey(skinModelName[i])
						end
				end)
			end
			
			TriggerEvent("FMODT:Option", "~r~" .. PageIndicator .. " 14", function(cb)
				if (cb) then
					drawNotification("~r~" .. PageIndicator .. " 14")
				end
			end)

			TriggerEvent("FMODT:Update")

		elseif everyPedSkinMenu15 then
		
			lasteveryPedSite = 15

			if not FloatIntArray then
				if IsDisabledControlJustReleased(1, 174)then
					everyPedSkinMenu15 = false
					everyPedSkinMenu14 = true
				elseif IsDisabledControlJustReleased(1, 175)then
					everyPedSkinMenu15 = false
					everyPedSkinMenu16 = true
				end
			end
		
			if not IsDisabledControlPressed(1, 173) and not IsDisabledControlPressed(1, 172) then
				currentOption = lastSelectioneveryPedSkinMenu15
			else
				lastSelectioneveryPedSkinMenu15 = currentOption
			end

			TriggerEvent("FMODT:Title", "~y~" .. EveryPedTitle .. "")

			for i = 281, 300 do
				TriggerEvent("FMODT:Option", skinName[i], function(cb)
					if (cb) then
						skin = GetHashKey(skinModelName[i])
						end
				end)
			end
			
			TriggerEvent("FMODT:Option", "~r~" .. PageIndicator .. " 15", function(cb)
				if (cb) then
					drawNotification("~r~" .. PageIndicator .. " 15")
				end
			end)

			TriggerEvent("FMODT:Update")

		elseif everyPedSkinMenu16 then
		
			lasteveryPedSite = 16

			if not FloatIntArray then
				if IsDisabledControlJustReleased(1, 174)then
					everyPedSkinMenu16 = false
					everyPedSkinMenu15 = true
				elseif IsDisabledControlJustReleased(1, 175)then
					everyPedSkinMenu16 = false
					everyPedSkinMenu17 = true
				end
			end
		
			if not IsDisabledControlPressed(1, 173) and not IsDisabledControlPressed(1, 172) then
				currentOption = lastSelectioneveryPedSkinMenu16
			else
				lastSelectioneveryPedSkinMenu16 = currentOption
			end

			TriggerEvent("FMODT:Title", "~y~" .. EveryPedTitle .. "")

			for i = 301, 320 do
				TriggerEvent("FMODT:Option", skinName[i], function(cb)
					if (cb) then
						skin = GetHashKey(skinModelName[i])
						end
				end)
			end
			
			TriggerEvent("FMODT:Option", "~r~" .. PageIndicator .. " 16", function(cb)
				if (cb) then
					drawNotification("~r~" .. PageIndicator .. " 16")
				end
			end)

			TriggerEvent("FMODT:Update")

		elseif everyPedSkinMenu17 then
		
			lasteveryPedSite = 17

			if not FloatIntArray then
				if IsDisabledControlJustReleased(1, 174)then
					everyPedSkinMenu17 = false
					everyPedSkinMenu16 = true
				elseif IsDisabledControlJustReleased(1, 175)then
					everyPedSkinMenu17 = false
					everyPedSkinMenu18 = true
				end
			end
		
			if not IsDisabledControlPressed(1, 173) and not IsDisabledControlPressed(1, 172) then
				currentOption = lastSelectioneveryPedSkinMenu17
			else
				lastSelectioneveryPedSkinMenu17 = currentOption
			end

			TriggerEvent("FMODT:Title", "~y~" .. EveryPedTitle .. "")

			for i = 321, 340 do
				TriggerEvent("FMODT:Option", skinName[i], function(cb)
					if (cb) then
						skin = GetHashKey(skinModelName[i])
						end
				end)
			end
			
			TriggerEvent("FMODT:Option", "~r~" .. PageIndicator .. " 17", function(cb)
				if (cb) then
					drawNotification("~r~" .. PageIndicator .. " 17")
				end
			end)

			TriggerEvent("FMODT:Update")

		elseif everyPedSkinMenu18 then
		
			lasteveryPedSite = 18

			if not FloatIntArray then
				if IsDisabledControlJustReleased(1, 174)then
					everyPedSkinMenu18 = false
					everyPedSkinMenu17 = true
				elseif IsDisabledControlJustReleased(1, 175)then
					everyPedSkinMenu18 = false
					everyPedSkinMenu19 = true
				end
			end
		
			if not IsDisabledControlPressed(1, 173) and not IsDisabledControlPressed(1, 172) then
				currentOption = lastSelectioneveryPedSkinMenu18
			else
				lastSelectioneveryPedSkinMenu18 = currentOption
			end

			TriggerEvent("FMODT:Title", "~y~" .. EveryPedTitle .. "")

			for i = 341, 360 do
				TriggerEvent("FMODT:Option", skinName[i], function(cb)
					if (cb) then
						skin = GetHashKey(skinModelName[i])
						end
				end)
			end
			
			TriggerEvent("FMODT:Option", "~r~" .. PageIndicator .. " 18", function(cb)
				if (cb) then
					drawNotification("~r~" .. PageIndicator .. " 18")
				end
			end)

			TriggerEvent("FMODT:Update")

		elseif everyPedSkinMenu19 then
		
			lasteveryPedSite = 19

			if not FloatIntArray then
				if IsDisabledControlJustReleased(1, 174)then
					everyPedSkinMenu19 = false
					everyPedSkinMenu18 = true
				elseif IsDisabledControlJustReleased(1, 175)then
					everyPedSkinMenu19 = false
					everyPedSkinMenu20 = true
				end
			end
		
			if not IsDisabledControlPressed(1, 173) and not IsDisabledControlPressed(1, 172) then
				currentOption = lastSelectioneveryPedSkinMenu19
			else
				lastSelectioneveryPedSkinMenu19 = currentOption
			end

			TriggerEvent("FMODT:Title", "~y~" .. EveryPedTitle .. "")

			for i = 361, 380 do
				TriggerEvent("FMODT:Option", skinName[i], function(cb)
					if (cb) then
						skin = GetHashKey(skinModelName[i])
						end
				end)
			end
			
			TriggerEvent("FMODT:Option", "~r~" .. PageIndicator .. " 19", function(cb)
				if (cb) then
					drawNotification("~r~" .. PageIndicator .. " 19")
				end
			end)

			TriggerEvent("FMODT:Update")

		elseif everyPedSkinMenu20 then
		
			lasteveryPedSite = 20

			if not FloatIntArray then
				if IsDisabledControlJustReleased(1, 174)then
					everyPedSkinMenu20 = false
					everyPedSkinMenu19 = true
				elseif IsDisabledControlJustReleased(1, 175)then
					everyPedSkinMenu20 = false
					everyPedSkinMenu21 = true
				end
			end
		
			if not IsDisabledControlPressed(1, 173) and not IsDisabledControlPressed(1, 172) then
				currentOption = lastSelectioneveryPedSkinMenu20
			else
				lastSelectioneveryPedSkinMenu20 = currentOption
			end

			TriggerEvent("FMODT:Title", "~y~" .. EveryPedTitle .. "")

			for i = 381, 400 do
				TriggerEvent("FMODT:Option", skinName[i], function(cb)
					if (cb) then
						skin = GetHashKey(skinModelName[i])
						end
				end)
			end
			
			TriggerEvent("FMODT:Option", "~r~" .. PageIndicator .. " 20", function(cb)
				if (cb) then
					drawNotification("~r~" .. PageIndicator .. " 20")
				end
			end)

			TriggerEvent("FMODT:Update")

		elseif everyPedSkinMenu21 then
		
			lasteveryPedSite = 21

			if not FloatIntArray then
				if IsDisabledControlJustReleased(1, 174)then
					everyPedSkinMenu21 = false
					everyPedSkinMenu20 = true
				elseif IsDisabledControlJustReleased(1, 175)then
					everyPedSkinMenu21 = false
					everyPedSkinMenu22 = true
				end
			end
		
			if not IsDisabledControlPressed(1, 173) and not IsDisabledControlPressed(1, 172) then
				currentOption = lastSelectioneveryPedSkinMenu21
			else
				lastSelectioneveryPedSkinMenu21 = currentOption
			end

			TriggerEvent("FMODT:Title", "~y~" .. EveryPedTitle .. "")

			for i = 401, 420 do
				TriggerEvent("FMODT:Option", skinName[i], function(cb)
					if (cb) then
						skin = GetHashKey(skinModelName[i])
						end
				end)
			end
			
			TriggerEvent("FMODT:Option", "~r~" .. PageIndicator .. " 21", function(cb)
				if (cb) then
					drawNotification("~r~" .. PageIndicator .. " 21")
				end
			end)

			TriggerEvent("FMODT:Update")

		elseif everyPedSkinMenu22 then
		
			lasteveryPedSite = 22

			if not FloatIntArray then
				if IsDisabledControlJustReleased(1, 174)then
					everyPedSkinMenu22 = false
					everyPedSkinMenu21 = true
				elseif IsDisabledControlJustReleased(1, 175)then
					everyPedSkinMenu22 = false
					everyPedSkinMenu23 = true
				end
			end
		
			if not IsDisabledControlPressed(1, 173) and not IsDisabledControlPressed(1, 172) then
				currentOption = lastSelectioneveryPedSkinMenu22
			else
				lastSelectioneveryPedSkinMenu22 = currentOption
			end

			TriggerEvent("FMODT:Title", "~y~" .. EveryPedTitle .. "")

			for i = 421, 440 do
				TriggerEvent("FMODT:Option", skinName[i], function(cb)
					if (cb) then
						skin = GetHashKey(skinModelName[i])
						end
				end)
			end
			
			TriggerEvent("FMODT:Option", "~r~" .. PageIndicator .. " 22", function(cb)
				if (cb) then
					drawNotification("~r~" .. PageIndicator .. " 22")
				end
			end)

			TriggerEvent("FMODT:Update")

		elseif everyPedSkinMenu23 then
		
			lasteveryPedSite = 23

			if not FloatIntArray then
				if IsDisabledControlJustReleased(1, 174)then
					everyPedSkinMenu23 = false
					everyPedSkinMenu22 = true
				elseif IsDisabledControlJustReleased(1, 175)then
					everyPedSkinMenu23 = false
					everyPedSkinMenu24 = true
				end
			end
		
			if not IsDisabledControlPressed(1, 173) and not IsDisabledControlPressed(1, 172) then
				currentOption = lastSelectioneveryPedSkinMenu23
			else
				lastSelectioneveryPedSkinMenu23 = currentOption
			end

			TriggerEvent("FMODT:Title", "~y~" .. EveryPedTitle .. "")

			for i = 441, 460 do
				TriggerEvent("FMODT:Option", skinName[i], function(cb)
					if (cb) then
						skin = GetHashKey(skinModelName[i])
						end
				end)
			end
			
			TriggerEvent("FMODT:Option", "~r~" .. PageIndicator .. " 23", function(cb)
				if (cb) then
					drawNotification("~r~" .. PageIndicator .. " 23")
				end
			end)

			TriggerEvent("FMODT:Update")

		elseif everyPedSkinMenu24 then
		
			lasteveryPedSite = 24

			if not FloatIntArray then
				if IsDisabledControlJustReleased(1, 174)then
					everyPedSkinMenu24 = false
					everyPedSkinMenu23 = true
				elseif IsDisabledControlJustReleased(1, 175)then
					everyPedSkinMenu24 = false
					everyPedSkinMenu25 = true
				end
			end
		
			if not IsDisabledControlPressed(1, 173) and not IsDisabledControlPressed(1, 172) then
				currentOption = lastSelectioneveryPedSkinMenu24
			else
				lastSelectioneveryPedSkinMenu24 = currentOption
			end

			TriggerEvent("FMODT:Title", "~y~" .. EveryPedTitle .. "")

			for i = 461, 480 do
				TriggerEvent("FMODT:Option", skinName[i], function(cb)
					if (cb) then
						skin = GetHashKey(skinModelName[i])
						end
				end)
			end
			
			TriggerEvent("FMODT:Option", "~r~" .. PageIndicator .. " 24", function(cb)
				if (cb) then
					drawNotification("~r~" .. PageIndicator .. " 24")
				end
			end)

			TriggerEvent("FMODT:Update")

		elseif everyPedSkinMenu25 then
		
			lasteveryPedSite = 25

			if not FloatIntArray then
				if IsDisabledControlJustReleased(1, 174)then
					everyPedSkinMenu25 = false
					everyPedSkinMenu24 = true
				elseif IsDisabledControlJustReleased(1, 175)then
					everyPedSkinMenu25 = false
					everyPedSkinMenu26 = true
				end
			end
		
			if not IsDisabledControlPressed(1, 173) and not IsDisabledControlPressed(1, 172) then
				currentOption = lastSelectioneveryPedSkinMenu25
			else
				lastSelectioneveryPedSkinMenu25 = currentOption
			end

			TriggerEvent("FMODT:Title", "~y~" .. EveryPedTitle .. "")

			for i = 481, 500 do
				TriggerEvent("FMODT:Option", skinName[i], function(cb)
					if (cb) then
						skin = GetHashKey(skinModelName[i])
						end
				end)
			end
			
			TriggerEvent("FMODT:Option", "~r~" .. PageIndicator .. " 25", function(cb)
				if (cb) then
					drawNotification("~r~" .. PageIndicator .. " 25")
				end
			end)

			TriggerEvent("FMODT:Update")

		elseif everyPedSkinMenu26 then
		
			lasteveryPedSite = 26

			if not FloatIntArray then
				if IsDisabledControlJustReleased(1, 174)then
					everyPedSkinMenu26 = false
					everyPedSkinMenu25 = true
				elseif IsDisabledControlJustReleased(1, 175)then
					everyPedSkinMenu26 = false
					everyPedSkinMenu27 = true
				end
			end
		
			if not IsDisabledControlPressed(1, 173) and not IsDisabledControlPressed(1, 172) then
				currentOption = lastSelectioneveryPedSkinMenu26
			else
				lastSelectioneveryPedSkinMenu26 = currentOption
			end

			TriggerEvent("FMODT:Title", "~y~" .. EveryPedTitle .. "")

			for i = 501, 520 do
				TriggerEvent("FMODT:Option", skinName[i], function(cb)
					if (cb) then
						skin = GetHashKey(skinModelName[i])
						end
				end)
			end
			
			TriggerEvent("FMODT:Option", "~r~" .. PageIndicator .. " 26", function(cb)
				if (cb) then
					drawNotification("~r~" .. PageIndicator .. " 26")
				end
			end)

			TriggerEvent("FMODT:Update")

		elseif everyPedSkinMenu27 then
		
			lasteveryPedSite = 27

			if not FloatIntArray then
				if IsDisabledControlJustReleased(1, 174)then
					everyPedSkinMenu27 = false
					everyPedSkinMenu26 = true
				elseif IsDisabledControlJustReleased(1, 175)then
					everyPedSkinMenu27 = false
					everyPedSkinMenu28 = true
				end
			end
		
			if not IsDisabledControlPressed(1, 173) and not IsDisabledControlPressed(1, 172) then
				currentOption = lastSelectioneveryPedSkinMenu27
			else
				lastSelectioneveryPedSkinMenu27 = currentOption
			end

			TriggerEvent("FMODT:Title", "~y~" .. EveryPedTitle .. "")

			for i = 521, 540 do
				TriggerEvent("FMODT:Option", skinName[i], function(cb)
					if (cb) then
						skin = GetHashKey(skinModelName[i])
						end
				end)
			end
			
			TriggerEvent("FMODT:Option", "~r~" .. PageIndicator .. " 27", function(cb)
				if (cb) then
					drawNotification("~r~" .. PageIndicator .. " 27")
				end
			end)

			TriggerEvent("FMODT:Update")

		elseif everyPedSkinMenu28 then
		
			lasteveryPedSite = 28

			if not FloatIntArray then
				if IsDisabledControlJustReleased(1, 174)then
					everyPedSkinMenu28 = false
					everyPedSkinMenu27 = true
				elseif IsDisabledControlJustReleased(1, 175)then
					everyPedSkinMenu28 = false
					everyPedSkinMenu29 = true
				end
			end
		
			if not IsDisabledControlPressed(1, 173) and not IsDisabledControlPressed(1, 172) then
				currentOption = lastSelectioneveryPedSkinMenu28
			else
				lastSelectioneveryPedSkinMenu28 = currentOption
			end

			TriggerEvent("FMODT:Title", "~y~" .. EveryPedTitle .. "")

			for i = 541, 560 do
				TriggerEvent("FMODT:Option", skinName[i], function(cb)
					if (cb) then
						skin = GetHashKey(skinModelName[i])
						end
				end)
			end
			
			TriggerEvent("FMODT:Option", "~r~" .. PageIndicator .. " 28", function(cb)
				if (cb) then
					drawNotification("~r~" .. PageIndicator .. " 28")
				end
			end)

			TriggerEvent("FMODT:Update")

		elseif everyPedSkinMenu29 then
		
			lasteveryPedSite = 29

			if not FloatIntArray then
				if IsDisabledControlJustReleased(1, 174)then
					everyPedSkinMenu29 = false
					everyPedSkinMenu28 = true
				elseif IsDisabledControlJustReleased(1, 175)then
					everyPedSkinMenu29 = false
					everyPedSkinMenu30 = true
				end
			end
		
			if not IsDisabledControlPressed(1, 173) and not IsDisabledControlPressed(1, 172) then
				currentOption = lastSelectioneveryPedSkinMenu29
			else
				lastSelectioneveryPedSkinMenu29 = currentOption
			end

			TriggerEvent("FMODT:Title", "~y~" .. EveryPedTitle .. "")

			for i = 561, 580 do
				TriggerEvent("FMODT:Option", skinName[i], function(cb)
					if (cb) then
						skin = GetHashKey(skinModelName[i])
						end
				end)
			end
			
			TriggerEvent("FMODT:Option", "~r~" .. PageIndicator .. " 29", function(cb)
				if (cb) then
					drawNotification("~r~" .. PageIndicator .. " 29")
				end
			end)

			TriggerEvent("FMODT:Update")

		elseif everyPedSkinMenu30 then
		
			lasteveryPedSite = 30

			if not FloatIntArray then
				if IsDisabledControlJustReleased(1, 174)then
					everyPedSkinMenu30 = false
					everyPedSkinMenu29 = true
				elseif IsDisabledControlJustReleased(1, 175)then
					everyPedSkinMenu30 = false
					everyPedSkinMenu31 = true
				end
			end
		
			if not IsDisabledControlPressed(1, 173) and not IsDisabledControlPressed(1, 172) then
				currentOption = lastSelectioneveryPedSkinMenu30
			else
				lastSelectioneveryPedSkinMenu30 = currentOption
			end

			TriggerEvent("FMODT:Title", "~y~" .. EveryPedTitle .. "")

			for i = 581, 600 do
				TriggerEvent("FMODT:Option", skinName[i], function(cb)
					if (cb) then
						skin = GetHashKey(skinModelName[i])
						end
				end)
			end
			
			TriggerEvent("FMODT:Option", "~r~" .. PageIndicator .. " 30", function(cb)
				if (cb) then
					drawNotification("~r~" .. PageIndicator .. " 30")
				end
			end)

			TriggerEvent("FMODT:Update")

		elseif everyPedSkinMenu31 then
		
			lasteveryPedSite = 31

			if not FloatIntArray then
				if IsDisabledControlJustReleased(1, 174)then
					everyPedSkinMenu31 = false
					everyPedSkinMenu30 = true
				elseif IsDisabledControlJustReleased(1, 175)then
					everyPedSkinMenu31 = false
					everyPedSkinMenu32 = true
				end
			end
		
			if not IsDisabledControlPressed(1, 173) and not IsDisabledControlPressed(1, 172) then
				currentOption = lastSelectioneveryPedSkinMenu31
			else
				lastSelectioneveryPedSkinMenu31 = currentOption
			end

			TriggerEvent("FMODT:Title", "~y~" .. EveryPedTitle .. "")

			for i = 601, 620 do
				TriggerEvent("FMODT:Option", skinName[i], function(cb)
					if (cb) then
						skin = GetHashKey(skinModelName[i])
						end
				end)
			end
			
			TriggerEvent("FMODT:Option", "~r~" .. PageIndicator .. " 31", function(cb)
				if (cb) then
					drawNotification("~r~" .. PageIndicator .. " 31")
				end
			end)

			TriggerEvent("FMODT:Update")

		elseif everyPedSkinMenu32 then
		
			lasteveryPedSite = 32

			if not FloatIntArray then
				if IsDisabledControlJustReleased(1, 174)then
					everyPedSkinMenu32 = false
					everyPedSkinMenu31 = true
				elseif IsDisabledControlJustReleased(1, 175)then
					everyPedSkinMenu32 = false
					everyPedSkinMenu33 = true
				end
			end
		
			if not IsDisabledControlPressed(1, 173) and not IsDisabledControlPressed(1, 172) then
				currentOption = lastSelectioneveryPedSkinMenu32
			else
				lastSelectioneveryPedSkinMenu32 = currentOption
			end

			TriggerEvent("FMODT:Title", "~y~" .. EveryPedTitle .. "")

			for i = 621, 640 do
				TriggerEvent("FMODT:Option", skinName[i], function(cb)
					if (cb) then
						skin = GetHashKey(skinModelName[i])
						end
				end)
			end
			
			TriggerEvent("FMODT:Option", "~r~" .. PageIndicator .. " 32", function(cb)
				if (cb) then
					drawNotification("~r~" .. PageIndicator .. " 32")
				end
			end)

			TriggerEvent("FMODT:Update")

		elseif everyPedSkinMenu33 then
		
			lasteveryPedSite = 33

			if not FloatIntArray then
				if IsDisabledControlJustReleased(1, 174)then
					everyPedSkinMenu33 = false
					everyPedSkinMenu32 = true
				elseif IsDisabledControlJustReleased(1, 175)then
					everyPedSkinMenu33 = false
					everyPedSkinMenu34 = true
				end
			end
		
			if not IsDisabledControlPressed(1, 173) and not IsDisabledControlPressed(1, 172) then
				currentOption = lastSelectioneveryPedSkinMenu33
			else
				lastSelectioneveryPedSkinMenu33 = currentOption
			end

			TriggerEvent("FMODT:Title", "~y~" .. EveryPedTitle .. "")

			for i = 641, 660 do
				TriggerEvent("FMODT:Option", skinName[i], function(cb)
					if (cb) then
						skin = GetHashKey(skinModelName[i])
						end
				end)
			end
			
			TriggerEvent("FMODT:Option", "~r~" .. PageIndicator .. " 33", function(cb)
				if (cb) then
					drawNotification("~r~" .. PageIndicator .. " 33")
				end
			end)

			TriggerEvent("FMODT:Update")

		elseif everyPedSkinMenu34 then
		
			lasteveryPedSite = 34

			if not FloatIntArray then
				if IsDisabledControlJustReleased(1, 174)then
					everyPedSkinMenu34 = false
					everyPedSkinMenu33 = true
				elseif IsDisabledControlJustReleased(1, 175)then
					everyPedSkinMenu34 = false
					everyPedSkinMenu1 = true
				end
			end
		
			if not IsDisabledControlPressed(1, 173) and not IsDisabledControlPressed(1, 172) then
				currentOption = lastSelectioneveryPedSkinMenu34
			else
				lastSelectioneveryPedSkinMenu34 = currentOption
			end

			TriggerEvent("FMODT:Title", "~y~" .. EveryPedTitle .. "")

			for i = 661, tablelength(skinModelName) do
				TriggerEvent("FMODT:Option", skinName[i], function(cb)
					if (cb) then
						skin = GetHashKey(skinModelName[i])
						end
				end)
			end
			
			TriggerEvent("FMODT:Option", "~r~" .. PageIndicator .. " 34", function(cb)
				if (cb) then
					drawNotification("~r~" .. PageIndicator .. " 34")
				end
			end)

			TriggerEvent("FMODT:Update")

		end
		Citizen.Wait(0)
	end
end)

Citizen.CreateThread(function() --Scenarios Menu						[Multiple Pages]
	while true do
		if (scenarioMenu) then
		
			if not IsDisabledControlPressed(1, 173) and not IsDisabledControlPressed(1, 172) then
				currentOption = lastSelectionscenarioMenu
			else
				lastSelectionscenarioMenu = currentOption
			end

			TriggerEvent("FMODT:Title", "~y~" .. ScenariosTitle .. "")

			TriggerEvent("FMODT:Option", StopScenariosTitle, function(cb)
				if (cb) then
					ClearPedTasksImmediately(GetPlayerPed(-1))
				end
			end)

			TriggerEvent("FMODT:Option", "~y~>> ~s~" .. MalePedScenariosTitle .. "", function(cb)
				if (cb) then
					scenarioMenu = false
					maleScenarioMenu = true
				end
			end)

			TriggerEvent("FMODT:Option", BinocularsTitle, function(cb)
				if (cb) then
					TaskStartScenarioInPlace(GetPlayerPed(-1), "WORLD_HUMAN_BINOCULARS", 0, false)
				end
			end)

			TriggerEvent("FMODT:Option", CheeringTitle, function(cb)
				if (cb) then
					TaskStartScenarioInPlace(GetPlayerPed(-1), "WORLD_HUMAN_CHEERING", 0, false)
				end
			end)

			TriggerEvent("FMODT:Option", DrillTitle, function(cb)
				if (cb) then
					TaskStartScenarioInPlace(GetPlayerPed(-1), "WORLD_HUMAN_CONST_DRILL", 0, false)
				end
			end)

			TriggerEvent("FMODT:Option", DrinkingSomeCovfefeTitle, function(cb)
				if (cb) then
					TaskStartScenarioInPlace(GetPlayerPed(-1), "WORLD_HUMAN_DRINKING", 0, false)
				end
			end)

			TriggerEvent("FMODT:Option", FilmingTitle, function(cb)
				if (cb) then
					TaskStartScenarioInPlace(GetPlayerPed(-1), "WORLD_HUMAN_MOBILE_FILM_SHOCKING", 0, false)
				end
			end)

			TriggerEvent("FMODT:Option", FishingTitle, function(cb)
				if (cb) then
					TaskStartScenarioInPlace(GetPlayerPed(-1), "WORLD_HUMAN_STAND_FISHING", 0, false)
				end
			end)

			TriggerEvent("FMODT:Option", HammeringTitle, function(cb)
				if (cb) then
					TaskStartScenarioInPlace(GetPlayerPed(-1), "WORLD_HUMAN_HAMMERING", 0, false)
				end
			end)

			TriggerEvent("FMODT:Option", JanitorTitle, function(cb)
				if (cb) then
					TaskStartScenarioInPlace(GetPlayerPed(-1), "WORLD_HUMAN_JANITOR", 0, false)
				end
			end)

			TriggerEvent("FMODT:Option", TouristTitle, function(cb)
				if (cb) then
					TaskStartScenarioInPlace(GetPlayerPed(-1), "WORLD_HUMAN_TOURIST_MAP", 0, false)
				end
			end)

			TriggerEvent("FMODT:Option", WeedSmokingTitle, function(cb)
				if (cb) then
					TaskStartScenarioInPlace(GetPlayerPed(-1), "WORLD_HUMAN_SMOKING_POT", 0, false)
				end
			end)

			TriggerEvent("FMODT:Option", WeightliftingTitle, function(cb)
				if (cb) then
					TaskStartScenarioInPlace(GetPlayerPed(-1), "WORLD_HUMAN_MUSCLE_FREE_WEIGHTS", 0, false)
				end
			end)

			TriggerEvent("FMODT:Option", WeldingTitle, function(cb)
				if (cb) then
					TaskStartScenarioInPlace(GetPlayerPed(-1), "WORLD_HUMAN_WELDING", 0, false)
				end
			end)

			TriggerEvent("FMODT:Option", YogaTitle, function(cb)
				if (cb) then
					TaskStartScenarioInPlace(GetPlayerPed(-1), "WORLD_HUMAN_YOGA", 0, false)
				end
			end)

			TriggerEvent("FMODT:Update")
			
		elseif (maleScenarioMenu) then
		
			if not IsDisabledControlPressed(1, 173) and not IsDisabledControlPressed(1, 172) then
				currentOption = lastSelectionmaleScenarioMenu
			else
				lastSelectionmaleScenarioMenu = currentOption
			end

			TriggerEvent("FMODT:Title", "~y~" .. MalePedScenariosTitle .. "")

			TriggerEvent("FMODT:Option", StopScenariosTitle, function(cb)
				if (cb) then
					ClearPedTasksImmediately(GetPlayerPed(-1))
				end
			end)

			TriggerEvent("FMODT:Option", BBQTitle, function(cb)
				if (cb) then
					if IsPedMale(GetPlayerPed(-1)) then
						TaskStartScenarioInPlace(GetPlayerPed(-1), "PROP_HUMAN_BBQ", 0, false)
						else
						drawNotification("~r~Only Works With Male Peds!")
					end
				end
			end)

			TriggerEvent("FMODT:Option", CarParkAttendantTitle, function(cb)
				if (cb) then
					if IsPedMale(GetPlayerPed(-1)) then
						TaskStartScenarioInPlace(GetPlayerPed(-1), "WORLD_HUMAN_CAR_PARK_ATTENDANT", 0, false)
						else
						drawNotification("~r~Only Works With Male Peds!")
					end
				end
			end)

			TriggerEvent("FMODT:Option", GolfTitle, function(cb)
				if (cb) then
					if IsPedMale(GetPlayerPed(-1)) then
						TaskStartScenarioInPlace(GetPlayerPed(-1), "WORLD_HUMAN_GOLF_PLAYER", 0, false)
						else
						drawNotification("~r~Only Works With Male Peds!")
					end
				end
			end)

			TriggerEvent("FMODT:Option", MusicianTitle, function(cb)
				if (cb) then
					if IsPedMale(GetPlayerPed(-1)) then
						TaskStartScenarioInPlace(GetPlayerPed(-1), "WORLD_HUMAN_MUSICIAN", 0, false)
						else
						drawNotification("~r~Only Works With Male Peds!")
					end
				end
			end)

			TriggerEvent("FMODT:Option", PaparazziTitle, function(cb)
				if (cb) then
					if IsPedMale(GetPlayerPed(-1)) then
						TaskStartScenarioInPlace(GetPlayerPed(-1), "WORLD_HUMAN_PAPARAZZI", 0, false)
						else
						drawNotification("~r~Only Works With Male Peds!")
					end
				end
			end)

			TriggerEvent("FMODT:Option", PushUpsTitle, function(cb)
				if (cb) then
					if IsPedMale(GetPlayerPed(-1)) then
						TaskStartScenarioInPlace(GetPlayerPed(-1), "WORLD_HUMAN_PUSH_UPS", 0, false)
						else
						drawNotification("~r~Only Works With Male Peds!")
					end
				end
			end)

			TriggerEvent("FMODT:Option", SitUpsTitle, function(cb)
				if (cb) then
					if IsPedMale(GetPlayerPed(-1)) then
						TaskStartScenarioInPlace(GetPlayerPed(-1), "WORLD_HUMAN_SIT_UPS", 0, false)
						else
						drawNotification("~r~Only Works With Male Peds!")
					end
				end
			end)

			TriggerEvent("FMODT:Update")
		end
		Citizen.Wait(0)
	end
end)

Citizen.CreateThread(function() --Wanted Menu
	while true do
		wanted = GetPlayerWantedLevel(PlayerId())
		maxWantedLevel = GetMaxWantedLevel()
		if (wantedMenu) then
		
			if not IsDisabledControlPressed(1, 173) and not IsDisabledControlPressed(1, 172) then
				currentOption = lastSelectionwantedMenu
			else
				lastSelectionwantedMenu = currentOption
			end

			TriggerEvent("FMODT:Title", "~y~" .. WantedLevelTitle .. "")

			TriggerEvent("FMODT:Option", ClearWantedLevelTitle, function(cb)
				if (cb) then
					if nowantedlevel then
						drawNotification("~r~" .. ClearWantedLevelMessage1 .. "!")
					else
						SetPlayerWantedLevel(PlayerId(), 0, false)
						SetPlayerWantedLevelNow(PlayerId(), 0)
						drawNotification("~g~" .. ClearWantedLevelMessage2 .. "!")
					end
				end
			end)

			TriggerEvent("FMODT:Bool", DisableWantedLevelTitle, nowantedlevel, function(cb)
				nowantedlevel = cb
				if nowantedlevel then
					nowantedlevelCount = 1
					drawNotification("~g~" .. DisableWantedLevelDisableMessage .. "!")
				else
					nowantedlevelCount = 0
					drawNotification("~r~" .. DisableWantedLevelEnableMessage .. "!")
				end
			end)

			TriggerEvent("FMODT:Int", MaximumWantedLevelTitle, maxWantedLevel, 0, 5, function(cb)
				maxWantedLevel = cb
				SetMaxWantedLevel(maxWantedLevel)
			end)

			TriggerEvent("FMODT:Int", SetWantedLevelTitle, WantedLevel, 0, 5, function(cb)
				WantedLevel = cb
				if nowantedlevel then
					drawNotification("~r~" .. SetWantedLevelMessage .. "!")
				else
					SetPlayerWantedLevel(PlayerId(), WantedLevel, false)
					SetPlayerWantedLevelNow(PlayerId(), WantedLevel)
				end
			end)

			TriggerEvent("FMODT:Update")
		end

		Citizen.Wait(0)
	end
end)

Citizen.CreateThread(function() --Godmode
	while true do
		Citizen.Wait(0)
		if allowed then
			if godmode then
				SetEntityInvincible(GetPlayerPed(-1), true)
				SetPlayerInvincible(PlayerId(), true)
				SetPedCanRagdoll(GetPlayerPed(-1), false)
				ClearPedBloodDamage(GetPlayerPed(-1))
				ResetPedVisibleDamage(GetPlayerPed(-1))
				ClearPedLastWeaponDamage(GetPlayerPed(-1))
				SetEntityProofs(GetPlayerPed(-1), true, true, true, true, true, true, true, true)
				SetEntityCanBeDamaged(GetPlayerPed(-1), false)
			else
				SetEntityInvincible(GetPlayerPed(-1), false)
				SetPlayerInvincible(PlayerId(), false)
				SetPedCanRagdoll(GetPlayerPed(-1), true)
				SetEntityProofs(GetPlayerPed(-1), false, false, false, false, false, false, false, false)
				SetEntityCanBeDamaged(GetPlayerPed(-1), true)
			end
		end
	end
end)

Citizen.CreateThread(function() --Visible
	while true do
		Citizen.Wait(0)
		if allowed then
			SetEntityVisible(GetPlayerPed(-1), playerVisible, 1)
		end
	end
end)

Citizen.CreateThread(function() --Infinite Stamina
	while true do
		Citizen.Wait(0)
		if stamina and allowed then
			RestorePlayerStamina(PlayerId(), 1.0)
		end
	end
end)

Citizen.CreateThread(function() --Disable Wanted Level
	while true do
		Citizen.Wait(0)
		if nowantedlevel and allowed then
			ClearPlayerWantedLevel(PlayerId())
			SetPlayerWantedLevel(PlayerId(), 0, false)
			SetPlayerWantedLevelNow(PlayerId(), 0)
		end
	end
end)

Citizen.CreateThread(function() --Animation Play
	while true do
		Citizen.Wait(0)
		if animPlay and allowed then
			SetCurrentPedWeapon(GetPlayerPed(-1), GetHashKey("WEAPON_UNARMED"), true)
			RequestAnimDict(animDict)
			while not HasAnimDictLoaded(animDict) do
				Citizen.Wait(0)
			end
			if pistol then
				GiveWeaponToPed(playerPed, GetHashKey("WEAPON_PISTOL"), 99999, false, false)
				SetCurrentPedWeapon(playerPed, GetHashKey("WEAPON_PISTOL"), true)
				pistol = false
			end
			TaskPlayAnim(GetPlayerPed(-1), animDict, animName, 8.0, 0.0, -1, 9, 0, 0, 0, 0)
			drawNotification("~g~Animation Started!")
			animPlay = false
		end
	end
end)

Citizen.CreateThread(function() --Skin Changing
	while true do
		Citizen.Wait(0)
		if skin and allowed then
			if IsModelInCdimage(skin) and IsModelValid(skin) then
				RequestModel(skin)
				while not HasModelLoaded(skin) do
					Citizen.Wait(0)
				end
				SetPlayerModel(PlayerId(), skin)
				SetPedDefaultComponentVariation(GetPlayerPed(-1))
			else
				drawNotification("~r~" .. PedNotExistingMessage .. "!")
			end
			if (skin == GetHashKey("mp_m_freemode_01")) then
				mChar = true
			elseif (skin == GetHashKey("mp_f_freemode_01")) then
				fChar = true
			end
			SetModelAsNoLongerNeeded(skin)
			skin = nil
		end
	end
end)

Citizen.CreateThread(function() --Fast Run
	while true do
		Citizen.Wait(0)
		if allowed then
			SetPedMoveRateOverride(GetPlayerPed(-1), Run)
			if Run > 1.49 then
				SetRunSprintMultiplierForPlayer(PlayerId(), 1.49)
			else
				SetRunSprintMultiplierForPlayer(PlayerId(), Run)
			end
		end
	end
end)

Citizen.CreateThread(function() --Fast Swim
	while true do
		Citizen.Wait(0)
		if allowed then
			if Swim > 1.49 then
				SetSwimMultiplierForPlayer(PlayerId(), 1.49)
			else
				SetSwimMultiplierForPlayer(PlayerId(), Swim)
			end
		end
	end
end)

Citizen.CreateThread(function() --Enable Super Jump
	while true do
		Citizen.Wait(0)
		if superjump and allowed then
			SetSuperJumpThisFrame(PlayerId())
		end
	end
end)

Citizen.CreateThread(function() --Superman Mode
	while true do
		Wait(1)
		
		local coords = Citizen.InvokeNative(0x0A794A5A57F8DF91, GetPlayerPed(-1), Citizen.ResultAsVector())
		local SupermanZ
		if IsControlPressed(1, 33) then
			SupermanZ = 5.0
		else
			SupermanZ = 0.225
		end
		
		if supermanmode and allowed then
			GiveWeaponToPed(GetPlayerPed(-1), GetHashKey("gadget_parachute"), 1, false, false)
			if IsPedInParachuteFreeFall(GetPlayerPed(-1)) then
				ApplyForceToEntity(GetPlayerPed(-1), 1, coords.x * 2, coords.y * 2, SupermanZ, 0.0, 0.0, 0.0, 1, false, true, true, true, true)
			end
		end
	end
end)

Citizen.CreateThread(function() --Making Some Animals Visible
	while true do
		Citizen.Wait(0)

		if (IsPedHuman(GetPlayerPed(-1)) == false) and allowed then
			SetPedComponentVariation(GetPlayerPed(-1), 0, 0, 0, 0)
		end
	end
end)

Citizen.CreateThread(function() --Making MP Character Visible
	while true do
		Citizen.Wait(0)

		if mChar and allowed then
			SetPedHeadBlendData(GetPlayerPed(-1), 4, 4, 0, 4, 4, 0, 1.0, 1.0, 0.0, false)
			SetPedComponentVariation(GetPlayerPed(-1), 2, 2, 4, 0)
			SetPedComponentVariation(GetPlayerPed(-1), 3, 1, 0, 0)
			SetPedComponentVariation(GetPlayerPed(-1), 4, 33, 0, 0)
			SetPedComponentVariation(GetPlayerPed(-1), 5, 45, 0, 0)
			SetPedComponentVariation(GetPlayerPed(-1), 6, 25, 0, 0)
			SetPedComponentVariation(GetPlayerPed(-1), 8, 56, 1, 0)
			SetPedComponentVariation(GetPlayerPed(-1), 11, 49, 0, 0)
			mChar = false
		elseif fChar and allowed then
			SetPedHeadBlendData(GetPlayerPed(-1), 25, 25, 0, 25, 25, 0, 1.0, 1.0, 0.0, false)
			SetPedComponentVariation(GetPlayerPed(-1), 2, 13, 3, 0)
			SetPedComponentVariation(GetPlayerPed(-1), 3, 3, 0, 0)
			SetPedComponentVariation(GetPlayerPed(-1))
			SetPedComponentVariation(GetPlayerPed(-1), 5, 45, 0, 0)
			SetPedComponentVariation(GetPlayerPed(-1), 6, 25, 0, 0)
			SetPedComponentVariation(GetPlayerPed(-1), 8, 33, 1, 0)
			SetPedComponentVariation(GetPlayerPed(-1), 11, 42, 0, 0)
			fChar = false
		end
	end
end)

Citizen.CreateThread(function() --Change Ped By Name
	while true do
		Citizen.Wait(0)
		if changePedByName then
			local result = KeyboardInput(PedModelKeyboardMessage .. ":", "", 25, false)
			
			if result ~= nil then
				skin = GetHashKey(string.upper(result))
			else
				drawNotification("~r~" .. ChangingByNameAbortedMessage .. "!")
			end
			changePedByName = false
		end
	end
end)

AddEventHandler("GotAddOnPeds", function(AddOnPeds)
	for i = 1, 60 do
		AddOnPedsTable[i] = nil
	end
	
	local AddOnPedsSplitted = stringsplit(AddOnPeds, "\n")
	
	for i = 1, tablelength(AddOnPedsSplitted) do
		local Splitted = stringsplit(AddOnPedsSplitted[i], ",")
		if Splitted[1] ~= "SpawnName" and Splitted[2] ~= "DisplayName" then
			table.insert(AddOnPedsTable, {Splitted[1], Splitted[2]})
		end
	end
end)

