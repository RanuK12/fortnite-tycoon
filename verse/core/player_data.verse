# Datos del jugador (persistibles)

player_data := class(persistable):
    # --- Recursos ---
    gold: int := 0
    wood: int := 0
    stone: int := 0

    # --- Progresión ---
    level: int := 1
    xp: int := 0
    prestige: int := 0

    # --- Edificios ---
    # Diccionario: edificio_id -> cantidad construida
    buildings: map<string, int> := {}

    # --- Inventario ---
    # Lista de objetos consumibles o especiales
    inventory: array<int> := []

    # --- Métodos de ayuda ---
    CanAfford(cost_gold: int, cost_wood: int, cost_stone: int) -> bool:
        return gold >= cost_gold and wood >= cost_wood and stone >= cost_stone

    SpendResources(cost_gold: int, cost_wood: int, cost_stone: int) -> void:
        gold -= cost_gold
        wood -= cost_wood
        stone -= cost_stone

    AddResources(gain_gold: int, gain_wood: int, gain_stone: int) -> void:
        gold += gain_gold
        wood += gain_wood
        stone += gain_stone

    AddXP(amount: int) -> void:
        xp += amount
        # Lógica de level up simple (puede ir en progression_system)
        while xp >= XpForLevel(level + 1):
            level += 1
            # Aquí podrías dar puntos de habilidad, desbloqueos, etc.

    XpForLevel(target_level: int) -> int:
        # Fórmula simple: 100 * nivel^1.5
        return 100 * pow(target_level as float, 1.5) as int