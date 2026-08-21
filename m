Received: from BYAPR05CU005.outbound.protection.outlook.com (mail-westusazon11010055.outbound.protection.outlook.com [52.101.85.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3796932C302;
	Fri, 21 Aug 2026 15:38:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.85.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787326720; cv=fail; b=K5AWvG76KD+29fPPJHg7iJ3tpyG0InyeyYVFWGZ1ywFWjJwR76RJnhY8vPUt9mAm1KnPaAmYMWEQGXsTcc6QzdtEUz7uz50VlHfnbCkyUa3nYzHKnvr/OPViqSkLM24qe+gcpM+hD0hRxq+DIuAi0SZCepxpWXLIE2X+aKiV9ts=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787326720; c=relaxed/simple;
	bh=UvuIbYgN1O+5Ih69QwFRUs1YLGEbrJdYhzAQAXOfDDo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=b8o2Sk8xlkNDo0XZZN2DNO/4ApJOWeENkZeSxnS8QkGpZv8kNnUQwlY8RkId7DFHYG3OM4f8Y2JC0TuRpbt/nlRtcscFQ2jVtyf7tSrXO5Y7matuXFMmOuPNS7hyIvTFNw8PZGtP88fDJohIWPEixETmv1TVhtR6iHglaeHsors=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=rQBpxdpb; arc=fail smtp.client-ip=52.101.85.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="rQBpxdpb"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=V+JuOO1zwR7gwrywACI5vIcsRACX0g9rvNTctCzKxwQmsuXojIAMGeex6IGn8ctQAeQStwKc8CZ9yUyhgntygkLKoHTWXkgaK0h3oqeo3yNcZUOxZrCRMN6oSHxrMxW3HuHHHVrgUw20ABXMgAJoRNkxbrI/LLFwrU4L6Ip0HoARA9wxNqPYR06VCYfs+xnRR1xzP79xsT1S7+h/XWC/91RaFlBrYU95wTORbBVmZQSklYHEIEUT5PW83dCRJhYhmzBW0s4iBWFnM9R+CE3bCVuDCRJuxSxi27Txlipf+b1wQaj20xEKaEF6lPnSG1OGeZ3AMB05+O1nRCaKi7WO6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hweOGX02xGnPps0wqcMytK2dRCJRYUB3Oe/KemvFpTQ=;
 b=pWeP9land/wka//vPpZjWl4DRIkOiMmRBi9AW6q7UghWeLus1+5vpwFWmFJfR/Bqf8d4qTHfAeoFov1jAdGt8ddbWfiV+mDKZ2oeQq4kcP9BMpvBRhjXzuEP1x333U7wrJkAhbXVLL51SMr1mYo0EreGIsIbqfgpotMvR/s63dWpe0UmLDDPt5/KLspGSx/dQ7p06EEN9JEE7/qfuvpJOYUsdZIRcpPI8ImCVEcHOZur2lt/UIRq6OxpghswIFoQyt8jpsEZkIMyJn6OvqXTBmdyD5LpUQd8Ef9dFIdNYr1V0Qum4I8/K4+jjBFvQmiL/HANkh8JEBduTiP4MKr6mA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=gmail.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hweOGX02xGnPps0wqcMytK2dRCJRYUB3Oe/KemvFpTQ=;
 b=rQBpxdpbms7HTVcRd1fAPt8KUmd2ZISgaj2VdmBIgWfObmclH1infHlw4ECOWpaPex/cX2ctcybyumhGsnXvOc/vX4zHRV4hGxyV1Fwt/hSLIBzCte7vNaPW7nf9TJGIwzwv6YBC/mqtWD1Vzx6TccU4wvBH8AxZ4xyn203irQnns2bmQC3hU2/m1hcrp9Hk4YcsExSbsN+Zy+uw9o3tyoLo3aiGoCTzXQaMZaChK2P7u6D9ZH6yb4VlhZsDXI14cxrqu5PY0KwKRiRPcXZ3KxO8YJdWG/tWxOQCB4ZiFAuYcxGIx/b+7TWy2ruLNyn9aWiOzrHw52yxExNVo/ODUw==
Received: from BN1PR13CA0011.namprd13.prod.outlook.com (2603:10b6:408:e2::16)
 by BY5PR12MB4212.namprd12.prod.outlook.com (2603:10b6:a03:202::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.11; Fri, 21 Aug
 2026 15:38:34 +0000
Received: from MN1PEPF0000ECD4.namprd02.prod.outlook.com
 (2603:10b6:408:e2:cafe::7a) by BN1PR13CA0011.outlook.office365.com
 (2603:10b6:408:e2::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.360.4 via Frontend Transport; Fri, 21
 Aug 2026 15:38:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 MN1PEPF0000ECD4.mail.protection.outlook.com (10.167.242.132) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.360.3 via Frontend Transport; Fri, 21 Aug 2026 15:38:34 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Fri, 21 Aug
 2026 08:38:07 -0700
Received: from moonraker.nvidia.com (10.126.231.37) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Fri, 21 Aug
 2026 08:38:04 -0700
From: Jon Hunter <jonathanh@nvidia.com>
To: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
	Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, "Thierry
 Reding" <thierry.reding@kernel.org>, Sheetal <sheetal@nvidia.com>,
	<peter.ujfalusi@linux.intel.com>
CC: <linux-sound@vger.kernel.org>, <linux-tegra@vger.kernel.org>, Jon Hunter
	<jonathanh@nvidia.com>, <stable@vger.kernel.org>
Subject: [PATCH 4/4] ASoC: tegra: Sort MBDRC register defaults
Date: Fri, 21 Aug 2026 16:37:34 +0100
Message-ID: <20260821153734.158426-5-jonathanh@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: MN1PEPF0000ECD4:EE_|BY5PR12MB4212:EE_
X-MS-Office365-Filtering-Correlation-Id: be958255-5107-4521-4553-08deff9a42bb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|23010399003|82310400026|1800799024|376014|56012099006|11063799006|10067099003|3023799007|18002099003|22082099003|6133799003;
X-Microsoft-Antispam-Message-Info:
	EjdO3xkTaEieLowYiNRaQQ5SzxlrQR0O12tzaxDZBOlwrJpXeg4a1XaodNlz0bUvIASiN9p4un3wjUBELo7tkT73jW53YdN3F5aZeGoWwKydzoEq+af7o//6Vz/qIn6LLGhd1VBZ5Mri52QvP6bRwSaWVmxLCrWxeoeOHqyDAV1HTh8oIVmCDoxEVJZz8zP/X7VxYyQWeUmve0oa+9zdTXjI5sV3i/qVLy2GGL+nZr8JlO5AsqtAAS0Wv/BBJ/7dRZMm8zMAwKIv7+wdJ20Rf3nmtpmMmwf10l8TbuGwlAVxCvFQjpoN1SKkuc/kO+gEMllaWY0SX3qnAOjrT+1fwPZ9Xg6gx+oExXWOBLbR1DkgThlQOQ0pl427rF3i5OQ/eApg8675isjy0940cBfkgrF+928kAZ1qg+whXg41xMNQwjZcE7mCZoouPB/VDAi7nS1qwRfG0JGP/KdHy3ukG2UCHQAvreHgrH+QMODN9uHakW7/HgCaNd4pD2k7hQGzXiDu+M45saYNBm01XnbLPvTP5CBOCrYxd5YKx5GWtWe9dUTrlMRLW+A8z9Ip5Ec+Xfi4y7DjSgibt09CbkbI92Cq1bYsOc0MI9PR4F7TBXrvBDKgmAWbhm+D1c3Y93TfjBtAGxPi7QRyiU3VfC6I5Yimdmgt/kHCO1WDGyhVswbfq++1ZzbMUb2y7pJnAtljcQMWzkbAFxquNT1lnQ/YVA==
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(36860700016)(23010399003)(82310400026)(1800799024)(376014)(56012099006)(11063799006)(10067099003)(3023799007)(18002099003)(22082099003)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	dmUwxHI0cYPfNtJyx87Tog57mc66TD1NZosBGxHnWZ9ib1/P5CY0+zEqJPsQ6NY04gpaitmwA9jIiQkyKpuekrwD+WHv4ozroVCYvxFmFw3YS+zm8R5bPxxRR1+mle2aPPsH2hRcUyZXiklpZACc85aCkx0apnAj/PrED0i/XB7DDawkZENjQEhmIs1Jy/dL1YThGvF+KVDi44J81/QL5v+x1RUePRLww3Tou8o24T4MpPjEK9IFvM8Dbe9gqvOysOVHtmtjAFHS+vqRZbh0o5kYLkgFFi2//ViAiAI8phml6gJXmxKwz+ShK1jGE26cefBxmc2RGppHz1m5X0z/NJ4xjYMmnRgHXtVFAW/uELocH1xJ8BNdSoPFf7k9QUUl7Cwbn479xT3X7MhpYutRHM2rxbkm8siHY3+0HRE2IPB1w2A/FM2T5q4p93G5clt9
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2026 15:38:34.0838
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: be958255-5107-4521-4553-08deff9a42bb
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MN1PEPF0000ECD4.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4212

Commit 4b05ccb17f92 ("regcache: Sort the local copy of an unsorted
reg_defaults array") exposed an issue with the Tegra MBDRC driver and
now the following warning is observed:

 tegra210-ope 2908000.processing-engine: Driver needs fixing: Unsorted
  reg_defaults, sorting the copy

This warning occurs because register defaults in the structure
tegra210_mbdrc_reg_defaults are not specified in ascending order which
is required by regmap. Fix this by sorting the register defaults
according to their address. Note that in order to do this it is
necessary to replace the macro MBDRC_FILTER_REG_DEFAULTS with a per
register macro MBDRC_FILTER_PARAM_REG_DEFAULTS.

Fixes: 7358a803c778 ("ASoC: tegra: Add Tegra210 based OPE driver")
Cc: stable@vger.kernel.org
Signed-off-by: Jon Hunter <jonathanh@nvidia.com>
---
 sound/soc/tegra/tegra210_mbdrc.c | 42 ++++++++++++++++----------------
 1 file changed, 21 insertions(+), 21 deletions(-)

diff --git a/sound/soc/tegra/tegra210_mbdrc.c b/sound/soc/tegra/tegra210_mbdrc.c
index f5d4a93dd6f1..1d78b4c1cc88 100644
--- a/sound/soc/tegra/tegra210_mbdrc.c
+++ b/sound/soc/tegra/tegra210_mbdrc.c
@@ -20,33 +20,33 @@
 #define MBDRC_FILTER_REG(reg, id)					    \
 	((reg) + ((id) * TEGRA210_MBDRC_FILTER_PARAM_STRIDE))
 
-#define MBDRC_FILTER_REG_DEFAULTS(id)					    \
-	{ MBDRC_FILTER_REG(TEGRA210_MBDRC_IIR_CFG, id), 0x00000005},	    \
-	{ MBDRC_FILTER_REG(TEGRA210_MBDRC_IN_ATTACK, id), 0x3e48590c},	    \
-	{ MBDRC_FILTER_REG(TEGRA210_MBDRC_IN_RELEASE, id), 0x08414e9f},	    \
-	{ MBDRC_FILTER_REG(TEGRA210_MBDRC_FAST_ATTACK, id), 0x7fffffff},    \
-	{ MBDRC_FILTER_REG(TEGRA210_MBDRC_IN_THRESHOLD, id), 0x06145082},   \
-	{ MBDRC_FILTER_REG(TEGRA210_MBDRC_OUT_THRESHOLD, id), 0x060d379b},  \
-	{ MBDRC_FILTER_REG(TEGRA210_MBDRC_RATIO_1ST, id), 0x0000a000},	    \
-	{ MBDRC_FILTER_REG(TEGRA210_MBDRC_RATIO_2ND, id), 0x00002000},	    \
-	{ MBDRC_FILTER_REG(TEGRA210_MBDRC_RATIO_3RD, id), 0x00000b33},	    \
-	{ MBDRC_FILTER_REG(TEGRA210_MBDRC_RATIO_4TH, id), 0x00000800},	    \
-	{ MBDRC_FILTER_REG(TEGRA210_MBDRC_RATIO_5TH, id), 0x0000019a},	    \
-	{ MBDRC_FILTER_REG(TEGRA210_MBDRC_MAKEUP_GAIN, id), 0x00000002},    \
-	{ MBDRC_FILTER_REG(TEGRA210_MBDRC_INIT_GAIN, id), 0x00066666},	    \
-	{ MBDRC_FILTER_REG(TEGRA210_MBDRC_GAIN_ATTACK, id), 0x00d9ba0e},    \
-	{ MBDRC_FILTER_REG(TEGRA210_MBDRC_GAIN_RELEASE, id), 0x3e48590c},   \
-	{ MBDRC_FILTER_REG(TEGRA210_MBDRC_FAST_RELEASE, id), 0x7ffff26a},   \
-	{ MBDRC_FILTER_REG(TEGRA210_MBDRC_CFG_RAM_CTRL, id), 0x4000}
+#define MBDRC_FILTER_PARAM_REG_DEFAULTS(reg, val)			    \
+	{ MBDRC_FILTER_REG(reg, 0), val},				    \
+	{ MBDRC_FILTER_REG(reg, 1), val},				    \
+	{ MBDRC_FILTER_REG(reg, 2), val}
 
 static const struct reg_default tegra210_mbdrc_reg_defaults[] = {
 	{ TEGRA210_MBDRC_CFG, 0x0030de51},
 	{ TEGRA210_MBDRC_CHANNEL_MASK, 0x00000003},
 	{ TEGRA210_MBDRC_FAST_FACTOR, 0x30000800},
 
-	MBDRC_FILTER_REG_DEFAULTS(0),
-	MBDRC_FILTER_REG_DEFAULTS(1),
-	MBDRC_FILTER_REG_DEFAULTS(2),
+	MBDRC_FILTER_PARAM_REG_DEFAULTS(TEGRA210_MBDRC_IIR_CFG, 0x00000005),
+	MBDRC_FILTER_PARAM_REG_DEFAULTS(TEGRA210_MBDRC_IN_ATTACK, 0x3e48590c),
+	MBDRC_FILTER_PARAM_REG_DEFAULTS(TEGRA210_MBDRC_IN_RELEASE, 0x08414e9f),
+	MBDRC_FILTER_PARAM_REG_DEFAULTS(TEGRA210_MBDRC_FAST_ATTACK, 0x7fffffff),
+	MBDRC_FILTER_PARAM_REG_DEFAULTS(TEGRA210_MBDRC_IN_THRESHOLD, 0x06145082),
+	MBDRC_FILTER_PARAM_REG_DEFAULTS(TEGRA210_MBDRC_OUT_THRESHOLD, 0x060d379b),
+	MBDRC_FILTER_PARAM_REG_DEFAULTS(TEGRA210_MBDRC_RATIO_1ST, 0x0000a000),
+	MBDRC_FILTER_PARAM_REG_DEFAULTS(TEGRA210_MBDRC_RATIO_2ND, 0x00002000),
+	MBDRC_FILTER_PARAM_REG_DEFAULTS(TEGRA210_MBDRC_RATIO_3RD, 0x00000b33),
+	MBDRC_FILTER_PARAM_REG_DEFAULTS(TEGRA210_MBDRC_RATIO_4TH, 0x00000800),
+	MBDRC_FILTER_PARAM_REG_DEFAULTS(TEGRA210_MBDRC_RATIO_5TH, 0x0000019a),
+	MBDRC_FILTER_PARAM_REG_DEFAULTS(TEGRA210_MBDRC_MAKEUP_GAIN, 0x00000002),
+	MBDRC_FILTER_PARAM_REG_DEFAULTS(TEGRA210_MBDRC_INIT_GAIN, 0x00066666),
+	MBDRC_FILTER_PARAM_REG_DEFAULTS(TEGRA210_MBDRC_GAIN_ATTACK, 0x00d9ba0e),
+	MBDRC_FILTER_PARAM_REG_DEFAULTS(TEGRA210_MBDRC_GAIN_RELEASE, 0x3e48590c),
+	MBDRC_FILTER_PARAM_REG_DEFAULTS(TEGRA210_MBDRC_FAST_RELEASE, 0x7ffff26a),
+	MBDRC_FILTER_PARAM_REG_DEFAULTS(TEGRA210_MBDRC_CFG_RAM_CTRL, 0x4000),
 };
 
 /* Default MBDRC parameters */
-- 
2.43.0

