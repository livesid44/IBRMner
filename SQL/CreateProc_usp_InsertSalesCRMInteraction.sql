-- ============================================================
-- Stored Procedure: usp_InsertSalesCRMInteraction
-- Description: Inserts one Sales CRM interaction record and
--              returns the new primary key.
-- ============================================================

IF OBJECT_ID('dbo.usp_InsertSalesCRMInteraction', 'P') IS NOT NULL
    DROP PROCEDURE [dbo].[usp_InsertSalesCRMInteraction];
GO

CREATE PROCEDURE [dbo].[usp_InsertSalesCRMInteraction]
    -- CTI parameters
    @UCID               NVARCHAR(50),
    @Language           NVARCHAR(50),
    @CallerAccountNo    NVARCHAR(50),
    @CustId             NVARCHAR(50),
    @CallerANI          NVARCHAR(20),
    @RMNFlag            NVARCHAR(10),
    @SkillSet           NVARCHAR(100),
    @ExistingCustomer   NVARCHAR(10),
    @IVRLastNodes       NVARCHAR(200),

    -- Customer detail parameters
    @CustomerName       NVARCHAR(200),
    @CustomerRMN        NVARCHAR(20),
    @SolId              NVARCHAR(50),
    @CustomerEmail      NVARCHAR(200),
    @BranchName         NVARCHAR(200),

    -- Data Capture parameters
    @Product            NVARCHAR(100),
    @SubProduct         NVARCHAR(100),
    @DataCustName       NVARCHAR(200),
    @DataEmail          NVARCHAR(200),
    @AlternateContactNo NVARCHAR(20),
    @Disposition        NVARCHAR(100),
    @SubDisposition     NVARCHAR(100),
    @DemandedAmount     NVARCHAR(50),
    @AppointmentDate    DATE,
    @AppointmentTime    NVARCHAR(10),
    @BranchSMSDept      NVARCHAR(100),
    @SelectField        NVARCHAR(100),
    @Address            NVARCHAR(500),
    @Remarks            NVARCHAR(1000),

    -- Agent identity parameters
    @AgentRoleName      NVARCHAR(100),
    @AgentTeamID        NVARCHAR(50),
    @AgentCreatedBy     NVARCHAR(100)
AS
BEGIN
    SET NOCOUNT ON;

    INSERT INTO [dbo].[SalesCRMInteractions]
    (
        [UCID], [Language], [CallerAccountNo], [CustId], [CallerANI],
        [RMNFlag], [SkillSet], [ExistingCustomer], [IVRLastNodes],
        [CustomerName], [CustomerRMN], [SolId], [CustomerEmail], [BranchName],
        [Product], [SubProduct], [DataCustName], [DataEmail],
        [AlternateContactNo], [Disposition], [SubDisposition],
        [DemandedAmount], [AppointmentDate], [AppointmentTime],
        [BranchSMSDept], [SelectField], [Address], [Remarks],
        [AgentRoleName], [AgentTeamID], [AgentCreatedBy]
    )
    VALUES
    (
        @UCID, @Language, @CallerAccountNo, @CustId, @CallerANI,
        @RMNFlag, @SkillSet, @ExistingCustomer, @IVRLastNodes,
        @CustomerName, @CustomerRMN, @SolId, @CustomerEmail, @BranchName,
        @Product, @SubProduct, @DataCustName, @DataEmail,
        @AlternateContactNo, @Disposition, @SubDisposition,
        @DemandedAmount, @AppointmentDate, @AppointmentTime,
        @BranchSMSDept, @SelectField, @Address, @Remarks,
        @AgentRoleName, @AgentTeamID, @AgentCreatedBy
    );

    SELECT SCOPE_IDENTITY() AS NewId;
END;
GO
