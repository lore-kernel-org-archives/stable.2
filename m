Received: from CH5PR02CU005.outbound.protection.outlook.com (mail-northcentralusazon11012006.outbound.protection.outlook.com [40.107.200.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE9D42236F0;
	Fri, 21 Aug 2026 15:38:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.200.6
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787326711; cv=fail; b=ExTVfWqRAjXgmKDhDEqiXK5Am4KJGof6h10AxxcUhKsfX5SqrYUIXm25ahmPDwwq16rqlmNmRfQMJC3ppiEGdiYT9X7y6vPva+azFSLg2HSKLGxePkVvw7P/3Un+FmeUm180ryypGPjXsPZrN14fp0HyyMcFnzTu+MIWnDTylco=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787326711; c=relaxed/simple;
	bh=U4iAh+h8cocwS87h4sy/1LGxsrk1lj89ynR+Xgg64Bs=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Ff3j5aGUTpcXALHhrWAGSPqITd7G0vXURfMD6iPlL4HOHURKa8vWBwMPfvR9bnNUDlvDsbiTG8/QtgE2yzdW8Bzia8H8q/q7t70xT9nNtOI5gOo5C6NPIPKYUZPXeeZG0B91eGy6skDXvo6OmazqVSHM/A6SNyXTVS0pc4BJf/A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=G6lDvj+f; arc=fail smtp.client-ip=40.107.200.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="G6lDvj+f"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DoK/FWbFsBI+9aOgN5PV6DFPUUaBtmW/Q3YVXFxwC2Olfjak3d9wIZ1Hsl4ELnNeshnOytOJkPy17jPuBmdEyRqh4uPL/e2PZW36s1odJWqWSppLxQJoEayosC2XhBruSE3UVKFVo+hi0v0EchbdZK5ZLhgBvAIDwJRBjBQRMEvB5mGq46GVlH+oTnuh/sHSISsUI7XwS13Xzuobox/PMu/LGIWqgBHa0OWEwiIL4vmlpvblCqPoL9hGHdfC1MygfeassMnJbxhN9yn7BX9sATplqpVSgAprX6OaB2yBPMUS/fLbg5jJ7WmZ5FgwoBX2/moJInSTf6y93tqEUchsPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QXwIkzuFSLSbnxxw+rKH2KAVy4oMZ0Df7GMyYHb5SeE=;
 b=JIotyoaoplxeUaDYu2GLIBxPPRmpQDsldSP7v/rUMt9BOqqnON8V0clAio7PbhwlORS9zx7RdItGXHWeca76AINs0qGcnUhsCYowhp9F2Hk+D3/sdzHa0akgoAffvvG/R/8+xpxCwEJrrFLJ6ITT0WGdF956hhiglY20dY6Hdv0JoxdprUoiSWlz6mBrwKQkh4+d2adn6EWalRgjJOGebnxfQJMEaIsLnEdB8A+mESTxI8GX7wVue389aPL2ryU8uKD1TpGAXO+ee/2+MLMg2cjw5nKoaQWeJYf39wl/Yd7uuTbOH9MM98gaL60bb0oTGR0PmkxK/Ys4pMXkgDTGww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=gmail.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QXwIkzuFSLSbnxxw+rKH2KAVy4oMZ0Df7GMyYHb5SeE=;
 b=G6lDvj+fnmD+9UXay25QzyK3aFGWodQlURwJjBKO6XhJuSpPf5XFKLZIKz7yHs7SciO+3dMnsaw8wzXu6F/9CoWYKA1qWHvhfcmjS9uqwGYngN1vQDjA0Cp1gZZ9eGutn8eJG8RY8PJhTaWqC+zVS7IXcB0G1ul9hlHWhpH1+uzjVVbvMmwrMGLs9V7BsGSZGke+Ga5fsJEe+Dbu76OBHJzCXzbiXOj+9uu8aBgn1D20vhCtbC1nmN9HLzknQaWK0qI11OW/Cfd5F0YfPx7umIi9a+BvvKu/s0HMhPhvi8yhfhZJr68Dd/V8+0K4MSV09CVFQbv8GUAIBABNnYVk9Q==
Received: from BL1PR13CA0429.namprd13.prod.outlook.com (2603:10b6:208:2c3::14)
 by CH2PR12MB4149.namprd12.prod.outlook.com (2603:10b6:610:7c::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.10; Fri, 21 Aug
 2026 15:38:23 +0000
Received: from MN1PEPF0000ECD5.namprd02.prod.outlook.com
 (2603:10b6:208:2c3:cafe::26) by BL1PR13CA0429.outlook.office365.com
 (2603:10b6:208:2c3::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.360.4 via Frontend Transport; Fri, 21
 Aug 2026 15:38:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 MN1PEPF0000ECD5.mail.protection.outlook.com (10.167.242.133) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.360.3 via Frontend Transport; Fri, 21 Aug 2026 15:38:23 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Fri, 21 Aug
 2026 08:37:58 -0700
Received: from moonraker.nvidia.com (10.126.231.37) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Fri, 21 Aug
 2026 08:37:55 -0700
From: Jon Hunter <jonathanh@nvidia.com>
To: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
	Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, "Thierry
 Reding" <thierry.reding@kernel.org>, Sheetal <sheetal@nvidia.com>,
	<peter.ujfalusi@linux.intel.com>
CC: <linux-sound@vger.kernel.org>, <linux-tegra@vger.kernel.org>, Jon Hunter
	<jonathanh@nvidia.com>, <stable@vger.kernel.org>
Subject: [PATCH 1/4] ASoC: tegra: Fix the I2S enable default value
Date: Fri, 21 Aug 2026 16:37:31 +0100
Message-ID: <20260821153734.158426-2-jonathanh@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260821153734.158426-1-jonathanh@nvidia.com>
References: <20260821153734.158426-1-jonathanh@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: MN1PEPF0000ECD5:EE_|CH2PR12MB4149:EE_
X-MS-Office365-Filtering-Correlation-Id: aee898d7-ca16-41f9-fb15-08deff9a3c34
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|376014|1800799024|36860700016|82310400026|6133799003|10067099003|56012099006|11063799006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	krRT4w/vhBW1mHZAHVH08zu2FZ3G6c4FNdGYD6M3z6FWd3PZKBfbPPQO1sjuRi6ciC6lCPiwYuwJYkXEr6/RCX+Fo0n1NTvqwfpM+GI8N6fM9yUCHPSIL8I2vmrOm2sopyZ1crHUT9O368LgT0OJzxrCZoPDEy0BgeEBjcN0YiycsZQ2RbXsVQMuhebi6//isBa0ATGUlOATCyGLgIFebd52fSyw02gU1nJlPzpeeSFaP1n0j2fgBLafV3JrC96R2nonAjhBZFOcdBMt8lBP9j39++eX2/X0ktt3+4ervNbICajEYOp1uU+VypmdfuUD6WsmvhTuG+QXw4B3L0FvW0QIlzwWEXbZgfODKkfXrfde0uwMxIV+N4bQQ4nzz/11JFHfoLUa5girYbe9I0Ti1xCCDqXSZugFMh+B4XogKQ7jFwLhiTpu3nINTJUhP+U0tscSG5ZIAl+cgWgHkFhJGQ5vydw+5NM8hvdtm6q0bYiQuOUdMiIcDFfAxp6MrgvryQSOH4MeDd6Z28cAWw5fWLgE9WjkRyr5awKU8cWD5s9iymKZxOXc6HdB6du5upjC1ZjSUNFWh3KHhl94N/r4GGuHAS715lhi4HtTtwagdI0CXMn7qBthF9yis+23eFD4fqi3eEdlc3xRrk5rbV0UHD0fKTQL4GPN8maYdoEXl+AWfGsGWf4jXPNyCzAbElrFt8l8cnboiyZWQFgs5d3Row==
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(23010399003)(376014)(1800799024)(36860700016)(82310400026)(6133799003)(10067099003)(56012099006)(11063799006)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	coKJBaasRqkOBEYj3TenAyNp/9aGF8rqjI24Ix5FYljFPyMTGTnKTOrwfSIVy6RGL9aPOTds6bhkoV+5cCPQ7pAvZ+xgloZhUglVlskdD9vtRrkzn3ihTL/wcKnN7l7Zf0H+5oHm9eKArEq+tChPltB7V+/iJsYje0nwFIVA1LeCb+cSP7EYrH1dD9tvxw6AIcmUT33npd14AIzffVk/0PdQndK+jFhkhUStKijnKwLgQ2Etuo3Uew9qsyfYkkuEvxy9wHfMTcVH/BpIjoK4JXvThjYtMbGqkfGuzURQiSV175EtuQQm1pcdLuiBjbvLBT1bjIydyDIRGAhjd259e0Qmsc35yNOxCbgfNWlRSxmXJZfD4luvlynTSXRevBxJHqM6o0KJL0yesHfDgTdpiQn/hAmFZlFNVl6AUW5YxFSRYK+mgA2Pbx0Jf1mixnzZ
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2026 15:38:23.1209
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: aee898d7-ca16-41f9-fb15-08deff9a3c34
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MN1PEPF0000ECD5.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4149

Commit 4b05ccb17f92 ("regcache: Sort the local copy of an unsorted
reg_defaults array") exposed an issue in the Tegra I2S driver where the
register default for the TEGRA210_I2S_ENABLE is specified as 1, but the
hardware default is actually 0. After this commit was added the I2S
driver is no longer working and so fix this by correcting the default
value for this register and explicitly configuring the I2S_ENABLE
register when runtime resuming the I2S device.

The I2S_ENABLE register offset is different on Tegra264 devices than
other Tegra devices and so add a 'enable_reg' variable to the SoC data
structure to specify the offset for different SoC devices.

Fixes: c0bfa98349d1 ("ASoC: tegra: Add Tegra210 based I2S driver")
Cc: stable@vger.kernel.org
Signed-off-by: Jon Hunter <jonathanh@nvidia.com>
---
 sound/soc/tegra/tegra210_i2s.c | 20 +++++++++++++++++---
 sound/soc/tegra/tegra210_i2s.h |  1 +
 2 files changed, 18 insertions(+), 3 deletions(-)

diff --git a/sound/soc/tegra/tegra210_i2s.c b/sound/soc/tegra/tegra210_i2s.c
index 84506576437d..79a2f898ea28 100644
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
@@ -201,9 +201,21 @@ static int tegra210_i2s_runtime_resume(struct device *dev)
 	}
 
 	regcache_cache_only(i2s->regmap, false);
-	regcache_sync(i2s->regmap);
+	err = regcache_sync(i2s->regmap);
+	if (err)
+		goto err;
+
+	err = regmap_write(i2s->regmap, i2s->soc_data->enable_reg, I2S_EN);
+	if (err)
+		goto err;
 
 	return 0;
+
+err:
+	regcache_cache_only(i2s->regmap, true);
+	clk_disable_unprepare(i2s->clk_i2s);
+
+	return err;
 }
 
 static void tegra210_i2s_set_data_offset(struct tegra210_i2s *i2s,
@@ -1133,6 +1145,7 @@ static const struct tegra_i2s_soc_data soc_data_tegra210 = {
 	.regmap_conf		= &tegra210_regmap_conf,
 	.i2s_cmpnt		= &tegra210_i2s_cmpnt,
 	.max_ch			= TEGRA210_I2S_MAX_CHANNEL,
+	.enable_reg		= TEGRA210_I2S_ENABLE,
 	.tx_offset		= TEGRA210_I2S_TX_OFFSET,
 	.i2s_ctrl_offset	= TEGRA210_I2S_CTRL_OFFSET,
 	.fsync_width_mask	= I2S_CTRL_FSYNC_WIDTH_MASK,
@@ -1144,6 +1157,7 @@ static const struct tegra_i2s_soc_data soc_data_tegra264 = {
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

