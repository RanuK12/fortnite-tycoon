# Sistema de eventos del juego

using { /Verse.org/Simulation }

# Bus de eventos tipados para comunicación desacoplada entre sistemas

# Evento: se colocó un edificio
OnBuildingPlaced := class(message):
    Player: player
    BuildingId: string
    Position: vector3
    TeamIndex: int

# Evento: se mejoró un edificio
OnBuildingUpgraded := class(message):
    Player: player
    BuildingId: string
    NewLevel: int

# Evento: se recolectaron recursos
OnResourcesGained := class(message):
    Player: player
    Gold: int
    Wood: int
    Stone: int
    Source: string  # "building", "event", "daily", etc.

# Evento: cambió el oro del jugador
OnGoldChanged := class(message):
    Player: player
    OldAmount: int
    NewAmount: int

# Evento: subió de nivel
OnLevelUp := class(message):
    Player: player
    NewLevel: int
    Prestige: int

# Evento: evento dinámico activado
OnDynamicEventStarted := class(message):
    EventId: string
    Duration: float
    AffectedPlayers: array<player>

# Evento: evento dinámico terminado
OnDynamicEventEnded := class(message):
    EventId: string
    AffectedPlayers: array<player>

# Evento: jugador se unió
OnPlayerJoined := class(message):
    Player: player
    IsReturning: bool

# Evento: jugador salió
OnPlayerLeft := class(message):
    Player: player