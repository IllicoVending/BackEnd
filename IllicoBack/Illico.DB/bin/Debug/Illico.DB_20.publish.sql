/*
Script de déploiement pour IllicoDB

Ce code a été généré par un outil.
La modification de ce fichier peut provoquer un comportement incorrect et sera perdue si
le code est régénéré.
*/

GO
SET ANSI_NULLS, ANSI_PADDING, ANSI_WARNINGS, ARITHABORT, CONCAT_NULL_YIELDS_NULL, QUOTED_IDENTIFIER ON;

SET NUMERIC_ROUNDABORT OFF;


GO
:setvar DatabaseName "IllicoDB"
:setvar DefaultFilePrefix "IllicoDB"
:setvar DefaultDataPath "C:\Program Files\Microsoft SQL Server\MSSQL16.SQLSERVER\MSSQL\DATA\"
:setvar DefaultLogPath "C:\Program Files\Microsoft SQL Server\MSSQL16.SQLSERVER\MSSQL\DATA\"

GO
:on error exit
GO
/*
Détectez le mode SQLCMD et désactivez l'exécution du script si le mode SQLCMD n'est pas pris en charge.
Pour réactiver le script une fois le mode SQLCMD activé, exécutez ce qui suit :
SET NOEXEC OFF; 
*/
:setvar __IsSqlCmdEnabled "True"
GO
IF N'$(__IsSqlCmdEnabled)' NOT LIKE N'True'
    BEGIN
        PRINT N'Le mode SQLCMD doit être activé de manière à pouvoir exécuter ce script.';
        SET NOEXEC ON;
    END


GO
USE [master];


GO

IF (DB_ID(N'$(DatabaseName)') IS NOT NULL) 
BEGIN
    ALTER DATABASE [$(DatabaseName)]
    SET SINGLE_USER WITH ROLLBACK IMMEDIATE;
    DROP DATABASE [$(DatabaseName)];
END

GO
PRINT N'Création de la base de données $(DatabaseName)...'
GO
CREATE DATABASE [$(DatabaseName)]
    ON 
    PRIMARY(NAME = [$(DatabaseName)], FILENAME = N'$(DefaultDataPath)$(DefaultFilePrefix)_Primary.mdf')
    LOG ON (NAME = [$(DatabaseName)_log], FILENAME = N'$(DefaultLogPath)$(DefaultFilePrefix)_Primary.ldf') COLLATE SQL_Latin1_General_CP1_CI_AS
GO
IF EXISTS (SELECT 1
           FROM   [master].[dbo].[sysdatabases]
           WHERE  [name] = N'$(DatabaseName)')
    BEGIN
        ALTER DATABASE [$(DatabaseName)]
            SET AUTO_CLOSE OFF 
            WITH ROLLBACK IMMEDIATE;
    END


GO
USE [$(DatabaseName)];


GO
IF EXISTS (SELECT 1
           FROM   [master].[dbo].[sysdatabases]
           WHERE  [name] = N'$(DatabaseName)')
    BEGIN
        ALTER DATABASE [$(DatabaseName)]
            SET ANSI_NULLS ON,
                ANSI_PADDING ON,
                ANSI_WARNINGS ON,
                ARITHABORT ON,
                CONCAT_NULL_YIELDS_NULL ON,
                NUMERIC_ROUNDABORT OFF,
                QUOTED_IDENTIFIER ON,
                ANSI_NULL_DEFAULT ON,
                CURSOR_DEFAULT LOCAL,
                RECOVERY FULL,
                CURSOR_CLOSE_ON_COMMIT OFF,
                AUTO_CREATE_STATISTICS ON,
                AUTO_SHRINK OFF,
                AUTO_UPDATE_STATISTICS ON,
                RECURSIVE_TRIGGERS OFF 
            WITH ROLLBACK IMMEDIATE;
    END


GO
IF EXISTS (SELECT 1
           FROM   [master].[dbo].[sysdatabases]
           WHERE  [name] = N'$(DatabaseName)')
    BEGIN
        ALTER DATABASE [$(DatabaseName)]
            SET ALLOW_SNAPSHOT_ISOLATION OFF;
    END


GO
IF EXISTS (SELECT 1
           FROM   [master].[dbo].[sysdatabases]
           WHERE  [name] = N'$(DatabaseName)')
    BEGIN
        ALTER DATABASE [$(DatabaseName)]
            SET READ_COMMITTED_SNAPSHOT OFF 
            WITH ROLLBACK IMMEDIATE;
    END


