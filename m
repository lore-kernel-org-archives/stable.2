Received: from PH0PR06CU001.outbound.protection.outlook.com (mail-westus3azon11011063.outbound.protection.outlook.com [40.107.208.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BD59352005;
	Sat, 27 Jun 2026 15:52:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.208.63
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782575569; cv=fail; b=IO/ibPIcF5bTJJr9caENg/2irX/mIkER9nReErD4TR1OJEPle7/BwSdKXhuoeBxxKC659nWOaAX2zcZ19Nh8SMXehJPNDZKDZBTqn3eG7wEb7t3fpY21adyExb4s8Qtt0fsSbF10uzMn8MdFAPAfyROSmgkX86zRH7ONCFXnEe8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782575569; c=relaxed/simple;
	bh=bo/AJ85CH+mlXG9H2q942unIcIZwMef8irUXAVAxKZs=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=O0VpwHXc85DzSDJ0xa+El/hqm5fSVwaWFg7Gq2kLAQHDVqfVy7PPiHjqEtIXeLX/gnQcDLBM/HSSr92xRoLI5X0nOrghZMe9Yuli5oadr5LpDLDSTNZc7fqVBEX8nVUeDtYedb9g2Qj2PMXWi+c+JCT1oJnj60G3xjQtlwQj1ws=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=shdQKoaQ; arc=fail smtp.client-ip=40.107.208.63
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="shdQKoaQ"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SbArmXonEajNDZXFi5wC6q2OF51ikgJzk2ackahNsMHzxBn88NInzjOW3i4BP4BkR/t2PPSbz3P9nxw5Ty45nIEWSMx3+routDT0REE4daGV1X9hFarSPxtzV7uj12nhyib9u0iXhK7gcu2E171AE01cq0rD+MrW0Q0Di53vzBOqvemRzYw2a30lt0fI3gQUIbm1T6buRSiykG3whvL4LyV0Uo2p7KLXJj9v37YHEctlGPwcvspKtB5a+BjaxfpuDZnP2Is1rFCqQtpc4nXJ6a5R3aOgys+K20Oi69dBGjBF55Fq2qMex0v3DXkqM/zfHxzch/709CWGhwqGZyFXgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yce8P5tkf7Jq5DR5Wx+GbqHwAEM1DH6lIoYfZPpULYo=;
 b=TOeXFspAeRVYWpqKY7zSquKCmJiao6EUsInsF2eN2zflEm7hCpB0Sl6Y3kqYnUm9ke5UmWM8nAtPZFMC1aibQQ1aG8qnFgzF5hVD8gnTawfX/sLzuNLrofmJ1ZuSd6hhLNb10L/eXk3PiPEC3SuJQTGolK0At92X1dAEcKN4ahlVytZ0KEkpS67W+6GlOhEFuN4c/7Y0PlZ4solxqyOU9pVzT9Zhz+iPptHz6tR1IqDiHT3T8sHlIAb6x2Foan1blpyV7RHX0MbEAXLLEejXtfPe8RW+hVhNB1T+xGpjG8fUXr0qeabpDBFA0Iok+7QW+HSYvXqz1Kxpe7tZQgjSig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=ideasonboard.com smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yce8P5tkf7Jq5DR5Wx+GbqHwAEM1DH6lIoYfZPpULYo=;
 b=shdQKoaQQ1IxCGN+lahWX/GqnK109RYVgkWuOJ2V+foUg/oNzq9MiCXE41HJdFsTT3xmqixE28PkkbpxYzmZuEP+YIVZeHvUsTGN29evkbN96MpweQ0UVsz8hXZjd06eFkx3J9Uvw1QBB6r19mUoWLAQrHDjY93WEwnpF6U/f5k=
Received: from SA9PR13CA0038.namprd13.prod.outlook.com (2603:10b6:806:22::13)
 by SA0PR12MB7089.namprd12.prod.outlook.com (2603:10b6:806:2d5::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.17; Sat, 27 Jun
 2026 15:52:43 +0000
Received: from SA2PEPF00003AE8.namprd02.prod.outlook.com
 (2603:10b6:806:22:cafe::24) by SA9PR13CA0038.outlook.office365.com
 (2603:10b6:806:22::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.159.11 via Frontend Transport; Sat,
 27 Jun 2026 15:52:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SA2PEPF00003AE8.mail.protection.outlook.com (10.167.248.8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.181.6 via Frontend Transport; Sat, 27 Jun 2026 15:52:43 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Sat, 27 Jun
 2026 10:52:42 -0500
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Sat, 27 Jun
 2026 08:52:42 -0700
Received: from xhdradheys41.xilinx.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.41 via Frontend
 Transport; Sat, 27 Jun 2026 10:52:40 -0500
From: Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>
To: <tomi.valkeinen@ideasonboard.com>, <vkoul@kernel.org>,
	<michal.simek@amd.com>
CC: <linux-kernel@vger.kernel.org>, <linux-phy@lists.infradead.org>,
	<linux-arm-kernel@lists.infradead.org>, Nava kishore Manne
	<nava.kishore.manne@amd.com>, <stable@vger.kernel.org>, Radhey Shyam Pandey
	<radhey.shyam.pandey@amd.com>
Subject: [RESEND PATCH 1/3] phy: zynqmp: fix L0_TM_DISABLE_SCRAMBLE_ENCODER mask
Date: Sat, 27 Jun 2026 21:22:27 +0530
Message-ID: <20260627155229.2791113-2-radhey.shyam.pandey@amd.com>
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
X-MS-TrafficTypeDiagnostic: SA2PEPF00003AE8:EE_|SA0PR12MB7089:EE_
X-MS-Office365-Filtering-Correlation-Id: 4e4d28ab-d729-4492-0090-08ded464202a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|23010399003|36860700016|1800799024|82310400026|18002099003|22082099003|10086099003|11063799006|56012099006|3023799007;
X-Microsoft-Antispam-Message-Info:
	mFAJndqSxj9DmWoAP17MQjuS/OOpju37pHXf9KzxWHl0uNkIw2sH+pLodeQTIK7Bi76zlxiGeOzq+wr94azU8xItS2nz+mD5xx/EczE3SyYx+VIjmYBBqtAEA0d1s8wAz3rB6Z1oC6F+PQ1eFl10pYjR7zSW4NK+OfRrV/UbJEGYFF9zfhBkk9wFiw7BTXw1aIuveRcrjf2sk7uH6nvFL/2R9J0reK0fhPekj8ze+73vsK4PDebD1DxHjEDvvbHZ9QCqxuEsxi2MtSIJvUOK9M03lnWv/wRbvkGmHAZbvgR64L0K71h/uT4P/bYVRPsNboz1h/xYYilU7r7V8PPTd/VqFQ0yYTx7gaXTs37zVz766DVKkEulgMjLf1FdOIQNX7noTYnizbaOhzJi53ez/irtpjFT03OciNoaZEwneegghk8FXwy167rZmZPHWGygvnJmvpZUB40zIGe/DTZguH3u+djLMYmnvoNk/vWeOHtEENrDKNDTLJ+lBa5dpldtJXIiq4gbnJ6Eye9LPFqE9cQULmjmm0trmiCWAe2kzCnrhCgMNgj/f6AXqLPuQ/24sAyL7CigynmVhQOpWOuNEDaJImGsZ9M4lSGkhbP0ho6lbsmQLIw7CD6RBKvAJkER+zRJNElwjQBlGDeS5f1vyRiF7hQ7QPImTEsLMLd6g5xRvOWYLmxmY51RS+EnuvrNAR/kogsmsx933DnaTdbHtA==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(23010399003)(36860700016)(1800799024)(82310400026)(18002099003)(22082099003)(10086099003)(11063799006)(56012099006)(3023799007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	V31mtSg/AM/Bs3psmGbunVMQJktWebMidrIAwz1ImLEo+LJZVPh1WB+jB5gJCRdmF1SqvHFz0OMbYFZxq9NB5Hbmpsnospgp6b9WAoagj2aDEfutkA3jIS0k4usTT7u+sdWKpYNv4KgOfL3F/WUQ9DJTGP0v5gnKw/mc4TQflUjE6FF8LPVbs4lGybrrN/C23Ba8dp/LI7BFWFexEM0vW/QfRBTvJO575nRk3BR60KEQAgx0uoRT5XDXBLvLzZ6nPNLloafPtiI5sglKBavc1+DOoN1ejmiKmOmAKJbAvbO68pChL32MvzVBDQu/E/DDm9L45bANLdVXmCrh/UwMsOs9xO6chzgprIO64CDD99A3Y5KhS0vgIc+39pzknU+QGBKsAtMGG5CKPcXW6edbZlgB/ZngE49rRZRICXI9Mczh+y5kCTGITnx0Q6mWP2rQ
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jun 2026 15:52:43.4289
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4e4d28ab-d729-4492-0090-08ded464202a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF00003AE8.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB7089

From: Nava kishore Manne <nava.kishore.manne@amd.com>

The L0_TX_DIG_61 register bit 2 is a reserved read-only field.
The previous mask value 0x0f incorrectly included bit 2, causing
unintended writes to a reserved bit on every scrambler bypass
operation.

Correct the mask to (BIT(3) | GENMASK(1, 0)) to cover only the
valid scramble bypass control bits.

Fixes: 4a33bea00314 ("phy: zynqmp: Add PHY driver for the Xilinx ZynqMP Gigabit Transceiver")
Cc: stable@vger.kernel.org
Signed-off-by: Nava kishore Manne <nava.kishore.manne@amd.com>
Signed-off-by: Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>
---
 drivers/phy/xilinx/phy-zynqmp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/phy/xilinx/phy-zynqmp.c b/drivers/phy/xilinx/phy-zynqmp.c
index fe6b4925d166..c037d7c13d48 100644
--- a/drivers/phy/xilinx/phy-zynqmp.c
+++ b/drivers/phy/xilinx/phy-zynqmp.c
@@ -53,7 +53,7 @@
 #define L0_TM_DIG_6			0x106c
 #define L0_TM_DIS_DESCRAMBLE_DECODER	0x0f
 #define L0_TX_DIG_61			0x00f4
-#define L0_TM_DISABLE_SCRAMBLE_ENCODER	0x0f
+#define L0_TM_DISABLE_SCRAMBLE_ENCODER	(BIT(3) | GENMASK(1, 0))
 
 /* PLL Test Mode register parameters */
 #define L0_TM_PLL_DIG_37		0x2094
-- 
2.43.0

