Received: from CH4PR04CU002.outbound.protection.outlook.com (mail-northcentralusazon11013002.outbound.protection.outlook.com [40.107.201.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF8023B585D;
	Sat, 27 Jun 2026 15:52:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.201.2
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782575573; cv=fail; b=axZGwRYrC9hFtRDw4pftfC5PQaH3Sxr00oZi0klYouKX+QyDYauFbBFMhbZ622E5RLBLNDzMpzP2avJY0lsoiGBPFvrodVAjQrGV8xEZAZp4pGqhBBDcCaxCbEg5mmWSltINIoo0FWMZjpn70ECTxjNhgLG+YjrXz1lyq10RsMo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782575573; c=relaxed/simple;
	bh=9dgQM6ZgC6Uec0G84er+9k9XTjxoJE3DTON5KCAIc4g=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=W8zv3u+gfu+Nz7gkRWRfPXV38PEbbbcLaNGc1CFudBT1mHZd2u7lamPz2JMggrMy7ne3Dkzm3szJzEeXbKfX5mmatu6+wJspYxTt21bzJcrbcwViL1CELkDC1or9QAa1jIOZmmReHpjfBGtYpQF6/vD28Zj8mAWlrl0pTg4HSb8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=HHvnzNUn; arc=fail smtp.client-ip=40.107.201.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="HHvnzNUn"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZJV4ckM++I8zMNoNg2tiEUSSw8WPOh5X2fTec27Q3FRG5cDQroiOBVDa+VY1aXth6cU+NRFWxC9e2joRZngi0D+DaAF41HQKYNVowiBZ6NC5NllMteXcBUrInkd1k3tymFB3bFgp6wmm4rxvdDqigQgwxxSlhGgSO9Az/l2sRI3gbIdZDBdnwxNnNhn3yutG9B+KGaRYYitTezmR1IF+Zw54SFHENSeVHCxmsUucZlt0lft95OMkmog4wmqzOsHS2XCvGSsThmgwZNjZ906iWl81LJxEC+SF9QsjscHnUUXI2U+CQmbaeqmlHWgEA4ZjjdlzH5pstsf6TeaVAommOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BRn7+hN114BPqmx732KOHLTU2mhk8kHo0GrZnhlgCt0=;
 b=aKgfN4lpjwQTi3Sz6NYTmbvD5DsopVTAbwBZUclVNu27veDCAIVQD6I4zlyC/zGqN/9ikQmYcH0nnuGd6TpZy92QKJA5SI1Qs6yylTF18euTy50EtG20EbuSs8hbdU+//pIU61my+tn+FcTqXgn58GiDkzVIwY0rHBGIHDCxf2yx4xrXvgP6YCdK3WKRvM+ua3x5xo0JTEp4wyS28Y1lFAOe/L9W6MfsCjRPrsyDV/YLjN8/2QX1QHXeqEipzoszdgfA8IQH3k6jt9RQe0p0fIqwzM9mAxjD+InoYo7isZYqg7YngxB8/7bQ7KxbC7J78c3MqoTHF2QJbmXR7LMNNw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=ideasonboard.com smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BRn7+hN114BPqmx732KOHLTU2mhk8kHo0GrZnhlgCt0=;
 b=HHvnzNUn9qLSV0HCEefSzrtI1xKFZJsIDNKGYsbvDz7Ahg6n6wV1j0ZToIR10pc0ElpZh8UkruQ9lOlOpIMFLcfVuCTr9OCcIm+b9uJ9za0NGwqC+LqmhkTWgRLOzIwRJ/FyhdWOtOjX1R64bj+RlmupSuxFb6URaMSlU0OlK3Y=
Received: from CY3P220CA0003.NAMP220.PROD.OUTLOOK.COM (2603:10b6:930:fb::16)
 by DM6PR12MB4170.namprd12.prod.outlook.com (2603:10b6:5:219::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.18; Sat, 27 Jun
 2026 15:52:46 +0000
Received: from CY4PEPF0000EE36.namprd05.prod.outlook.com
 (2603:10b6:930:fb:cafe::42) by CY3P220CA0003.outlook.office365.com
 (2603:10b6:930:fb::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.159.18 via Frontend Transport; Sat,
 27 Jun 2026 15:52:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 CY4PEPF0000EE36.mail.protection.outlook.com (10.167.242.42) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.181.6 via Frontend Transport; Sat, 27 Jun 2026 15:52:46 +0000
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Sat, 27 Jun
 2026 10:52:45 -0500
Received: from xhdradheys41.xilinx.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.41 via Frontend
 Transport; Sat, 27 Jun 2026 10:52:43 -0500
From: Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>
To: <tomi.valkeinen@ideasonboard.com>, <vkoul@kernel.org>,
	<michal.simek@amd.com>
CC: <linux-kernel@vger.kernel.org>, <linux-phy@lists.infradead.org>,
	<linux-arm-kernel@lists.infradead.org>, Nava kishore Manne
	<nava.kishore.manne@amd.com>, <stable@vger.kernel.org>, Radhey Shyam Pandey
	<radhey.shyam.pandey@amd.com>
Subject: [RESEND PATCH 2/3] phy: zynqmp: use read-modify-write for SERDES scrambler bypass
Date: Sat, 27 Jun 2026 21:22:28 +0530
Message-ID: <20260627155229.2791113-3-radhey.shyam.pandey@amd.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE36:EE_|DM6PR12MB4170:EE_
X-MS-Office365-Filtering-Correlation-Id: 77b4f71a-6a23-4b8f-f866-08ded46421c6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700016|376014|23010399003|1800799024|22082099003|18002099003|11063799006|3023799007|6133799003|56012099006;
X-Microsoft-Antispam-Message-Info:
	qGTZAjktLahN6vjOP/xQlr8MukWZf80cy9YAuR5j3pkW9BmhTGm2zN4NgEX1YyNR08C+mhXFJhPoghU7wcA7DPyUR4Rwl1nM5x6W0WL0XN+CACpnXohu0cwHP9EIotBXUof+h1C6ktr+weh1wGxlagoDgSIb0T4kaeadWbHPU7A01QA9O9wYncVbZKIymme6el8tgooreL8lVVomdSMbj3oGRSW7hQMWFzuXORg72Az9b+VpnPx91qT5BbDFjbrEnH51tRZyixAEly+XxGi2PDhMx56/nmT2jhXdNsxwUUqV0z7gNgq4vgSXY+SytEAJVYggvRa2zehGjm05dpbp7ADIwiAkHHteDqxdgExi1nGLAtmQczbqua475J8Jy4BtKvlPrm5IECryv2tz5h0FEEr/3OyVrjIoVHVkBQe0woLx778SrvhXmPlCmRCgzWwdSOSPUgUmsJtDEirSxJN7rFMY/zQhw5AALOjPitKqPcwX9ZvU6KjqWNCUwl+ySzax/oWbNhUHAmoVXso0FdvtWrlQt0lElqnzXmKOBTQDt3vZ0KHQMkehy3ZR+CvdeXLEZvasrfUXnJqZGQ/GBWSz4Ifz+mqNflVl25w9snF8ORn4W98drByVydrQchh2T9KEB1LNCIkWiCMPAN2TY8E8cC26v+cgFQIpLu70mh3pyHRe3mxkdHeLG9qK0xq9CBBI3OcnGaOY8fZ+f0hIGV8lUg==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb08.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(36860700016)(376014)(23010399003)(1800799024)(22082099003)(18002099003)(11063799006)(3023799007)(6133799003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	hd0ngbf9BJWReiod3u4rP1bdjHVI6+udQT08e6/0FQub/jQ5E2JvEH5aKg8AWHadUjFdVfB/hdvKaC9OnZs56SvpEsBpkd21r/S9n8gqADjFqF4MoNBMC1iP0MrCPzMJ7qu/5AIaez6Zs1JzYK9AQaBJGs5s0VwKBGj6rn0Aq1zelGeWcxHMczipN+6D5keoXKPjUFOauXLGMLWTwzG+Y6jWAgtG4lt7wlpz4hsrwpFbcziA4QTyPsjpOrCO4Nn5oSM8kC1Qh4KTULckmsq4oV8VWe/n2MGUmZ8X/OXl7aRUMbJo2w+N9anqUjBCEuJ4qYNMmKhgj0j/B5puMzqoRIiruD6Sac/t7A+03AHgsnSZH+lzIrZnSkQPqCO144DCtFwEigm6Qg//dEJ4iZv5F3pZsJSrsif8YBhA3P3paG5XINJ4UCB5ykCuIFDpc6Gh
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jun 2026 15:52:46.0798
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 77b4f71a-6a23-4b8f-f866-08ded46421c6
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000EE36.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4170

From: Nava kishore Manne <nava.kishore.manne@amd.com>

xpsgtr_bypass_scrambler_8b10b() used xpsgtr_write_phy() which performs
a full register write, silently clearing any bits beyond the intended
bypass control fields.

Switch to xpsgtr_clr_set_phy() with clr=mask, set=mask to set only
the bypass bits while preserving the remaining bits in each register.

Fixes: 4a33bea00314 ("phy: zynqmp: Add PHY driver for the Xilinx ZynqMP Gigabit Transceiver")
Cc: stable@vger.kernel.org
Signed-off-by: Nava kishore Manne <nava.kishore.manne@amd.com>
Signed-off-by: Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>
---
 drivers/phy/xilinx/phy-zynqmp.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/phy/xilinx/phy-zynqmp.c b/drivers/phy/xilinx/phy-zynqmp.c
index c037d7c13d48..6c56c4df8523 100644
--- a/drivers/phy/xilinx/phy-zynqmp.c
+++ b/drivers/phy/xilinx/phy-zynqmp.c
@@ -505,8 +505,12 @@ static void xpsgtr_lane_set_protocol(struct xpsgtr_phy *gtr_phy)
 /* Bypass (de)scrambler and 8b/10b decoder and encoder. */
 static void xpsgtr_bypass_scrambler_8b10b(struct xpsgtr_phy *gtr_phy)
 {
-	xpsgtr_write_phy(gtr_phy, L0_TM_DIG_6, L0_TM_DIS_DESCRAMBLE_DECODER);
-	xpsgtr_write_phy(gtr_phy, L0_TX_DIG_61, L0_TM_DISABLE_SCRAMBLE_ENCODER);
+	xpsgtr_clr_set_phy(gtr_phy, L0_TM_DIG_6,
+			   L0_TM_DIS_DESCRAMBLE_DECODER,
+			   L0_TM_DIS_DESCRAMBLE_DECODER);
+	xpsgtr_clr_set_phy(gtr_phy, L0_TX_DIG_61,
+			   L0_TM_DISABLE_SCRAMBLE_ENCODER,
+			   L0_TM_DISABLE_SCRAMBLE_ENCODER);
 }
 
 /* DP-specific initialization. */
-- 
2.43.0