GO
IF EXISTS (SELECT 1
           FROM   [master].[dbo].[sysdatabases]
           WHERE  [name] = N'$(DatabaseName)')
    BEGIN
        ALTER DATABASE [$(DatabaseName)]
            SET AUTO_UPDATE_STATISTICS_ASYNC OFF,
                PAGE_VERIFY NONE,
                DATE_CORRELATION_OPTIMIZATION OFF,
                DISABLE_BROKER,
                PARAMETERIZATION SIMPLE,
                SUPPLEMENTAL_LOGGING OFF 
            WITH ROLLBACK IMMEDIATE;
    END


GO
IF IS_SRVROLEMEMBER(N'sysadmin') = 1
    BEGIN
        IF EXISTS (SELECT 1
                   FROM   [master].[dbo].[sysdatabases]
                   WHERE  [name] = N'$(DatabaseName)')
            BEGIN
                EXECUTE sp_executesql N'ALTER DATABASE [$(DatabaseName)]
    SET TRUSTWORTHY OFF,
        DB_CHAINING OFF 
    WITH ROLLBACK IMMEDIATE';
            END
    END
ELSE
    BEGIN
        PRINT N'Impossible de modifier les paramètres de base de données. Vous devez être administrateur système pour appliquer ces paramètres.';
    END


GO
IF IS_SRVROLEMEMBER(N'sysadmin') = 1
    BEGIN
        IF EXISTS (SELECT 1
                   FROM   [master].[dbo].[sysdatabases]
                   WHERE  [name] = N'$(DatabaseName)')
            BEGIN
                EXECUTE sp_executesql N'ALTER DATABASE [$(DatabaseName)]
    SET HONOR_BROKER_PRIORITY OFF 
    WITH ROLLBACK IMMEDIATE';
            END
    END
ELSE
    BEGIN
        PRINT N'Impossible de modifier les paramètres de base de données. Vous devez être administrateur système pour appliquer ces paramètres.';
    END


GO
ALTER DATABASE [$(DatabaseName)]
    SET TARGET_RECOVERY_TIME = 0 SECONDS 
    WITH ROLLBACK IMMEDIATE;


GO
IF EXISTS (SELECT 1
           FROM   [master].[dbo].[sysdatabases]
           WHERE  [name] = N'$(DatabaseName)')
    BEGIN
        ALTER DATABASE [$(DatabaseName)]
            SET FILESTREAM(NON_TRANSACTED_ACCESS = OFF),
                CONTAINMENT = NONE 
            WITH ROLLBACK IMMEDIATE;
    END


GO
IF EXISTS (SELECT 1
           FROM   [master].[dbo].[sysdatabases]
           WHERE  [name] = N'$(DatabaseName)')
    BEGIN
        ALTER DATABASE [$(DatabaseName)]
            SET AUTO_CREATE_STATISTICS ON(INCREMENTAL = OFF),
                MEMORY_OPTIMIZED_ELEVATE_TO_SNAPSHOT = OFF,
                DELAYED_DURABILITY = DISABLED 
            WITH ROLLBACK IMMEDIATE;
    END


GO
IF EXISTS (SELECT 1
           FROM   [master].[dbo].[sysdatabases]
           WHERE  [name] = N'$(DatabaseName)')
    BEGIN
        ALTER DATABASE [$(DatabaseName)]
            SET QUERY_STORE (QUERY_CAPTURE_MODE = ALL, DATA_FLUSH_INTERVAL_SECONDS = 900, INTERVAL_LENGTH_MINUTES = 60, MAX_PLANS_PER_QUERY = 200, CLEANUP_POLICY = (STALE_QUERY_THRESHOLD_DAYS = 367), MAX_STORAGE_SIZE_MB = 100) 
            WITH ROLLBACK IMMEDIATE;
    END


GO
IF EXISTS (SELECT 1
           FROM   [master].[dbo].[sysdatabases]
           WHERE  [name] = N'$(DatabaseName)')
    BEGIN
        ALTER DATABASE [$(DatabaseName)]
            SET QUERY_STORE = OFF 
            WITH ROLLBACK IMMEDIATE;
    END


