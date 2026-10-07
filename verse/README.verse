// Example modular Verse code for Fortnite Tycoon map
// This file demonstrates how to split your Verse logic into reusable modules.

// spawn_point.verse
// Defines a simple spawn point device that can be placed in the level.
SpawnPoint := class():
    // Called when the device is spawned in the level
    OnBegin<override>()<suspends>:void=
    {
        Print("SpawnPoint initialized at location: {Location}")
    }

// resource_node.verse
// Represents a resource node that players can interact with to gather resources.
ResourceNode := class():
    // Amount of resources this node holds
    Resources:int = 100
    
    // Called when a player interacts with the node
    OnInteract<override>()<suspends>:void=
    {
        if (Resources > 0):
        {
            Resources := Resources - 10
            Print("Player gathered 10 resources. Remaining: {Resources}")
        }
        else
        {
            Print("Resource node is depleted.")
        }
    }

// Example usage in a main Verse script:
// Import the modules (if they were in separate files)
// import /verse/spawn_point.verse
// import /verse/resource_node.verse
//
// Then you could place instances in the level:
// var MySpawnPoint:SpawnPoint = SpawnPoint{}
// var MyResourceNode:ResourceNode = ResourceNode{}
