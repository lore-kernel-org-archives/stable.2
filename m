Received: from PH0PR06CU001.outbound.protection.outlook.com (mail-westus3azon11011052.outbound.protection.outlook.com [40.107.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06CB33BBA04
	for <stable@vger.kernel.org>; Fri, 21 Aug 2026 11:42:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.208.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787312530; cv=fail; b=qA1ijlb+yER4nDnHbOyUEUoCGQrfLgrPvnZGH29IKJolYvJODX9ta52S7nnCZkBlGMayq4gP1Ogk5lEkXsUCe4gHZi5Sx/bvb5ZRBPjyYcca67tf4RCHR24TFJY16v0svYOaVa9pnfL1LWmbu4UVrUinkN/0r5uKGab85GdNOck=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787312530; c=relaxed/simple;
	bh=UuNbzz8Ezsld0x9pP6pNVkPG5AujYlqpWUQBAz1RvSk=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=VyOSB5zOXFeMPSzst1sl/GcW8tl+b5sJ7Tw3tBnAiE+GBcsS6eFcKcoUjF7rt4FrwdF5U751b6UD4aTCBb8jlgvCOlOfjr5I7RujWrhN+CCS+5ryhqzFjv4UMpsouoDr1m6SxqK+00rxIRDJph0JjE7yE4DDPKd3h9Vpx2Y86T8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=g0rA8LFt; arc=fail smtp.client-ip=40.107.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="g0rA8LFt"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RmJ2XJrG4IvWSKcjQ9ajVwRE9vJDvDSr8eypVbxfRuA9A4Z0jEMOcBDi/IYt0fcKBV9ZZUvZVhnswUEux3ADNYfJsUjXpJhdL0wL0+m3WTSPuCSOme1OH0O0sZE9tS7HOKyOfAQI0cB+uYgCU4rpDzYcuZyVLl4GTC1a+N73qIGe8RWzlrNN+rD3RmG+3U9LtGIfE7Pk3A6gW9vOK80wOVBUF2fnXMY6s2bnuH9BDc8Wdr7UvIxbTLB1T2QqNycKLXMYlpf1zDuxUwgga/07/+f0SF1j1Jbr3oaB7se1lmcyIM+EKxma/xWUKiWAe4nutAyLAiIMutLAHL/9PsJ30Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LpR04skyHTvDSZNst/T7O+s4+7xms8+a8sPUQrE8jQ8=;
 b=J1LxLaowasrLV2oF0fUEsNSXC7ZPmQ+h6hLVbAx5T6nFn2Tg5zGJeQ+5BmNBEG1WlvM6mkwz5iRW7fr6UVLxaxgK2C7lQNlwh5WJg1HNj9nscNSB0wNjeBgVKyWzFJOUVs/jxtP9Y5ffulvfgQc7axLGDmfy181MVIJr4mBOQHUskaUTyJ9CVJK5qf90vdO0gs2blwFunaCQTBDMDZHLGAEq/W85XkhUTPEGfSlDlAkKhqwW33OYrbFafXMXQjFW6r02IyRCrLPKhaxZkhLwD2HkRaHAdqnuLBRM+ZnPsK1OnG0ePiFqVEBbeu3VGBhRp17oMEiEDdNSdlsF3TIygw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LpR04skyHTvDSZNst/T7O+s4+7xms8+a8sPUQrE8jQ8=;
 b=g0rA8LFtYFeqIR2qnPQzHNeviIb7LeDu+p55jztjAyXiV4Yz0zSKKe5d1wG3ApVF1fK7074l784i2hHxASgxBcu6fc/dFNgCt8tUKliVb8w1oAcJnE2oyzIZysZVvftYZ3AiOcbxBuogJqiXDmJGhHtmUB2eH79n+YCqsgADaz40PiwQy95re47wdeNjBryCnLrL+1gY3bM9CHoJwATTiflYdmgLp+VnzIgEl/30sZwKObJz+qdNPxMzjJ0v7H7EvIN+xtryhNRfU6S5WLJwBMPTQjCvfxulP0IdANysZnFZkvTxcVxRy10F3kn8+Dgh/1apEOXWuC7cvU5LZVHDnQ==
Received: from BN0PR04CA0115.namprd04.prod.outlook.com (2603:10b6:408:ec::30)
 by CYYPR12MB8751.namprd12.prod.outlook.com (2603:10b6:930:ba::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.10; Fri, 21 Aug
 2026 11:42:03 +0000
Received: from BN2PEPF00004FBD.namprd04.prod.outlook.com
 (2603:10b6:408:ec:cafe::8e) by BN0PR04CA0115.outlook.office365.com
 (2603:10b6:408:ec::30) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.339.10 via Frontend Transport; Fri,
 21 Aug 2026 11:42:03 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BN2PEPF00004FBD.mail.protection.outlook.com (10.167.243.183) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.360.3 via Frontend Transport; Fri, 21 Aug 2026 11:42:03 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Fri, 21 Aug
 2026 04:41:46 -0700
Received: from moonraker.nvidia.com (10.126.231.37) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Fri, 21 Aug
 2026 04:41:45 -0700
From: Jon Hunter <jonathanh@nvidia.com>
To: <svclkml-review@nvidia.com>
CC: Jon Hunter <jonathanh@nvidia.com>, <stable@vger.kernel.org>
Subject: [PATCH 1/4] ASoC: tegra: Fix the I2S enable default value
Date: Fri, 21 Aug 2026 12:41:27 +0100
Message-ID: <20260821114130.54376-1-jonathanh@nvidia.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-NVConfidentiality: public
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: rnnvmail201.nvidia.com (10.129.68.8) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF00004FBD:EE_|CYYPR12MB8751:EE_
X-MS-Office365-Filtering-Correlation-Id: fac03bff-b759-40a6-e92c-08deff79386e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|36860700016|23010399003|376014|18002099003|56012099006|6133799003|11063799006|10067099003;
X-Microsoft-Antispam-Message-Info:
	x/Zqm/v6PtK19IUlnIZ0W+Pg9s6UQU48vY2klswXwGk7S9owxphERb+UnDlq1Pyxl3B4eWK9toLq/0bBVJAM2GgkG06Cub6eTeG0to2UsdEILm208+aF3XLticXeF330VDycmenGLuSTE6GMvkBLl+p3OAPcm1w5/DdjEADhCz6B3dhIRMVL1igSDKytkLTxbsDqX2gwgdjVFR0BR4UKE1XjjYSOH60KLyU1BrB1XzUtjwET5l3ntnNWc2OGBqqSY1sPDQkaoHJPLR+jEohMLJtWtsH2EJj3sSHUPz2VFO/g3hgrKPWX6Uzp3eUPsEBhhDE7vmdoUOV/Ipv0L8cJrAM+MxHtAFTnUShqTCw+CLORthFUNRFprQ4InFU/V8QDFyceixB/Nx6o/Tw4nVex/sK50FtaxjsMXHj7V3JeEZ2dPUOm1yivX/7HssCZa4JozwypoaSFPZHePRw6p2HvPcU3P9EW90CPB/LlBwbBkhacT0lYuj7TgWU2YODMEiUvMWTGWTWfXLbYQfaskjsKcC2TQ0uBpd8P+qzVk2SkLoJQa8yXTp80cW0iOw3VxpSE6L22jxjIo9dtm+LzP2U5r7gBr1W5DnEEqakpr4moYKDZwPynsRu5V3lB3R2jKq5wGZz0Qco63uDLRkrRag2CEz9gWe37OAdJUJ70xvwaf7AKYy45ESKcaBMXKqoIyD4ifKchQMxjO2PyVWFpRFtx6g==
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(36860700016)(23010399003)(376014)(18002099003)(56012099006)(6133799003)(11063799006)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	4Idqt+vw6xvVmKyKaLRriR5jLHHZqDyoF4cXtQSrAevrPnCziMIwMaXcMw5vrJAqfpFb6EWr5htn57nRaxUmpIsoxH31MxxOXWveBIJBXzK/XGYNhqCQ2dB9J/2B2KMwFLGswyu7BF4V3c3QogW5n6VNP51G9/fgRlauiToqgCQudGLXtJ4a+654J4itZbJ4wgn9y4GJY9xzue0JL3jdQ+drkRk2KGIWTn8JEiakMABvgY1aLLz0u5o+/H7O3W+OnEP8EiosisDFtXsn7v0B6VFL9EbubGgzEcbB0eBhEq2yyMvF6QhAMO/9hvreWNAIMWbq/0c57R8njLlJssbR5Yrh+TEl/8U5NqjHsF6IPiMcIsUZWFo5j1oGLKtmPr+sNMXLpa///uZn0tatVvYUzVwvxEnL3aomdOeigUYXUNwpPcoqoUuar56U+kWGKacF
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2026 11:42:03.4236
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fac03bff-b759-40a6-e92c-08deff79386e
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN2PEPF00004FBD.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR12MB8751

Commit 4b05ccb17f92 ("regcache: Sort the local copy of an unsorted
reg_defaults array") exposed an issue in the Tegra I2S driver where the
register default for the TEGRA210_I2S_ENABLE is specified as 1, but the
hardware default is actually 0. After commit 4b05ccb17f92 was added the
I2S playback/capture is no longer working and so fix this by correcting
the default value for this register and explicitly configuring the
I2S_ENABLE register when runtime resuming the I2S device.

The I2S_ENABLE register offset is different on Tegra264 devices than
other Tegra devices and so add a 'enable_reg' variable to the SoC data
structure to specify the offset for different SoC devices.

Fixes: c0bfa98349d1 ("ASoC: tegra: Add Tegra210 based I2S driver")
Cc: stable@vger.kernel.org
Signed-off-by: Jon Hunter <jonathanh@nvidia.com>
---
 sound/soc/tegra/tegra210_i2s.c | 19 ++++++++++++++++---
 sound/soc/tegra/tegra210_i2s.h |  1 +
 2 files changed, 17 insertions(+), 3 deletions(-)

diff --git a/sound/soc/tegra/tegra210_i2s.c b/sound/soc/tegra/tegra210_i2s.c
index 84506576437d..a1dd99e67a35 100644
--- a/sound/soc/tegra/tegra210_i2s.c
+++ b/sound/soc/tegra/tegra210_i2s.c
@@ -23,7 +23,7 @@ static const struct reg_default tegra210_i2s_reg_defaults[] = {
 	{ TEGRA210_I2S_RX_CIF_CTRL, 0x00007700 },
 	{ TEGRA210_I2S_TX_INT_MASK, 0x00000003 },
 	{ TEGRA210_I2S_TX_CIF_CTRL, 0x00007700 },
-	{ TEGRA210_I2S_ENABLE, 0x1 },
+	{ TEGRA210_I2S_ENABLE, 0x0 },
 	{ TEGRA210_I2S_CG, 0x1 },
 	{ TEGRA210_I2S_TIMING, 0x0000001f },
 	/*
@@ -42,7 +42,7 @@ static const struct reg_default tegra264_i2s_reg_defaults[] = {
 	{ TEGRA264_I2S_TX_INT_MASK, 0x00000003 },
 	{ TEGRA264_I2S_TX_CIF_CTRL, 0x00003f00 },
 	{ TEGRA264_I2S_TX_FIFO_RD_ACCESS_MODE, 0x1 },
-	{ TEGRA264_I2S_ENABLE, 0x1 },
+	{ TEGRA264_I2S_ENABLE, 0x0 },
 	{ TEGRA264_I2S_CG, 0x1 },
 	{ TEGRA264_I2S_TIMING, 0x0000001f },
 };
@@ -201,9 +201,20 @@ static int tegra210_i2s_runtime_resume(struct device *dev)
 	}
 
 	regcache_cache_only(i2s->regmap, false);
-	regcache_sync(i2s->regmap);
+	err = regcache_sync(i2s->regmap);
+	if (err)
+		goto disable_clk;
+
+	err = regmap_write(i2s->regmap, i2s->soc_data->enable_reg, I2S_EN);
+	if (err)
+		goto disable_clk;
 
 	return 0;
+
+disable_clk:
+	clk_disable_unprepare(i2s->clk_i2s);
+
+	return err;
 }
 
 static void tegra210_i2s_set_data_offset(struct tegra210_i2s *i2s,
@@ -1133,6 +1144,7 @@ static const struct tegra_i2s_soc_data soc_data_tegra210 = {
 	.regmap_conf		= &tegra210_regmap_conf,
 	.i2s_cmpnt		= &tegra210_i2s_cmpnt,
 	.max_ch			= TEGRA210_I2S_MAX_CHANNEL,
+	.enable_reg		= TEGRA210_I2S_ENABLE,
 	.tx_offset		= TEGRA210_I2S_TX_OFFSET,
 	.i2s_ctrl_offset	= TEGRA210_I2S_CTRL_OFFSET,
 	.fsync_width_mask	= I2S_CTRL_FSYNC_WIDTH_MASK,
@@ -1144,6 +1156,7 @@ static const struct tegra_i2s_soc_data soc_data_tegra264 = {
 	.regmap_conf		= &tegra264_regmap_conf,
 	.i2s_cmpnt		= &tegra264_i2s_cmpnt,
 	.max_ch			= TEGRA264_I2S_MAX_CHANNEL,
+	.enable_reg		= TEGRA264_I2S_ENABLE,
 	.tx_offset		= TEGRA264_I2S_TX_OFFSET,
 	.i2s_ctrl_offset	= TEGRA264_I2S_CTRL_OFFSET,
 	.fsync_width_mask	= TEGRA264_I2S_CTRL_FSYNC_WIDTH_MASK,
diff --git a/sound/soc/tegra/tegra210_i2s.h b/sound/soc/tegra/tegra210_i2s.h
index 42be2137342c..82292f96ab36 100644
--- a/sound/soc/tegra/tegra210_i2s.h
+++ b/sound/soc/tegra/tegra210_i2s.h
@@ -150,6 +150,7 @@ struct tegra_i2s_soc_data {
 	const struct regmap_config *regmap_conf;
 	const struct snd_soc_component_driver *i2s_cmpnt;
 	unsigned int max_ch;
+	unsigned int enable_reg;
 	unsigned int tx_offset;
 	unsigned int i2s_ctrl_offset;
 	unsigned int fsync_width_mask;
-- 
2.43.0

