Received: from CO1PR03CU002.outbound.protection.outlook.com (mail-westus2azon11010015.outbound.protection.outlook.com [52.101.46.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC20E4AC163;
	Mon, 28 Sep 2026 12:01:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.46.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790596897; cv=fail; b=USaXBCGrNGQ4Sncy/4hZrSrXtxZw4htDLkpy9Dfnd4sqZ7eP9PMi7CzCACYT8Q2hz73W9TyOLkC9neh9vTv9QjUDhYgBRSy2r/2loF8d8CswQKHPrwhO1/j3WpCyF4xHy5WDSWEberTO5h6eNiuQc+WCJPrTIHLVA0m4YJzQ/Ag=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790596897; c=relaxed/simple;
	bh=Pu08NiRPyBsv1y/cjy8V+I5kVc9VNGOHB2jd5acJE1M=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bDHlLzKsdaJXytf2sr5Cdk9a4Ngd+zaB1Ov/EP6+/rPPYV7ZDsRpydGu7+PSVfdqXOJucAdqRIDcWcaNrVs2SHJF3NJLEcAIkMbsI5UIdz2vzmWoxFf1k7IEH9A+IskuPY0gKE1M6T7rl6R6lyNwwyiPGa1ZAdj0Ry6p+nBU0c8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=wLhj3q1f; arc=fail smtp.client-ip=52.101.46.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="wLhj3q1f"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jaPECmA0gEWxVvOFjuu6PjdsfOM2KGCnlZPqA6E7/jBQu6PIII+SFv01Rr/ol+u93tQPY2Scr5SojJExyPlxNeqcFbMSZHTdtCSlYeIMKrwN+orq158ZaToSOKGySlwOkWppBF0rFFk42rlUlHbtgCB3ZB1YaFf30DOSxl+FDnfXPhuWM0mIAXyT22ixTjHWPENSHUaVN/7/gRH2MUB8cHRxGgULMt8+GXpeMxJ1uH/9PIzn2MR782VkgxtMxLHutx5xPlNod0OYal13IFPF7T99Rm+Ho8s2Q1gWhk9M7MjCE9TkmcFvkRhPANtWvBdkPYsLi3CBNv2p8vqucUv8LQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yEI4jgfs1sg5Yr4T1mblF35cks4mYLEyqyoJ1pUxUQM=;
 b=iyR+WSutCdUvNhNGJiOoPM3WS1/VpyjzhQVmfViUYtys41wh+/p3fz9aG41DHaQRgSPuERQ5Dq4E4c7hs27OO+khKm5F9s1LkSyr9D8e+8aBSoZdtE9THGrAWiAtpNtPtiwbbK5NiyiLy9Qr3tV3TPdam1C94OjLfkUNhcHMCf6NqTzp9oGd1lzRvA6hJy7nTOgJr+yOp92eJ1ePGj6xHGwTZslVnss0tcAEm9WI5QBNx57JlwyB8CABGwGdQWUvLh0EHUlWUXGe179XuNp2lzKt7RoXuK+41dZ7n7o1lja/XJr4gUaZr402NR6Ric2f9450XJX09qIP7tUnjGSeNA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=synopsys.com smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yEI4jgfs1sg5Yr4T1mblF35cks4mYLEyqyoJ1pUxUQM=;
 b=wLhj3q1fYNoH9G4rErUsyvejyp0bJgkBAjBKwyGLos0Vp3JUarOvMxM9p8rQU5crZsWWcNmHBqVFWMfU2G7UZ3Ka3Dopvw8ckxCu6c8uBjeDe94zkR7y3msIcZK+iyty/nEoVttwkuaC4Q6Sze7yjJw/w4XDas7WXFyqcq4/io4=
Received: from BY3PR03CA0020.namprd03.prod.outlook.com (2603:10b6:a03:39a::25)
 by LV8PR12MB9333.namprd12.prod.outlook.com (2603:10b6:408:1fa::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.24; Mon, 28 Sep
 2026 12:01:28 +0000
Received: from SJ1PEPF00001CE6.namprd03.prod.outlook.com
 (2603:10b6:a03:39a:cafe::34) by BY3PR03CA0020.outlook.office365.com
 (2603:10b6:a03:39a::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.451.24 via Frontend Transport; Mon,
 28 Sep 2026 12:01:28 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ1PEPF00001CE6.mail.protection.outlook.com (10.167.242.22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.472.14 via Frontend Transport; Mon, 28 Sep 2026 12:01:28 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Mon, 28 Sep
 2026 07:01:16 -0500
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Mon, 28 Sep
 2026 07:01:04 -0500
Received: from xhdradheys41.xilinx.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.49 via Frontend
 Transport; Mon, 28 Sep 2026 07:01:01 -0500
From: Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>
To: <Thinh.Nguyen@synopsys.com>, <gregkh@linuxfoundation.org>,
	<michal.simek@amd.com>, <p.zabel@pengutronix.de>
CC: <linux-usb@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>, Radhey Shyam Pandey
	<radhey.shyam.pandey@amd.com>, <stable@vger.kernel.org>
Subject: [PATCH v3 3/3] usb: dwc3: xilinx: unwind ZynqMP platform init on probe failure and remove
Date: Mon, 28 Sep 2026 17:30:15 +0530
Message-ID: <20260928120015.3152461-4-radhey.shyam.pandey@amd.com>
X-Mailer: git-send-email 2.44.4
In-Reply-To: <20260928120015.3152461-1-radhey.shyam.pandey@amd.com>
References: <20260928120015.3152461-1-radhey.shyam.pandey@amd.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CE6:EE_|LV8PR12MB9333:EE_
X-MS-Office365-Filtering-Correlation-Id: 58feb60c-3266-466a-f62e-08df1d583a4f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700016|23010399003|376014|1800799024|10067099003|11063799006|5023799004|6133799003|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	vmNDtCyi/Wq+vCa4/N7baxyq1wL7XwQ4oG2fbieTA0+9afzNpdeOy9aD6k8J8R2Q9ml5kpgilPA4aVZYz6ZKepMkYEkCnFio/6tV5K/GVIox+BNiVvj+14ScRU7Mvklt8wGqD0KqRE1DuiLxKcpQ/NlWQAHCL+ssBl741N8B5vdzPy5j6yzBvXVsaBILvF3RN5ME7SkTekwGrq6uX+Cb2OcWJU01/ungapTm+1EiyPqfIIMyzMFsd9oRsLHYvYMroSi1+J+5AVypKNpX79P2zVExx0fL7vWktZ/yMCJL9HRK9TVbjJzP0iJ7iM9gskU2LkuF5mEzLzq5tFhVrazc84JnrZeW7B+ssH5rpeY6+QzgEo2S+trOxmzy/woqOOYRUfD/9XXX0X3lyMpsAViBwi8pVLAU4t+nTYalgT2+TaCXnamEQIsLityBJzAycZFXeE8pV00tIaEJ/LsH4z6IyOKKV1nHGwKwWeQjBpdZxTTBkAc5PnIBOd8Jlb4wnBJ+/YlmWQFE7GEWQdaXynpgOIuigBXv50bWFW0q6bRw7kS5o4jui+mIGPaECxyAcQSz65GJv1GdZiDKfMnOEquND4/ItOkAdnWGldGSLm7dD6NAf/leGLLLM5Ky7F0h6n/rYGgu8SdpWMTTfnLLKOb9NdeLVLUeNdcySge1TGM6EQ/pLa8ti4SEt03L8/iGmyzobV+nb1CNgdI3e3OIQAkH+w==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(36860700016)(23010399003)(376014)(1800799024)(10067099003)(11063799006)(5023799004)(6133799003)(56012099006)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	+pChe9YG7pixapn3FR9hRzjcnpdGtjaFKrP1MMuSzM9c2QJECLIqUGKDVvnYxlpipRi4CfFTlKJGSy5BIkLQXD5xCX/EtZW7AJ5vI0Gs/e7fgacr7q8/oGEVduFbt2Vsoiie4jooPsnKMpL77Z3rld8UsiPexDReGv/M4aDP0KdlrD5ONtaquIeQHXUWDObtUhQQYw9gqA6DhUNfVnr+YuCZjmxRvQOvlaglFH3IUZrS+MuGkMqgqGLqQ78UjXytcnXud6SEQrDhLT6i/1+Eo7WZX4JdMLfOSj8IFujZyRE3OZU4h4cKUTrHWcdK/+YLRJbqlQh3HnaXOS+g3Tj0cdqx6lvIfacUlWHV8Ts9Zf7tJWlwdCpe2XI8uwBqD2lFVSTO+NOdxZhrb7l886Jc1KsP1owkeDD8sHRLdkW9Bh7fFQq5WVUQuBt7NkaPRMqr
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Sep 2026 12:01:28.1524
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 58feb60c-3266-466a-f62e-08df1d583a4f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00001CE6.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9333

dwc3_xlnx_init_zynqmp() leaves the controller out of reset with the PHY
powered on, but nothing undoes that if probe fails later or when the
driver is removed. The resets stay deasserted and the PHY stays on with
no driver bound.

Register the teardown with devm_add_action_or_reset() once init has
completed, so it runs on probe failure without the driver having to
track how far init progressed. The teardown only undoes the reset cycle
init performed, so it carries the same usb3-phy guard: with no PHY the
resets were never asserted, and asserting them could break a USB3
configuration that is live but missing from the device tree.

The resets have to be asserted while the clocks are still running, so
both the probe error path and remove() run the teardown explicitly
before gating the clocks rather than leaving it to devres, which would
otherwise run it afterwards. devm_release_action() unlinks the action
before calling it, so devres cannot run it a second time.

Running it from remove() also covers .shutdown, which shares
dwc3_xlnx_remove(): device_shutdown() does not call
devres_release_all(), so a teardown left to devres would never run
there.

Fixes: 84770f028fab ("usb: dwc3: Add driver for Xilinx platforms")
Cc: stable@vger.kernel.org
Suggested-by: Philipp Zabel <p.zabel@pengutronix.de>
Assisted-by: Claude:claude-opus-5
Signed-off-by: Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>
---
Changes in v3:
- Register the teardown with devm_add_action_or_reset() instead of a
  pltfm_exit pointer and the usb_resets_released flag, per Philipp.
- Guard the teardown's reset asserts on usb3_phy; v2 asserted
  unconditionally, resetting a no-PHY board that init never asserted.
- Replace v2's err_pltfm_exit label with dwc3_xlnx_release_teardown(),
  called from both the probe error path and remove() so the resets are
  unwound before the clocks are gated in either.
- Explain in remove() why the teardown is not left to devres:
  device_shutdown() does not call devres_release_all().
- Clocks left unmanaged: devm_pm_runtime_enable()'s cleanup runs
  runtime_suspend() before a clock devres node would release, which
  double-disables on ZynqMP.

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
---
 drivers/usb/dwc3/dwc3-xilinx.c | 44 +++++++++++++++++++++++++++++++++-
 1 file changed, 43 insertions(+), 1 deletion(-)

diff --git a/drivers/usb/dwc3/dwc3-xilinx.c b/drivers/usb/dwc3/dwc3-xilinx.c
index d2315573b3d3..475bc19a1746 100644
--- a/drivers/usb/dwc3/dwc3-xilinx.c
+++ b/drivers/usb/dwc3/dwc3-xilinx.c
@@ -112,6 +112,39 @@ static int dwc3_xlnx_init_versal(struct dwc3_xlnx *priv_data)
 	return 0;
 }
 
+static void dwc3_xlnx_zynqmp_teardown(void *data)
+{
+	struct dwc3_xlnx *priv_data = data;
+
+	phy_power_off(priv_data->usb3_phy);
+
+	/*
+	 * Undo only the reset cycle init performed.  As on the init error
+	 * path, the unconditional deasserts are not paired with an assert
+	 * here: with no usb3-phy, resetting the core could break a USB3
+	 * configuration that is live but missing from the device tree.
+	 */
+	if (priv_data->usb3_phy) {
+		reset_control_assert(priv_data->usb_hibrst);
+		reset_control_assert(priv_data->usb_crst);
+		reset_control_assert(priv_data->usb_apbrst);
+	}
+
+	phy_exit(priv_data->usb3_phy);
+}
+
+/*
+ * Run the platform teardown explicitly, so the resets are asserted while the
+ * clocks are still running.  devm_release_action() unlinks the action before
+ * calling it, so devres will not run it a second time.
+ */
+static void dwc3_xlnx_release_teardown(struct device *dev,
+				       struct dwc3_xlnx *priv_data)
+{
+	if (devm_is_action_added(dev, dwc3_xlnx_zynqmp_teardown, priv_data))
+		devm_release_action(dev, dwc3_xlnx_zynqmp_teardown, priv_data);
+}
+
 static int dwc3_xlnx_init_zynqmp(struct dwc3_xlnx *priv_data)
 {
 	struct device		*dev = priv_data->dev;
@@ -228,7 +261,8 @@ static int dwc3_xlnx_init_zynqmp(struct dwc3_xlnx *priv_data)
 
 	dwc3_xlnx_set_coherency(priv_data, XLNX_USB_TRAFFIC_ROUTE_CONFIG);
 
-	return 0;
+	return devm_add_action_or_reset(dev, dwc3_xlnx_zynqmp_teardown,
+					priv_data);
 
 err_phy_power_off:
 	phy_power_off(priv_data->usb3_phy);
@@ -355,6 +389,7 @@ static int dwc3_xlnx_probe(struct platform_device *pdev)
 	pm_runtime_set_suspended(dev);
 
 err_clk_put:
+	dwc3_xlnx_release_teardown(dev, priv_data);
 	clk_bulk_disable_unprepare(priv_data->num_clocks, priv_data->clks);
 
 	return ret;
@@ -367,6 +402,13 @@ static void dwc3_xlnx_remove(struct platform_device *pdev)
 
 	of_platform_depopulate(dev);
 
+	/*
+	 * This is also what makes .shutdown behave the same as .remove:
+	 * device_shutdown() does not call devres_release_all(), so a teardown
+	 * left to devres would never run on the shutdown path.
+	 */
+	dwc3_xlnx_release_teardown(dev, priv_data);
+
 	clk_bulk_disable_unprepare(priv_data->num_clocks, priv_data->clks);
 	priv_data->num_clocks = 0;
 
-- 
2.44.4