GO
IF EXISTS (SELECT 1
           FROM   [master].[dbo].[sysdatabases]
           WHERE  [name] = N'$(DatabaseName)')
    BEGIN
        ALTER DATABASE SCOPED CONFIGURATION SET MAXDOP = 0;
        ALTER DATABASE SCOPED CONFIGURATION FOR SECONDARY SET MAXDOP = PRIMARY;
        ALTER DATABASE SCOPED CONFIGURATION SET LEGACY_CARDINALITY_ESTIMATION = OFF;
        ALTER DATABASE SCOPED CONFIGURATION FOR SECONDARY SET LEGACY_CARDINALITY_ESTIMATION = PRIMARY;
        ALTER DATABASE SCOPED CONFIGURATION SET PARAMETER_SNIFFING = ON;
        ALTER DATABASE SCOPED CONFIGURATION FOR SECONDARY SET PARAMETER_SNIFFING = PRIMARY;
        ALTER DATABASE SCOPED CONFIGURATION SET QUERY_OPTIMIZER_HOTFIXES = OFF;
        ALTER DATABASE SCOPED CONFIGURATION FOR SECONDARY SET QUERY_OPTIMIZER_HOTFIXES = PRIMARY;
    END


GO
IF EXISTS (SELECT 1
           FROM   [master].[dbo].[sysdatabases]
           WHERE  [name] = N'$(DatabaseName)')
    BEGIN
        ALTER DATABASE [$(DatabaseName)]
            SET TEMPORAL_HISTORY_RETENTION ON 
            WITH ROLLBACK IMMEDIATE;
    END


GO
IF fulltextserviceproperty(N'IsFulltextInstalled') = 1
    EXECUTE sp_fulltext_database 'enable';


GO
PRINT N'Création de Table [dbo].[Category]...';


GO
CREATE TABLE [dbo].[Category] (
    [CategoryId] INT            IDENTITY (0, 1) NOT NULL,
    [Name]       NVARCHAR (100) NOT NULL,
    PRIMARY KEY CLUSTERED ([CategoryId] ASC)
);


GO
PRINT N'Création de Table [dbo].[Client]...';


GO
CREATE TABLE [dbo].[Client] (
    [ClientId] INT              IDENTITY (0, 1) NOT NULL,
    [Address]  VARCHAR (255)    NOT NULL,
    [PersonId] UNIQUEIDENTIFIER NOT NULL,
    PRIMARY KEY CLUSTERED ([ClientId] ASC)
);


GO
PRINT N'Création de Table [dbo].[Order]...';


GO
CREATE TABLE [dbo].[Order] (
    [OrderId]          INT             IDENTITY (0, 1) NOT NULL,
    [Date]             DATETIME        NOT NULL,
    [TotalPrice]       DECIMAL (10, 2) NOT NULL,
    [IsCommandHandled] BIT             NULL,
    [UserId]           INT             NOT NULL,
    [ClientId]         INT             NOT NULL,
    PRIMARY KEY CLUSTERED ([OrderId] ASC)
);


GO
PRINT N'Création de Table [dbo].[OrderDetail]...';


GO
CREATE TABLE [dbo].[OrderDetail] (
    [OrderDetail] UNIQUEIDENTIFIER NOT NULL,
    [Quantity]    INT              NOT NULL,
    [DetailPrice] DECIMAL (10, 2)  NOT NULL,
    [OrderId]     INT              NOT NULL,
    [ProductId]   INT              NOT NULL,
    PRIMARY KEY CLUSTERED ([OrderDetail] ASC)
);


GO
PRINT N'Création de Table [dbo].[Person]...';


GO
CREATE TABLE [dbo].[Person] (
    [PersonId]    UNIQUEIDENTIFIER NOT NULL,
    [Name]        NVARCHAR (100)   NOT NULL,
    [Email]       NVARCHAR (255)   NOT NULL,
    [PhoneNumber] NVARCHAR (15)    NULL,
    [Password]    CHAR (64)        NOT NULL,
    PRIMARY KEY CLUSTERED ([PersonId] ASC)
);


GO
PRINT N'Création de Table [dbo].[Product]...';


GO
CREATE TABLE [dbo].[Product] (
    [ProductId]  INT             IDENTITY (0, 1) NOT NULL,
    [Name]       NVARCHAR (100)  NOT NULL,
    [Price]      DECIMAL (10, 2) NOT NULL,
    [Image]      VARBINARY (MAX) NULL,
    [CategoryId] INT             NOT NULL,
    PRIMARY KEY CLUSTERED ([ProductId] ASC)
);


GO
PRINT N'Création de Table [dbo].[Role]...';


GO
CREATE TABLE [dbo].[Role] (
    [RoleId] INT            IDENTITY (0, 1) NOT NULL,
    [Name]   NVARCHAR (100) NOT NULL,
    PRIMARY KEY CLUSTERED ([RoleId] ASC)
);


GO
PRINT N'Création de Table [dbo].[Stock]...';


