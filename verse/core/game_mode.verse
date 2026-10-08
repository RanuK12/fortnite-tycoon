using { /Fortnite.com/Devices }
using { /Verse.org/Simulation }

tycoon_game_mode := class(creative_game_mode):
	OnBegin<override>() : void =
		Log("Tycoon GameMode iniciado")
		# Spawn inicial, configuración de equipos, etc.