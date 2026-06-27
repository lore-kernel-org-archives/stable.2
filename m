Received: from CH5PR02CU005.outbound.protection.outlook.com (mail-northcentralusazon11012015.outbound.protection.outlook.com [40.107.200.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D12193BBFA5;
	Sat, 27 Jun 2026 15:52:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.200.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782575574; cv=fail; b=uvCB82bxLpN+mIjly9UOruY23ksAwau9ATp656eKPPmUSlgX64XwqlEbLbhC1OCrX/ziV3YRhpV9Ny+65D1kvQFmfkPSsI5uLsKqUGA9WRtnrySSD5UMLTDQYRzwU+JxRL0LE3vhG3ANBQ9Q4JeqaTU3FLQI6ffBrn0fZ51/x0w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782575574; c=relaxed/simple;
	bh=27e8XAIUybbvj1QVzFXY5WpCZfMEvrwULVlqdS50KkE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ja5C589kPdbQZBKruGw1SfWHHTvUAEE/2KWD22mXLfJyjC9rQ1g21wb2fNpX2arPJ3rCsZQLg6z3U7vqMgFrzgX10C0YNovG4FbSLt3oUTZu00peMCsSGeEVrDKNpPDgfGUmntR1Gk304zaVF6nDmZoQG9RcH3+yMIzJ27NxANY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=4tm63vy/; arc=fail smtp.client-ip=40.107.200.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="4tm63vy/"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NXQ7s5nRROfS2YkZBPWw1yn5wrb5EPg8rllOEKeI4kpVtrS7LbfBT5qdC6V9HNnHknPia0jQFyr1f96rAyMTFzRAswgEjwcs7+QRIXauyGKarhNe5LapSsUuRtbTSA3VyuNl9VO1SOU9wNGnc1AQZABrQ4ttiwsArAiQ7PtAtp4reus7M7MnNa7pknpFH3IC+8RXKnenKAdbCRj+kDa8ysag+kcGW0/Ah9PrXrYPKxnrwAatV/HHjEIKTLfyDu9KSgmTe2y55f+yEo1zX85BoKm+EPaHjOcv9Td1B/6PRx6pDwlOzuEwiy0XDTLRiXKzLowRKTXkzs2HluAP+Oi2Ow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LDEHckzY6cmu/LyEFbjKi1V0R0pBN0KTZIlkY6+Igv8=;
 b=JmC8v4DiJSl4LTUSoYbgXbv+dFUdK2gZAnsJzKz+vlCmah9Yyix5OTgoY9nMCVJ30iQIpkP8avG853RcBg9ISTRf7tueNHNjM0UqRCiABfCZvkISMrk0MJh8mVyyTtC593E+vC4VBRLKOMsbCZK8a65yb3W6Bd+K9JCCMMu+YxEJWJW2wWQMgfTpfzrIiLxpejGCNCuIJMkjJZV6pw1cWE1T+9imUr6VVwkX3mDplpzmaxv/gypx1ZQt7nQt/sMNT9Py77FnFpszOGjyf4OQ+YGSlRic9rUGeMEBPDWfNzejhM+LgAcZgPEzIeYl9LaVGaMhfiB/NvtW9mZYQ5a7gg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=ideasonboard.com smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LDEHckzY6cmu/LyEFbjKi1V0R0pBN0KTZIlkY6+Igv8=;
 b=4tm63vy/+FwvV/JXlHwcnswg7yHmrLaOV5pBoSN4XGk5ywZxJFrcg08W8KqLvwP7rUNrHxheM7JbrJwbU8BWKxyGQUG9ePf8++IY21yscO7y2fBQzedg/Jg0ynp8Wc5a/L0mOsVlbqyUsZcd6X7vkBIl2OdZvc+suLSrWfwEp+8=
Received: from CYXPR02CA0018.namprd02.prod.outlook.com (2603:10b6:930:cf::11)
 by LV9PR12MB9830.namprd12.prod.outlook.com (2603:10b6:408:2ec::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.17; Sat, 27 Jun
 2026 15:52:49 +0000
Received: from CY4PEPF0000EE37.namprd05.prod.outlook.com
 (2603:10b6:930:cf:cafe::a4) by CYXPR02CA0018.outlook.office365.com
 (2603:10b6:930:cf::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.159.18 via Frontend Transport; Sat,
 27 Jun 2026 15:52:49 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 CY4PEPF0000EE37.mail.protection.outlook.com (10.167.242.43) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.181.6 via Frontend Transport; Sat, 27 Jun 2026 15:52:49 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Sat, 27 Jun
 2026 10:52:48 -0500
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Sat, 27 Jun
 2026 08:52:48 -0700
Received: from xhdradheys41.xilinx.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.41 via Frontend
 Transport; Sat, 27 Jun 2026 10:52:45 -0500
From: Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>
To: <tomi.valkeinen@ideasonboard.com>, <vkoul@kernel.org>,
	<michal.simek@amd.com>
CC: <linux-kernel@vger.kernel.org>, <linux-phy@lists.infradead.org>,
	<linux-arm-kernel@lists.infradead.org>, Nava kishore Manne
	<nava.kishore.manne@amd.com>, <stable@vger.kernel.org>, Radhey Shyam Pandey
	<radhey.shyam.pandey@amd.com>
Subject: [RESEND PATCH 3/3] phy: zynqmp: keep SERDES scrambler and 8b/10b enabled for USB
Date: Sat, 27 Jun 2026 21:22:29 +0530
Message-ID: <20260627155229.2791113-4-radhey.shyam.pandey@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260627155229.2791113-1-radhey.shyam.pandey@amd.com>
References: <20260627155229.2791113-1-radhey.shyam.pandey@amd.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE37:EE_|LV9PR12MB9830:EE_
X-MS-Office365-Filtering-Correlation-Id: 7eafc5e0-31b8-475e-5686-08ded4642384
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|36860700016|23010399003|82310400026|1800799024|6133799003|3023799007|56012099006|11063799006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	0hE525zsangTBzumVutf6fywNIoCmAE5PFefMxlMgr6ajvVxGCITdOWgg25gxPU10u3c3jplF7PRC/ZMQYUJKwef7xcv6imw4ihmkxNgPFGLNSUedlB1rlrDliVcTV5joam0zESxzgFksr/3utGIN4C2ekesrwjuhKThZ/N/RksYthxDPr3PdgT5Er+/jmtEl6rQmotURYyBDPqmROTcUuPb2/iRTNcLjCVePGRXBXI4l89mtHMj+3nsaCN6tExzbcPNu0FNFd/GS+bHyaMgqkBlc3jbzWAzDJciR2hYP0i6wRm34cyFaOhoDZi0ciqqSK8jmhxbuTYJYATTuE/ztOSUbd6JvPQdutsxWeNCWozUT8dW1wyqPQiwt5Mu28Hz33fTAsYYO4+sJUx4ERnYLOLjU3VdC5xPtKzQvyjlcoUDdmh8jBnMUV3+KrlIPhCxEwMFgpVUL7RhkOwJ99x/kIhEcT2SU5UlN6ef5thvKcEgxKOXEw1V6Oo5TvJNwq810ycnB0aE0KbE9k0kfVO3BewVMgS9zAbCvU2oBQsoUXEN6LU3U8VNtAu9xJQx7R05KIhyuuMH1V6rq0dop5XptjvTkdaIgpeNX0XB+moD3znOflAJbxK/EsEbp2OFjeGtJNDvUzMUgj7lsDfk1Mb5SAHCzxuotJk/ZgkoSJIYYRJVuEd50FKAKezPYxpQoScU4pHxKHpxiYXwNIgcMXanUQ==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb08.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(36860700016)(23010399003)(82310400026)(1800799024)(6133799003)(3023799007)(56012099006)(11063799006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	n16uJ4T3VCx4oHgToNKpeI1TUHzKliEwkK4RNYubcWvyrP9KMG+oEEtMCFt9kXg4EuGfCtrutbBKsW19Q9VdkNRf2O78yhGUw1x7KrMkPZ+dlxkeQwCyun0pBtJCX89fkPPwf8vYQsIfEKOvGP19yck5hPsb6QTitrxhrnMMSIhuti0Hs20HOG6hSOBlrIniukT6e26iZkjmjDPhC3jwPU8PqcxbLEtA+UIuul0YTU+1WQln1s0+yci1rcazWoxuju1JcSvW9UnrN8p/dN7zqWxlfT/W3kvk0YTyl4VRoZDAOBNBFjLVCyhhVX2NKUZuUH6AVMl36kmMFD4EdjsG1FeOonvZEYGDwxYuVFoaHEtHHpaUuO2/Y9K+B5QiESHaYNzddBBayBPjCSJGnUizM9adUKsvBdoZmXJ7FO/xEaRL6dMUQrFeyRNE5LhVCWOD
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jun 2026 15:52:49.0007
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7eafc5e0-31b8-475e-5686-08ded4642384
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000EE37.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV9PR12MB9830

From: Nava kishore Manne <nava.kishore.manne@amd.com>

USB Gen1 requires scrambling and 8b/10b encoding to be performed in the
physical layer. Do not bypass PHY-side scrambler or encoder/decoder for
USB operation, as mandated by the USB 3.x specification.

Scrambler and 8b/10b bypass remain restricted to SATA and SGMII
modes, where encoding is handled in the controller.

Fixes: 4a33bea00314 ("phy: zynqmp: Add PHY driver for the Xilinx ZynqMP Gigabit Transceiver")
Cc: stable@vger.kernel.org
Signed-off-by: Nava kishore Manne <nava.kishore.manne@amd.com>
Signed-off-by: Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>
---
 drivers/phy/xilinx/phy-zynqmp.c | 39 ++++++++++++++++++++++++---------
 1 file changed, 29 insertions(+), 10 deletions(-)

diff --git a/drivers/phy/xilinx/phy-zynqmp.c b/drivers/phy/xilinx/phy-zynqmp.c
index 6c56c4df8523..087fe402e4e2 100644
--- a/drivers/phy/xilinx/phy-zynqmp.c
+++ b/drivers/phy/xilinx/phy-zynqmp.c
@@ -502,15 +502,30 @@ static void xpsgtr_lane_set_protocol(struct xpsgtr_phy *gtr_phy)
 	}
 }
 
-/* Bypass (de)scrambler and 8b/10b decoder and encoder. */
-static void xpsgtr_bypass_scrambler_8b10b(struct xpsgtr_phy *gtr_phy)
+/**
+ * xpsgtr_bypass_scrambler_8b10b - Configure scrambler/encoder behavior
+ * @gtr_phy: pointer to lane context
+ * @bypass: true to enable scrambler/encoder bypass (SATA/SGMII),
+ *          false to disable scrambler/encoder bypass (USB3)
+ *
+ * Uses RMW to preserve reserved and unrelated register fields.
+ */
+static void xpsgtr_bypass_scrambler_8b10b(struct xpsgtr_phy *gtr_phy,
+					  bool bypass)
 {
-	xpsgtr_clr_set_phy(gtr_phy, L0_TM_DIG_6,
-			   L0_TM_DIS_DESCRAMBLE_DECODER,
-			   L0_TM_DIS_DESCRAMBLE_DECODER);
-	xpsgtr_clr_set_phy(gtr_phy, L0_TX_DIG_61,
-			   L0_TM_DISABLE_SCRAMBLE_ENCODER,
-			   L0_TM_DISABLE_SCRAMBLE_ENCODER);
+	if (bypass) {
+		xpsgtr_clr_set_phy(gtr_phy, L0_TM_DIG_6,
+				   L0_TM_DIS_DESCRAMBLE_DECODER,
+				   L0_TM_DIS_DESCRAMBLE_DECODER);
+		xpsgtr_clr_set_phy(gtr_phy, L0_TX_DIG_61,
+				   L0_TM_DISABLE_SCRAMBLE_ENCODER,
+				   L0_TM_DISABLE_SCRAMBLE_ENCODER);
+	} else {
+		xpsgtr_clr_set_phy(gtr_phy, L0_TM_DIG_6,
+				   L0_TM_DIS_DESCRAMBLE_DECODER, 0);
+		xpsgtr_clr_set_phy(gtr_phy, L0_TX_DIG_61,
+				   L0_TM_DISABLE_SCRAMBLE_ENCODER, 0);
+	}
 }
 
 /* DP-specific initialization. */
@@ -531,7 +546,7 @@ static void xpsgtr_phy_init_sata(struct xpsgtr_phy *gtr_phy)
 {
 	struct xpsgtr_dev *gtr_dev = gtr_phy->dev;
 
-	xpsgtr_bypass_scrambler_8b10b(gtr_phy);
+	xpsgtr_bypass_scrambler_8b10b(gtr_phy, true);
 
 	writel(gtr_phy->lane, gtr_dev->siou + SATA_CONTROL_OFFSET);
 }
@@ -547,7 +562,7 @@ static void xpsgtr_phy_init_sgmii(struct xpsgtr_phy *gtr_phy)
 	xpsgtr_clr_set(gtr_dev, TX_PROT_BUS_WIDTH, mask, val);
 	xpsgtr_clr_set(gtr_dev, RX_PROT_BUS_WIDTH, mask, val);
 
-	xpsgtr_bypass_scrambler_8b10b(gtr_phy);
+	xpsgtr_bypass_scrambler_8b10b(gtr_phy, true);
 }
 
 /* Configure TX de-emphasis and margining for DP. */
@@ -707,6 +722,10 @@ static int xpsgtr_phy_init(struct phy *phy)
 	case ICM_PROTOCOL_SGMII:
 		xpsgtr_phy_init_sgmii(gtr_phy);
 		break;
+
+	case ICM_PROTOCOL_USB:
+		xpsgtr_bypass_scrambler_8b10b(gtr_phy, false);
+		break;
 	}
 
 out:
-- 
2.43.0

