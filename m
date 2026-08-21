Received: from BN1PR04CU002.outbound.protection.outlook.com (mail-eastus2azon11010042.outbound.protection.outlook.com [52.101.56.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69FF636B90A;
	Fri, 21 Aug 2026 15:38:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.56.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787326721; cv=fail; b=ADeYj3KbRjy3yXGKDFMRQQ0qb2kSZ0env76ci/aIDXzCtYJn3cVEiFAkNav4gTJwgYYY1Af4qh9h957O9qCTDCRxGwRUZtO3roxjXG4GL6NORHmSWqQ8ehlJARA1l8supinoEaqz31cNS5Z+RLmnTCibtozOx7cJ2bCDtu7/DaA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787326721; c=relaxed/simple;
	bh=mGbaSlD2z9xi1XNmSoXX6OobwTTHMv4zlGzhwx+h+o0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OogcHeVQOC5m6QToOOKz+L8hilDAaWrYiEEXPFBiBvhqG+baERXNn61rY0GSbvXXcSVrmKsK20+BlzR1LKU5laxz2NeeT25ndkKJJiGeOm2LQVmqRxti030VUQx5vLxRl5Ru/pRYb2pGM/CSldl0pCWSgnAha0DPLzXQoeItv5M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Sx7R87r/; arc=fail smtp.client-ip=52.101.56.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Sx7R87r/"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=G6IpB26F5laC/Cc9u1Hphr8LvxZYDQl5wpcLHS0TVZTuoavjMkyowJ5p4jGKokLpWuQkA7WZj69s2IeKI5L9FjGzWh6aU2KqguuvV6nTo7rMZ+U0EPLQTOCoTC1by/BhhlFNACMqSm9DtkaOfjj+mxPwU/YObWoX523Yfe+WUKD8WESujHfUIeHKtq3xMy+5254smLIATHe6apls2OMTCRw+s3NmQ/7KiAt3j+ydXueOQUxU5YeIM18ynGjQNSU8FtEEQCmS0dAAFIhGJVXldi3KEJQELbaLxTGYdsTw4WgQ22Wgj8un+wMGjWawkJ8jov1zRr3pvLlunlEKW1Soow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9iKR1/5yf5sCaryF+yL7y5zphgui5Gsa5gnKbTKHF48=;
 b=gGbdDAhkat+pwY+j6rMDjswWIaVz/uPJHmUrLtgTlYmT8XVS6LbN7g7B5DP65a41ExkWghr+FKuPIdYovorTxZv9DSYPqy1yJLXdmIvmfgiD1H2btfsXSoQv4YFpuMCTTX4cJqAhvtBkqVEallVwU9+97oiRQes75tua/9wzeNREY8tQrT1PdR4IBe8RASPIhM2chKkZubaSNakrVm7G6J72UZ4QQZEZ4b9Gx0kWGlYeaIJJNCVUAphPao1Q5o+c0E2RiKIkIC/aBUm4ZLLrnISBWyRYe8T0mvnHpoGH4ek8iaOssRjFypK5rCYppo8/TRza16I9tWCxGHB+DbIvhA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=gmail.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9iKR1/5yf5sCaryF+yL7y5zphgui5Gsa5gnKbTKHF48=;
 b=Sx7R87r/ZpEj9a9QCD+nWUgD+mFNZJ/i9eDxlL+4+9ghtTVyyPgflxM0mWMWRS8KfyPQYHuIKXlilYAwk3rYd/I6xhCOZrUiGkx1656xfuN05ZDbo1jtIsdp9qPoPF3p+4AkEMnCI2duaN4/gBaaElBFck95W+332ZadfxUREKc66EV5YGzk4epN0N6l22YP05/mTjl+Wkr5JkXv8wbVnCdZcQX3r/HUCjHVAGj3/9Vc9hO9yAyrHtz05f8Y9D6qdRtcoD6xpD27BvtK0cd6nwna91p2GQFJv29KSVK9F5kbbjHJrjmyIf277EH3uCVNcjXWFFAyxNS4117Cq4tahw==
Received: from BN0PR04CA0113.namprd04.prod.outlook.com (2603:10b6:408:ec::28)
 by CH2PR12MB4037.namprd12.prod.outlook.com (2603:10b6:610:7a::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.8; Fri, 21 Aug
 2026 15:38:30 +0000
Received: from MN1PEPF0000ECD6.namprd02.prod.outlook.com
 (2603:10b6:408:ec:cafe::3f) by BN0PR04CA0113.outlook.office365.com
 (2603:10b6:408:ec::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.339.11 via Frontend Transport; Fri,
 21 Aug 2026 15:38:30 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 MN1PEPF0000ECD6.mail.protection.outlook.com (10.167.242.135) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.360.3 via Frontend Transport; Fri, 21 Aug 2026 15:38:29 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Fri, 21 Aug
 2026 08:38:04 -0700
Received: from moonraker.nvidia.com (10.126.231.37) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Fri, 21 Aug
 2026 08:38:01 -0700
From: Jon Hunter <jonathanh@nvidia.com>
To: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
	Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, "Thierry
 Reding" <thierry.reding@kernel.org>, Sheetal <sheetal@nvidia.com>,
	<peter.ujfalusi@linux.intel.com>
CC: <linux-sound@vger.kernel.org>, <linux-tegra@vger.kernel.org>, Jon Hunter
	<jonathanh@nvidia.com>, <stable@vger.kernel.org>
Subject: [PATCH 3/4] ASoC: tegra: Sort ADMAIF register defaults
Date: Fri, 21 Aug 2026 16:37:33 +0100
Message-ID: <20260821153734.158426-4-jonathanh@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: MN1PEPF0000ECD6:EE_|CH2PR12MB4037:EE_
X-MS-Office365-Filtering-Correlation-Id: 7a66eed1-3d19-4d6b-92b2-08deff9a4036
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700016|376014|23010399003|1800799024|10067099003|6133799003|56012099006|11063799006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	YWfXfx4cAb1LqGhA0UHSu1cFjLad6GR9tATPIMLTRs7ZF+lZhR8vU5zTfTA4LNWVW4jF2uZpfzjiUmwLof7ctiNAzJmGykufSJSCVPsL3CZJP+53gWJmTETqfRNFjlPAfOjzHq1hcT2klQxrD4j0npZaXSHIMhR8eT8p6kwc1Vfy3Rn8Lrclpb8ljC0Yf117eXqov9BRzjVGW7uhFwtYPysHxUisj6HVt+qO9Nme/UQekfyx4GPjaNcBdc6EmoNvwMRzJYDQU1bSAdtJDHhUeTVwbtfTCoAkAoDbIIy1pRG4NZCTvhzjiA4EswFjXzo1UTSthgjHUPGWxZPuqnOcDzqvq4TgrAfCsOlyMg3UZt0Zmc6hIFXP4YAeJNsVWaNVlTkcc8bzIj5C7s0WW/zAwHySDYVtFSagT4Hi7Ow9yRJqemlD80ES4csEOthkflON449CsiiWC54cNdSNgBRp0XNpPYquizH4JZEE5hVLaEbq/ArUs7LgsnqRbkZCbXNZVfOVTnTzrOH8P1T4c/fwPm+ogHwPPxLr9UcKLECzs3Y3xY7julMWqmzyUTNhRkFQs9Km14FZ2KT8JNCryPtOzB7qJ9k6V5YYJeZ+t964gPkUNiHFRlig+KG29nlNW8i1U+94W58z2Bh/EbW0SnBo5I5JCFJiZkxVq4AVXwGiwrxewjjYDbspOhRD7dGmCvHqJSpGNJYJ6SJhfFGoEM20+A==
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(36860700016)(376014)(23010399003)(1800799024)(10067099003)(6133799003)(56012099006)(11063799006)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	1fDqO45D+Xeznr+qWD2TeLajTQZmfbDaGiXKYjG5Pfgs2umYMMy7hwuEJftwjJpo86xFB9Bl6DTNd02D5BYxriuOVR5+Fnax44oxEhgJOcNv58PLk4oM59sCmgp6gXOCM2d7QOb1NblqmQZn6FS391umjvhtxLrFIAeXZ6R2cb1c8GKChhVM9m5XBWA42gmgR7foLb0ahpQmJGt28MmSxrwN44BhWCJxHOQ7ROb8lziTPE8e9iybELzKTSrnnvNxWlKp/fRCUxJcHV1WWuCYn9kn/JkhPdPkAWfAUFeDI86iiK54OgQNjU2OGudoYciPd+LYmj/WjlhK0/T2/+2ZC3i5GZJHluqKikNFrhb/CBdtbLiMxIn0BFF2RKluAKdRfA8rr6uk0Nr8sPyMLscCPPc5KYYKXq9PgI5ShWzK/61fy2ZvNyxf5qtmxNzjPOz2
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2026 15:38:29.9025
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7a66eed1-3d19-4d6b-92b2-08deff9a4036
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MN1PEPF0000ECD6.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4037

Commit 4b05ccb17f92 ("regcache: Sort the local copy of an unsorted
reg_defaults array") exposed an issue in the Tegra ADMAIF driver and now
the following warning is observed:

 tegra210-admaif 290f000.admaif: Driver needs fixing: Unsorted
  reg_defaults, sorting the copy

This warning occurs because register defaults in the structures
tegra186_admaif_reg_defaults and tegra264_admaif_reg_defaults are not
specified in ascending order which is required by regmap. Fix this by
sorting the register defaults according to their address. Note that in
order to do this it is necessary to split the macro ADMAIF_REG_DEFAULTS
into separate RX and TX macros to the RX and TX registers.

Fixes: f74028e159bb ("ASoC: tegra: Add Tegra210 based ADMAIF driver")
Cc: stable@vger.kernel.org
Signed-off-by: Jon Hunter <jonathanh@nvidia.com>
---
 sound/soc/tegra/tegra210_admaif.c | 208 ++++++++++++++++++++----------
 1 file changed, 138 insertions(+), 70 deletions(-)

diff --git a/sound/soc/tegra/tegra210_admaif.c b/sound/soc/tegra/tegra210_admaif.c
index 7299c6bfcf15..87e898cc35e4 100644
--- a/sound/soc/tegra/tegra210_admaif.c
+++ b/sound/soc/tegra/tegra210_admaif.c
@@ -26,94 +26,162 @@
 
 #define CH_RX_REG(reg, id) CH_REG(admaif->soc_data->rx_base, reg, id)
 
-#define REG_DEFAULTS(id, rx_ctrl, tx_ctrl, tx_base, rx_base, cif_ctrl)	       \
+#define RX_REG_DEFAULTS(id, rx_ctrl, rx_base, cif_ctrl)			       \
 	{ CH_REG(rx_base, TEGRA_ADMAIF_RX_INT_MASK, id), 0x00000001 },	       \
 	{ CH_REG(rx_base, TEGRA_ADMAIF_CH_ACIF_RX_CTRL, id), cif_ctrl },     \
-	{ CH_REG(rx_base, TEGRA_ADMAIF_RX_FIFO_CTRL, id), rx_ctrl },	       \
+	{ CH_REG(rx_base, TEGRA_ADMAIF_RX_FIFO_CTRL, id), rx_ctrl }
+
+#define TX_REG_DEFAULTS(id, tx_ctrl, tx_base, cif_ctrl)			       \
 	{ CH_REG(tx_base, TEGRA_ADMAIF_TX_INT_MASK, id), 0x00000001 },	       \
 	{ CH_REG(tx_base, TEGRA_ADMAIF_CH_ACIF_TX_CTRL, id), cif_ctrl },     \
 	{ CH_REG(tx_base, TEGRA_ADMAIF_TX_FIFO_CTRL, id), tx_ctrl }
 
-#define ADMAIF_REG_DEFAULTS(id, chip)					       \
-	REG_DEFAULTS((id) - 1,						       \
+#define ADMAIF_RX_REG_DEFAULTS(id, chip)				       \
+	RX_REG_DEFAULTS((id) - 1,					       \
 		chip ## _ADMAIF_RX ## id ## _FIFO_CTRL_REG_DEFAULT,	       \
+		chip ## _ADMAIF_RX_BASE,				       \
+		chip ## _ADMAIF_CIF_REG_DEFAULT)
+
+#define ADMAIF_TX_REG_DEFAULTS(id, chip)				       \
+	TX_REG_DEFAULTS((id) - 1,					       \
 		chip ## _ADMAIF_TX ## id ## _FIFO_CTRL_REG_DEFAULT,	       \
 		chip ## _ADMAIF_TX_BASE,				       \
-		chip ## _ADMAIF_RX_BASE,				       \
 		chip ## _ADMAIF_CIF_REG_DEFAULT)
 
 static const struct reg_default tegra186_admaif_reg_defaults[] = {
-	{(TEGRA_ADMAIF_GLOBAL_CG_0 + TEGRA186_ADMAIF_GLOBAL_BASE), 0x00000003},
-	ADMAIF_REG_DEFAULTS(1, TEGRA186),
-	ADMAIF_REG_DEFAULTS(2, TEGRA186),
-	ADMAIF_REG_DEFAULTS(3, TEGRA186),
-	ADMAIF_REG_DEFAULTS(4, TEGRA186),
-	ADMAIF_REG_DEFAULTS(5, TEGRA186),
-	ADMAIF_REG_DEFAULTS(6, TEGRA186),
-	ADMAIF_REG_DEFAULTS(7, TEGRA186),
-	ADMAIF_REG_DEFAULTS(8, TEGRA186),
-	ADMAIF_REG_DEFAULTS(9, TEGRA186),
-	ADMAIF_REG_DEFAULTS(10, TEGRA186),
-	ADMAIF_REG_DEFAULTS(11, TEGRA186),
-	ADMAIF_REG_DEFAULTS(12, TEGRA186),
-	ADMAIF_REG_DEFAULTS(13, TEGRA186),
-	ADMAIF_REG_DEFAULTS(14, TEGRA186),
-	ADMAIF_REG_DEFAULTS(15, TEGRA186),
-	ADMAIF_REG_DEFAULTS(16, TEGRA186),
-	ADMAIF_REG_DEFAULTS(17, TEGRA186),
-	ADMAIF_REG_DEFAULTS(18, TEGRA186),
-	ADMAIF_REG_DEFAULTS(19, TEGRA186),
-	ADMAIF_REG_DEFAULTS(20, TEGRA186)
+	ADMAIF_RX_REG_DEFAULTS(1, TEGRA186),
+	ADMAIF_RX_REG_DEFAULTS(2, TEGRA186),
+	ADMAIF_RX_REG_DEFAULTS(3, TEGRA186),
+	ADMAIF_RX_REG_DEFAULTS(4, TEGRA186),
+	ADMAIF_RX_REG_DEFAULTS(5, TEGRA186),
+	ADMAIF_RX_REG_DEFAULTS(6, TEGRA186),
+	ADMAIF_RX_REG_DEFAULTS(7, TEGRA186),
+	ADMAIF_RX_REG_DEFAULTS(8, TEGRA186),
+	ADMAIF_RX_REG_DEFAULTS(9, TEGRA186),
+	ADMAIF_RX_REG_DEFAULTS(10, TEGRA186),
+	ADMAIF_RX_REG_DEFAULTS(11, TEGRA186),
+	ADMAIF_RX_REG_DEFAULTS(12, TEGRA186),
+	ADMAIF_RX_REG_DEFAULTS(13, TEGRA186),
+	ADMAIF_RX_REG_DEFAULTS(14, TEGRA186),
+	ADMAIF_RX_REG_DEFAULTS(15, TEGRA186),
+	ADMAIF_RX_REG_DEFAULTS(16, TEGRA186),
+	ADMAIF_RX_REG_DEFAULTS(17, TEGRA186),
+	ADMAIF_RX_REG_DEFAULTS(18, TEGRA186),
+	ADMAIF_RX_REG_DEFAULTS(19, TEGRA186),
+	ADMAIF_RX_REG_DEFAULTS(20, TEGRA186),
+	ADMAIF_TX_REG_DEFAULTS(1, TEGRA186),
+	ADMAIF_TX_REG_DEFAULTS(2, TEGRA186),
+	ADMAIF_TX_REG_DEFAULTS(3, TEGRA186),
+	ADMAIF_TX_REG_DEFAULTS(4, TEGRA186),
+	ADMAIF_TX_REG_DEFAULTS(5, TEGRA186),
+	ADMAIF_TX_REG_DEFAULTS(6, TEGRA186),
+	ADMAIF_TX_REG_DEFAULTS(7, TEGRA186),
+	ADMAIF_TX_REG_DEFAULTS(8, TEGRA186),
+	ADMAIF_TX_REG_DEFAULTS(9, TEGRA186),
+	ADMAIF_TX_REG_DEFAULTS(10, TEGRA186),
+	ADMAIF_TX_REG_DEFAULTS(11, TEGRA186),
+	ADMAIF_TX_REG_DEFAULTS(12, TEGRA186),
+	ADMAIF_TX_REG_DEFAULTS(13, TEGRA186),
+	ADMAIF_TX_REG_DEFAULTS(14, TEGRA186),
+	ADMAIF_TX_REG_DEFAULTS(15, TEGRA186),
+	ADMAIF_TX_REG_DEFAULTS(16, TEGRA186),
+	ADMAIF_TX_REG_DEFAULTS(17, TEGRA186),
+	ADMAIF_TX_REG_DEFAULTS(18, TEGRA186),
+	ADMAIF_TX_REG_DEFAULTS(19, TEGRA186),
+	ADMAIF_TX_REG_DEFAULTS(20, TEGRA186),
+	{(TEGRA_ADMAIF_GLOBAL_CG_0 + TEGRA186_ADMAIF_GLOBAL_BASE), 0x00000003}
 };
 
 static const struct reg_default tegra210_admaif_reg_defaults[] = {
-	{(TEGRA_ADMAIF_GLOBAL_CG_0 + TEGRA210_ADMAIF_GLOBAL_BASE), 0x00000003},
-	ADMAIF_REG_DEFAULTS(1, TEGRA210),
-	ADMAIF_REG_DEFAULTS(2, TEGRA210),
-	ADMAIF_REG_DEFAULTS(3, TEGRA210),
-	ADMAIF_REG_DEFAULTS(4, TEGRA210),
-	ADMAIF_REG_DEFAULTS(5, TEGRA210),
-	ADMAIF_REG_DEFAULTS(6, TEGRA210),
-	ADMAIF_REG_DEFAULTS(7, TEGRA210),
-	ADMAIF_REG_DEFAULTS(8, TEGRA210),
-	ADMAIF_REG_DEFAULTS(9, TEGRA210),
-	ADMAIF_REG_DEFAULTS(10, TEGRA210)
+	ADMAIF_RX_REG_DEFAULTS(1, TEGRA210),
+	ADMAIF_RX_REG_DEFAULTS(2, TEGRA210),
+	ADMAIF_RX_REG_DEFAULTS(3, TEGRA210),
+	ADMAIF_RX_REG_DEFAULTS(4, TEGRA210),
+	ADMAIF_RX_REG_DEFAULTS(5, TEGRA210),
+	ADMAIF_RX_REG_DEFAULTS(6, TEGRA210),
+	ADMAIF_RX_REG_DEFAULTS(7, TEGRA210),
+	ADMAIF_RX_REG_DEFAULTS(8, TEGRA210),
+	ADMAIF_RX_REG_DEFAULTS(9, TEGRA210),
+	ADMAIF_RX_REG_DEFAULTS(10, TEGRA210),
+	ADMAIF_TX_REG_DEFAULTS(1, TEGRA210),
+	ADMAIF_TX_REG_DEFAULTS(2, TEGRA210),
+	ADMAIF_TX_REG_DEFAULTS(3, TEGRA210),
+	ADMAIF_TX_REG_DEFAULTS(4, TEGRA210),
+	ADMAIF_TX_REG_DEFAULTS(5, TEGRA210),
+	ADMAIF_TX_REG_DEFAULTS(6, TEGRA210),
+	ADMAIF_TX_REG_DEFAULTS(7, TEGRA210),
+	ADMAIF_TX_REG_DEFAULTS(8, TEGRA210),
+	ADMAIF_TX_REG_DEFAULTS(9, TEGRA210),
+	ADMAIF_TX_REG_DEFAULTS(10, TEGRA210),
+	{(TEGRA_ADMAIF_GLOBAL_CG_0 + TEGRA210_ADMAIF_GLOBAL_BASE), 0x00000003}
 };
 
 static const struct reg_default tegra264_admaif_reg_defaults[] = {
-	{(TEGRA_ADMAIF_GLOBAL_CG_0 + TEGRA264_ADMAIF_GLOBAL_BASE), 0x00000003},
-	ADMAIF_REG_DEFAULTS(1, TEGRA264),
-	ADMAIF_REG_DEFAULTS(2, TEGRA264),
-	ADMAIF_REG_DEFAULTS(3, TEGRA264),
-	ADMAIF_REG_DEFAULTS(4, TEGRA264),
-	ADMAIF_REG_DEFAULTS(5, TEGRA264),
-	ADMAIF_REG_DEFAULTS(6, TEGRA264),
-	ADMAIF_REG_DEFAULTS(7, TEGRA264),
-	ADMAIF_REG_DEFAULTS(8, TEGRA264),
-	ADMAIF_REG_DEFAULTS(9, TEGRA264),
-	ADMAIF_REG_DEFAULTS(10, TEGRA264),
-	ADMAIF_REG_DEFAULTS(11, TEGRA264),
-	ADMAIF_REG_DEFAULTS(12, TEGRA264),
-	ADMAIF_REG_DEFAULTS(13, TEGRA264),
-	ADMAIF_REG_DEFAULTS(14, TEGRA264),
-	ADMAIF_REG_DEFAULTS(15, TEGRA264),
-	ADMAIF_REG_DEFAULTS(16, TEGRA264),
-	ADMAIF_REG_DEFAULTS(17, TEGRA264),
-	ADMAIF_REG_DEFAULTS(18, TEGRA264),
-	ADMAIF_REG_DEFAULTS(19, TEGRA264),
-	ADMAIF_REG_DEFAULTS(20, TEGRA264),
-	ADMAIF_REG_DEFAULTS(21, TEGRA264),
-	ADMAIF_REG_DEFAULTS(22, TEGRA264),
-	ADMAIF_REG_DEFAULTS(23, TEGRA264),
-	ADMAIF_REG_DEFAULTS(24, TEGRA264),
-	ADMAIF_REG_DEFAULTS(25, TEGRA264),
-	ADMAIF_REG_DEFAULTS(26, TEGRA264),
-	ADMAIF_REG_DEFAULTS(27, TEGRA264),
-	ADMAIF_REG_DEFAULTS(28, TEGRA264),
-	ADMAIF_REG_DEFAULTS(29, TEGRA264),
-	ADMAIF_REG_DEFAULTS(30, TEGRA264),
-	ADMAIF_REG_DEFAULTS(31, TEGRA264),
-	ADMAIF_REG_DEFAULTS(32, TEGRA264)
+	ADMAIF_RX_REG_DEFAULTS(1, TEGRA264),
+	ADMAIF_RX_REG_DEFAULTS(2, TEGRA264),
+	ADMAIF_RX_REG_DEFAULTS(3, TEGRA264),
+	ADMAIF_RX_REG_DEFAULTS(4, TEGRA264),
+	ADMAIF_RX_REG_DEFAULTS(5, TEGRA264),
+	ADMAIF_RX_REG_DEFAULTS(6, TEGRA264),
+	ADMAIF_RX_REG_DEFAULTS(7, TEGRA264),
+	ADMAIF_RX_REG_DEFAULTS(8, TEGRA264),
+	ADMAIF_RX_REG_DEFAULTS(9, TEGRA264),
+	ADMAIF_RX_REG_DEFAULTS(10, TEGRA264),
+	ADMAIF_RX_REG_DEFAULTS(11, TEGRA264),
+	ADMAIF_RX_REG_DEFAULTS(12, TEGRA264),
+	ADMAIF_RX_REG_DEFAULTS(13, TEGRA264),
+	ADMAIF_RX_REG_DEFAULTS(14, TEGRA264),
+	ADMAIF_RX_REG_DEFAULTS(15, TEGRA264),
+	ADMAIF_RX_REG_DEFAULTS(16, TEGRA264),
+	ADMAIF_RX_REG_DEFAULTS(17, TEGRA264),
+	ADMAIF_RX_REG_DEFAULTS(18, TEGRA264),
+	ADMAIF_RX_REG_DEFAULTS(19, TEGRA264),
+	ADMAIF_RX_REG_DEFAULTS(20, TEGRA264),
+	ADMAIF_RX_REG_DEFAULTS(21, TEGRA264),
+	ADMAIF_RX_REG_DEFAULTS(22, TEGRA264),
+	ADMAIF_RX_REG_DEFAULTS(23, TEGRA264),
+	ADMAIF_RX_REG_DEFAULTS(24, TEGRA264),
+	ADMAIF_RX_REG_DEFAULTS(25, TEGRA264),
+	ADMAIF_RX_REG_DEFAULTS(26, TEGRA264),
+	ADMAIF_RX_REG_DEFAULTS(27, TEGRA264),
+	ADMAIF_RX_REG_DEFAULTS(28, TEGRA264),
+	ADMAIF_RX_REG_DEFAULTS(29, TEGRA264),
+	ADMAIF_RX_REG_DEFAULTS(30, TEGRA264),
+	ADMAIF_RX_REG_DEFAULTS(31, TEGRA264),
+	ADMAIF_RX_REG_DEFAULTS(32, TEGRA264),
+	ADMAIF_TX_REG_DEFAULTS(1, TEGRA264),
+	ADMAIF_TX_REG_DEFAULTS(2, TEGRA264),
+	ADMAIF_TX_REG_DEFAULTS(3, TEGRA264),
+	ADMAIF_TX_REG_DEFAULTS(4, TEGRA264),
+	ADMAIF_TX_REG_DEFAULTS(5, TEGRA264),
+	ADMAIF_TX_REG_DEFAULTS(6, TEGRA264),
+	ADMAIF_TX_REG_DEFAULTS(7, TEGRA264),
+	ADMAIF_TX_REG_DEFAULTS(8, TEGRA264),
+	ADMAIF_TX_REG_DEFAULTS(9, TEGRA264),
+	ADMAIF_TX_REG_DEFAULTS(10, TEGRA264),
+	ADMAIF_TX_REG_DEFAULTS(11, TEGRA264),
+	ADMAIF_TX_REG_DEFAULTS(12, TEGRA264),
+	ADMAIF_TX_REG_DEFAULTS(13, TEGRA264),
+	ADMAIF_TX_REG_DEFAULTS(14, TEGRA264),
+	ADMAIF_TX_REG_DEFAULTS(15, TEGRA264),
+	ADMAIF_TX_REG_DEFAULTS(16, TEGRA264),
+	ADMAIF_TX_REG_DEFAULTS(17, TEGRA264),
+	ADMAIF_TX_REG_DEFAULTS(18, TEGRA264),
+	ADMAIF_TX_REG_DEFAULTS(19, TEGRA264),
+	ADMAIF_TX_REG_DEFAULTS(20, TEGRA264),
+	ADMAIF_TX_REG_DEFAULTS(21, TEGRA264),
+	ADMAIF_TX_REG_DEFAULTS(22, TEGRA264),
+	ADMAIF_TX_REG_DEFAULTS(23, TEGRA264),
+	ADMAIF_TX_REG_DEFAULTS(24, TEGRA264),
+	ADMAIF_TX_REG_DEFAULTS(25, TEGRA264),
+	ADMAIF_TX_REG_DEFAULTS(26, TEGRA264),
+	ADMAIF_TX_REG_DEFAULTS(27, TEGRA264),
+	ADMAIF_TX_REG_DEFAULTS(28, TEGRA264),
+	ADMAIF_TX_REG_DEFAULTS(29, TEGRA264),
+	ADMAIF_TX_REG_DEFAULTS(30, TEGRA264),
+	ADMAIF_TX_REG_DEFAULTS(31, TEGRA264),
+	ADMAIF_TX_REG_DEFAULTS(32, TEGRA264),
+	{(TEGRA_ADMAIF_GLOBAL_CG_0 + TEGRA264_ADMAIF_GLOBAL_BASE), 0x00000003}
 };
 
 static bool tegra_admaif_wr_reg(struct device *dev, unsigned int reg)
-- 
2.43.0