GO
CREATE TABLE [dbo].[Stock] (
    [StockId]     INT IDENTITY (0, 1) NOT NULL,
    [Quantity]    INT NOT NULL,
    [ProductId]   INT NOT NULL,
    [WarehouseId] INT NOT NULL,
    PRIMARY KEY CLUSTERED ([StockId] ASC)
);


GO
PRINT N'Création de Table [dbo].[User]...';


GO
CREATE TABLE [dbo].[User] (
    [UserId]   INT              IDENTITY (0, 1) NOT NULL,
    [RoleId]   INT              NOT NULL,
    [PersonId] UNIQUEIDENTIFIER NOT NULL,
    PRIMARY KEY CLUSTERED ([UserId] ASC)
);


GO
PRINT N'Création de Table [dbo].[Warehouse]...';


GO
CREATE TABLE [dbo].[Warehouse] (
    [WarehouseId] INT            IDENTITY (0, 1) NOT NULL,
    [Name]        NVARCHAR (100) NOT NULL,
    [Address]     NVARCHAR (255) NOT NULL,
    PRIMARY KEY CLUSTERED ([WarehouseId] ASC)
);


GO
PRINT N'Création de Contrainte par défaut contrainte sans nom sur [dbo].[Order]...';


GO
ALTER TABLE [dbo].[Order]
    ADD DEFAULT GETDATE() FOR [Date];


GO
PRINT N'Création de Contrainte par défaut contrainte sans nom sur [dbo].[OrderDetail]...';


GO
ALTER TABLE [dbo].[OrderDetail]
    ADD DEFAULT NEWID() FOR [OrderDetail];


GO
PRINT N'Création de Clé étrangère contrainte sans nom sur [dbo].[Client]...';


GO
ALTER TABLE [dbo].[Client]
    ADD FOREIGN KEY ([PersonId]) REFERENCES [dbo].[Person] ([PersonId]);


GO
PRINT N'Création de Clé étrangère contrainte sans nom sur [dbo].[Order]...';


GO
ALTER TABLE [dbo].[Order]
    ADD FOREIGN KEY ([UserId]) REFERENCES [dbo].[User] ([UserId]);


GO
PRINT N'Création de Clé étrangère contrainte sans nom sur [dbo].[Order]...';


GO
ALTER TABLE [dbo].[Order]
    ADD FOREIGN KEY ([ClientId]) REFERENCES [dbo].[Client] ([ClientId]);


GO
PRINT N'Création de Clé étrangère contrainte sans nom sur [dbo].[OrderDetail]...';


GO
ALTER TABLE [dbo].[OrderDetail]
    ADD FOREIGN KEY ([OrderId]) REFERENCES [dbo].[Order] ([OrderId]);


GO
PRINT N'Création de Clé étrangère contrainte sans nom sur [dbo].[OrderDetail]...';


GO
ALTER TABLE [dbo].[OrderDetail]
    ADD FOREIGN KEY ([ProductId]) REFERENCES [dbo].[Product] ([ProductId]);


GO
PRINT N'Création de Clé étrangère contrainte sans nom sur [dbo].[Product]...';


GO
ALTER TABLE [dbo].[Product]
    ADD FOREIGN KEY ([CategoryId]) REFERENCES [dbo].[Category] ([CategoryId]);


GO
PRINT N'Création de Clé étrangère contrainte sans nom sur [dbo].[Stock]...';


GO
ALTER TABLE [dbo].[Stock]
    ADD FOREIGN KEY ([ProductId]) REFERENCES [dbo].[Product] ([ProductId]);


GO
PRINT N'Création de Clé étrangère contrainte sans nom sur [dbo].[Stock]...';


GO
ALTER TABLE [dbo].[Stock]
    ADD FOREIGN KEY ([WarehouseId]) REFERENCES [dbo].[Warehouse] ([WarehouseId]);


GO
PRINT N'Création de Clé étrangère contrainte sans nom sur [dbo].[User]...';


GO
ALTER TABLE [dbo].[User]
    ADD FOREIGN KEY ([RoleId]) REFERENCES [dbo].[Role] ([RoleId]);


GO
PRINT N'Création de Clé étrangère contrainte sans nom sur [dbo].[User]...';


GO
ALTER TABLE [dbo].[User]
    ADD FOREIGN KEY ([PersonId]) REFERENCES [dbo].[Person] ([PersonId]);


GO
/*
Modèle de script de post-déploiement							
--------------------------------------------------------------------------------------
 Ce fichier contient des instructions SQL qui seront ajoutées au script de compilation.		
 Utilisez la syntaxe SQLCMD pour inclure un fichier dans le script de post-déploiement.			
 Exemple :      :r .\monfichier.sql								
 Utilisez la syntaxe SQLCMD pour référencer une variable dans le script de post-déploiement.		
 Exemple :      :setvar TableName MyTable							
               SELECT * FROM [$(TableName)]					
--------------------------------------------------------------------------------------
*/

