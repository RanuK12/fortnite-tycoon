# Fortnite‑Tycoon

Mapa Tycoon para Fortnite (UEFN/Verse) diseñado para **retener 45+ minutos por sesión**.

## Qué es

Un mapa tipo *tycoon* (simulación de negocio/construcción) construido 100% en **Verse** y **UEFN**. El jugador construye, gestiona recursos y expande su base mientras compite o colabora con otros. El bucle de juego está pensado para sesiones largas: progresión persistente, eventos dinámicos y metas a medio plazo que enganchan.

## Requisitos

- **UEFN** (Unreal Editor for Fortnite) instalado en **Windows 10/11**.
- **No funciona en macOS ni Linux** — UEFN solo corre en Windows.
- Cuenta de Epic Games con acceso a Fortnite Creative.

## Compilación y publicación

1. Abre UEFN.
2. `Archivo → Abrir proyecto` → selecciona `fortnite-tycoon.uproject` (en la raíz del repo).
3. Espera a que cargue el proyecto y compile los scripts Verse.
4. `Build → Publish` para generar el paquete y subirlo a Fortnite Creative.
5. Copia el **código de isla** que te da UEFN y compártelo.

## Estructura del repositorio

```
fortnite-tycoon/
├── fortnite-tycoon.uproject      # Archivo de proyecto UEFN
├── /verse                        # Código Verse modular (lógica de juego)
│   ├── core/                     # Sistemas base (jugador, datos, eventos)
│   ├── gameplay/                 # Mecánicas de tycoon (edificios, recursos, progresión)
│   ├── ui/                       # Widgets y HUD en Verse
│   └── utils/                    # Helpers y extensiones
├── /docs                         # Documentación y guías
│   ├── ARQUITECTURA.md           # Diseño técnico del código Verse
│   ├── GUIA_UEFN.md              # Pasos exactos en UEFN (windows-only)
│   └── GAMEPLAY.md               # Diseño de juego: bucles, retención, métricas
├── /design                       # Bocetos, diagramas, assets de diseño
│   ├── map_layout.drawio         # Layout de la isla
│   ├── economy.xlsx              # Balance de economía
│   └── wireframes/               # UI/UX wireframes
└── README.md                     # Este archivo
```

## Estado actual

**Paso 1 de 21** — Repo creado, estructura base y README. Siguiente: scaffolding de código Verse en `/verse/core` y `/verse/gameplay`.

## Licencia

MIT — libre para uso personal y comercial. Atribución apreciada.

---

*Proyecto de Ranuk IT Solutions · ranuk.dev · ranukorbit.com*