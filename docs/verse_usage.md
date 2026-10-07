# How to Use Verse Modules in Fortnite-Tycoon

This guide explains how to include and use the Verse modules provided in this repository.

## Including Modules

To use the `spawn_point` or `resource_node` classes in your own Verse scripts:

1. Copy the desired `.verse` file from the `verse/` directory into your UEFN project's Verse scripts folder.
2. Ensure the file is included in your Verse build (UEFN automatically compiles all `.verse` files in the project).

## Example Usage

### Spawn Point
Place a `spawn_point` device in your level to define where players spawn when they join the game or respawn.

```verse
spawn_point_instance := spawn_point{
    SpawnLocation := vector3{0.0, 0.0, 500.0}
}
```

### Resource Node
Place a `resource_node` device in your level to create collectible resources for players.

```verse
resource_node_instance := resource_node{
    ResourceAmount := 100
}
```

Players can interact with the node to collect resources, decreasing the `ResourceAmount` each time until it reaches zero.

## Best Practices

- Keep Verse scripts modular and focused on a single responsibility.
- Use descriptive names for devices and properties.
- Test your Verse code frequently in UEFN using the "Play" button.
- Refer to the official Verse documentation for more advanced features.

## Troubleshooting

- If a script fails to compile, check for syntax errors and ensure all required dependencies are present.
- Verify that the file is saved with a `.verse` extension and located in a directory UEFN scans for Verse files.