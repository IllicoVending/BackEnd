﻿CREATE TABLE [dbo].[Order]
(
	[OrderId] INT NOT NULL PRIMARY KEY IDENTITY(0,1),
	[Date] DATETIME NOT NULL,
	[TotalPrice] DECIMAL(10,2) NOT NULL,
	[UserId] INT FOREIGN KEY REFERENCES [User]([UserId]) NOT NULL,
	[ClientId] INT FOREIGN KEY REFERENCES [Client]([ClientId]) NOT NULL
)
