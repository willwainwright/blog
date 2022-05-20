# Wide world Importers data generation

This folder is for the following blog post xxx.

It contains the files that have been edited and vary from the official Microsoft code.

### PopulateDataToSetDate
New stored procedure designed to only load a set number of days at once.

Usage example:
```
EXECUTE DataLoadSimulation.PopulateDataToSetDate
        @AverageNumberOfCustomerOrdersPerDay = 60,
        @SaturdayPercentageOfNormalWorkDay = 50,
        @SundayPercentageOfNormalWorkDay = 0,
        @IsSilentMode = 1,
        @AreDatesPrinted = 1,
        @EndingDate = '2016-07-02';
```

### Configuration_ApplyDataLoadSimulationProcedures
Updated with new objects and changes to the daily history load stored procedure.

### Configuration_RemoveDataLoadSimulationProcedures
Added two new objects to the drop list