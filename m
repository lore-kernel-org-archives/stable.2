Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11010009.outbound.protection.outlook.com [52.101.84.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E5BD4D4899;
	Thu, 17 Sep 2026 15:10:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.84.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789657843; cv=fail; b=BFcK32zR4OsFVNlVXbpUC/XuWUg0gHtIyuzM0D1Tbp9AQIgOpteAez8IiUTrsLdCFJPhEUNqNxy2KNnNr1eK+S4C1HuN9/6C3utibUTls4FaePchkSlQMZ/1PmbX2yi4yWMFH6CS3rsDhheb5XNuWAoyz1DquVAAYnhvnaltIjA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789657843; c=relaxed/simple;
	bh=pb/xpp76qLu+RbdYYcy+50NmbUNFuJF6WXYw1R1Xqcc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=OdsOoo2o2Kq0P7sSqGLmWwk1eVFPOuNd6lqYfK7awk2PC55EvdQWVe4MA7jcmRJNgGlz1lp2edHIwDbthELZ5Tct34tF7fdcv3UZJ5dEHxd1tqkCwASuqQZiq0zc9bBvquM8DPQWvd+S1nKO7Bfbcp+f+EwlP5nD57zKl1JXXh4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=pOb8huDW; arc=fail smtp.client-ip=52.101.84.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="pOb8huDW"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vPeOgPe39xphLXdOzrDIxHvcIYPIBVbphp3JmpbCj6QMm5E9/dlzGS2H8PfJRja1p9nY3RdPLssHcTBRywubgrmG4rgSWYvojCSEs670dFtuU+KI1edJF1Dpbv76wSuxJwHbFZutDIf33etIrogfRh/y2ThaUmbaJdEHxMmDFIwbLPsvHieRTBPMF09WGbMtlAfP07+H3KXXLxaN94FWREPuOxaPX1oHTqzYmYuXTJNruyD8HS35rLqHagV7ZEE2t+qu9cuPDriRQGMzHBBX6hDnruf7tPKa8cPIKIoW53X1UuUeoO4DA/OxquZ233hg8/HHawUX6qLubp4jI3Dy2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WoHnMv9dr3xSggpURxi8oERQZtmvbq3yfDyhD8SoiZ4=;
 b=I+2Uha6HSlXzxnadoN9GQVU2PwDE5CZPWOatNmmWs4atHbHSb6PXNoieGp5p/ohSq3p318b5xQ0QslSYVmLtFlJF1k7Cp7zSDCdMDAZ7xnl4qO0l7t/N5xOFN1IEtu6+G7SXcGHikL5PCiDTXnSD1b3v7+VgWvd1ANWeJGYCNj9xA6Eoa5NegKdJwfhIzNrjbec0IKBKLUoiF542xaScO8GBSLwoczXUZ1mzR1/xNrZ4RBvybpPRsLRXOrArG3Fh+6V8H4aLLi9eIdBMGwcH7sEs0cg8ijzlzybVW56rLKUsxQ1CoxBxlaO+yf07YNUDJ6gn3RDQU8u0TlRUBapn+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WoHnMv9dr3xSggpURxi8oERQZtmvbq3yfDyhD8SoiZ4=;
 b=pOb8huDWpblwTGG2wnfhRJ0dgjuD0Dw1x2ERwfzbwyET5+XV4TAGocgftyEjPs0hFH7uITuJQhc5VFuiGssQ+TB/um9lGQNEJn26kVhbAvZOC70qrOosv+A2ku+bXBeTnT7bnHnq7C6yMXX4indn2arQ1GdVeWOf7IpYJonlsYEdx8cp/5ezBSmXNKe1nzBEP6FI0hQOBmkoOtynM9bvnQeMiWjRO1oI4/3RUvr5KFqnJhWG1wrPwQyFj5ja62ux5v4DwEOITHXDaRgSCgpuow2MeMhjChsrZyx+v4FTkOU8Pi2k1s7/sp2MU2R1+QGu4iQHeKQQkqFysNb48oojWw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from AS8PR04MB9079.eurprd04.prod.outlook.com (2603:10a6:20b:446::12)
 by GVXPR04MB10564.eurprd04.prod.outlook.com (2603:10a6:150:215::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.12; Thu, 17 Sep
 2026 15:10:25 +0000
Received: from AS8PR04MB9079.eurprd04.prod.outlook.com
 ([fe80::9761:3d78:e9db:2308]) by AS8PR04MB9079.eurprd04.prod.outlook.com
 ([fe80::9761:3d78:e9db:2308%6]) with mapi id 15.21.0406.007; Thu, 17 Sep 2026
 15:10:25 +0000
Date: Thu, 17 Sep 2026 10:10:18 -0500
From: "han.xu" <han.xu@oss.nxp.com>
To: Frieder Schrempf <frieder@fris.de>
Cc: Han Xu <han.xu@nxp.com>, Mark Brown <broonie@kernel.org>, 
	Miquel Raynal <miquel.raynal@bootlin.com>, linux-spi@vger.kernel.org, imx@lists.linux.dev, 
	linux-kernel@vger.kernel.org, Frieder Schrempf <frieder.schrempf@kontron.de>, 
	stable@vger.kernel.org
Subject: Re: [PATCH] spi: fsl-qspi: Reprogram the clock rate when the
 operation frequency changes
Message-ID: <aqwCpIcNn-hsR0Ii@cozumel>
References: <20260917-fsl-qspi-freq-op-fix-v1-1-5fbe6b02f738@kontron.de>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260917-fsl-qspi-freq-op-fix-v1-1-5fbe6b02f738@kontron.de>
X-ClientProxiedBy: CY5PR17CA0002.namprd17.prod.outlook.com
 (2603:10b6:930:17::22) To AS8PR04MB9079.eurprd04.prod.outlook.com
 (2603:10a6:20b:446::12)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB9079:EE_|GVXPR04MB10564:EE_
X-MS-Office365-Filtering-Correlation-Id: 1b8fc4e1-8c50-4c39-edeb-08df14cdccdb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|366016|376014|19092799006|1800799024|6133799003|10067099003|56012099006|11063799006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	BCOgnacmEjDlhdbEF+c8UNT4ee2TDo1glgwGSWZmqwpmNHPD35RP5cFuYTrl6vgbzggU8ZRY5ttpOqXkXu3VRPeut4o2+q0NqGSTB9hi1uSVSBVpf8vubLzLlKO6ROlfn9TWmLUZfz5OV5mhVwSEaxok2+/4VB2dw0AMonwClaAl0QzUbiwVG5wSC1ouxfX+LPS8LWwavf6dkJQ39XuNYYnaBl3+2sOAvtU4rWvjuSeGxGN6VyRRooS52Ls8KXE/dGtIdRmjp/06Toyalz9pmwKKyIY4ummxOIoC+UBkhunGxedtmT8kaNlMvK5g0qKSA+oGcTVVSZyppvp7pg7FGlIYLqta/m9WXJvloxlM/ZobbO/l6BX/cR7KKvbiXYaLaooh3XXhHSOlC6ljB1bS0pLDICWnvuHb8VgZodpoxml40kZfAMb0SFccgEAU7MO0hFqG85iuIeR+AJJqrlDg1NZ66+w2CrOqy3AZwoQnYr5ZbBI+R93OW8sOZakiJoz4vBFKh/LmF/LcuXBFB50Ntx/uW2QKx9sHQOlBcEbSevTFMJPc5MEo2QvkCVXfFs+2Dd8ntnf3CNX3EQzHD7ounAPBvUpUWRVB3Ks7QVqUpB0rMferbZj6ysBufXXV9s2LYHZiAz7jkk5MdtGveSu3X5u7QZZ9vVV2MRH4qneOjBo=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB9079.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(366016)(376014)(19092799006)(1800799024)(6133799003)(10067099003)(56012099006)(11063799006)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?iTvXeEm3dtQmj5TkrPjs72vNlByULB0yubotlrb9o99uOeJTil1ify43/U9F?=
 =?us-ascii?Q?jNjCk+r9nBR38gT6zLoyR12TUKP5i3o6SOmQsy6weiBEne4GmH5pTCArZCXY?=
 =?us-ascii?Q?p2geGU1au430oLdJ3qKzpKGnapth2c81e0HP1vtDmIY0XBXuBT4+scG43LRM?=
 =?us-ascii?Q?v2axxcLhwOGhzK50bbTktb3CSjJD8B0etOXNh+FQSi7mlS4gAg+XWRsLv8/0?=
 =?us-ascii?Q?GDBGUUWklgeVxOi59NGANUia3eC3PapStuqJbChAoaxFJEb+/XcdsSakKia0?=
 =?us-ascii?Q?3Wd/2rBbvczlzpHhNzzBL7emr3/v2XJTddnSBv87NpXkwBccmPpXxEXlFP2Z?=
 =?us-ascii?Q?tpoIxUo8RsfHVBHxb+BeZyAI3qITiHE7xOEOW/8Edf2ug3/S7vUNNgHTVOpi?=
 =?us-ascii?Q?/wFDeK/dQr2v9C1QcUwKfMibGQkF+O5YwTHzqEcqYhj1FtMUHxEkElaydyh7?=
 =?us-ascii?Q?CTtUd1MJm7NR1SAdPQ6FyN3YUPGs1PIdoj+P0lBsl4s9Q1E1HlSclRv/uxxg?=
 =?us-ascii?Q?PD/72KDqjl8meGsVFAuUsRlDUrpfYgBnYXGGtka0sjaT8JIIDGs6EC6A3f2N?=
 =?us-ascii?Q?GeFSL55XiEUS4yPORbBd30nXggc0kQuvGDrLqntdGTVtSiC8YShsKEfLTIXD?=
 =?us-ascii?Q?oIunXiz0PGVkceMuOEGEWlHLOelp2/urH28kGHpbYufWgpLBDtEo/AJRaH2E?=
 =?us-ascii?Q?+E/WQZ8348cp/xqhenfk66PJwPa/zuRK7HlvI5SFdzRXdH5YgzWUXHEYnwht?=
 =?us-ascii?Q?6WcACAtl79yPGh4JF2TYUPki59x/RSx/NAGFseoT+yUp9c1fihwkPJhLPM7a?=
 =?us-ascii?Q?sbRbMog0sonngNItICMJfOwtDXkBR8VjRoj/Sh+3LEcrELLJZFf/G0TFEQkZ?=
 =?us-ascii?Q?IRtyeOqB0q2T8LVh61QEkh5aM4w6Eu4yE/CKWRP/Lzndlw1/kdzNXh4jKkh8?=
 =?us-ascii?Q?L7uOIcyEe9z0X6rkd0JbMKvQQLGPbJciuS6R/DITMFQBjfRjGfzk3SoS0w1d?=
 =?us-ascii?Q?1zRIHq5dkV+mUbtXpaf45yi/WgH7qUoqtgkl9Lu8boeESuloBq05vvWTSksM?=
 =?us-ascii?Q?t4AbdCJ0lmlclD10Y47K3MhK0Rp0Y2wUygy6eDsAWHhylOdI/0Qd/zI10ICk?=
 =?us-ascii?Q?ENXOfpzstT7IlIyQmYbJ5bW81pltxYuVZ9NLlZDZ/M4MIHIslubHPsITSAWT?=
 =?us-ascii?Q?xAdkERICfHcGF3gzn1MrSpTYS3Voyp8yARGl2+3l36CBjStiOj+8OzDC7IvB?=
 =?us-ascii?Q?bpRjWlxtsN1CY7Vl313xr3sVqf/Y/nPNK5YXoLySVIDEqzrSQutTlkQeAbmj?=
 =?us-ascii?Q?4SPIyKR1DCANxIzNSB5nhlPsuZTQ6Yie985yFofE6UZS1rBPAmpBxZLMfjP9?=
 =?us-ascii?Q?q9E5jMyoHW43XytEG5Uyd0YG3j/LCB2owO9bMCy72RMkOI/wDoxrB3azt9HE?=
 =?us-ascii?Q?Ynd/AnRO581PJzp0Fmdgn8Za5MH3bLRprIZFj9mMufn6EzBUzTbwgupprAaX?=
 =?us-ascii?Q?GPqFe23P68UPS3eiw/l7Po9XzQvVNaNw7stwEcUZRBWf/sTFIQGVj/j3hK/O?=
 =?us-ascii?Q?qjICMk2PvcOP+o8UUIA/B9D1AoGDrzVZLTMkYT/t6/HoUog7KuH77AG2qOyZ?=
 =?us-ascii?Q?AV0xMRoVQUR17a+m7T9RgcfMTkPotU5vmZ/6VcELMBfdP1QNCrO42ziqsvP+?=
 =?us-ascii?Q?xXTGTDFB/GvIwhun/Tm4UCfft66Q9R3FAtuTyFj57OBQjfrdsFae1yCRAW5h?=
 =?us-ascii?Q?mSFA6/bFUa1Dtr4Nwv19k8QAAmH6diZ3pXVYv3ABxV9KPATpIfCj?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1b8fc4e1-8c50-4c39-edeb-08df14cdccdb
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB9079.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Sep 2026 15:10:25.3191
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yPtp2ZGoNVOOMkjLsU9I34ZxE6kO6RiJcra9kjMjTJ4ehF9z5hmRYqTBI14FjmVw2oBm154BswVqKazUX5pAtS/+X83taLz5FwopO5CEJOs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR04MB10564

On 26/09/17 04:10PM, Frieder Schrempf wrote:
> From: Frieder Schrempf <frieder.schrempf@kontron.de>
> 
> fsl_qspi_select_mem() returns early when the chip select has not changed,
> which happens before it reaches clk_set_rate(). Since the rate is now
> taken from the spi-mem operation rather than from the SPI device, the
> controller honours op->max_freq exactly once per chip select and ignores
> it for every operation after that.
> 
> q->selected is only reset to -1 in fsl_qspi_default_setup(), i.e. at probe
> and on resume, so on the common single chip select board the very first
> operation latches a rate that all subsequent operations inherit, whatever
> frequency they asked for.
> 
> This results in operations being issued with the wrong frequency.
> 
> Cache the operation frequency the clock was programmed for next to the
> selected chip select, and redo the clock setup when either changes.
> 
> Fixes: 2438db5253eb ("spi: fsl-qspi: Support per spi-mem operation frequency switches")
> Cc: stable@vger.kernel.org
> Assisted-by: Claude:claude-opus-5
> Signed-off-by: Frieder Schrempf <frieder.schrempf@kontron.de>

Acked-by: Han Xu <han.xu@nxp.com>

> ---
> The bug is visible on an i.MX6UL board with a Winbond SPI NAND and
> spi-max-frequency = <104000000>: the QSPI clock keeps the rate programmed
> for the first operation for the lifetime of the system, regardless of what
> later operations ask for.
> 
> Here is a simple showcase with a SPI NAND where the max freq for the
> read ops was artificially limited to 25 MHz.
> 
> cd /sys/kernel/debug/tracing
> echo 1 > events/clk/clk_set_rate/enable
> echo 1 > events/spi-mem/spi_mem_start_op/enable
> echo > trace
> dd if=/dev/mtd0 of=/dev/null bs=1k count=4
> 
> Without fix the clock is set to the high rate initially and never changed:
> 
> clk_set_rate: qspi1_podf 396000000
> clk_set_rate: qspi1 396000000
> [...]
> spi_mem_start_op: 21e0000.spi 1S-1S-0S @104000000 Hz op=[13-00-00-00] len=0 tx=[]
> spi_mem_start_op: 21e0000.spi 1S-1S-1S @104000000 Hz op=[0f-c0] len=1 tx=[]
> spi_mem_start_op: 21e0000.spi 1S-4S-4S @25000000 Hz op=[eb-00-00-ff-ff] len=1024 tx=[]
> spi_mem_start_op: 21e0000.spi 1S-4S-4S @25000000 Hz op=[eb-04-00-ff-ff] len=1024 tx=[]
> spi_mem_start_op: 21e0000.spi 1S-1S-0S @104000000 Hz op=[13-00-00-00] len=0 tx=[]
> spi_mem_start_op: 21e0000.spi 1S-1S-1S @104000000 Hz op=[0f-c0] len=1 tx=[]
> spi_mem_start_op: 21e0000.spi 1S-4S-4S @25000000 Hz op=[eb-00-00-ff-ff] len=1024 tx=[]
> spi_mem_start_op: 21e0000.spi 1S-4S-4S @25000000 Hz op=[eb-04-00-ff-ff] len=1024 tx=[]
> 
> With the fix the clock is actually changed according to what was
> requested by the op:
> 
> spi_mem_start_op: 21e0000.spi 1S-1S-0S @104000000 Hz op=[13-00-00-00] len=0 tx=[]
> clk_set_rate: qspi1_podf 396000000
> clk_set_rate: qspi1 396000000
> spi_mem_start_op: 21e0000.spi 1S-1S-1S @104000000 Hz op=[0f-c0] len=1 tx=[]
> spi_mem_start_op: 21e0000.spi 1S-4S-4S @25000000 Hz op=[eb-00-00-ff-ff] len=1024 tx=[]
> clk_set_rate: qspi1_podf 99000000
> clk_set_rate: qspi1 99000000
> spi_mem_start_op: 21e0000.spi 1S-4S-4S @25000000 Hz op=[eb-04-00-ff-ff] len=1024 tx=[]
> spi_mem_start_op: 21e0000.spi 1S-1S-0S @104000000 Hz op=[13-00-00-00] len=0 tx=[]
> clk_set_rate: qspi1_podf 396000000
> clk_set_rate: qspi1 396000000
> spi_mem_start_op: 21e0000.spi 1S-1S-1S @104000000 Hz op=[0f-c0] len=1 tx=[]
> spi_mem_start_op: 21e0000.spi 1S-4S-4S @25000000 Hz op=[eb-00-00-ff-ff] len=1024 tx=[]
> clk_set_rate: qspi1_podf 99000000
> clk_set_rate: qspi1 99000000
> spi_mem_start_op: 21e0000.spi 1S-4S-4S @25000000 Hz op=[eb-04-00-ff-ff] len=1024 tx=[]
> ---
>  drivers/spi/spi-fsl-qspi.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/spi/spi-fsl-qspi.c b/drivers/spi/spi-fsl-qspi.c
> index 57358851029b..d2c2090442f8 100644
> --- a/drivers/spi/spi-fsl-qspi.c
> +++ b/drivers/spi/spi-fsl-qspi.c
> @@ -289,6 +289,7 @@ struct fsl_qspi {
>  	struct pm_qos_request pm_qos_req;
>  	struct device *dev;
>  	int selected;
> +	u32 selected_freq;
>  	u32 memmap_phy;
>  };
>  
> @@ -551,7 +552,8 @@ static void fsl_qspi_select_mem(struct fsl_qspi *q, struct spi_device *spi,
>  	unsigned long rate = op->max_freq;
>  	int ret;
>  
> -	if (q->selected == spi_get_chipselect(spi, 0))
> +	if (q->selected == spi_get_chipselect(spi, 0) &&
> +	    q->selected_freq == op->max_freq)
>  		return;
>  
>  	if (needs_4x_clock(q))
> @@ -571,6 +573,7 @@ static void fsl_qspi_select_mem(struct fsl_qspi *q, struct spi_device *spi,
>  	}
>  
>  	q->selected = spi_get_chipselect(spi, 0);
> +	q->selected_freq = op->max_freq;
>  
>  	fsl_qspi_invalidate(q);
>  }
> 
> ---
> base-commit: 238650ef6c7c7cca08e032527329424c9fbd70e5
> change-id: 20260917-fsl-qspi-freq-op-fix-f38fedb13100
> 
> Best regards,
> --  
> Frieder Schrempf <frieder.schrempf@kontron.de>
> 
