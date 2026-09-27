# Sistema de guardado y carga

using { /Fortnite.com/Devices }
using { /Verse.org/Simulation }
using { /UnrealEngine.com/Temporary/SpatialMath }

# Wrapper sobre SaveGame/LoadGame de UEFN para datos persistibles

save_system := class():
    # Guarda los datos de un jugador
    SavePlayerData(PlayerData: player_data, Player: player) : void =
        if (SaveGame[PlayerData](Player)) then:
            Log("Datos guardados para jugador: {Player}")
        else:
            Log("Error guardando datos para: {Player}")

    # Carga los datos de un jugador
    LoadPlayerData(Player: player) : ?player_data =
        if (LoadedData := LoadGame[player_data](Player)) then:
            Log("Datos cargados para jugador: {Player}")
            LoadedData
        else:
            Log("No hay datos previos para: {Player}, creando nuevos")
            player_data{}

    # Guarda datos de todos los jugadores en el equipo
    SaveAllPlayers(Players: array<player>, PlayerDataMap: map<player, player_data>) : void =
        for (Player : Players):
            if (Data := PlayerDataMap[Player]) then:
                SavePlayerData(Data, Player)

    # Carga datos de todos los jugadores
    LoadAllPlayers(Players: array<player>) : map<player, player_data> =
        var Result: map<player, player_data> = map{}
        for (Player : Players):
            if (Data := LoadPlayerData(Player)) then:
                Result[Player] = Data
            else:
                Result[Player] = player_data{}
        Result

    # Borra datos de un jugador (para reset/prestige)
    DeletePlayerData(Player: player) : void =
        if (DeleteGame[player_data](Player)) then:
            Log("Datos borrados para: {Player}")
        else:
            Log("Error borrando datos para: {Player}")