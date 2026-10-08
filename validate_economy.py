import sys
import os
file_path = "verse/core/economy_system.verse"
if not os.path.exists(file_path):
    print(f"ERROR: File {file_path} does not exist")
    sys.exit(1)
with open(file_path, 'r') as f:
    content = f.read()
# Check for class definition
if "economy_system := class:" not in content:
    print("ERROR: Missing economy_system class definition")
    sys.exit(1)
# Check for StartingCurrency
if "StartingCurrency<public>:float" not in content:
    print("ERROR: Missing StartingCurrency")
    sys.exit(1)
# Check for Currency with replicates
if "Currency<public><replicates>:float" not in content:
    print("ERROR: Missing Currency with replicates")
    sys.exit(1)
# Check for IncomePerSecond
if "IncomePerSecond<public>:float" not in content:
    print("ERROR: Missing IncomePerSecond")
    sys.exit(1)
# Check for OnBegin method
if "OnBegin<override>()" not in content:
    print("ERROR: Missing OnBegin method")
    sys.exit(1)
# Check for Timer.StartRepeating
if "Timer.StartRepeating" not in content:
    print("ERROR: Missing Timer.StartRepeating")
    sys.exit(1)
# Check for AddIncome method
if "AddIncome<private>()" not in content:
    print("ERROR: Missing AddIncome method")
    sys.exit(1)
# Check for TryPurchase method
if "TryPurchase<public>(Cost:float)" not in content:
    print("ERROR: Missing TryPurchase method")
    sys.exit(1)
# Check for UpgradeIncome method
if "UpgradeIncome<public>(Amount:float)" not in content:
    print("ERROR: Missing UpgradeIncome method")
    sys.exit(1)
print("SUCCESS: Economy system verse file contains all expected components")
