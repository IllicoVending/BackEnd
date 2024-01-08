CREATE TABLE [dbo].[Stock]
(
	[StockId] INT NOT NULL PRIMARY KEY IDENTITY(0,1),

	[Quantity] INT NOT NULL,

	[ProductId] INT FOREIGN KEY REFERENCES [Product]([ProductId]) NOT NULL
	
)
