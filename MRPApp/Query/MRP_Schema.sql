USE [MRP]
GO
/****** Object:  Table [dbo].[Process]    Script Date: 2021-07-01 오후 2:06:06 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Process](
	[PrcIdx] [int] IDENTITY(1,1) NOT NULL,
	[SchIdx] [int] NOT NULL,
	[PrcCD] [char](14) NOT NULL,
	[PrcDate] [date] NOT NULL,
	[PrcLoadTime] [int] NULL,
	[PrcStartTime] [time](7) NULL,
	[PrcEndTime] [time](7) NULL,
	[PrcFacilityID] [char](8) NULL,
	[PrcResult] [bit] NOT NULL,
	[ModID] [varchar](20) NULL,
	[RegDate] [datetime] NULL,
	[RegID] [varchar](20) NULL,
	[ModDate] [datetime] NULL,
 CONSTRAINT [PK_Process] PRIMARY KEY CLUSTERED 
(
	[PrcIdx] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY],
 CONSTRAINT [UK_Process_PrcCD] UNIQUE NONCLUSTERED 
(
	[PrcCD] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Schedules]    Script Date: 2021-07-01 오후 2:06:06 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Schedules](
	[SchIdx] [int] IDENTITY(1,1) NOT NULL,
	[PlantCode] [char](8) NULL,
	[SchDate] [date] NOT NULL,
	[SchLoadTime] [int] NOT NULL,
	[SchStartTime] [time](7) NULL,
	[SchEndTime] [time](7) NULL,
	[SchFacilityID] [char](8) NULL,
	[SchAmount] [int] NOT NULL,
	[RegDate] [datetime] NULL,
	[RegID] [varchar](20) NULL,
	[ModDate] [datetime] NULL,
	[ModID] [varchar](20) NULL,
 CONSTRAINT [PK_Schedules] PRIMARY KEY CLUSTERED 
(
	[SchIdx] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Settings]    Script Date: 2021-07-01 오후 2:06:06 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Settings](
	[BasicCode] [char](8) NOT NULL,
	[CodeName] [nvarchar](100) NOT NULL,
	[CodeDesc] [nvarchar](max) NULL,
	[RegDate] [datetime] NULL,
	[RegID] [varchar](20) NULL,
	[ModDate] [datetime] NULL,
	[ModID] [varchar](20) NULL,
 CONSTRAINT [PK_Settings] PRIMARY KEY CLUSTERED 
(
	[BasicCode] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
ALTER TABLE [dbo].[Process]  WITH NOCHECK ADD  CONSTRAINT [FK_Process_Schedules] FOREIGN KEY([SchIdx])
REFERENCES [dbo].[Schedules] ([SchIdx])
GO
ALTER TABLE [dbo].[Process] NOCHECK CONSTRAINT [FK_Process_Schedules]
GO
ALTER TABLE [dbo].[Process]  WITH NOCHECK ADD  CONSTRAINT [FK_Process_Settings] FOREIGN KEY([PrcFacilityID])
REFERENCES [dbo].[Settings] ([BasicCode])
GO
ALTER TABLE [dbo].[Process] NOCHECK CONSTRAINT [FK_Process_Settings]
GO
ALTER TABLE [dbo].[Schedules]  WITH NOCHECK ADD  CONSTRAINT [FK_Schedules_Settings] FOREIGN KEY([PlantCode])
REFERENCES [dbo].[Settings] ([BasicCode])
GO
ALTER TABLE [dbo].[Schedules] NOCHECK CONSTRAINT [FK_Schedules_Settings]
GO
ALTER TABLE [dbo].[Schedules]  WITH NOCHECK ADD  CONSTRAINT [FK_Schedules_Settings1] FOREIGN KEY([SchFacilityID])
REFERENCES [dbo].[Settings] ([BasicCode])
GO
ALTER TABLE [dbo].[Schedules] NOCHECK CONSTRAINT [FK_Schedules_Settings1]
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'수정자' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Process', @level2type=N'COLUMN',@level2name=N'ModID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'작성일' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Process', @level2type=N'COLUMN',@level2name=N'RegDate'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'작성자' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Process', @level2type=N'COLUMN',@level2name=N'RegID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'수정일' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Process', @level2type=N'COLUMN',@level2name=N'ModDate'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'공정계획 순번' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Schedules', @level2type=N'COLUMN',@level2name=N'SchIdx'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'공정코드' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Schedules', @level2type=N'COLUMN',@level2name=N'PlantCode'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'공정계획일' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Schedules', @level2type=N'COLUMN',@level2name=N'SchDate'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'로드타임(초)' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Schedules', @level2type=N'COLUMN',@level2name=N'SchLoadTime'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'시작시간(계획)' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Schedules', @level2type=N'COLUMN',@level2name=N'SchStartTime'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'종료시간(계획)' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Schedules', @level2type=N'COLUMN',@level2name=N'SchEndTime'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'생산설비ID' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Schedules', @level2type=N'COLUMN',@level2name=N'SchFacilityID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'계획수량' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Schedules', @level2type=N'COLUMN',@level2name=N'SchAmount'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'작성일' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Schedules', @level2type=N'COLUMN',@level2name=N'RegDate'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'작성자' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Schedules', @level2type=N'COLUMN',@level2name=N'RegID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'수정일' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Schedules', @level2type=N'COLUMN',@level2name=N'ModDate'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'수정자' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Schedules', @level2type=N'COLUMN',@level2name=N'ModID'
GO
