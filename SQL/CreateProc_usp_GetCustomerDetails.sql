-- ============================================================
-- Stored Procedure: usp_GetCustomerDetails
-- Description: Returns customer details for the most recent
--              interaction matching the supplied Account No.
--              or RMN (Registered Mobile Number).
-- ============================================================

IF OBJECT_ID('dbo.usp_GetCustomerDetails', 'P') IS NOT NULL
    DROP PROCEDURE [dbo].[usp_GetCustomerDetails];
GO

CREATE PROCEDURE [dbo].[usp_GetCustomerDetails]
    @SearchTerm NVARCHAR(50)    -- Account No. or RMN
AS
BEGIN
    SET NOCOUNT ON;

    SELECT TOP 1
        [CustomerName],
        [CustomerRMN],
        [SolId],
        [CustomerEmail],
        [BranchName],
        [CallerAccountNo]
    FROM  [dbo].[SalesCRMInteractions]
    WHERE [CallerAccountNo] = @SearchTerm
       OR [CustomerRMN]     = @SearchTerm
    ORDER BY [CreatedAt] DESC;
END;
GO
