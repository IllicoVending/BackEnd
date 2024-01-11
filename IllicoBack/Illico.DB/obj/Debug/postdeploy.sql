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
('Remi','Remi@example.com','','Remi123'),
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
