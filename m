Received: from SN4PR2101CU001.outbound.protection.outlook.com (mail-southcentralusazon11012040.outbound.protection.outlook.com [40.93.195.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB0C0374745
	for <stable@vger.kernel.org>; Fri, 21 Aug 2026 11:42:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.195.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787312534; cv=fail; b=rtgo0XnJZ5bhWGxK3ttQcvnFNTFtf5VBWOJwX9uQcWo/MgAL5HkqTCf7+5VzgGQy1Um72j7r9WEHu4rjuQwDjlRDX0zzjSR053f8+6Taqq90buIIACiwpkOL57EwiwQq7Jet/+VqV3kju64uvRjIjA9SFI39nuteMj24etM4pjE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787312534; c=relaxed/simple;
	bh=JfnMUHT85+70AulFYrgsKGL3U+RH21wLivwIDatwnqw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YsXI9S5BV5lmMRv0Wsts+Oy/z5mkOHgYREwmt7GUsXdkcFAlolGux2cPSYAmyFmwHeBmlPpc9UYjJ4fR9Mma19+6aZjZ1GYPyYaWBU2eI95eAEyYKkTNa/6owrGuUIr/jvsa0YoSsXRioS9ibfzq55z7DOJOtnBjb4+ktWnq/3k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=UIRGK8/b; arc=fail smtp.client-ip=40.93.195.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="UIRGK8/b"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FO9pcOWZPmYi5o+QbmEb1I1vIM71UuhHzgkGbJTiPNjcSvvwNZgOHjg8Mq0Sky2q/29UrvoZomaH2KeQ6B+vm4gCfWBVlakc7TeJTmAbTZTfOE26JUx+RYMkhmDHIpAGRMKc5Ihx7eR9lUmfR3mRC+LxD00TK2CNL8OGAcvDg+SoBlCCiMIqkKoSAFg/xXVB+QfqIAs/AUE+Yxq84JtyAnFCxfLz8junRiYsYDxhY/yJJat+PEfCbz3VTD9ybTGHRQev7nBjOpnj+1CyG8+sw3uZO5ytArxdLAzgMXqMJ6xLpqI8yYjGlTlwgD29Ha9XQlGWexo7TGkAUtCe04vD2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Xvo/dY4AvTnsQByJV74WJOxZKHgd/Yrz37HHH6WPAbM=;
 b=uA5s7fpQQirqITnkb2v5oyje7DR9L/sNe8dz0gjo+9tNwRt6vrRIz2hrt68nStAy/x1ywR53Cl+cC9SRLACyzPkQkOSF4gJuCW+e6wqUahS2eSV+KXoiSfXX65FsFzf2Xd4RyIc8/2yFpq3QKcsYkHVbDplnawBic2E7LphKQ+rOCtcJS9lNJiFt9Lt1gAsSmbwDDHuDWsglRGCVZIH4ychyw87XBOoz9NTn3ZlweMzJdeQnlw8WegM8x2rS4jSXKXQKlf/ztMhETwKnk9pRt+tvZL4TFQbSnXm5TZPmGsI7Gvn201zGQYS8Q5nCo/AqqORUKkm2qr6MnKLqKQj9Pw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Xvo/dY4AvTnsQByJV74WJOxZKHgd/Yrz37HHH6WPAbM=;
 b=UIRGK8/bkdpeydYjiG/AkLh+GsSX0N7teog3HKi00bCs2jPc2UdrbsB/WxpQDdtS0FXgVL0e7Z7ggnyrKv+HttMvrDYaLsXd7w9ZcM2OS5U0xv4PjPjlfp9bGSRN4K6yZVyJtKcQOUYpOQjyfnswGp8kKpGwR7t+/9tCmApgrKX4VsDwhUk7dz4yd+yn1DKGh/Gm5TQoCPWU3OMlb7f1mS0j/JQ3xNFCUIHMaBxPr/WCItuALU2lp35+jMU3ZzA6W2o4YHGnRVj2+sKYDnHzliKsRWVPbmGZjiOocQL6ahGD+0CLMCeWfuYkAzkMklvt93P5BKMj7gPlzY9R9eREqg==
Received: from BN0PR04CA0091.namprd04.prod.outlook.com (2603:10b6:408:ec::6)
 by SN7PR12MB7834.namprd12.prod.outlook.com (2603:10b6:806:34d::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.10; Fri, 21 Aug
 2026 11:42:05 +0000
Received: from BN2PEPF00004FBD.namprd04.prod.outlook.com
 (2603:10b6:408:ec:cafe::37) by BN0PR04CA0091.outlook.office365.com
 (2603:10b6:408:ec::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.339.11 via Frontend Transport; Fri,
 21 Aug 2026 11:42:05 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BN2PEPF00004FBD.mail.protection.outlook.com (10.167.243.183) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.360.3 via Frontend Transport; Fri, 21 Aug 2026 11:42:04 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Fri, 21 Aug
 2026 04:41:48 -0700
Received: from moonraker.nvidia.com (10.126.231.37) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Fri, 21 Aug
 2026 04:41:46 -0700
From: Jon Hunter <jonathanh@nvidia.com>
To: <svclkml-review@nvidia.com>
CC: Jon Hunter <jonathanh@nvidia.com>, <stable@vger.kernel.org>
Subject: [PATCH 2/4] ASoC: tegra: Fix the MIXER enable default value
Date: Fri, 21 Aug 2026 12:41:28 +0100
Message-ID: <20260821114130.54376-2-jonathanh@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260821114130.54376-1-jonathanh@nvidia.com>
References: <20260821114130.54376-1-jonathanh@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BN2PEPF00004FBD:EE_|SN7PR12MB7834:EE_
X-MS-Office365-Filtering-Correlation-Id: 662df0a3-4075-41b0-5d3e-08deff79394d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|82310400026|1800799024|376014|23010399003|18002099003|22082099003|56012099006|6133799003|11063799006|10067099003;
X-Microsoft-Antispam-Message-Info:
	vXOECQ9bXYSBIeiqozjoWXR5o9IkrJkM4Jd3n8ukjYDe+RvjZsP0MHNuvLACzAgOA7Zo9CfDIYXngIkly2hUYHcap+36IjQbshLsGSHpk1KMiQX8eChpBDL3BGJzr3l8rAPBiAEHJVZMlxVby2AN5v9Q7049TTi0UcHpmHf3wdHVqkGCNwzT3UB/WkKelY2u+Xl+l2ZenVFL1kjn6qGnpMNr9yOUjMIEkByPxXBIfn/0PMa3EzNRRvHXAVhlfrEWOszWfBhBV+OSoHLkfFeXvzYfJkJk80fiLO4cPg/El4BVu2Pgu4vV5Sh1bYv8+65r8b5mXBc5zmc7QIspF30L8CYlT7o6Tq1sHJ3i4JZklZHPB+rkzf86tEJDaf2VmGPRxjAG8ROgfNK7qrns5rt4A3CiGzhmMPUGfIAwcunpNXuYxE0W3hH4P2VvwxTqbqYns7FvQigRpfF9yryxBc3QUeIveettdR7iTvHerYd4d8BrGTn77jsCh+EMQR6iV4q44Z2/YZQVO+UYzcFaCmKFSLitZjtwy6rnLGNnmen3HD2/u0nloGaWktjLbnqtATyZ1uNSFPzjZv7+o4NDvyR/ExlHpLHi9WqxbD/pzEzA/lNqn93CFR0TyPP0/mao1y1VBmYVwrRhHlkwIdXfGjWc1mWo9liro2TDElAW+pIjFXN8kMLFIY2eX98YAIUqWgfIPwRO+n8/iSqEWvlm3Jc8Zw==
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(36860700016)(82310400026)(1800799024)(376014)(23010399003)(18002099003)(22082099003)(56012099006)(6133799003)(11063799006)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	7CYxAKXDmKYrZxcbJPu7OH6f/TnupChqZ6SKUSK2+vHxEZgvo/JoJ7NvaV4xBDlVK4v/Oz9BuCZXwKzCJ4fd1/1zk1PpX+h+rOgtUSn+2hmjTkNRS8h62XEoRVpl93EuuWGywSge03On2JMeIpP1jvVGysCgRVVTy2UIHTUb6lCwSqLQkGJ8PamLMCWYgymDH4AnCpzqKNXgqilJWax32cvbiPjxsDBHf7I1xdDkD1TWPgNZaehCU6BkTbcR1oAQRM2/3fO10fyhrhkbLBmrCn5fwPOfEKDH4tFYPyImJgDzBtffjN0x1cyEly/cie3MlEJI/bzIgukTwUlqI+oc2I/5rE/00Qz11eq0R7M8/9jFFTOc23teRtBj+O6b+WYryO8j/Pz1Zvt1xq56Ij+/NQV2L6HSm1Y+mgeaNKMyympSS8AIKOSEEoA7CgTBYNHL
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2026 11:42:04.8759
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 662df0a3-4075-41b0-5d3e-08deff79394d
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN2PEPF00004FBD.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7834

Commit 4b05ccb17f92 ("regcache: Sort the local copy of an unsorted
reg_defaults array") exposed an issue in the Tegra MIXER driver where
the register default for the TEGRA210_MIXER_ENABLE is specified as 1,
but the hardware default is actually 0. After commit 4b05ccb17f92 was
added the MIXER driver is no longer working and so fix this by
correcting the default value for this register and explicitly
configuring the MIXER_ENABLE register when runtime resuming the MIXER
device.

Fixes: 05bb3d5ec64a ("ASoC: tegra: Add Tegra210 based Mixer driver")
Cc: stable@vger.kernel.org
Signed-off-by: Jon Hunter <jonathanh@nvidia.com>
---
 sound/soc/tegra/tegra210_mixer.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/sound/soc/tegra/tegra210_mixer.c b/sound/soc/tegra/tegra210_mixer.c
index 8eb4e54b954b..96259a6cbc59 100644
--- a/sound/soc/tegra/tegra210_mixer.c
+++ b/sound/soc/tegra/tegra210_mixer.c
@@ -57,7 +57,7 @@ static const struct reg_default tegra210_mixer_reg_defaults[] = {
 	MIXER_TX_REG_DEFAULTS(3),
 	MIXER_TX_REG_DEFAULTS(4),
 
-	{ TEGRA210_MIXER_ENABLE, 0x1 },
+	{ TEGRA210_MIXER_ENABLE, 0x0 },
 	{ TEGRA210_MIXER_CG, 0x00000001},
 	{ TEGRA210_MIXER_GAIN_CFG_RAM_CTRL, 0x00004000},
 	{ TEGRA210_MIXER_PEAKM_RAM_CTRL, 0x00004000},
@@ -86,11 +86,15 @@ static int tegra210_mixer_runtime_suspend(struct device *dev)
 static int tegra210_mixer_runtime_resume(struct device *dev)
 {
 	struct tegra210_mixer *mixer = dev_get_drvdata(dev);
+	int err;
 
 	regcache_cache_only(mixer->regmap, false);
-	regcache_sync(mixer->regmap);
+	err = regcache_sync(mixer->regmap);
+	if (err)
+		return err;
 
-	return 0;
+	return regmap_write(mixer->regmap, TEGRA210_MIXER_ENABLE,
+			    TEGRA210_MIXER_EN);
 }
 
 static int tegra210_mixer_write_ram(struct tegra210_mixer *mixer,
-- 
2.43.0

