BEGIN TRY
	DECLARE @version INT
	SET @version = 1

	BEGIN TRANSACTION
		SET QUOTED_IDENTIFIER OFF;
			
		IF SCHEMA_ID(N'dbo') IS NULL EXECUTE(N'CREATE SCHEMA [dbo]');		

		DECLARE @Sql NVARCHAR(500) DECLARE @Cursor CURSOR

		SET @Cursor = CURSOR FAST_FORWARD FOR
		SELECT DISTINCT sql = 'ALTER TABLE [' + tc2.TABLE_NAME + '] DROP [' + rc1.CONSTRAINT_NAME + ']'
		FROM INFORMATION_SCHEMA.REFERENTIAL_CONSTRAINTS rc1
		LEFT JOIN INFORMATION_SCHEMA.TABLE_CONSTRAINTS tc2 ON tc2.CONSTRAINT_NAME =rc1.CONSTRAINT_NAME

		OPEN @Cursor FETCH NEXT FROM @Cursor INTO @Sql

		WHILE (@@FETCH_STATUS = 0)
		BEGIN
		Exec SP_EXECUTESQL @Sql
		FETCH NEXT FROM @Cursor INTO @Sql
		END

		CLOSE @Cursor DEALLOCATE @Cursor

		EXEC sp_MSForEachTable 'DROP TABLE ?'

		-- --------------------------------------------------
		-- Dropping existing FOREIGN KEY constraints
		-- --------------------------------------------------

		IF OBJECT_ID(N'[dbo].[FK_CharactersCharacterSheets]', 'F') IS NOT NULL
			ALTER TABLE [dbo].[Characters] DROP CONSTRAINT [FK_CharactersCharacterSheets];
		
		IF OBJECT_ID(N'[dbo].[FK_CharacterSheetsStats]', 'F') IS NOT NULL
			ALTER TABLE [dbo].[CharacterSheets] DROP CONSTRAINT [FK_CharacterSheetsStats];
		
		IF OBJECT_ID(N'[dbo].[FK_CharacterSheetsEquippedWeapons_CharacterSheets]', 'F') IS NOT NULL
			ALTER TABLE [dbo].[CharacterSheets_EquippedWeapons] DROP CONSTRAINT [FK_CharacterSheetsEquippedWeapons_CharacterSheets];
		
		IF OBJECT_ID(N'[dbo].[FK_CharacterSheetsEquippedWeapons_EquippedWeapons]', 'F') IS NOT NULL
			ALTER TABLE [dbo].[CharacterSheets_EquippedWeapons] DROP CONSTRAINT [FK_CharacterSheetsEquippedWeapons_EquippedWeapons];
		
		IF OBJECT_ID(N'[dbo].[FK_EquippedWeaponsItems]', 'F') IS NOT NULL
			ALTER TABLE [dbo].[EquippedWeapons] DROP CONSTRAINT [FK_EquippedWeaponsItems];
		
		IF OBJECT_ID(N'[dbo].[FK_EquippedArmorCharacterSheets]', 'F') IS NOT NULL
			ALTER TABLE [dbo].[EquippedArmors] DROP CONSTRAINT [FK_EquippedArmorCharacterSheets];
		
		IF OBJECT_ID(N'[dbo].[FK_EquippedArmorItems]', 'F') IS NOT NULL
			ALTER TABLE [dbo].[EquippedArmors] DROP CONSTRAINT [FK_EquippedArmorItems];
		
		IF OBJECT_ID(N'[dbo].[FK_CharacterSheetsLanguages_CharacterSheets]', 'F') IS NOT NULL
			ALTER TABLE [dbo].[CharacterSheets_Languages] DROP CONSTRAINT [FK_CharacterSheetsLanguages_CharacterSheets];
		
		IF OBJECT_ID(N'[dbo].[FK_CharacterSheetsLanguages_Languages]', 'F') IS NOT NULL
			ALTER TABLE [dbo].[CharacterSheets_Languages] DROP CONSTRAINT [FK_CharacterSheetsLanguages_Languages];
		
		IF OBJECT_ID(N'[dbo].[FK_CharacterSheetsTalents_CharacterSheets]', 'F') IS NOT NULL
			ALTER TABLE [dbo].[CharacterSheets_Talents] DROP CONSTRAINT [FK_CharacterSheetsTalents_CharacterSheets];
		
		IF OBJECT_ID(N'[dbo].[FK_CharacterSheetsTalents_Talents]', 'F') IS NOT NULL
			ALTER TABLE [dbo].[CharacterSheets_Talents] DROP CONSTRAINT [FK_CharacterSheetsTalents_Talents];
		
		IF OBJECT_ID(N'[dbo].[FK_CharacterSheetsItems_CharacterSheets]', 'F') IS NOT NULL
			ALTER TABLE [dbo].[CharacterSheets_Items] DROP CONSTRAINT [FK_CharacterSheetsItems_CharacterSheets];
		
		IF OBJECT_ID(N'[dbo].[FK_CharacterSheetsItems_Items]', 'F') IS NOT NULL
			ALTER TABLE [dbo].[CharacterSheets_Items] DROP CONSTRAINT [FK_CharacterSheetsItems_Items];
		
		IF OBJECT_ID(N'[dbo].[FK_CharacterSheetsForcePowers_CharacterSheets]', 'F') IS NOT NULL
			ALTER TABLE [dbo].[CharacterSheets_ForcePowers] DROP CONSTRAINT [FK_CharacterSheetsForcePowers_CharacterSheets];
		
		IF OBJECT_ID(N'[dbo].[FK_CharacterSheetsForcePowers_ForcePowers]', 'F') IS NOT NULL
			ALTER TABLE [dbo].[CharacterSheets_ForcePowers] DROP CONSTRAINT [FK_CharacterSheetsForcePowers_ForcePowers];
		
		IF OBJECT_ID(N'[dbo].[FK_CharacterSheetsSkills]', 'F') IS NOT NULL
			ALTER TABLE [dbo].[CharacterSheets] DROP CONSTRAINT [FK_CharacterSheetsSkills];
		
		IF OBJECT_ID(N'[dbo].[FK_FeatsCharacterSheets_Feats]', 'F') IS NOT NULL
			ALTER TABLE [dbo].[Feats_CharacterSheets] DROP CONSTRAINT [FK_FeatsCharacterSheets_Feats];
		
		IF OBJECT_ID(N'[dbo].[FK_FeatsCharacterSheets_CharacterSheets]', 'F') IS NOT NULL
			ALTER TABLE [dbo].[Feats_CharacterSheets] DROP CONSTRAINT [FK_FeatsCharacterSheets_CharacterSheets];
		
		IF OBJECT_ID(N'[dbo].[FK_UsersCharacters]', 'F') IS NOT NULL
			ALTER TABLE [dbo].[Characters] DROP CONSTRAINT [FK_UsersCharacters];
		

		-- --------------------------------------------------
		-- Dropping existing tables
		-- --------------------------------------------------

		IF OBJECT_ID(N'[dbo].[Users]', 'U') IS NOT NULL
			DROP TABLE [dbo].[Users];
		
		IF OBJECT_ID(N'[dbo].[Characters]', 'U') IS NOT NULL
			DROP TABLE [dbo].[Characters];
		
		IF OBJECT_ID(N'[dbo].[CharacterSheets]', 'U') IS NOT NULL
			DROP TABLE [dbo].[CharacterSheets];
		
		IF OBJECT_ID(N'[dbo].[Stats]', 'U') IS NOT NULL
			DROP TABLE [dbo].[Stats];
		
		IF OBJECT_ID(N'[dbo].[EquippedWeapons]', 'U') IS NOT NULL
			DROP TABLE [dbo].[EquippedWeapons];
		
		IF OBJECT_ID(N'[dbo].[Items]', 'U') IS NOT NULL
			DROP TABLE [dbo].[Items];
		
		IF OBJECT_ID(N'[dbo].[EquippedArmors]', 'U') IS NOT NULL
			DROP TABLE [dbo].[EquippedArmors];
		
		IF OBJECT_ID(N'[dbo].[Languages]', 'U') IS NOT NULL
			DROP TABLE [dbo].[Languages];
		
		IF OBJECT_ID(N'[dbo].[Talents]', 'U') IS NOT NULL
			DROP TABLE [dbo].[Talents];
		
		IF OBJECT_ID(N'[dbo].[ForcePowers]', 'U') IS NOT NULL
			DROP TABLE [dbo].[ForcePowers];
		
		IF OBJECT_ID(N'[dbo].[Feats]', 'U') IS NOT NULL
			DROP TABLE [dbo].[Feats];
		
		IF OBJECT_ID(N'[dbo].[Skills]', 'U') IS NOT NULL
			DROP TABLE [dbo].[Skills];
		
		IF OBJECT_ID(N'[dbo].[Versions]', 'U') IS NOT NULL
			DROP TABLE [dbo].[Versions];
		
		IF OBJECT_ID(N'[dbo].[CharacterSheets_EquippedWeapons]', 'U') IS NOT NULL
			DROP TABLE [dbo].[CharacterSheets_EquippedWeapons];
		
		IF OBJECT_ID(N'[dbo].[CharacterSheets_Languages]', 'U') IS NOT NULL
			DROP TABLE [dbo].[CharacterSheets_Languages];
		
		IF OBJECT_ID(N'[dbo].[CharacterSheets_Talents]', 'U') IS NOT NULL
			DROP TABLE [dbo].[CharacterSheets_Talents];
		
		IF OBJECT_ID(N'[dbo].[CharacterSheets_Items]', 'U') IS NOT NULL
			DROP TABLE [dbo].[CharacterSheets_Items];
		
		IF OBJECT_ID(N'[dbo].[CharacterSheets_ForcePowers]', 'U') IS NOT NULL
			DROP TABLE [dbo].[CharacterSheets_ForcePowers];
		
		IF OBJECT_ID(N'[dbo].[Feats_CharacterSheets]', 'U') IS NOT NULL
			DROP TABLE [dbo].[Feats_CharacterSheets];
		

		-- --------------------------------------------------
		-- Creating all tables
		-- --------------------------------------------------

		-- Creating table 'Users'
		CREATE TABLE [dbo].[Users] (
			[Id] int IDENTITY(1,1) NOT NULL,
			[FirstName] nvarchar(max)  NOT NULL,
			[LastName] nvarchar(max)  NOT NULL,
			[Username] nvarchar(max)  NOT NULL,
			[Password] nvarchar(max)  NOT NULL,
			[IsDm] bit  NOT NULL
		);
		

		-- Creating table 'Characters'
		CREATE TABLE [dbo].[Characters] (
			[Id] int IDENTITY(1,1) NOT NULL,
			[Name] nvarchar(max)  NOT NULL,
			[Class] nvarchar(max)  NOT NULL,
			[Species] nvarchar(max)  NOT NULL,
			[Level] int  NOT NULL,
			[Age] int  NOT NULL,
			[Gender] nvarchar(max)  NOT NULL,
			[Height] int  NOT NULL,
			[Weight] int  NOT NULL,
			[Background] nvarchar(max)  NULL,
			[Destiny] nvarchar(max)  NULL,
			[Credits] decimal(18,0)  NOT NULL,
			[MaxHp] int  NOT NULL,
			[CurrentHp] int  NOT NULL,
			[Experience] bigint  NOT NULL,
			[PortraitPath] nvarchar(max)  NULL,
			[IsActive] bit  NOT NULL,
			[CharacterSheet_Id] int  NOT NULL,
			[Users_Id] int  NOT NULL
		);
		

		-- Creating table 'CharacterSheets'
		CREATE TABLE [dbo].[CharacterSheets] (
			[Id] int IDENTITY(1,1) NOT NULL,
			[Stats_Id] int  NOT NULL,
			[Skills_Id] int  NOT NULL
		);
		

		-- Creating table 'Stats'
		CREATE TABLE [dbo].[Stats] (
			[Id] int IDENTITY(1,1) NOT NULL,
			[Strength] int  NOT NULL,
			[Dexterity] int  NOT NULL,
			[Constitution] int  NOT NULL,
			[Intelligence] int  NOT NULL,
			[Wisdom] int  NOT NULL,
			[Charisma] int  NOT NULL,
			[Fortitude] int  NOT NULL,
			[Reflex] int  NOT NULL,
			[Will] int  NOT NULL,
			[DmgThreshold] int  NOT NULL,
			[Speed] int  NOT NULL,
			[BaseAttack] int  NOT NULL,
			[Initiative] int  NOT NULL,
			[Perception] int  NOT NULL,
			[Grapple] int  NOT NULL,
			[ForcePoints] int  NOT NULL,
			[DestinyPoints] int  NOT NULL
		);
		

		-- Creating table 'EquippedWeapons'
		CREATE TABLE [dbo].[EquippedWeapons] (
			[Id] int IDENTITY(1,1) NOT NULL,
			[AttackBonus] int  NOT NULL,
			[Damage] int  NOT NULL,
			[CritBonus] int  NOT NULL,
			[Notes] nvarchar(max)  NULL,
			[Item_Id] int  NOT NULL
		);
		

		-- Creating table 'Items'
		CREATE TABLE [dbo].[Items] (
			[Id] int IDENTITY(1,1) NOT NULL,
			[Name] nvarchar(max)  NOT NULL,
			[Type] nvarchar(max)  NOT NULL,
			[Weight] int  NOT NULL,
			[Cost] int  NOT NULL,
			[Description] nvarchar(max)  NULL
		);
		

		-- Creating table 'EquippedArmors'
		CREATE TABLE [dbo].[EquippedArmors] (
			[Id] int IDENTITY(1,1) NOT NULL,
			[CharacterSheet_Id] int  NOT NULL,
			[Item_Id] int  NOT NULL
		);
		

		-- Creating table 'Languages'
		CREATE TABLE [dbo].[Languages] (
			[Id] int IDENTITY(1,1) NOT NULL,
			[Name] nvarchar(max)  NOT NULL
		);
		

		-- Creating table 'Talents'
		CREATE TABLE [dbo].[Talents] (
			[Id] int IDENTITY(1,1) NOT NULL,
			[Name] nvarchar(max)  NOT NULL,
			[Description] nvarchar(max)  NULL
		);
		

		-- Creating table 'ForcePowers'
		CREATE TABLE [dbo].[ForcePowers] (
			[Id] int IDENTITY(1,1) NOT NULL,
			[Name] nvarchar(max)  NOT NULL,
			[Description] nvarchar(max)  NULL
		);
		

		-- Creating table 'Feats'
		CREATE TABLE [dbo].[Feats] (
			[Id] int IDENTITY(1,1) NOT NULL,
			[Name] nvarchar(max)  NOT NULL,
			[Description] nvarchar(max)  NULL,
			[PageNumber] int  NOT NULL
		);
		

		-- Creating table 'Skills'
		CREATE TABLE [dbo].[Skills] (
			[Id] int IDENTITY(1,1) NOT NULL,
			[Acrobatics] int  NOT NULL,
			[Climb] int  NOT NULL,
			[Deception] int  NOT NULL,
			[Endurance] int  NOT NULL,
			[GatherInformation] int  NOT NULL,
			[Initiative] int  NOT NULL,
			[Jump] int  NOT NULL,
			[Knowledge] int  NOT NULL,
			[Mechanics] int  NOT NULL,
			[Perception] int  NOT NULL,
			[Persuasion] int  NOT NULL,
			[Pilot] int  NOT NULL,
			[Ride] int  NOT NULL,
			[Stealth] int  NOT NULL,
			[Survival] int  NOT NULL,
			[Swim] int  NOT NULL,
			[TreatInjury] int  NOT NULL,
			[UseComputer] int  NOT NULL,
			[UseTheForce] int  NOT NULL
		);
		

		-- Creating table 'Versions'
		CREATE TABLE [dbo].[Versions] (
			[Id] int IDENTITY(1,1) NOT NULL,
			[Timestamp] datetime  NOT NULL,
			[Version] nvarchar(max)  NOT NULL,
			[Description] nvarchar(max)  NOT NULL
		);
		

		-- Creating table 'CharacterSheets_EquippedWeapons'
		CREATE TABLE [dbo].[CharacterSheets_EquippedWeapons] (
			[CharacterSheet_Id] int  NOT NULL,
			[EquippedWeapons_Id] int  NOT NULL
		);
		

		-- Creating table 'CharacterSheets_Languages'
		CREATE TABLE [dbo].[CharacterSheets_Languages] (
			[CharacterSheet_Id] int  NOT NULL,
			[Languages_Id] int  NOT NULL
		);
		

		-- Creating table 'CharacterSheets_Talents'
		CREATE TABLE [dbo].[CharacterSheets_Talents] (
			[CharacterSheet_Id] int  NOT NULL,
			[Talents_Id] int  NOT NULL
		);
		

		-- Creating table 'CharacterSheets_Items'
		CREATE TABLE [dbo].[CharacterSheets_Items] (
			[CharacterSheet_Id] int  NOT NULL,
			[Items_Id] int  NOT NULL
		);
		

		-- Creating table 'CharacterSheets_ForcePowers'
		CREATE TABLE [dbo].[CharacterSheets_ForcePowers] (
			[CharacterSheet_Id] int  NOT NULL,
			[ForcePowers_Id] int  NOT NULL
		);
		

		-- Creating table 'Feats_CharacterSheets'
		CREATE TABLE [dbo].[Feats_CharacterSheets] (
			[Feat_Id] int  NOT NULL,
			[CharacterSheets_Id] int  NOT NULL
		);
		

		-- --------------------------------------------------
		-- Creating all PRIMARY KEY constraints
		-- --------------------------------------------------

		-- Creating primary key on [Id] in table 'Users'
		ALTER TABLE [dbo].[Users]
		ADD CONSTRAINT [PK_Users]
			PRIMARY KEY CLUSTERED ([Id] ASC);
		

		-- Creating primary key on [Id] in table 'Characters'
		ALTER TABLE [dbo].[Characters]
		ADD CONSTRAINT [PK_Characters]
			PRIMARY KEY CLUSTERED ([Id] ASC);
		

		-- Creating primary key on [Id] in table 'CharacterSheets'
		ALTER TABLE [dbo].[CharacterSheets]
		ADD CONSTRAINT [PK_CharacterSheets]
			PRIMARY KEY CLUSTERED ([Id] ASC);
		

		-- Creating primary key on [Id] in table 'Stats'
		ALTER TABLE [dbo].[Stats]
		ADD CONSTRAINT [PK_Stats]
			PRIMARY KEY CLUSTERED ([Id] ASC);
		

		-- Creating primary key on [Id] in table 'EquippedWeapons'
		ALTER TABLE [dbo].[EquippedWeapons]
		ADD CONSTRAINT [PK_EquippedWeapons]
			PRIMARY KEY CLUSTERED ([Id] ASC);
		

		-- Creating primary key on [Id] in table 'Items'
		ALTER TABLE [dbo].[Items]
		ADD CONSTRAINT [PK_Items]
			PRIMARY KEY CLUSTERED ([Id] ASC);
		

		-- Creating primary key on [Id] in table 'EquippedArmors'
		ALTER TABLE [dbo].[EquippedArmors]
		ADD CONSTRAINT [PK_EquippedArmors]
			PRIMARY KEY CLUSTERED ([Id] ASC);
		

		-- Creating primary key on [Id] in table 'Languages'
		ALTER TABLE [dbo].[Languages]
		ADD CONSTRAINT [PK_Languages]
			PRIMARY KEY CLUSTERED ([Id] ASC);
		

		-- Creating primary key on [Id] in table 'Talents'
		ALTER TABLE [dbo].[Talents]
		ADD CONSTRAINT [PK_Talents]
			PRIMARY KEY CLUSTERED ([Id] ASC);
		

		-- Creating primary key on [Id] in table 'ForcePowers'
		ALTER TABLE [dbo].[ForcePowers]
		ADD CONSTRAINT [PK_ForcePowers]
			PRIMARY KEY CLUSTERED ([Id] ASC);
		

		-- Creating primary key on [Id] in table 'Feats'
		ALTER TABLE [dbo].[Feats]
		ADD CONSTRAINT [PK_Feats]
			PRIMARY KEY CLUSTERED ([Id] ASC);
		

		-- Creating primary key on [Id] in table 'Skills'
		ALTER TABLE [dbo].[Skills]
		ADD CONSTRAINT [PK_Skills]
			PRIMARY KEY CLUSTERED ([Id] ASC);
		

		-- Creating primary key on [Id] in table 'Versions'
		ALTER TABLE [dbo].[Versions]
		ADD CONSTRAINT [PK_Versions]
			PRIMARY KEY CLUSTERED ([Id] ASC);
		

		-- Creating primary key on [CharacterSheet_Id], [EquippedWeapons_Id] in table 'CharacterSheets_EquippedWeapons'
		ALTER TABLE [dbo].[CharacterSheets_EquippedWeapons]
		ADD CONSTRAINT [PK_CharacterSheets_EquippedWeapons]
			PRIMARY KEY CLUSTERED ([CharacterSheet_Id], [EquippedWeapons_Id] ASC);
		

		-- Creating primary key on [CharacterSheet_Id], [Languages_Id] in table 'CharacterSheets_Languages'
		ALTER TABLE [dbo].[CharacterSheets_Languages]
		ADD CONSTRAINT [PK_CharacterSheets_Languages]
			PRIMARY KEY CLUSTERED ([CharacterSheet_Id], [Languages_Id] ASC);
		

		-- Creating primary key on [CharacterSheet_Id], [Talents_Id] in table 'CharacterSheets_Talents'
		ALTER TABLE [dbo].[CharacterSheets_Talents]
		ADD CONSTRAINT [PK_CharacterSheets_Talents]
			PRIMARY KEY CLUSTERED ([CharacterSheet_Id], [Talents_Id] ASC);
		

		-- Creating primary key on [CharacterSheet_Id], [Items_Id] in table 'CharacterSheets_Items'
		ALTER TABLE [dbo].[CharacterSheets_Items]
		ADD CONSTRAINT [PK_CharacterSheets_Items]
			PRIMARY KEY CLUSTERED ([CharacterSheet_Id], [Items_Id] ASC);
		

		-- Creating primary key on [CharacterSheet_Id], [ForcePowers_Id] in table 'CharacterSheets_ForcePowers'
		ALTER TABLE [dbo].[CharacterSheets_ForcePowers]
		ADD CONSTRAINT [PK_CharacterSheets_ForcePowers]
			PRIMARY KEY CLUSTERED ([CharacterSheet_Id], [ForcePowers_Id] ASC);
		

		-- Creating primary key on [Feat_Id], [CharacterSheets_Id] in table 'Feats_CharacterSheets'
		ALTER TABLE [dbo].[Feats_CharacterSheets]
		ADD CONSTRAINT [PK_Feats_CharacterSheets]
			PRIMARY KEY CLUSTERED ([Feat_Id], [CharacterSheets_Id] ASC);
		

		-- --------------------------------------------------
		-- Creating all FOREIGN KEY constraints
		-- --------------------------------------------------

		-- Creating foreign key on [CharacterSheet_Id] in table 'Characters'
		ALTER TABLE [dbo].[Characters]
		ADD CONSTRAINT [FK_CharactersCharacterSheets]
			FOREIGN KEY ([CharacterSheet_Id])
			REFERENCES [dbo].[CharacterSheets]
				([Id])
			ON DELETE NO ACTION ON UPDATE NO ACTION;
		

		-- Creating non-clustered index for FOREIGN KEY 'FK_CharactersCharacterSheets'
		CREATE INDEX [IX_FK_CharactersCharacterSheets]
		ON [dbo].[Characters]
			([CharacterSheet_Id]);
		

		-- Creating foreign key on [Stats_Id] in table 'CharacterSheets'
		ALTER TABLE [dbo].[CharacterSheets]
		ADD CONSTRAINT [FK_CharacterSheetsStats]
			FOREIGN KEY ([Stats_Id])
			REFERENCES [dbo].[Stats]
				([Id])
			ON DELETE NO ACTION ON UPDATE NO ACTION;
		

		-- Creating non-clustered index for FOREIGN KEY 'FK_CharacterSheetsStats'
		CREATE INDEX [IX_FK_CharacterSheetsStats]
		ON [dbo].[CharacterSheets]
			([Stats_Id]);
		

		-- Creating foreign key on [CharacterSheet_Id] in table 'CharacterSheets_EquippedWeapons'
		ALTER TABLE [dbo].[CharacterSheets_EquippedWeapons]
		ADD CONSTRAINT [FK_CharacterSheetsEquippedWeapons_CharacterSheets]
			FOREIGN KEY ([CharacterSheet_Id])
			REFERENCES [dbo].[CharacterSheets]
				([Id])
			ON DELETE NO ACTION ON UPDATE NO ACTION;
		

		-- Creating foreign key on [EquippedWeapons_Id] in table 'CharacterSheets_EquippedWeapons'
		ALTER TABLE [dbo].[CharacterSheets_EquippedWeapons]
		ADD CONSTRAINT [FK_CharacterSheetsEquippedWeapons_EquippedWeapons]
			FOREIGN KEY ([EquippedWeapons_Id])
			REFERENCES [dbo].[EquippedWeapons]
				([Id])
			ON DELETE NO ACTION ON UPDATE NO ACTION;
		

		-- Creating non-clustered index for FOREIGN KEY 'FK_CharacterSheetsEquippedWeapons_EquippedWeapons'
		CREATE INDEX [IX_FK_CharacterSheetsEquippedWeapons_EquippedWeapons]
		ON [dbo].[CharacterSheets_EquippedWeapons]
			([EquippedWeapons_Id]);
		

		-- Creating foreign key on [Item_Id] in table 'EquippedWeapons'
		ALTER TABLE [dbo].[EquippedWeapons]
		ADD CONSTRAINT [FK_EquippedWeaponsItems]
			FOREIGN KEY ([Item_Id])
			REFERENCES [dbo].[Items]
				([Id])
			ON DELETE NO ACTION ON UPDATE NO ACTION;
		

		-- Creating non-clustered index for FOREIGN KEY 'FK_EquippedWeaponsItems'
		CREATE INDEX [IX_FK_EquippedWeaponsItems]
		ON [dbo].[EquippedWeapons]
			([Item_Id]);
		

		-- Creating foreign key on [CharacterSheet_Id] in table 'EquippedArmors'
		ALTER TABLE [dbo].[EquippedArmors]
		ADD CONSTRAINT [FK_EquippedArmorCharacterSheets]
			FOREIGN KEY ([CharacterSheet_Id])
			REFERENCES [dbo].[CharacterSheets]
				([Id])
			ON DELETE NO ACTION ON UPDATE NO ACTION;
		

		-- Creating non-clustered index for FOREIGN KEY 'FK_EquippedArmorCharacterSheets'
		CREATE INDEX [IX_FK_EquippedArmorCharacterSheets]
		ON [dbo].[EquippedArmors]
			([CharacterSheet_Id]);
		

		-- Creating foreign key on [Item_Id] in table 'EquippedArmors'
		ALTER TABLE [dbo].[EquippedArmors]
		ADD CONSTRAINT [FK_EquippedArmorItems]
			FOREIGN KEY ([Item_Id])
			REFERENCES [dbo].[Items]
				([Id])
			ON DELETE NO ACTION ON UPDATE NO ACTION;
		

		-- Creating non-clustered index for FOREIGN KEY 'FK_EquippedArmorItems'
		CREATE INDEX [IX_FK_EquippedArmorItems]
		ON [dbo].[EquippedArmors]
			([Item_Id]);
		

		-- Creating foreign key on [CharacterSheet_Id] in table 'CharacterSheets_Languages'
		ALTER TABLE [dbo].[CharacterSheets_Languages]
		ADD CONSTRAINT [FK_CharacterSheetsLanguages_CharacterSheets]
			FOREIGN KEY ([CharacterSheet_Id])
			REFERENCES [dbo].[CharacterSheets]
				([Id])
			ON DELETE NO ACTION ON UPDATE NO ACTION;
		

		-- Creating foreign key on [Languages_Id] in table 'CharacterSheets_Languages'
		ALTER TABLE [dbo].[CharacterSheets_Languages]
		ADD CONSTRAINT [FK_CharacterSheetsLanguages_Languages]
			FOREIGN KEY ([Languages_Id])
			REFERENCES [dbo].[Languages]
				([Id])
			ON DELETE NO ACTION ON UPDATE NO ACTION;
		

		-- Creating non-clustered index for FOREIGN KEY 'FK_CharacterSheetsLanguages_Languages'
		CREATE INDEX [IX_FK_CharacterSheetsLanguages_Languages]
		ON [dbo].[CharacterSheets_Languages]
			([Languages_Id]);
		

		-- Creating foreign key on [CharacterSheet_Id] in table 'CharacterSheets_Talents'
		ALTER TABLE [dbo].[CharacterSheets_Talents]
		ADD CONSTRAINT [FK_CharacterSheetsTalents_CharacterSheets]
			FOREIGN KEY ([CharacterSheet_Id])
			REFERENCES [dbo].[CharacterSheets]
				([Id])
			ON DELETE NO ACTION ON UPDATE NO ACTION;
		

		-- Creating foreign key on [Talents_Id] in table 'CharacterSheets_Talents'
		ALTER TABLE [dbo].[CharacterSheets_Talents]
		ADD CONSTRAINT [FK_CharacterSheetsTalents_Talents]
			FOREIGN KEY ([Talents_Id])
			REFERENCES [dbo].[Talents]
				([Id])
			ON DELETE NO ACTION ON UPDATE NO ACTION;
		

		-- Creating non-clustered index for FOREIGN KEY 'FK_CharacterSheetsTalents_Talents'
		CREATE INDEX [IX_FK_CharacterSheetsTalents_Talents]
		ON [dbo].[CharacterSheets_Talents]
			([Talents_Id]);
		

		-- Creating foreign key on [CharacterSheet_Id] in table 'CharacterSheets_Items'
		ALTER TABLE [dbo].[CharacterSheets_Items]
		ADD CONSTRAINT [FK_CharacterSheetsItems_CharacterSheets]
			FOREIGN KEY ([CharacterSheet_Id])
			REFERENCES [dbo].[CharacterSheets]
				([Id])
			ON DELETE NO ACTION ON UPDATE NO ACTION;
		

		-- Creating foreign key on [Items_Id] in table 'CharacterSheets_Items'
		ALTER TABLE [dbo].[CharacterSheets_Items]
		ADD CONSTRAINT [FK_CharacterSheetsItems_Items]
			FOREIGN KEY ([Items_Id])
			REFERENCES [dbo].[Items]
				([Id])
			ON DELETE NO ACTION ON UPDATE NO ACTION;
		

		-- Creating non-clustered index for FOREIGN KEY 'FK_CharacterSheetsItems_Items'
		CREATE INDEX [IX_FK_CharacterSheetsItems_Items]
		ON [dbo].[CharacterSheets_Items]
			([Items_Id]);
		

		-- Creating foreign key on [CharacterSheet_Id] in table 'CharacterSheets_ForcePowers'
		ALTER TABLE [dbo].[CharacterSheets_ForcePowers]
		ADD CONSTRAINT [FK_CharacterSheetsForcePowers_CharacterSheets]
			FOREIGN KEY ([CharacterSheet_Id])
			REFERENCES [dbo].[CharacterSheets]
				([Id])
			ON DELETE NO ACTION ON UPDATE NO ACTION;
		

		-- Creating foreign key on [ForcePowers_Id] in table 'CharacterSheets_ForcePowers'
		ALTER TABLE [dbo].[CharacterSheets_ForcePowers]
		ADD CONSTRAINT [FK_CharacterSheetsForcePowers_ForcePowers]
			FOREIGN KEY ([ForcePowers_Id])
			REFERENCES [dbo].[ForcePowers]
				([Id])
			ON DELETE NO ACTION ON UPDATE NO ACTION;
		

		-- Creating non-clustered index for FOREIGN KEY 'FK_CharacterSheetsForcePowers_ForcePowers'
		CREATE INDEX [IX_FK_CharacterSheetsForcePowers_ForcePowers]
		ON [dbo].[CharacterSheets_ForcePowers]
			([ForcePowers_Id]);
		

		-- Creating foreign key on [Skills_Id] in table 'CharacterSheets'
		ALTER TABLE [dbo].[CharacterSheets]
		ADD CONSTRAINT [FK_CharacterSheetsSkills]
			FOREIGN KEY ([Skills_Id])
			REFERENCES [dbo].[Skills]
				([Id])
			ON DELETE NO ACTION ON UPDATE NO ACTION;
		

		-- Creating non-clustered index for FOREIGN KEY 'FK_CharacterSheetsSkills'
		CREATE INDEX [IX_FK_CharacterSheetsSkills]
		ON [dbo].[CharacterSheets]
			([Skills_Id]);
		

		-- Creating foreign key on [Feat_Id] in table 'Feats_CharacterSheets'
		ALTER TABLE [dbo].[Feats_CharacterSheets]
		ADD CONSTRAINT [FK_FeatsCharacterSheets_Feats]
			FOREIGN KEY ([Feat_Id])
			REFERENCES [dbo].[Feats]
				([Id])
			ON DELETE NO ACTION ON UPDATE NO ACTION;
		

		-- Creating foreign key on [CharacterSheets_Id] in table 'Feats_CharacterSheets'
		ALTER TABLE [dbo].[Feats_CharacterSheets]
		ADD CONSTRAINT [FK_FeatsCharacterSheets_CharacterSheets]
			FOREIGN KEY ([CharacterSheets_Id])
			REFERENCES [dbo].[CharacterSheets]
				([Id])
			ON DELETE NO ACTION ON UPDATE NO ACTION;
		

		-- Creating non-clustered index for FOREIGN KEY 'FK_FeatsCharacterSheets_CharacterSheets'
		CREATE INDEX [IX_FK_FeatsCharacterSheets_CharacterSheets]
		ON [dbo].[Feats_CharacterSheets]
			([CharacterSheets_Id]);
		

		-- Creating foreign key on [Users_Id] in table 'Characters'
		ALTER TABLE [dbo].[Characters]
		ADD CONSTRAINT [FK_UsersCharacters]
			FOREIGN KEY ([Users_Id])
			REFERENCES [dbo].[Users]
				([Id])
			ON DELETE NO ACTION ON UPDATE NO ACTION;
		

		-- Creating non-clustered index for FOREIGN KEY 'FK_UsersCharacters'
		CREATE INDEX [IX_FK_UsersCharacters]
		ON [dbo].[Characters]
			([Users_Id]);

			
		INSERT INTO [dbo].[Versions] ([Timestamp], [Version], [Description])
		VALUES (GetDate(), @version, 'Initial migration')
	COMMIT
END TRY
BEGIN CATCH
	ROLLBACK
	DECLARE @err_msg NVARCHAR(MAX)
	SET @err_msg = ERROR_MESSAGE() + '; Line #: ' + CAST(Error_Line() AS NVARCHAR) + '; Version number: ' + CAST(@version AS nvarchar)
	RAISERROR (@err_msg, 12, 1);
END CATCH