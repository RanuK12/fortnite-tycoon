# Fortnite‑Tycoon

Mapa Tycoon para Fortnite (UEFN/Verse) pensado para sesiones de 45 + minutos.

## Requisitos
- **Windows 10/11** con UEFN instalado (UEFN no funciona en macOS).
- Git para clonar el repositorio.
- GitHub CLI (`gh`) autenticado (opcional, solo para clonar).

## Estructura
- `verse/` – Código Verse modular.
- `verse/core/` – Sistemas principales del juego.
- `verse/utils/` – Utilidades y helpers.
- `docs/` – Documentación del proyecto.
- `design/` – Bocetos, diagramas y assets de diseño.

## Sistema de Eventos
El proyecto incluye un sistema de eventos modular (`game_events.verse`) que permite:

- **Eventos principales**: `OnBuildingPlaced`, `OnResourceGained`, `OnPlayerLevelUp`, `OnGameStateChanged`, `OnQuestCompleted`, `OnItemPurchased`
- **Tipado fuerte**: Estructuras de datos específicas para cada tipo de evento
- **EventBus central**: Gestiona suscripciones y emisiones de eventos
- **Modularidad**: Los sistemas pueden comunicarse sin acoplamiento directo

## Compilación
1. Abrir UEFN en Windows.
2. Importar el proyecto desde la carpeta raíz.
3. Ejecutar `Build` dentro de UEFN.