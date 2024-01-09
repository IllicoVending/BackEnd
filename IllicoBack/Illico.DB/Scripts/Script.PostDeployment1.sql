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

SELECT @AdminId = [Id] FROM [dbo].[Role] WHERE [Name] = 'admin';
SELECT @LivreurId = [Id] FROM [dbo].[Role] WHERE [Name] = 'livreur';

/*init person*/

INSERT INTO [dbo].[Person] ([Name],[Email],[Password])
VALUES
('Mimi','mimi@example.com','Mimi123'),
('Manu','Manu@example.com','Manu123'),
('Remi','Remi@example.com','Remi123'),
('Toto','Toto@example.com','Toto123'),
('Harry','Harry@example.com','Harry123');


/*init user*/

INSERT INTO [dbo].[User] ([RoleId],[PersonId])
VALUES
(@AdminId,0),
(@LivreurId,1),
(@LivreurId,2);

/*init client*/

INSERT INTO [dbo].[Client] ([Adress],[PersonId])
VALUES
('rue de la faille 12',3),
('rue colette 6',4)

/*init categories*/
INSERT INTO [dbo].[Category] ([Name]) VALUES ('Food'),('Drink');

DECLARE @FoodId INT ,@DrinkId INT;

SELECT @FoodId = [Id] FROM [dbo].[Category] WHERE [Name] = 'Food';
SELECT @DrinkId = [Id] FROM [dbo].[Category] WHERE [Name] = 'Drink';

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
(15,0,3);

/*init orderdetail*/
INSERT INTO [dbo].[OrderDetail] ([Quantity],[DetailPrice],[OrderId],[ProductId])
VALUES
(10,15,0,0),
(5,5,0,3);

