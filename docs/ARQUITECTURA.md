# Arquitectura del código Verse

## Principios

- **Modularidad**: cada sistema en su propio archivo/módulo.
- **Datos sobre código**: configuración en JSON/CSV, lógica genérica que lee datos.
- **Event-driven**: sistemas se comunican vía `message`/`event` (no acoplamiento directo).
- **Persistencia**: `persistable` en clases de datos de jugador.

## Módulos planeados

### `/verse/core`
- `player_data.verse` — datos persistibles del jugador (oro, nivel, edificios, inventario).
- `game_events.verse` — bus de eventos tipados (OnBuildingPlaced, OnResourceGained, etc).
- `save_system.verse` — wrapper sobre `SaveGame`/`LoadGame` de UEFN.
- `team_manager.verse` — gestión de equipos/cooperación.

### `/verse/gameplay`
- `building_system.verse` — colocación, mejora, producción de edificios.
- `resource_system.verse` — generación, recolección, almacenamiento de recursos.
- `progression_system.verse` — XP, niveles, desbloqueos, prestigio.
- `economy.verse` — precios, balance, inflación controlada.
- `events.verse` — eventos dinámicos (raids, mercado, weather).

### `/verse/ui`
- `hud.verse` — HUD principal (recursos, población, alertas).
- `build_menu.verse` — menú de construcción con categorías.
- `upgrade_panel.verse` — panel de mejoras de edificio.
- `leaderboard.verse` — ranking de jugadores/equipos.

### `/verse/utils`
- `math_ext.verse` — helpers matemáticos (lerp, clamp, easing).
- `array_ext.verse` — extensiones de array (shuffle, weighted_pick).
- `string_ext.verse` — formateo de números, tiempo, moneda.
- `debug.verse` — logging condicional y visualización en editor.

## Convenciones de naming

- Clases: `PascalCase` (`player_data`, `building_system`).
- Funciones/Variables: `snake_case` (`get_gold`, `max_level`).
- Constantes: `UPPER_SNAKE_CASE` (`MAX_BUILDINGS`, `BASE_GOLD_PER_SEC`).
- Eventos: `On` + `PascalCase` (`OnBuildingPlaced`, `OnResourceChanged`).

## Flujo de datos

```
Input (UI/Interacción)
    → Event (game_events)
    → Sistema correspondiente (gameplay)
    → Mutación de player_data (persistable)
    → SaveSystem persiste
    → UI reacciona a OnDataChanged
```