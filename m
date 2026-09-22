Received: from CO1PR03CU002.outbound.protection.outlook.com (mail-westus2azon11010063.outbound.protection.outlook.com [52.101.46.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 857A93E6399;
	Tue, 22 Sep 2026 18:21:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.46.63
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790101318; cv=fail; b=a1otTWIYj2Rjw9I76Qua6SgA+kd0epdLjRMnqU/Fi4GrV5HlTqWk4+LaRUBD2GJv6gLrbP29s1Jyh0wa/iKwnI8Kgv4Aqyzo0HdcrU+t4l3nZ/0hX7GArXwQUqBmEmniCsnYP0j+2b+ScZyfCFxl/F/5mc+/TFu02HlBPZO3soY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790101318; c=relaxed/simple;
	bh=gIzUW0Ii8oj9cUJFvJSstkx6pBaBvo+oS+z9mKnsEPo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ELkD2PA16SCe4AYe1IZjHK7k1I8VSXgMsxycKlY3i0z3Vx1EbIfUQUY6OuDvAOjJvL0hv3jCb57T4gnQ+YOIpjhRjR+ahDGREdpaGC+0aXjohvpMHvbgPmkFEdHTi9Tw2xe69LOnlRw3XfaXXQWZ/janukaYOh8vm6KyGHhLMHs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=dVX0eIqq; arc=fail smtp.client-ip=52.101.46.63
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="dVX0eIqq"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uAWLK0iN4A2aiNVItSZqB041cgCStr0isoxKrU3UB3T218mMo08bCY0MkQAOy6w7FOIH8/iuWvxucET/pOQR3C8QoC/4XRThFlP49ZZtDQpuQgYswprGpePCSzG1S6pCvaht9aBzL69yrlhJDECO+ea+HryQcg/OZX7zHdOYP3UZ1CiTjtH9Yp2FXbm7SZA91R6jJ0d+Bw+NSZz24HzexIxBcRYcWgjB+Jm5xpHbVW40x3kv95H17A2t8e3QEcDA0PVxsDrlJuY9m0+9H65lYfNJwyRz888Ly+hEEe5nz7hJL1lWMDN6opRs8em2BhzFOyrmKupmGEEuDGLdtuITjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5Y+2bKC+1zppb1lKc08MiOvCJKQVmQw34cnoLKfiBTQ=;
 b=pNINfwFg4XCSdB8AzOSfk05xlyKcumCtgFnyaF6BjTQgB7FrLN64OeELquuRW+TUB9F/FtcoPtEp8MpLaeDt98bmGgCh73AKohrvPxY5c7hiwBWouumDzmjqBAoF6ci6EjrUheg3ccBV/+5FcnMmoewxbpBHO4rXfVf0sovoSwfhHkBkTn6vXMTLOELZYAJRryxc38yoHI3dIy/N2TRPA4mWs4rL8uc96DaoJnd7JlCSsWsF08khQTvGngDVSY1I5DcukpDQ0l6IKoFyNreF5dgeo5+2+mgFK4ocwOaBXrCe4JxnFu7LMJtTnOPPzuMC3+k97Qg34TjU3TwDslPKoA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=synopsys.com smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5Y+2bKC+1zppb1lKc08MiOvCJKQVmQw34cnoLKfiBTQ=;
 b=dVX0eIqqHsr3iYPM/x+aehmqWYF9cM3B5YG4jM19IMWi1KEaRxxOz49n5oElt3sKMzT4OqPbgaQcryYz9q0AE9VzgfreMy2eLFItNSwt6+dxxeYJ0v7G/sS970khtw/VD1GKTP61lqreeikGW034uOFoCVpXO9hc4cujwGflwA4=
Received: from PH7P220CA0082.NAMP220.PROD.OUTLOOK.COM (2603:10b6:510:32c::17)
 by MW3PR12MB4492.namprd12.prod.outlook.com (2603:10b6:303:57::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.14; Tue, 22 Sep
 2026 18:21:50 +0000
Received: from BY1PEPF000264B3.namprd02.prod.outlook.com
 (2603:10b6:510:32c:cafe::a8) by PH7P220CA0082.outlook.office365.com
 (2603:10b6:510:32c::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.451.14 via Frontend Transport; Tue,
 22 Sep 2026 18:21:49 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BY1PEPF000264B3.mail.protection.outlook.com (10.167.242.120) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.451.8 via Frontend Transport; Tue, 22 Sep 2026 18:21:49 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Tue, 22 Sep
 2026 13:21:48 -0500
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Tue, 22 Sep
 2026 13:21:48 -0500
Received: from xhdradheys41.xilinx.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.49 via Frontend
 Transport; Tue, 22 Sep 2026 13:21:46 -0500
From: Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>
To: <Thinh.Nguyen@synopsys.com>, <gregkh@linuxfoundation.org>,
	<michal.simek@amd.com>, <p.zabel@pengutronix.de>
CC: <linux-usb@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>, Radhey Shyam Pandey
	<radhey.shyam.pandey@amd.com>, <stable@vger.kernel.org>
Subject: [PATCH v2 1/3] usb: dwc3: xilinx: fix system suspend and resume PHY handling
Date: Tue, 22 Sep 2026 23:51:23 +0530
Message-ID: <20260922182125.11067-2-radhey.shyam.pandey@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260922182125.11067-1-radhey.shyam.pandey@amd.com>
References: <20260922182125.11067-1-radhey.shyam.pandey@amd.com>
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
X-MS-TrafficTypeDiagnostic: BY1PEPF000264B3:EE_|MW3PR12MB4492:EE_
X-MS-Office365-Filtering-Correlation-Id: 4928345a-4a59-4bd8-8dcb-08df18d65e5d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700016|82310400026|376014|23010399003|6133799003|18002099003|22082099003|11063799006|10067099003|56012099006;
X-Microsoft-Antispam-Message-Info:
	BuXuaWgNwywpjNtl0qAFcAkmK3DXqYuP4WBSPQ7bcbkYYPXQShLIu5zLNaDXok3PTTX5wHy1E7y/6l08aOQH9G9RBdtW6et9AhDY2ETPIIxHBQ3bnUbI693ZzqpRs9M6npnYSpiPp78owsXw9xE8jXx5/IOzt8YaarE62yNqLAKj6VUW4cOh4xgQl5OVUe/folwLCPxOsOCWmVOzZO8wMS7zJfPFfnsyWl7BYQBTEXPQxlv+tckJXVadu7TTuFotkFOXTSKINomdHkqcpeVx4Y0178KtJ1Xk8Hxpf1yGE6F+3CJ9fjoVOb69lZeiBLDULXLkua10+AlTepUkqIYEYjuqljwdqMcor3GZ8wtJmwZcfqzrpgcAAF+0NXszgV2O8D4tGlVd5w0D61t45fUX95mx/L2+NOTIuwm6FbJOvAKkg+cZiiaUTTcSRfaVRMng2rMlxfQHVk2rT8XR/DVZMbaP7FrwU6+hClIMFe1wfdEF8PR1poKaLQlMv71XKSCedqBymPFqMu5EzLpKiAbufOMB2MV7Q2s5ZinWx80rp5Fud989iIfuVZlk4IwOjeWVgvvBK0PbChIDTQBVboQE3wJWtnkCuto0jqdoJTBRfBuHXO7pxcfjsICWp3bvsvpyExatYsguErpzJ7AIYkL+x1R2AZrOZomagGJNCmv5i0tBnaZnSPDaTfzC0l9CN+v6exoFZpe5Quj7Y7l2dmqd2Q==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(36860700016)(82310400026)(376014)(23010399003)(6133799003)(18002099003)(22082099003)(11063799006)(10067099003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	lOkRwLpSEqKRO0MBND2JNHCx9UXmGxL9qAXKYqbRupBic7NU0jfO9x2/AByertQ+8pQwZ6w0uaP43+lLnjlmuGRYC9mbkT+QPEDkCLqKR5U5iM1zlKGrjiapA3ETHEMlkXFbR0/Mn/sThhJVsjN/SAhy0JcBzHMxX7zjDR8oZl3O9MzDBGnUUzNjfSnjl0Ks+noi7JA/XxpsxTzHUV6S7t4WMu8lfQZPUNAsns3JRJIgJJ4y/om3fB+ZLTlpEcvT6TQD/9uBuWlqBbCTMcOYOBvs4TbgriNwbabyHHSpqPZhDAPUrBxM2OZIooldAfFeDQKr1a0umkjPWTqVFHypaC3bv6Q3JSgUsRwBNyZgUCbgbv6Cau/NdSbC4VINh/hFOhRH0V0UlLPkGrcuWYl1KfTlRpfI4O/8g8IzdhferBQaAVecJ+TRO2jNbYiWANFe
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Sep 2026 18:21:49.3424
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4928345a-4a59-4bd8-8dcb-08df18d65e5d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BY1PEPF000264B3.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4492

System suspend and resume error paths do not handle PHY and clock
resources correctly. Suspend calls phy_exit() without first powering
off the PHY and ignores failures, while resume can leave clocks
enabled if PHY reinitialization fails.

Propagate errors to the PM core and unwind resources to ensure a
consistent state on suspend and resume failures.

Fixes: d6edcdc1ef06 ("usb: dwc3: xilinx: fix usb3 non-wakeup source resume failure")
Cc: stable@vger.kernel.org
Assisted-by: Claude:claude-opus-5
Signed-off-by: Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>
---
Changes in v2:
- Split out of the combined five patch series so the fixes can be sent
  and backported on their own, per review feedback.
- Reordered ahead of the platform-data cleanups.
- Log a failure of the phy_power_on() rollback.  phy_exit() leaves
  init_count untouched when it fails, so if the rollback also fails the
  PHY is left with power_count and init_count out of step; that is now
  at least visible in the log.
- Added Cc: stable.

 drivers/usb/dwc3/dwc3-xilinx.c | 24 +++++++++++++++++++++---
 1 file changed, 21 insertions(+), 3 deletions(-)

diff --git a/drivers/usb/dwc3/dwc3-xilinx.c b/drivers/usb/dwc3/dwc3-xilinx.c
index b832505e1b04..8c63e02575f1 100644
--- a/drivers/usb/dwc3/dwc3-xilinx.c
+++ b/drivers/usb/dwc3/dwc3-xilinx.c
@@ -383,13 +383,26 @@ static int __maybe_unused dwc3_xlnx_runtime_idle(struct device *dev)
 static int __maybe_unused dwc3_xlnx_suspend(struct device *dev)
 {
 	struct dwc3_xlnx *priv_data = dev_get_drvdata(dev);
+	int ret;
 
-	phy_exit(priv_data->usb3_phy);
+	ret = phy_power_off(priv_data->usb3_phy);
+	if (ret < 0)
+		return ret;
+
+	ret = phy_exit(priv_data->usb3_phy);
+	if (ret < 0)
+		goto err_phy_power_on;
 
 	/* Disable the clocks */
 	clk_bulk_disable(priv_data->num_clocks, priv_data->clks);
 
 	return 0;
+
+err_phy_power_on:
+	if (phy_power_on(priv_data->usb3_phy))
+		dev_err(dev, "failed to restore PHY power after suspend error\n");
+
+	return ret;
 }
 
 static int __maybe_unused dwc3_xlnx_resume(struct device *dev)
@@ -403,15 +416,20 @@ static int __maybe_unused dwc3_xlnx_resume(struct device *dev)
 
 	ret = phy_init(priv_data->usb3_phy);
 	if (ret < 0)
-		return ret;
+		goto err_clk_disable;
 
 	ret = phy_power_on(priv_data->usb3_phy);
 	if (ret < 0) {
 		phy_exit(priv_data->usb3_phy);
-		return ret;
+		goto err_clk_disable;
 	}
 
 	return 0;
+
+err_clk_disable:
+	clk_bulk_disable(priv_data->num_clocks, priv_data->clks);
+
+	return ret;
 }
 
 static const struct dev_pm_ops dwc3_xlnx_dev_pm_ops = {
-- 
2.43.0