/* init Rôles user*/

INSERT INTO [dbo].[Role] ([Name]) VALUES ('admin'),('livreur');

DECLARE @AdminId INT, @LivreurId INT;

SELECT @AdminId = [RoleId] FROM [dbo].[Role] WHERE [Name] = 'admin';
SELECT @LivreurId = [RoleId] FROM [dbo].[Role] WHERE [Name] = 'livreur';

/*init person*/

INSERT INTO [dbo].[Person] ([Name],[Email],[PhoneNumber],[Password])
VALUES
('Mimi','mimi@example.com','','Mimi123'),
('Manu','Manu@example.com','','Manu123'),
('Remi','Remi@example.com','Remi123'),
('Toto','Toto@example.com','0412345678','Toto123'),
('Harry','Harry@example.com','0498765432','Harry123');


/*init user*/
DECLARE @UserId1 UNIQUEIDENTIFIER,@UserId2 UNIQUEIDENTIFIER,@UserId3 UNIQUEIDENTIFIER;

SELECT @UserId1 = [PersonId] FROM [dbo].[Person] WHERE [Name] = 'Mimi';
SELECT @UserId2 = [PersonId] FROM [dbo].[Person] WHERE [Name] = 'Manu';
SELECT @UserId3 = [PersonId] FROM [dbo].[Person] WHERE [Name] = 'Remi';

INSERT INTO [dbo].[User] ([RoleId],[PersonId])
VALUES
(@AdminId,@UserId1),
(@LivreurId,@UserId2),
(@LivreurId,@UserId3);

/*init client*/
DECLARE @ClientId1 UNIQUEIDENTIFIER,@ClientId2 UNIQUEIDENTIFIER;

SELECT @ClientId1 = [PersonId] FROM [dbo].[Person] WHERE [Name] = 'Toto';
SELECT @ClientId2 = [PersonId] FROM [dbo].[Person] WHERE [Name] = 'Harry';

INSERT INTO [dbo].[Client] ([Address],[PersonId])
VALUES
('rue de la faille 12',@ClientId1),
('rue colette 6',@ClientId2);

/*init categories*/
INSERT INTO [dbo].[Category] ([Name]) VALUES ('Food'),('Drink');

DECLARE @FoodId INT ,@DrinkId INT;

SELECT @FoodId = [CategoryId] FROM [dbo].[Category] WHERE [Name] = 'Food';
SELECT @DrinkId = [CategoryId] FROM [dbo].[Category] WHERE [Name] = 'Drink';

/*init produits*/
INSERT INTO [dbo].[Product] ([Name],[Price],[CategoryId])
VALUES
('Chaudfontaine',1.50,@DrinkId),
('Coca-Cola', 1.80,@DrinkId),
('Donut',1.20,@FoodId),
('GaufreSucre',1.00,@FoodId);

/*init entrepôt*/
INSERT INTO [dbo].[Warehouse] ([Name],[Address])
VALUES
('SodaBel','rue rouffa 2, 4000 Liège')

/*init stock*/
INSERT INTO [dbo].[Stock] ([Quantity],[ProductId],[WarehouseId])
VALUES
(25,0,0),
(50,1,0),
(30,2,0),
(40,3,0);

/*init order*/
INSERT INTO [dbo].[Order] ([TotalPrice],[UserId],[ClientId])
VALUES
(15,0,0);

/*init orderdetail*/
INSERT INTO [dbo].[OrderDetail] ([Quantity],[DetailPrice],[OrderId],[ProductId])
VALUES
(10,15,0,0),
(5,5,0,3);

GO

GO
DECLARE @VarDecimalSupported AS BIT;

SELECT @VarDecimalSupported = 0;

IF ((ServerProperty(N'EngineEdition') = 3)
    AND (((@@microsoftversion / power(2, 24) = 9)
          AND (@@microsoftversion & 0xffff >= 3024))
         OR ((@@microsoftversion / power(2, 24) = 10)
             AND (@@microsoftversion & 0xffff >= 1600))))
    SELECT @VarDecimalSupported = 1;

IF (@VarDecimalSupported > 0)
    BEGIN
        EXECUTE sp_db_vardecimal_storage_format N'$(DatabaseName)', 'ON';
    END


GO
PRINT N'Mise à jour terminée.';


GO
