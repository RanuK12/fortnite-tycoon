# Utilidades de gestión de recursos para el Tycoon
# Proporciona funciones auxiliares para manejar recursos de forma consistente

using { /Verse.org/Simulation }
using { /Fortnite.com/Devices }

# Tipos de recursos disponibles en el juego
resource_type := enum:
    Gold
    Wood
    Stone

# Convierte resource_type a string
ResourceToString(Resource: resource_type) : string =
    match Resource:
        resource_type.Gold => "Gold"
        resource_type.Wood => "Wood"
        resource_type.Stone => "Stone"

# Convierte string a resource_type
StringToResource(Name: string) : ?resource_type =
    match Name:
        "Gold" => option{resource_type.Gold}
        "Wood" => option{resource_type.Wood}
        "Stone" => option{resource_type.Stone}
        _ => false

# Mapa de recursos con valores por defecto
default_resources : map<string, int> = {
    "Gold": 0,
    "Wood": 0,
    "Stone": 0
}

# Suma dos mapas de recursos
AddResources(Resources1: map<string, int>, Resources2: map<string, int>) : map<string, int> =
    var Result: map<string, int> = {}
    for (Key, Value) : Resources1:
        Result[Key] = Value
    for (Key, Value) : Resources2:
        if (Result.HasKey(Key)) then:
            Result[Key] += Value
        else:
            Result[Key] = Value
    Result

# Resta recursos (verifica que haya suficientes)
SubtractResources(Resources1: map<string, int>, Resources2: map<string, int>) : ?map<string, int> =
    var Result: map<string, int> = {}
    for (Key, Value) : Resources1:
        Result[Key] = Value
    for (Key, Amount) : Resources2:
        if (Result.HasKey(Key) && Result[Key] >= Amount) then:
            Result[Key] -= Amount
        else:
            return false
    Result

# Verifica si se pueden pagar los costos
CanAfford(Current: map<string, int>, Cost: map<string, int>) : bool =
    for (Resource, Amount) : Cost:
        if (Current[Resource] < Amount) then:
            return false
    true

# Formatea recursos para UI
FormatResources(Resources: map<string, int>) : string =
    var Parts: array<string> = {}
    for (Resource, Amount) : Resources:
        Parts += ["{Resource}: {Amount}"]
    string.Join(", ", Parts)

# Calcula costo de nivel con multiplicador
CalculateLevelCost(BaseCost: map<string, int>, Level: int, Multiplier: float) : map<string, int> =
    var Result: map<string, int> = {}
    for (Resource, Amount) : BaseCost:
        Result[Resource] = floor(Amount * (Multiplier ^ (Level - 1)))
    Result

# Evento para cambios de recursos
OnResourcesChanged(Player: player, Resources: map<string, int>) : event