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
INSERT INTO [dbo].[Role] ([Name]) VALUES ('Admin'),('User');

DECLARE @AdminId INT, @UserId INT;

SELECT @AdminId = [Id] FROM [dbo].[Role] WHERE [Name] = 'Admin';
SELECT @UserId = [Id] FROM [dbo].[Role] WHERE [Name] = 'User';

INSERT INTO [dbo].[User] ([Name],[Email],[Password],[RoleId])
VALUES
('Yvan','YvanDesFrites@example.com','Yvan123',@AdminId),
('Remi','DosRemi@example.com','Remi123',@UserId),
('Toto','Toto@exemple.com','Toto123',@UserId),
('Harry','Harry@exemple.com','Harry123',@UserId);

INSERT INTO [dbo].[Category] ([Name]) VALUES ('Food'),('Drink');

DECLARE @FoodId INT ,@DrinkId INT;

SELECT @FoodId = [Id] FROM [dbo].[Category] WHERE [Name] = 'Food';
SELECT @DrinkId = [Id] FROM [dbo].[Category] WHERE [Name] = 'Drink';

INSERT INTO [dbo].[Product] ([Name],[Price],[Quantity],[CategoryId])
VALUES
('Chaudfontaine',1.50,75,@DrinkId),
('GaufreSucre',1.00,25,@FoodId);

GO
