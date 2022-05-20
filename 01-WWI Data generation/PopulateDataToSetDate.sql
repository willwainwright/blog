CREATE PROCEDURE [DataLoadSimulation].[PopulateDataToSetDate]
@AverageNumberOfCustomerOrdersPerDay int,
@SaturdayPercentageOfNormalWorkDay int,
@SundayPercentageOfNormalWorkDay int,
@IsSilentMode bit,
@AreDatesPrinted bit,
@EndingDate date,
@DeactivateTables bit =1,
@ApplyLoadProcs bit =1
AS
BEGIN
    SET NOCOUNT ON;

    DECLARE @CurrentMaximumDate date = COALESCE((SELECT MAX(CAST(ValidFrom AS DATE)) FROM [Warehouse].[ColdRoomTemperatures]), '20121231');
    DECLARE @StartingDate date = DATEADD(day, 1, @CurrentMaximumDate);

    IF @CurrentMaximumDate >= @EndingDate
    BEGIN
        THROW 0001, 'Date already loaded.', 1; 
    END

    IF EXISTS (SELECT * FROM DataLoadSimulation.Logging WHERE DateLoaded = @EndingDate)
    BEGIN
        THROW 0002, 'Date already loaded.', 1; 
    END

    IF @ApplyLoadProcs = 1 
    BEGIN
	    EXEC DataLoadSimulation.Configuration_ApplyDataLoadSimulationProcedures @DeactivateTables;
    END 
    
    EXEC DataLoadSimulation.DailyProcessToCreateHistory
        @StartDate = @StartingDate,
        @EndDate = @EndingDate,
        @AverageNumberOfCustomerOrdersPerDay = @AverageNumberOfCustomerOrdersPerDay,
        @SaturdayPercentageOfNormalWorkDay = @SaturdayPercentageOfNormalWorkDay,
        @SundayPercentageOfNormalWorkDay = @SundayPercentageOfNormalWorkDay,
        @UpdateCustomFields = 0, -- they were done in the initial load
        @IsSilentMode = @IsSilentMode,
        @AreDatesPrinted = @AreDatesPrinted,
        @DeactivateTables = @DeactivateTables,
        @UseCustomVersion = 1;

    IF @ApplyLoadProcs = 1 
    BEGIN
    	EXEC DataLoadSimulation.Configuration_RemoveDataLoadSimulationProcedures;
    END
END;
GO
