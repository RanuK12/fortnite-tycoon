using { /Fortnite.com/Devices }
using { /Verse.org/Simulation }

# Economy system for the tycoon game
# Manages currency, income, expenses, and purchases
economy_system := class:
	# Starting balance for new players
	StartingCurrency<public>:float = 1000.0
	
	# Current currency amount (replicated to clients)
	Currency<public><replicates>:float = StartingCurrency
	
	# Income per second (can be upgraded)
	IncomePerSecond<public>:float = 10.0
	
	OnBegin<override>() : void =
		# Start income timer
		Timer.StartRepeating(IncomeTimerHandle, 1.0, , AddIncome)
	
	AddIncome<private>() : void =
		Currency := Currency + IncomePerSecond
	
	# Purchase an item if player has enough currency
	TryPurchase<public>(Cost:float) : logic =
		if (Currency >= Cost):
			Currency := Currency - Cost
			return true
		else:
			return false
	
	# Upgrade income per second
	UpgradeIncome<public>(Amount:float) : void =
		IncomePerSecond := IncomePerSecond + Amount
