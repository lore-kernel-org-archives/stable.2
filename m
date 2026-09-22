Received: from PH7PR06CU001.outbound.protection.outlook.com (mail-westus3azon11010030.outbound.protection.outlook.com [52.101.201.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 943E348E0DE;
	Tue, 22 Sep 2026 18:22:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.201.30
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790101322; cv=fail; b=tUfSdYVUH+POi+ZKhbl4yzRuldSSMFKEDwD4n3+Iu7FVq9ypaM36KANInQPDM5vXl3JYeRhyDENYZ2Jf8LIvEM2YQs6qo9l+vpoZ+d5Q6kvIObc+NHd80SnJXWeaHSF3zNd7WmDq/NPGvYr/svZwYl/G6KRgsczx6r0Ytc0+lwM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790101322; c=relaxed/simple;
	bh=pWNqCFX7jJoaCDsHKcQI3tmuezCruS3jwflp9m6rT3M=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=O5p4XZoE3MbAYVIM2MFUo1ihCTN+4HOUy3s73Qyhf5jemnBmJ5fPKaYF0ERj98VIR3lvrBU/iEXY57+kKPeWdwcLNXPd0vZedqGjSKJ4AoaVEpJ3kkpqtODM4SsIhvgvgXM55Exa/A+0ZdEpXVfbkRHDZ3mQYbcVYuwHTgO81nU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=XwXs0TcM; arc=fail smtp.client-ip=52.101.201.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="XwXs0TcM"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WDNmYiGpqjmUGA03Fc4pYPiAYJef3rnfD48W3TUONIrapu47YoDIQo3JOAQZ7E2ovGkj7UehARNu5y1jkHnjBwbJhw+Snes2lqGYHWJNOtRU9jt6mPvVlJ0hgtXDTJzQM5ISkd9rwRxQtj3Uy6LTmoFLkMGMVI3we0T98HLL1Lsa+/qMK7b1849pRamZYmYkyzk00EYp0uP8+D7wwlr6wizgCxQKY+0dXN+Cqi+S31EaEwBCOuVTPq/LWgfzLq+vl6iVwRYLQ9VDKiYJT+h2BPzGm+MvQjj+fJuzYoQkTP9Vnq6AEr4pgeqDgOP+1I8mrjDCdbqvQb8qfaCpvXyRgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JigeNknI8wuBBmVHL+frGcINWYqhE/sVOMrs6eGC3qQ=;
 b=BBYuVahfgw0ZutPse7jaWUzOzEum5mX+gFVdz0zDINLLRUrz53AKTryHOBflWOM1b3ecX6pbVqx0HnAEnH24RUudRmDrCA9+san3C3cC1gwNnS85ls2nAO+mqeeSdd5JQpTnLCSaB3n97dCk5jORFBjQ8R/4bJZtlK4uCxxmWVL5LLRu0+djq6spMzT9Jqi6wm7rid5h1zFRuEOM5Sf0vekF8uN3cMkYDDalyVhPxrKlsrS234xdILxQyNbOJwAyqtIVXaP7tzM/Xb28LMk0NvJV3EFlDMmrYDYk5JdUpT69s9FLUMg5L8Vae3JxzhdfGnbKN5TwDD37aXND7aY/VQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=synopsys.com smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JigeNknI8wuBBmVHL+frGcINWYqhE/sVOMrs6eGC3qQ=;
 b=XwXs0TcMgg7r0NtFAySYIis7YcggAAA4ga5hnDE7HQmXY/TOzY+tFxZCZlkwIGS90JABhV2LQIvHecUTQE5MVgtzLbn6MFcc4eIfiQGu55laXij3+7+nIWezM/Q+iAo7Xjd/Ihb/60VvaYIKsF3xk5YH04cu5xcLN1luopyb7hE=
Received: from PH7P223CA0015.NAMP223.PROD.OUTLOOK.COM (2603:10b6:510:338::11)
 by LV5PR12MB9801.namprd12.prod.outlook.com (2603:10b6:408:2fc::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.13; Tue, 22 Sep
 2026 18:21:55 +0000
Received: from BY1PEPF000264B4.namprd02.prod.outlook.com
 (2603:10b6:510:338:cafe::91) by PH7P223CA0015.outlook.office365.com
 (2603:10b6:510:338::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.428.11 via Frontend Transport; Tue,
 22 Sep 2026 18:21:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BY1PEPF000264B4.mail.protection.outlook.com (10.167.242.121) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.451.8 via Frontend Transport; Tue, 22 Sep 2026 18:21:55 +0000
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Tue, 22 Sep
 2026 13:21:54 -0500
Received: from xhdradheys41.xilinx.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.49 via Frontend
 Transport; Tue, 22 Sep 2026 13:21:51 -0500
From: Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>
To: <Thinh.Nguyen@synopsys.com>, <gregkh@linuxfoundation.org>,
	<michal.simek@amd.com>, <p.zabel@pengutronix.de>
CC: <linux-usb@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>, Radhey Shyam Pandey
	<radhey.shyam.pandey@amd.com>, <stable@vger.kernel.org>
Subject: [PATCH v2 3/3] usb: dwc3: xilinx: unwind ZynqMP platform init on probe failure and remove
Date: Tue, 22 Sep 2026 23:51:25 +0530
Message-ID: <20260922182125.11067-4-radhey.shyam.pandey@amd.com>
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
X-MS-TrafficTypeDiagnostic: BY1PEPF000264B4:EE_|LV5PR12MB9801:EE_
X-MS-Office365-Filtering-Correlation-Id: 1aeb19c2-a894-4f03-662b-08df18d661c7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700016|82310400026|376014|23010399003|18002099003|22082099003|5023799004|11063799006|10067099003|56012099006;
X-Microsoft-Antispam-Message-Info:
	LfiVeHZE10BxFOxwg1RPZfnQRJblUbtleuc0/rfwQVFAJ2F9bQJBxyZsM6J7c6+wDfSy3Yr143m+57szJyTiz881Ka0PJQNnTGB4yurwsIeFOu1brdXX7n9CmYFBh/JgSKPtqB1S0ipFhpJ6yT8bGCxClCUjTVLHBHTiAUQZq0+yA/PG5T1RQCYxuEnbT5Quvs2fjw7ZL3HIFqy0tev+LXwK2CNmwTCsFLiGOXymoeMuY5YCoskSTow59kInmeW5xphM7nPDPYBRtcmUhAzRc2pGIpDQQT4Lukf7XEz7yPpG/1WgHcZgNVRoy5i9aCI1svjohrW0dXyPu+dSQyDzeYXL9xB5LzJpChnEqZ3JmxM1lD0uJXkgmSBrt5z3CCNqORE6+9v/omAk0/3PBdlch3n4GaRUTOAFvM70dpgGpwkGUVoE8kXmh1dEQuLFetb1nS4Li8+sEcWpBOMYLb8SI5cMA3nHOAuLy+0yowJuV6Zcv6qBobdt/actXygCVXn1RtiUSYKiPhmnKJYVHSOJUb+tPqE9waE5QK89brV70n7iqt+Ez9RcuXWV5OiLguIc0wdLbHsup9mvrlHPDtG0vLyGVuvTf71doiB7WWaPuqZHuFC9VjOOeK1qqYIS2mNOp+qP+W2sfRuoTO/wEUn2etkHwxKyB8JzmQEFmrY7L70f/D6MgyoEDTvQ9vKqo0VftU+c/W09MY7m+FEYCSJg5w==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(36860700016)(82310400026)(376014)(23010399003)(18002099003)(22082099003)(5023799004)(11063799006)(10067099003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	8WKXquOOXdhB0cPJQ8jN2r2jPBqfI0Gke0i5Xr5EvODods7WnwBX0TeILrK/62JfgyEddg/wSqig2rsMbl9AIHUPMer8f021kuYYa1TPocSUL+H63L+5OdxUXvUTqqmoiJ7aXLe4pYfdMB/VTOfy7TNstqKwYpg0h89omxk37lt0K0gkhTUbZmgLShSHTMbcqYEb5o3UK3Glsl7ZaLc2h53h0hSvQ7/hPQELdJeyXKcAVhPB/8NFaN+wZqVYverNK0/LLj1F8C+CZUGs2SJunj2CRqliI8X4LPZTb8IxUbBZ5sgLg5g0II81n/g62ZNZqTAPfbAveB+BC2d5dQylJnbG9HYKNsb6uIUUmJyBdSlyBp1QezemKnDxR354TbZJU04iS04ShjS5sDYKr4ECV3GcscofCayAP13+JMk+ULCfNyDL9t4E7IJqVLc5dNqp
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Sep 2026 18:21:55.0876
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1aeb19c2-a894-4f03-662b-08df18d661c7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BY1PEPF000264B4.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV5PR12MB9801

dwc3_xlnx_init_zynqmp() deasserts resets and initialises the USB3 PHY,
but nothing undoes that if a later probe step fails, and nothing undoes
it on remove either. The resets stay deasserted and the PHY stays
initialised while the clocks are disabled underneath them.

Add dwc3_xlnx_exit_zynqmp() and register it as the platform exit handler
once ZynqMP init has completed. Call it from the probe error path for
failures after init succeeded, and from remove(), which also serves as
the shutdown callback.

Fixes: 84770f028fab ("usb: dwc3: Add driver for Xilinx platforms")
Cc: stable@vger.kernel.org
Assisted-by: Claude:claude-opus-5
Signed-off-by: Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>
---
Changes in v2:
- Reworked so the fix no longer depends on the platform-data cleanup.
  v1 registered the teardown as plat->exit in struct dwc3_xlnx_platdata,
  which is introduced by one of the cleanup patches; that made the fix
  unbackportable.  It now uses a pltfm_exit pointer alongside the
  existing pltfm_init in struct dwc3_xlnx, assigned by
  dwc3_xlnx_init_zynqmp() once init has succeeded.  The follow-up
  cleanup series folds both pointers into the platform data struct.
- Made dwc3_xlnx_exit_zynqmp() idempotent by returning early when
  usb_resets_released is clear, rather than guarding only the reset
  assertions.  phy_power_off() and phy_exit() decrement their counts
  unconditionally, so an unbalanced second call would underflow them.
- Rewrote the commit message to describe the bug rather than the
  implementation, since the callback it referred to no longer exists at
  this point in the series.
- Added Cc: stable.

 drivers/usb/dwc3/dwc3-xilinx.c | 28 ++++++++++++++++++++++++++--
 1 file changed, 26 insertions(+), 2 deletions(-)

diff --git a/drivers/usb/dwc3/dwc3-xilinx.c b/drivers/usb/dwc3/dwc3-xilinx.c
index d18d3e364381..31ac75b79709 100644
--- a/drivers/usb/dwc3/dwc3-xilinx.c
+++ b/drivers/usb/dwc3/dwc3-xilinx.c
@@ -47,6 +47,7 @@ struct dwc3_xlnx {
 	struct device			*dev;
 	void __iomem			*regs;
 	int				(*pltfm_init)(struct dwc3_xlnx *data);
+	void				(*pltfm_exit)(struct dwc3_xlnx *data);
 	struct phy			*usb3_phy;
 	struct reset_control		*usb_crst;
 	struct reset_control		*usb_hibrst;
@@ -113,6 +114,21 @@ static int dwc3_xlnx_init_versal(struct dwc3_xlnx *priv_data)
 	return 0;
 }
 
+static void dwc3_xlnx_exit_zynqmp(struct dwc3_xlnx *priv_data)
+{
+	if (!priv_data->usb_resets_released)
+		return;
+
+	phy_power_off(priv_data->usb3_phy);
+
+	reset_control_assert(priv_data->usb_hibrst);
+	reset_control_assert(priv_data->usb_crst);
+	reset_control_assert(priv_data->usb_apbrst);
+	priv_data->usb_resets_released = false;
+
+	phy_exit(priv_data->usb3_phy);
+}
+
 static int dwc3_xlnx_init_zynqmp(struct dwc3_xlnx *priv_data)
 {
 	struct device		*dev = priv_data->dev;
@@ -230,6 +246,7 @@ static int dwc3_xlnx_init_zynqmp(struct dwc3_xlnx *priv_data)
 	dwc3_xlnx_set_coherency(priv_data, XLNX_USB_TRAFFIC_ROUTE_CONFIG);
 
 	priv_data->usb_resets_released = true;
+	priv_data->pltfm_exit = dwc3_xlnx_exit_zynqmp;
 
 	return 0;
 
@@ -326,11 +343,11 @@ static int dwc3_xlnx_probe(struct platform_device *pdev)
 
 	ret = dwc3_set_swnode(dev);
 	if (ret)
-		goto err_clk_put;
+		goto err_pltfm_exit;
 
 	ret = of_platform_populate(np, NULL, NULL, dev);
 	if (ret)
-		goto err_clk_put;
+		goto err_pltfm_exit;
 
 	pm_runtime_set_active(dev);
 	ret = devm_pm_runtime_enable(dev);
@@ -348,6 +365,10 @@ static int dwc3_xlnx_probe(struct platform_device *pdev)
 	of_platform_depopulate(dev);
 	pm_runtime_set_suspended(dev);
 
+err_pltfm_exit:
+	if (priv_data->pltfm_exit)
+		priv_data->pltfm_exit(priv_data);
+
 err_clk_put:
 	clk_bulk_disable_unprepare(priv_data->num_clocks, priv_data->clks);
 
@@ -361,6 +382,9 @@ static void dwc3_xlnx_remove(struct platform_device *pdev)
 
 	of_platform_depopulate(dev);
 
+	if (priv_data->pltfm_exit)
+		priv_data->pltfm_exit(priv_data);
+
 	clk_bulk_disable_unprepare(priv_data->num_clocks, priv_data->clks);
 	priv_data->num_clocks = 0;
 
-- 
2.43.0

