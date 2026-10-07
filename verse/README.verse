// Example: spawn_point.verse
spawn_point := class:
  // A simple spawn point for players
  SpawnLocation<transient> := vector3{Z}
  OnBegin<override>()<void>:
    Print("Spawn point initialized at: {SpawnLocation}")

// Example: resource_node.verse
resource_node := class:
  // A resource node that players can collect from
  ResourceAmount<transient> := 100
  OnInteract<override>()<void>:
    if (ResourceAmount > 0):
      ResourceAmount := ResourceAmount - 10
      Print("Collected 10 resources. Remaining: {ResourceAmount}")
    else:
      Print("Resource node is depleted.")