-- ============================================================
-- Table: SalesCRMInteractions
-- Description: Stores each Sales CRM agent interaction record.
--
-- Run this script once against the IBRMnerWeb database.
-- ============================================================

IF OBJECT_ID('dbo.SalesCRMInteractions', 'U') IS NULL
BEGIN
    CREATE TABLE [dbo].[SalesCRMInteractions]
    (
        [Id]                 INT            IDENTITY(1,1) NOT NULL,

        -- CTI fields (populated from query-string parameters)
        [UCID]               NVARCHAR(50)   NULL,
        [Language]           NVARCHAR(50)   NULL,
        [CallerAccountNo]    NVARCHAR(50)   NULL,
        [CustId]             NVARCHAR(50)   NULL,
        [CallerANI]          NVARCHAR(20)   NULL,
        [RMNFlag]            NVARCHAR(10)   NULL,
        [SkillSet]           NVARCHAR(100)  NULL,
        [ExistingCustomer]   NVARCHAR(10)   NULL,
        [IVRLastNodes]       NVARCHAR(200)  NULL,

        -- Customer details (populated from customer search)
        [CustomerName]       NVARCHAR(200)  NULL,
        [CustomerRMN]        NVARCHAR(20)   NULL,
        [SolId]              NVARCHAR(50)   NULL,
        [CustomerEmail]      NVARCHAR(200)  NULL,
        [BranchName]         NVARCHAR(200)  NULL,

        -- Data Capture form fields
        [Product]            NVARCHAR(100)  NULL,
        [SubProduct]         NVARCHAR(100)  NULL,
        [DataCustName]       NVARCHAR(200)  NULL,
        [DataEmail]          NVARCHAR(200)  NULL,
        [AlternateContactNo] NVARCHAR(20)   NULL,
        [Disposition]        NVARCHAR(100)  NULL,
        [SubDisposition]     NVARCHAR(100)  NULL,
        [DemandedAmount]     NVARCHAR(50)   NULL,
        [AppointmentDate]    DATE           NULL,
        [AppointmentTime]    NVARCHAR(10)   NULL,
        [BranchSMSDept]      NVARCHAR(100)  NULL,
        [SelectField]        NVARCHAR(100)  NULL,
        [Address]            NVARCHAR(500)  NULL,
        [Remarks]            NVARCHAR(1000) NULL,

        -- Agent identity
        [AgentRoleName]      NVARCHAR(100)  NULL,
        [AgentTeamID]        NVARCHAR(50)   NULL,
        [AgentCreatedBy]     NVARCHAR(100)  NULL,

        [CreatedAt]          DATETIME       NOT NULL
            CONSTRAINT DF_SalesCRMInteractions_CreatedAt DEFAULT (GETDATE()),

        CONSTRAINT PK_SalesCRMInteractions PRIMARY KEY CLUSTERED ([Id] ASC)
    );
END
GO
