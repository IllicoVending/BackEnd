﻿CREATE TABLE [dbo].[Client]
(
	[ClientId] INT NOT NULL PRIMARY KEY IDENTITY(0,1),
	[Nom] VARCHAR(100) NOT NULL,
	[Adresse] VARCHAR(255) NOT NULL,
	[Email] VARCHAR(100) NOT NULL
)
