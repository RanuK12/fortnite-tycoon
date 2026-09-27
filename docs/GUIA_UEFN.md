# Guía UEFN — Pasos exactos (Windows only)

> **IMPORTANTE**: UEFN **solo corre en Windows 10/11**. No intentes abrir el proyecto en macOS/Linux — fallará la compilación de Verse.

## 1. Instalación previa

1. Instala **Epic Games Launcher** en Windows.
2. En la pestaña *Unreal Engine*, instala **UEFN** (versión más reciente).
3. Inicia UEFN al menos una vez para que configure shaders y cache.

## 2. Abrir el proyecto

1. Clona este repo en Windows: `git clone https://github.com/RanuK12/fortnite-tycoon.git`
2. En UEFN: `Archivo → Abrir proyecto` → navega a la carpeta del repo → selecciona `fortnite-tycoon.uproject`.
3. UEFN detectará que es un proyecto Verse y compilará los scripts. **Espera a que termine** (barra de progreso abajo a la derecha).

## 3. Estructura en el Content Browser

```
Content/
├── Verse/              # Scripts Verse (se sincroniza con /verse del repo)
├── Maps/               # Niveles (.umap)
├── UI/                 # Widgets UMG
├── Blueprints/         # Blueprints de actores
└── Data/               # DataTables, Curves, DataAssets
```

## 4. Crear el mapa base

1. `Archivo → Nuevo nivel` → *Open World* o *Basic*.
2. Guarda como `Content/Maps/TycoonMap.umap`.
3. En *World Settings* → *GameMode Override*: selecciona `TycoonGameMode` (se crea en paso 5).

## 5. GameMode y PlayerController (Verse)

En `/verse/core/game_mode.verse`:
```verse
using { /Fortnite.com/Devices }
using { /Verse.org/Simulation }

tycoon_game_mode := class(creative_game_mode):
    OnBegin<override>() : void =
        Log("Tycoon GameMode iniciado")
        # Spawn inicial, configuración de equipos, etc.
```

En UEFN: compila Verse → el GameMode aparece en *Class Viewer* → arrástralo a *World Settings*.

## 6. Compilar Verse

- Atajo: `Ctrl + Shift + B` (Build Verse).
- Ver *Output Log* para errores. Verse es estricto: **cero warnings** antes de publicar.

## 7. Test en editor

1. Botón **Play** (▶) en la toolbar.
2. Prueba movimiento, UI, interacciones.
3. `Shift + F1` para soltar el mouse y clickear widgets.

## 8. Publicar a Fortnite Creative

1. `Build → Publish` (o `Archivo → Publish`).
2. Rellena: *Título*, *Descripción*, *Categoría*, *Imagen portada* (1920x1080).
3. **Publicar** → UEFN sube el paquete y te da el **Código de Isla** (ej. `1234-5678-9012`).
4. Copia el código y compártelo. Los jugadores entran con *Código de Isla* en el menú Creative.

## 9. Actualizaciones

- Cambios en Verse → recompila → `Build → Publish` → nueva versión.
- El código de isla **no cambia**; los jugadores ven la versión más reciente al entrar.

## 10. Debugging tips

- `Log("mensaje")` en Verse → sale en *Output Log*.
- `Print("mensaje")` → aparece en pantalla en juego (solo en editor).
- Breakpoints en Verse: click en margen izquierdo del editor de código → Play → se detiene.
- `verse.diagnostics` en *Output Log* para ver errores de tipo.

## Problemas comunes

| Problema | Solución |
|----------|----------|
| "Verse compilation failed" | Revisa *Output Log*, suele ser typo o tipo incorrecto. |
| "Missing module" | Verifica que el archivo `.verse` esté en `Content/Verse/` y el nombre coincida. |
| "Publish stuck at 99%" | Cancela, cierra UEFN, reabre, reintenta. A veces hay que `Build → Clean`. |
| "Island code not working" | Espera 5-10 min tras publish (propagación CDN). |

## Recursos oficiales

- [Documentación UEFN](https://dev.epicgames.com/documentation/en-us/unreal-editor-for-fortnite)
- [Referencia Verse](https://dev.epicgames.com/documentation/en-us/verse)
- [Fortnite Creative Discord](https://discord.gg/fortnitecreative) — canal #verse-help