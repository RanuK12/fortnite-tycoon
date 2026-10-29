using { /Fortnite.com/Devices }
using { /Verse.org/Simulation }
using "./game_events.verse"

// Test suite for event system
test_event_system := () => void =
    Log("Starting event system tests...")
    
    // Track received events
    received_events := new_list()
    
    // Create test callback
    test_callback := (event : game_event) => void =
        received_events.append(event)
        Log("Event received: " + event.type.string() + " for player: " + event.player_id)
    
    // Subscribe to all event types
    for event_type in game_event_type.values():
        global_event_bus.subscribe(event_type, test_callback)
    
    // Test building placement event
    emit_building_placed("generator", vector(100, 200, 0), "player_1", 500)
    
    // Test resource gain event
    emit_resource_gained("gold", 250, "player_1")
    emit_resource_gained("wood", 100, "player_2")
    
    // Test level up event
    emit_player_level_up("player_1", 1, 2, 100)
    
    // Test game state change event
    emit_game_state_changed("playing", "player_1")
    
    // Verify events were received
    expected_events := 4
    if received_events.count() == expected_events:
        Log("✅ All events received successfully (" + received_events.count().string() + "/" + expected_events.string() + ")")
        
        // Verify specific event types
        building_events := received_events.filter((e) => e.type == game_event_type.OnBuildingPlaced)
        resource_events := received_events.filter((e) => e.type == game_event_type.OnResourceGained)
        level_events := received_events.filter((e) => e.type == game_event_type.OnPlayerLevelUp)
        state_events := received_events.filter((e) => e.type == game_event_type.OnGameStateChanged)
        
        Log("Building events: " + building_events.count().string())
        Log("Resource events: " + resource_events.count().string())
        Log("Level events: " + level_events.count().string())
        Log("State events: " + state_events.count().string())
        
        // Test data structures
        if building_events.count() > 0:
            building_data := building_events[0].data as building_placement_data
            Log("Building type: " + building_data.building_type)
            Log("Position: " + building_data.position.string())
        
        if resource_events.count() > 0:
            resource_data := resource_events[0].data as resource_data
            Log("Resource type: " + resource_data.resource_type)
            Log("Amount: " + resource_data.amount.string())
        
        if level_events.count() > 0:
            level_data := level_events[0].data as level_up_data
            Log("Level up: " + level_data.old_level.string() + " -> " + level_data.new_level.string())
        
        if state_events.count() > 0:
            state_data := state_events[0].data as game_state_data
            Log("Game state: " + state_data.state)
        
        Log("✅ All tests passed!")
    else:
        Log("❌ Event test failed: expected " + expected_events.string() + " events, got " + received_events.count().string())
    
    Log("Event system tests completed")

// Run tests if this file is executed directly
if __name__ == "__main__":
    test_event_system()