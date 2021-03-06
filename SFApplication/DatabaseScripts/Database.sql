USE [master]
GO
/****** Object:  Database [PowerApps]    Script Date: 01-Nov-18 4:46:00 PM ******/
CREATE DATABASE [PowerApps]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'PowerApps', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL13.DYNGP16\MSSQL\DATA\PowerApps.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'PowerApps_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL13.DYNGP16\MSSQL\DATA\PowerApps_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
GO
ALTER DATABASE [PowerApps] SET COMPATIBILITY_LEVEL = 130
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [PowerApps].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [PowerApps] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [PowerApps] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [PowerApps] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [PowerApps] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [PowerApps] SET ARITHABORT OFF 
GO
ALTER DATABASE [PowerApps] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [PowerApps] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [PowerApps] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [PowerApps] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [PowerApps] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [PowerApps] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [PowerApps] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [PowerApps] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [PowerApps] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [PowerApps] SET  DISABLE_BROKER 
GO
ALTER DATABASE [PowerApps] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [PowerApps] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [PowerApps] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [PowerApps] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [PowerApps] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [PowerApps] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [PowerApps] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [PowerApps] SET RECOVERY FULL 
GO
ALTER DATABASE [PowerApps] SET  MULTI_USER 
GO
ALTER DATABASE [PowerApps] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [PowerApps] SET DB_CHAINING OFF 
GO
ALTER DATABASE [PowerApps] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [PowerApps] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [PowerApps] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [PowerApps] SET QUERY_STORE = OFF
GO
USE [PowerApps]
GO
ALTER DATABASE SCOPED CONFIGURATION SET LEGACY_CARDINALITY_ESTIMATION = OFF;
GO
ALTER DATABASE SCOPED CONFIGURATION SET MAXDOP = 0;
GO
ALTER DATABASE SCOPED CONFIGURATION SET PARAMETER_SNIFFING = ON;
GO
ALTER DATABASE SCOPED CONFIGURATION SET QUERY_OPTIMIZER_HOTFIXES = OFF;
GO
USE [PowerApps]
GO
/****** Object:  User [sa_fc]    Script Date: 01-Nov-18 4:46:00 PM ******/
CREATE USER [sa_fc] FOR LOGIN [sa_fc] WITH DEFAULT_SCHEMA=[dbo]
GO
/****** Object:  User [lpalacio]    Script Date: 01-Nov-18 4:46:00 PM ******/
CREATE USER [lpalacio] FOR LOGIN [lpalacio] WITH DEFAULT_SCHEMA=[dbo]
GO
/****** Object:  User [FINELINE\ptrotman]    Script Date: 01-Nov-18 4:46:00 PM ******/
CREATE USER [FINELINE\ptrotman] FOR LOGIN [FINELINE\ptrotman] WITH DEFAULT_SCHEMA=[dbo]
GO
ALTER ROLE [db_owner] ADD MEMBER [sa_fc]
GO
ALTER ROLE [db_ddladmin] ADD MEMBER [sa_fc]
GO
ALTER ROLE [db_backupoperator] ADD MEMBER [sa_fc]
GO
ALTER ROLE [db_datareader] ADD MEMBER [sa_fc]
GO
ALTER ROLE [db_datawriter] ADD MEMBER [sa_fc]
GO
ALTER ROLE [db_owner] ADD MEMBER [lpalacio]
GO
ALTER ROLE [db_owner] ADD MEMBER [FINELINE\ptrotman]
GO
/****** Object:  Table [dbo].[tbl_Forecasts]    Script Date: 01-Nov-18 4:46:00 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tbl_Forecasts](
	[ForecastId] [int] IDENTITY(1,1) NOT NULL,
	[Year] [int] NULL,
	[CreateDate] [datetime] NULL,
	[CreatedBy] [int] NULL,
 CONSTRAINT [PK_tbl_Forecasts] PRIMARY KEY CLUSTERED 
(
	[ForecastId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tbl_ForecastItems]    Script Date: 01-Nov-18 4:46:00 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tbl_ForecastItems](
	[ForecastItemId] [int] IDENTITY(1,1) NOT NULL,
	[ForecastId] [int] NULL,
	[ItemId] [int] NULL,
	[ConsumedAvg] [decimal](12, 2) NULL,
	[ForecastValue] [decimal](12, 2) NULL,
	[RevisedForecastValueId] [int] NULL,
	[Month] [int] NULL,
 CONSTRAINT [PK_tbl_ForecastItems] PRIMARY KEY CLUSTERED 
(
	[ForecastItemId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tbl_ForecastRevisions]    Script Date: 01-Nov-18 4:46:00 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tbl_ForecastRevisions](
	[RevisionId] [int] IDENTITY(1,1) NOT NULL,
	[ForecastItemId] [int] NULL,
	[InitialRevision] [bit] NULL,
	[RevisedBy] [int] NULL,
	[RevisionDate] [datetime] NULL,
 CONSTRAINT [PK_tbl_ForecastRevisions] PRIMARY KEY CLUSTERED 
(
	[RevisionId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[gp_InventoryItems]    Script Date: 01-Nov-18 4:46:00 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[gp_InventoryItems](
	[ItemId] [int] IDENTITY(1,1) NOT NULL,
	[ITEMNMBR] [nvarchar](50) NULL,
	[ITEMDESC] [nvarchar](101) NULL,
	[ITEMSHWT] [decimal](18, 6) NULL,
	[VENDORID] [nvarchar](50) NULL,
	[VNDITNUM] [nvarchar](101) NULL,
	[VNDITDSC] [nvarchar](50) NULL,
	[DateCreated] [datetime] NULL,
	[SyncDate] [datetime] NULL,
	[CustomItem] [bit] NULL,
	[Synced] [bit] NULL,
 CONSTRAINT [PK_gp_InventoryItems] PRIMARY KEY CLUSTERED 
(
	[ItemId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tbl_ForecastRevisionDetails]    Script Date: 01-Nov-18 4:46:00 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tbl_ForecastRevisionDetails](
	[RevisionDetailId] [int] IDENTITY(1,1) NOT NULL,
	[RevisionId] [int] NULL,
	[GPCustomerNumber] [nvarchar](50) NULL,
	[ForecastValue] [decimal](12, 4) NULL,
	[DateCreated] [datetime] NULL,
 CONSTRAINT [PK_tbl_ForecastRevisionDetails] PRIMARY KEY CLUSTERED 
(
	[RevisionDetailId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  UserDefinedFunction [dbo].[AAA2018_GET_FORECAST_SUMMARY_DATA]    Script Date: 01-Nov-18 4:46:00 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Prince Trotman
-- Create date: 2018-11-01
-- Description:	Populates forecas tool with summary data
-- =============================================
CREATE FUNCTION  [dbo].[AAA2018_GET_FORECAST_SUMMARY_DATA]
(	
	-- Add the parameters for the function here
	@ForecastId int
)
RETURNS TABLE AS

RETURN 
(
	WITH d AS (
		SELECT 
		 f.ForecastId, f.[Year]
		 ,fi.ForecastItemId, fi.[Month], fi.ItemId
		 ,original.ForecastValue as Original
		 ,revised.ForecastValue as Revised
		FROM 
			tbl_Forecasts f
			LEFT JOIN tbl_ForecastItems fi ON fi.ForecastId = f.ForecastId
			--LEFT JOIN tbl_ForecastRevisions fr ON fr.ForecastItemId = fi.ForecastItemId
			OUTER APPLY(
					SELECT fr.RevisionId, fr.RevisionDate, fr.InitialRevision 
						,SUM(ISNULL(frd.ForecastValue,0)) as ForecastValue
					FROM 
						tbl_ForecastRevisions fr
						LEFT JOIN tbl_ForecastRevisionDetails frd on frd.RevisionId = fr.RevisionId
					WHERE
						fr.ForecastItemId = fi.ForecastItemId
						AND fr.InitialRevision = 1
					GROUP BY 
						fr.RevisionId, fr.RevisionDate, fr.InitialRevision
			) as original
			OUTER APPLY(
					SELECT TOP 1 fr.RevisionId, fr.RevisionDate, fr.InitialRevision 
						,SUM(ISNULL(frd.ForecastValue,0)) as ForecastValue
					FROM 
						tbl_ForecastRevisions fr
						LEFT JOIN tbl_ForecastRevisionDetails frd on frd.RevisionId = fr.RevisionId
					WHERE
						fr.ForecastItemId = fi.ForecastItemId
						AND fr.InitialRevision = 0
					GROUP BY 
						fr.RevisionId, fr.RevisionDate, fr.InitialRevision
					ORDER BY
						fr.RevisionDate DESC
			) as revised
		WHERE 
			f.ForecastId = @ForecastId)

	SELECT 
		d.ForecastId, d.[Year], d.ForecastItemId, d.[Month], gpi.ItemId
		,ISNULL(d.Original,0) as Original
		,ISNULL(d.Revised,0) as Revised
		,gpi.ITEMNMBR as ItemNumber
		,gpi.ITEMDESC as ItemDescription
		,gpi.ITEMSHWT as ItemWeight
		,gpi.VENDORID as VendorId
		,gpi.VNDITNUM as VendorItemNumber
		,gpi.VNDITDSC as VendorItemDescription
		,gpi.CustomItem
		,gpi.Synced
	 FROM d
	FULL OUTER JOIN gp_InventoryItems gpi on d.ItemId = gpi.ItemId
)
GO
/****** Object:  Table [dbo].[tbl_AuditLogs]    Script Date: 01-Nov-18 4:46:00 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tbl_AuditLogs](
	[AuditLogId] [int] IDENTITY(1,1) NOT NULL,
	[AuditLog] [xml] NULL,
 CONSTRAINT [PK_tbl_AuditLogs] PRIMARY KEY CLUSTERED 
(
	[AuditLogId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tbl_ForecastDetails]    Script Date: 01-Nov-18 4:46:00 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tbl_ForecastDetails](
	[ForecastDetailId] [int] IDENTITY(1,1) NOT NULL,
	[RevisionId] [int] NULL,
	[CustomerId] [int] NULL,
	[CustomerName] [nvarchar](100) NULL,
	[ForecastValue] [int] NULL,
	[PreviousYearConsumption] [int] NULL,
	[DateCreated] [datetime] NULL,
 CONSTRAINT [PK_tbl_ForecastDetails] PRIMARY KEY CLUSTERED 
(
	[ForecastDetailId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tbl_GroupRoles]    Script Date: 01-Nov-18 4:46:00 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tbl_GroupRoles](
	[GroupId] [int] NOT NULL,
	[RoleId] [int] NOT NULL,
 CONSTRAINT [PK_tbl_GroupRoles] PRIMARY KEY CLUSTERED 
(
	[GroupId] ASC,
	[RoleId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tbl_UserGroups]    Script Date: 01-Nov-18 4:46:00 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tbl_UserGroups](
	[GroupId] [int] IDENTITY(1,1) NOT NULL,
	[GroupName] [nvarchar](50) NULL,
	[DateCreated] [datetime] NULL,
 CONSTRAINT [PK_tbl_UserGroups] PRIMARY KEY CLUSTERED 
(
	[GroupId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tbl_Users]    Script Date: 01-Nov-18 4:46:01 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tbl_Users](
	[UserId] [int] IDENTITY(1,1) NOT NULL,
	[UserName] [nvarchar](56) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[UserId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY],
UNIQUE NONCLUSTERED 
(
	[UserName] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tbl_UsersInGroups]    Script Date: 01-Nov-18 4:46:01 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tbl_UsersInGroups](
	[GroupId] [int] NOT NULL,
	[UserId] [int] NOT NULL,
 CONSTRAINT [PK_tbl_UsersInGroups] PRIMARY KEY CLUSTERED 
(
	[GroupId] ASC,
	[UserId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[webpages_Membership]    Script Date: 01-Nov-18 4:46:01 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[webpages_Membership](
	[UserId] [int] NOT NULL,
	[CreateDate] [datetime] NULL,
	[ConfirmationToken] [nvarchar](128) NULL,
	[IsConfirmed] [bit] NULL,
	[LastPasswordFailureDate] [datetime] NULL,
	[PasswordFailuresSinceLastSuccess] [int] NOT NULL,
	[Password] [nvarchar](128) NOT NULL,
	[PasswordChangedDate] [datetime] NULL,
	[PasswordSalt] [nvarchar](128) NOT NULL,
	[PasswordVerificationToken] [nvarchar](128) NULL,
	[PasswordVerificationTokenExpirationDate] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[UserId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[webpages_OAuthMembership]    Script Date: 01-Nov-18 4:46:01 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[webpages_OAuthMembership](
	[Provider] [nvarchar](30) NOT NULL,
	[ProviderUserId] [nvarchar](100) NOT NULL,
	[UserId] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[Provider] ASC,
	[ProviderUserId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[webpages_Roles]    Script Date: 01-Nov-18 4:46:01 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[webpages_Roles](
	[RoleId] [int] IDENTITY(1,1) NOT NULL,
	[RoleName] [nvarchar](256) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[RoleId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY],
UNIQUE NONCLUSTERED 
(
	[RoleName] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[webpages_UsersInRoles]    Script Date: 01-Nov-18 4:46:01 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[webpages_UsersInRoles](
	[UserId] [int] NOT NULL,
	[RoleId] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[UserId] ASC,
	[RoleId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[webpages_Membership] ADD  DEFAULT ((0)) FOR [IsConfirmed]
GO
ALTER TABLE [dbo].[webpages_Membership] ADD  DEFAULT ((0)) FOR [PasswordFailuresSinceLastSuccess]
GO
ALTER TABLE [dbo].[webpages_UsersInRoles]  WITH CHECK ADD  CONSTRAINT [fk_RoleId] FOREIGN KEY([RoleId])
REFERENCES [dbo].[webpages_Roles] ([RoleId])
GO
ALTER TABLE [dbo].[webpages_UsersInRoles] CHECK CONSTRAINT [fk_RoleId]
GO
ALTER TABLE [dbo].[webpages_UsersInRoles]  WITH CHECK ADD  CONSTRAINT [fk_UserId] FOREIGN KEY([UserId])
REFERENCES [dbo].[tbl_Users] ([UserId])
GO
ALTER TABLE [dbo].[webpages_UsersInRoles] CHECK CONSTRAINT [fk_UserId]
GO
/****** Object:  StoredProcedure [dbo].[AAA2018_SYNC_GP_ITEMS]    Script Date: 01-Nov-18 4:46:01 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Prince Trotman
-- Create date: 29 Oct 2018
-- Description:	Syncs new items from GP to FC
-- =============================================
CREATE PROCEDURE [dbo].[AAA2018_SYNC_GP_ITEMS]
	-- Add the parameters for the stored procedure here
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	--link temp FC items to new GP items
	SELECT * FROM 
		FDL.DBO.IV00101 itm
		LEFT JOIN FDL.DBO.IV00103 iv on iv.ITEMNMBR = itm.ITEMNMBR
	WHERE iv.VNDITNUM IN (SELECT DISTINCT VNDITNUM FROM gp_InventoryItems WHERE CustomItem = 1 AND ITEMNMBR IS NULL)

	IF @@ROWCOUNT > 0
	BEGIN
		UPDATE 
			fcitm
		SET
			fcitm.ITEMNMBR = rtrim(gpitm.ITEMNMBR),
			fcitm.ITEMSHWT = rtrim(gpitm.ITEMSHWT),
			fcitm.ITEMDESC = rtrim(gpitm.ITEMDESC),
			fcitm.VENDORID = rtrim(iv.VENDORID),
			fcitm.VNDITDSC = rtrim(iv.VNDITDSC),
			fcitm.SyncDate = CURRENT_TIMESTAMP,
			fcitm.Synced = 1
		FROM 
			gp_InventoryItems fcitm
			INNER JOIN FDL.DBO.IV00103 iv on rtrim(iv.VNDITNUM) = rtrim(fcitm.VNDITNUM)
			LEFT JOIN FDL.DBO.IV00101 gpitm on rtrim(gpitm.ITEMNMBR) = rtrim(iv.ITEMNMBR)
		WHERE 
			fcitm.CustomItem = 1 
			AND fcitm.ITEMNMBR IS NULL
	END

	--add new items items from GP
	;WITH items  AS(		   
		SELECT 
		TOP 20 --temporary amount TO BO REMOVED
			itm.ITEMNMBR
			,itm.ITEMDESC
			,itm.ITEMSHWT
			,v.VENDORID
			,iv.VNDITNUM
			,iv.VNDITDSC
			,CURRENT_TIMESTAMP as DateCreated
			,CURRENT_TIMESTAMP as SyncDate
			,0 as CustomItem
			,0 as Synced
		FROM 
			FDL.DBO.IV00101 itm
			LEFT JOIN FDL.DBO.IV00103 iv on iv.ITEMNMBR = itm.ITEMNMBR
			LEFT JOIN FDL.DBO.PM00200 v on v.VENDORID = iv.VENDORID
		WHERE 
			itm.INACTIVE = 0)
	
	--add new items
	INSERT INTO [dbo].[gp_InventoryItems]
			   (ITEMNMBR, ITEMDESC, ITEMSHWT, VENDORID, VNDITNUM, VNDITDSC, DateCreated, SyncDate, CustomItem, Synced) -- exclude existing items

	SELECT 
		rtrim(ITEMNMBR), rtrim(ITEMDESC), rtrim(ITEMSHWT), rtrim(VENDORID), rtrim(VNDITNUM), rtrim(VNDITDSC), DateCreated, SyncDate, CustomItem, Synced 
	FROM 
		items 
	WHERE 
		rtrim(items.ITEMNMBR) not in (SELECT DISTINCT rtrim(ITEMNMBR) FROM [dbo].[gp_InventoryItems])
END


/*
exec [AAA2018_SYNC_GP_ITEMS]
*/
GO
USE [master]
GO
ALTER DATABASE [PowerApps] SET  READ_WRITE 
GO
