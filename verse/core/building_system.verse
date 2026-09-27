# Sistema de edificios para el juego

using { /Verse.org/Simulation }
using { /Fortnite.com/Devices }

# Definición de tipos de edificios y sus propiedades
building_type := class(persistable):
    Id: string
    Name: string
    Description: string
    Cost: map<string, int>  # { "Gold": 100, "Wood": 50, "Stone": 30 }
    Production: map<string, int>  # { "Gold": 1, "Wood": 0, "Stone": 0 }
    MaxLevel: int
    LevelUpCost: map<string, int>  # { "Gold": 50, "Wood": 25, "Stone": 15 }
    BuildTime: float
    UpgradeTime: float
    TeamIndex: int
    
    # Ejemplo de edificio
    Barracks := building_type{
        Id: "barracks",
        Name: "Barracks",
        Description: "Entrenamiento para soldados",
        Cost: { "Gold": 100, "Wood": 50, "Stone": 30 },
        Production: { "Gold": 1, "Wood": 0, "Stone": 0 },
        MaxLevel: 5,
        LevelUpCost: { "Gold": 50, "Wood": 25, "Stone": 15 },
        BuildTime: 30.0,
        UpgradeTime: 15.0,
        TeamIndex: 0
    }
    
    Farm := building_type{
        Id: "farm",
        Name: "Farm",
        Description: "Recolección de recursos",
        Cost: { "Gold": 80, "Wood": 30, "Stone": 20 },
        Production: { "Gold": 0, "Wood": 2, "Stone": 0 },
        MaxLevel: 4,
        LevelUpCost: { "Gold": 40, "Wood": 15, "Stone": 10 },
        BuildTime: 25.0,
        UpgradeTime: 10.0,
        TeamIndex: 0
    }
    
    Mine := building_type{
        Id: "mine",
        Name: "Mine",
        Description: "Extracción de minerales",
        Cost: { "Gold": 120, "Wood": 40, "Stone": 60 },
        Production: { "Gold": 0, "Wood": 0, "Stone": 3 },
        MaxLevel: 5,
        LevelUpCost: { "Gold": 60, "Wood": 30, "Stone": 30 },
        BuildTime: 40.0,
        UpgradeTime: 20.0,
        TeamIndex: 0
    }
    
    Wall := building_type{
        Id: "wall",
        Name: "Wall",
        Description: "Protección del territorio",
        Cost: { "Gold": 200, "Wood": 100, "Stone": 100 },
        Production: { "Gold": 0, "Wood": 0, "Stone": 0 },
        MaxLevel: 3,
        LevelUpCost: { "Gold": 100, "Wood": 50, "Stone": 50 },
        BuildTime: 60.0,
        UpgradeTime: 30.0,
        TeamIndex: 0
    }

# Estado de un edificio en el juego
building := class(persistable):
    Id: string
    Player: player
    Type: building_type
    Level: int
    Position: vector3
    TeamIndex: int
    BuiltAt: float
    UpgradedAt: ?float
    IsActive: bool

# Sistema de gestión de edificios
building_system := class():
    # Registra los tipos de edificios disponibles
    RegisterBuildingTypes(Buildings: array<building_type>) : void =
        for (Building : Buildings):
            Log("Registrado edificio: {Building.Name}")

    # Crea un nuevo edificio
    CreateBuilding(Player: player, BuildingType: building_type, Position: vector3, TeamIndex: int) : building =
        var NewBuilding: building = building{
            Id: GenerateBuildingId(),
            Player: Player,
            Type: BuildingType,
            Level: 1,
            Position: Position,
            TeamIndex: TeamIndex,
            BuiltAt: CurrentTime(),
            IsActive: true
        }
        Emit(OnBuildingPlaced(Player, NewBuilding.Id, Position, TeamIndex))
        NewBuilding

    # Verifica si el jugador puede construir/upgradear un edificio
    CanBuildUpgrade(Player: player, BuildingType: building_type, Building: ?building, Level: int) : bool =
        var Cost: map<string, int> = 
            if (Building) then Building.Type.LevelUpCost[Level] 
            else BuildingType.Cost
        
        var PlayerResources: map<string, int> = GetPlayerResources(Player)
        
        for (Resource, Amount) : Cost:
            if (PlayerResources[Resource] < Amount) then:
                return false
        
        true

    # Actualiza la producción de edificios activos
    UpdateProduction() : void =
        var ActiveBuildings: array<building> = GetActiveBuildings()
        for (Building : ActiveBuildings):
            var Resources: map<string, int> = Building.Type.Production
            for (Resource, Amount) : Resources:
                AddPlayerResource(Building.Player, Resource, Amount)

    # Genera un ID único para edificios
    GenerateBuildingId() : string =
        "bld_" + CurrentTime().ToString().Replace("-", "_").Replace(":", "_") + "_" + RandomInt(10000)

    # Obtiene todos los edificios activos de un jugador
    GetPlayerBuildings(Player: player) : array<building> =
        var AllBuildings: array<building> = GetAllBuildings()
        filter (Building : AllBuildings, Building.Player == Player && Building.IsActive)

    # Obtiene todos los edificios activos del equipo
    GetTeamBuildings(TeamIndex: int) : array<building> =
        var AllBuildings: array<building> = GetAllBuildings()
        filter (Building : AllBuildings, Building.TeamIndex == TeamIndex && Building.IsActive)

    # Obtiene recursos de un jugador
    GetPlayerResources(Player: player) : map<string, int> =
        var PlayerData: player_data = LoadPlayerData(Player)
        PlayerData.Resources

    # Añade recursos a un jugador
    AddPlayerResource(Player: player, Resource: string, Amount: int) : void =
        var PlayerData: player_data = LoadPlayerData(Player)
        PlayerData.Resources[Resource] += Amount
        SavePlayerData(PlayerData, Player)