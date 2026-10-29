using { /Fortnite.com/Devices }
using { /Verse.org/Simulation }

// Event types with strong typing
game_event_type := enum:
    OnBuildingPlaced
    OnResourceGained
    OnPlayerLevelUp
    OnGameStateChanged
    OnQuestCompleted
    OnItemPurchased

// Event data structures
building_placement_data := struct:
    building_type : string
    position : vector
    player_id : string
    cost : int

resource_data := struct:
    resource_type : string
    amount : int
    player_id : string

level_up_data := struct:
    player_id : string
    old_level : int
    new_level : int
    experience_gained : int

game_state_data := struct:
    state : string  // "menu", "playing", "paused", "game_over"
    timestamp : time

quest_data := struct:
    quest_id : string
    player_id : string
    rewards : list<string>

item_purchase_data := struct:
    item_id : string
    player_id : string
    price : int

// Generic event structure
game_event := struct:
    type : game_event_type
    data : variant
    timestamp : time
    player_id : string

// Event bus for managing subscriptions and emissions
event_bus := class:
    private subscribers : map<game_event_type, list<game_event -> void>>
    
    __init__() : void =
        self.subscribers = new_map()
    
    // Subscribe to event type
    subscribe(event_type : game_event_type, callback : game_event -> void) : void =
        if self.subscribers[event_type] == nil:
            self.subscribers[event_type] = new_list()
        self.subscribers[event_type].append(callback)
    
    // Unsubscribe from event type
    unsubscribe(event_type : game_event_type, callback : game_event -> void) : void =
        if self.subscribers[event_type] != nil:
            self.subscribers[event_type].remove(callback)
    
    // Emit event to all subscribers
    emit(event : game_event) : void =
        Log("Event emitted: " + event.type.string())
        
        // Notify specific type subscribers
        if self.subscribers[event.type] != nil:
            for callback in self.subscribers[event.type]:
                try:
                    callback(event)
                except:
                    Log("Error in event callback: " + exception.message)
        
        // Notify global subscribers (if implemented later)
        // self.emit_to_global_subscribers(event)
    
    // Emit typed event helper
    emit_typed(event_type : game_event_type, data : variant, player_id : string) : void =
        event := game_event:
            type = event_type
            data = data
            timestamp = current_time()
            player_id = player_id
        
        self.emit(event)

// Global event bus instance
global_event_bus := event_bus()

// Event emission helpers
emit_building_placed(building_type : string, position : vector, player_id : string, cost : int) : void =
    data := building_placement_data:
        building_type = building_type
        position = position
        player_id = player_id
        cost = cost
    
    global_event_bus.emit_typed(game_event_type.OnBuildingPlaced, data, player_id)

emit_resource_gained(resource_type : string, amount : int, player_id : string) : void =
    data := resource_data:
        resource_type = resource_type
        amount = amount
        player_id = player_id
    
    global_event_bus.emit_typed(game_event_type.OnResourceGained, data, player_id)

emit_player_level_up(player_id : string, old_level : int, new_level : int, experience_gained : int) : void =
    data := level_up_data:
        player_id = player_id
        old_level = old_level
        new_level = new_level
        experience_gained = experience_gained
    
    global_event_bus.emit_typed(game_event_type.OnPlayerLevelUp, data, player_id)

emit_game_state_changed(state : string, player_id : string) : void =
    data := game_state_data:
        state = state
        timestamp = current_time()
    
    global_event_bus.emit_typed(game_event_type.OnGameStateChanged, data, player_id)

emit_quest_completed(quest_id : string, player_id : string, rewards : list<string>) : void =
    data := quest_data:
        quest_id = quest_id
        player_id = player_id
        rewards = rewards
    
    global_event_bus.emit_typed(game_event_type.OnQuestCompleted, data, player_id)

emit_item_purchased(item_id : string, player_id : string, price : int) : void =
    data := item_purchase_data:
        item_id = item_id
        player_id = player_id
        price = price
    
    global_event_bus.emit_typed(game_event_type.OnItemPurchased, data, player_id)

// Utility functions for event handling
create_event_callback(event_type : game_event_type, handler : variant -> void) : game_event -> void =
    return (event : game_event) =>:
        handler(event.data)

// Example usage and testing
__test__ := () => void =
    // Test event emission
    test_callback := (data : variant) => void =
        Log("Test event received: " + data.string())
    
    global_event_bus.subscribe(game_event_type.OnResourceGained, create_event_callback(game_event_type.OnResourceGained, test_callback))
    
    // Emit test event
    emit_resource_gained("gold", 100, "player_1")
    
    // Verify event was processed
    Log("Event system test completed")