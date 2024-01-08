﻿CREATE TABLE [dbo].[User]
(
	[UserId] INT NOT NULL PRIMARY KEY IDENTITY(0,1),
	[Name] NVARCHAR(100) NOT NULL,
	[Email] NVARCHAR(254) NOT NULL,
	[Password] CHAR(64) NOT NULL,
	[RoleId] INT FOREIGN KEY REFERENCES [Role]([RoleId]) NOT NULL
)
