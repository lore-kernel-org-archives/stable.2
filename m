Received: from MW6PR02CU001.outbound.protection.outlook.com (mail-westus2azon11012053.outbound.protection.outlook.com [52.101.48.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90A603BBA04
	for <stable@vger.kernel.org>; Fri, 21 Aug 2026 11:42:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.48.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787312535; cv=fail; b=mfVQLgaWX9clRCcQ7sdLYFdJLvjhrBAnotx4BmqOhpCqjvwlOGLtRFs7PgwQIDjJ8IWi7SZaa9efMrRXnO4CNXR9JKfDKgscrH07KcXEc66aLZegL3zoShWLvFFPubUMhZeHQgDYbUl9/L8ecuS6uN2UgUJHEZ7OTXfbVWCXTqM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787312535; c=relaxed/simple;
	bh=UvuIbYgN1O+5Ih69QwFRUs1YLGEbrJdYhzAQAXOfDDo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CDW4aSdPmi5A3erCHgPaoKkiJ58PyYtkOt74ZLpjPJJCaihH7n50rUYE3HkXR7zFu8yTpNEjTnFwKIj8NA0Dr/s1NojEcH471d+qwH9SWyHsvidWSIXXzNpRbi1vSK6gPX5rx4FQpEQR+Ri5MsAKBAClB3g/NvxqNZ4DsnM91rI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=N9981qvV; arc=fail smtp.client-ip=52.101.48.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="N9981qvV"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=H6/Sy3BIvNeYDp0il8QdrgGufz+nJBsN1yisqZ/bz6Y5IL2UuHuYPaqRfCH+z5yBNyfsNzzoU5KP/w+Q4kijPLkLo2uxIRQciicgpMoq3SddTwixP/cp6Sd9wDTru/aeou+oRKOzUhMo2YCIhN8JHwMGayF5QNqKNr2iWvIQxN18hr5N3dnZlznEpO4Mk5X3e9bkgMuG4LTEjxUHEul8k53sce/jm1n2SNkWsgySyrLBs8j3cn5u32fKuFiaWRsXzGpfSEGNvJuRZdNKmyS36yp86ky/GWL1/5r3uYZhsvkMjTNPsj92voeEmYZ2Mgl5Z8hBkbiwdvnh1tKasONa1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hweOGX02xGnPps0wqcMytK2dRCJRYUB3Oe/KemvFpTQ=;
 b=M3pPOsFhvkCbQmdCSuhrPWYOd2e881Dq3nMg6yF/fWZrf36n5EW0HK3iRjuojwc9DgwMrkXE64yOtvJ7BPYGwJC5Q+BlYjUVptLV9MBusTPZYQuq44WJNQL/V6v0zA8KC5HWJK9aRiCiDZ16co83EbS4tILZk9jIB/dstfcfqCXVBBH+L98lki/honSHHRqx9RXmoIeb9HO3UQbWq1uUmM73aW/PY2IWyiB6FYyoeBEhRKMJ9QRn5gRbPFOHuxdNsYGCc784BV2t/7OgbpysofayFVplqgw7w3M8rXPJ2u/hmFNpO/Dn5D7rBJsVPDNIYKw06DImGCR3rw7t1/ouOA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hweOGX02xGnPps0wqcMytK2dRCJRYUB3Oe/KemvFpTQ=;
 b=N9981qvVuTXlTKnztGGhOYSEOu7fM1jB8aB/QofQMG1+ZxZX2LP84g73Ps5RSU72Gv08ro4MrLOy/oLs1Nk6ITCCccsCDtqrjO23kBgK9W9RzKja1LseRHHupTQXzPv6/kFg1BzRdK1W0o84rt4mHPZmCJ+kx1NOUO6zJLhZYBWfzQOWSv4PiTLkhnoJeGX4SuYc/F/gw8gMoXUk/yvmyYS7FHfnKyhOtleyCmVwZH0Hr4/4o7gNaaAbbxsj8/lVUIhn6mQU9o0J9keMvec+CcUm7pA1fLCYO1ZyCOHLKpleYSbsmz3zlo72A1T8r4P0YwKa8BMjEiKjsTl7bgGSyg==
Received: from CH0PR04CA0081.namprd04.prod.outlook.com (2603:10b6:610:74::26)
 by MN0PR12MB5908.namprd12.prod.outlook.com (2603:10b6:208:37c::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.10; Fri, 21 Aug
 2026 11:42:09 +0000
Received: from CH2PEPF00000141.namprd02.prod.outlook.com
 (2603:10b6:610:74:cafe::81) by CH0PR04CA0081.outlook.office365.com
 (2603:10b6:610:74::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.339.11 via Frontend Transport; Fri,
 21 Aug 2026 11:42:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CH2PEPF00000141.mail.protection.outlook.com (10.167.244.74) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.339.3 via Frontend Transport; Fri, 21 Aug 2026 11:42:09 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Fri, 21 Aug
 2026 04:41:51 -0700
Received: from moonraker.nvidia.com (10.126.231.37) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Fri, 21 Aug
 2026 04:41:49 -0700
From: Jon Hunter <jonathanh@nvidia.com>
To: <svclkml-review@nvidia.com>
CC: Jon Hunter <jonathanh@nvidia.com>, <stable@vger.kernel.org>
Subject: [PATCH 4/4] ASoC: tegra: Sort MBDRC register defaults
Date: Fri, 21 Aug 2026 12:41:30 +0100
Message-ID: <20260821114130.54376-4-jonathanh@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CH2PEPF00000141:EE_|MN0PR12MB5908:EE_
X-MS-Office365-Filtering-Correlation-Id: 6e4ebb85-48dd-4455-fa0a-08deff793be0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|23010399003|1800799024|36860700016|82310400026|10067099003|11063799006|56012099006|3023799007|6133799003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	ScAVFSWJ/1t+i+M+KbEHMCaQB02aMI2b9lZcFAtCzGry+qq6kDmNK9q2LOlBH9T/U7vskTyUp/WLpQ5GLcWlUZgcRrjpFgG3jSGcNwK2o7Lr8xXtrjBikDfMngnbbNvnkCZjqxPVhxI7ZylL1gdHQ92WWcexUtOUIrrY3pv6W7nzfdss16lXuhj54d3qysnF1VG3n9ujx+YOat+BypDe7OQMh8VVS5PoBuerw2ACc6SuEbspU0sb8TqC6rw/haQcxiON5Bok7bv/0spM+5xVeBbsmqCrhpEy8KDwN3OtGS3MQ4+r6AsExmnHuRM8lwfUzSmH81tFdwGO9t/iRvMVYAf32rXI1G4KQDc1AC3GxlV5sdbazngxZiF9KMtHb8j6ZboxR9S9YHc/pp3X6EnGx/CJ2d4R0uAmcx3Ll2onmQa5fpPU9rbZwLdiZWaywcc79WTyo95GKRyKzbATNUKO/02uoFekfAmYHQsLGx9AWQYn5yWbakhDUBRnKyf+gBLn7+c25+WRk2u/pyGjwTFqJQTEF4LtwziQ50G1s5Ge29LPcjQ/zib6pdalUdV84Mn50eKDLrsUu9LSUdsc7ACp56mKV6KoI16z926Q/M21ZyDpu73DNEiOr04VJv7QIFhA7ymrSiBV4qJs6TAjlhtVMkNLsJLDLv28uzEab+oFkQTYUoxQb1o4nzjXrHlHbFeS0Bq0HyuZ6G5j+SxGR6wCuQ==
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(23010399003)(1800799024)(36860700016)(82310400026)(10067099003)(11063799006)(56012099006)(3023799007)(6133799003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	XuXq3x8i33SzHeLLTjDLuG4tcVsrDV30M1GSUYEfDv3q/pFZqd4NPsVYTcRdhvMD62s2uPVnBKS5hctxTpaMJTNR9jJNfsoK7JMeNtvc4AzpQGGZoNzDDVfpW/rUaXmdeD6QnOX0PWW5/YkIddL9DLMeGwhCDI99pFpzBDeEF7qUPfUdqH5swki+kQhYBEbAsNMGk7QC0cTOmT9FG93KVVsEVaXO3xbvMHGByc3WBGdUl2wBvR3FwO7RJ1kntkHZO84VBYO/X+HY+QXBLZXtHt3GEkntJHiDni1tn6JOahZLreRLWxpHUuZJZWL5201BDbbBwtEGOGflyAoUAk6Vn9Ve9qd8jDK6nHxcAtkk+oPlolS0FcUhG4dStUiQDsiCDu2NLtWBIN4tWNRHxBjKj0x3oJqbKcNLtqMzKiT1hLF4WyuRrH+VoHIoViJVyfS3
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2026 11:42:09.2346
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6e4ebb85-48dd-4455-fa0a-08deff793be0
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH2PEPF00000141.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5908

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

