Received: from CH4PR04CU002.outbound.protection.outlook.com (mail-northcentralusazon11013001.outbound.protection.outlook.com [40.107.201.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C57BB35AC13
	for <stable@vger.kernel.org>; Thu,  4 Jun 2026 12:19:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.201.1
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780575572; cv=fail; b=q6UJUKNzcjpI8Qjrs5vVX2cyfHU9wxROYn3TFjjYSQA1ZFDKofITGyg8nd4nIpfTgzC985j8C7XyKtipkiW/eLt1pDaT7+ckaZQayeuDWFFTZI5ed0a06+1/SeiT7GwJIQVx9uBnv6mn5ngsxxuMSiDi502so2yX8gtAm+vU2qU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780575572; c=relaxed/simple;
	bh=am0ECe5tHkSdFMlMDPYLVsHq4T/3isMdPnAi9iPs0rM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jTAxxEcg1b6aXTsqB14kVjFSH9hhCtxKEqJ2nZYocyJj4UEuIBTl71VC0MkSnjqYK2Dlt+yufkuNaC4/yvNxCgDj5MLoKO9Oj4wQbBImS8r39DVzdC18u7fsqqdwJ6qSWUoNIJL1n0b/KfTDsGG1k4JE5MjtGoQPqJ4GDabjRpo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=YKGlbEHD; arc=fail smtp.client-ip=40.107.201.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="YKGlbEHD"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=P139eLfGGHAjY7lEnMh4+JFQEU2NmsEtIZuZ0iGB3IF3B33JTuglBH3k6qh42ZSKnizanTfQBIvb9bWg7IzjGqUs7sXwcIKznXz0+wuQjs010bkLJnyZxpmprA2kSNq0CEH4E9rIIK4MERd51Jf6f5TWtOJzjcUfzY72JVfMHS+HkTXv2ZaL3DsJPscw6X84v+vBuuf0NmO8RlFvuWkvomAEJKNqB6UYk2bGH6e+t/QrER5Hr/HMaBj6K/uWYWW1dyMW1CKHUkv8lLR+XRoI9KGKC3OE2mfhhEJ919lbFSe3lHKMVqPTmm54ojbqAsXfM1xGh1Gtct2U9frG3sEvvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PkiyawCuapCLUbU48cOFvVC/JSjImivmwjou+pN7YSM=;
 b=q6zsyYXmUAc9yVRiaZNC3WfHaKQhRAFt7SyQLBplDlYvFXZu5bT8vdtE4+1o5u+oMAODY/bB23qu1jDHFNfEsPgKfkK0AMZg9cClrO/ugIB67KQ32sbDTxSN4PWu5zJx+NeG9vljHy+ql6UJPjxmp16uDjNeMJWwTUh9p4hzP3RcAKbE3CYeMr5sDP6u8yGeRdod9ikfx8ZDJc4pJNwy7ydOlxC63d8ODoERz48hdO/bHHvUaNAx1T0DXCBnFAEd1yI0xPhlmAmw2YxMD4AtC2cd/FNePxeAswpPgh5eBpiMLf6/mUCoNqKHVWLBR8Rt2lQoaUqNT1IrvBRnCMNHVw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PkiyawCuapCLUbU48cOFvVC/JSjImivmwjou+pN7YSM=;
 b=YKGlbEHDk/ks6PMncK2n3I/UOATvz6nPT8/A6yptjqVBPRFitW6+GA/Yr4GPvBFQT9zrgxczX4ZxHlPgNn/XUrZlPqUz+qBoZLPNzkhZyoxf5JF8LWf1xKBDXPTOLqzgMXTZNvPTx0ACPiKeFpUEaD06xuueQPVBwGo9kvb8CINdXWEvq+v19WPDoGDCABpwV4S4B7RBanUpH0fBqCIfs28zSDr3EwVv3FKg+kZ51ILD9s2XGNpndQ1a2sYPWNaO8+NmgOtP+2+vcATfvbdfbp9qL1mDEGgP+4BdRpQ+ZQv0e9BjdUVdQq1+tvu39xZhYPLtCv453aWBXORj8d8HxQ==
Received: from CH2PR15CA0021.namprd15.prod.outlook.com (2603:10b6:610:51::31)
 by SJ2PR12MB7845.namprd12.prod.outlook.com (2603:10b6:a03:4ce::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.8; Thu, 4 Jun 2026
 12:19:23 +0000
Received: from CH3PEPF0000000E.namprd04.prod.outlook.com
 (2603:10b6:610:51:cafe::10) by CH2PR15CA0021.outlook.office365.com
 (2603:10b6:610:51::31) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.92.8 via Frontend Transport; Thu, 4
 Jun 2026 12:19:22 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CH3PEPF0000000E.mail.protection.outlook.com (10.167.244.42) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.92.5 via Frontend Transport; Thu, 4 Jun 2026 12:19:22 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 4 Jun
 2026 05:19:09 -0700
Received: from rnnvmail204.nvidia.com (10.129.68.6) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 4 Jun
 2026 05:19:08 -0700
Received: from 5b171f0-lcelt.nvidia.com (10.127.8.13) by mail.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Thu, 4 Jun 2026 05:19:08 -0700
From: Wei-Cheng Chen <weichengc@nvidia.com>
To: <stable@vger.kernel.org>
CC: <weichengc@nvidia.com>
Subject: [PATCH 6.18.y] xhci: tegra: Fix ghost USB device on dual-role port unplug
Date: Thu, 4 Jun 2026 20:19:07 +0800
Message-ID: <20260604121907.150042-1-weichengc@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <2026060431-headgear-oversweet-6e6d@gregkh>
References: <2026060431-headgear-oversweet-6e6d@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PEPF0000000E:EE_|SJ2PR12MB7845:EE_
X-MS-Office365-Filtering-Correlation-Id: 18e57e31-9621-427e-539e-08dec23382e9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|376014|36860700016|56012099006|11063799006|22082099003|18002099003|13003099007;
X-Microsoft-Antispam-Message-Info:
	QVQWCp2jtSNN0zMRVX6sVFvPjbJQS0P0cvQT74m3NlhFJ28WdhX+m4nYMcUPyoSJvYDJQ53TxGnqNcIaRYhEBrxNETvpVT/phRM8uBaGxfJNJRav5lcSy3Dc9MUkd2M5JVhBrkIjQ7yfROm4Fan7P9rtLp4f4ZoGnNDyaQnvfUnoPbv4SSBtuJkBjnn4roWhI/qcn4JFPRah/8Izb1PmDskj+YsxzlB4N90nAVeqRpfzYo+eNw0paPXXtjYhsH6vEI+jgpy8OgQIebz6vQ6xTkda9tRBYP51sopB4j/bxZamwhsbtA1G04JqhU7IXCN+QfaI0nlSoC8sNUlLXh7LxFvAS3y6GTU4IGTYy+Hk3zPBngejmGf4GSkf+qen9p5x5lX68mTUz50J14OU//wK2eirw3b5PJxHGIQI/hMJNdWA7CM51iiRutCoq5xfayey51IAwNWwi6xdr1Klw2JzwpzzVhx28fTU+4glUXj3ExROXNrON/jmIwXGqk8dzp3mrRDWWzUAR37NUBs3QeXi8mdPTmj1mNx69OOyeC1Rsl1gB1VKT6RqReZDSjIHuNvSh/FDFzd8yzGGo7vUqoY6KexcgYc06JfvXLwvoZG/YjV/6zO4VsHmkBuuwVffwjFQUB5fIYun+8HazR8i3KqV8FoPpWfiB7rT57GJe7tiH9164UJCP8y2Fr3dvdn08F5VqHdKsO5g2deaq/fF3740kcON4/k2n3XkJcxu6VZWLpY=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(376014)(36860700016)(56012099006)(11063799006)(22082099003)(18002099003)(13003099007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	jzMByUnlt12S8V+lAT++G1krGHgUrlSV7mYv8gQa7oY9UvMdQGShE57lNTSFX0R6MizWqKqhZXh00RX8JiG7+VhP3V5Dx7tezrLTZhrInBBtDZ99Fn+P0uaDJWY+K4zqH6D/U4im0zI2S14nDHUCRBPRfLg0t8kgSi5oiKHi7C5fLDR9/cBcNRyP11zvyKsWDG8XsvH3ONlZ8G/Vo+zsKpbM4ZSvfyn7uudHzpsLO9KsqL8EGkfnhlIGE+qMIDwhT8JiEzQ2ltpf+PbyWhA7xOsuwKBPp7YE/0Z8r2obZI/UfwNtG2Kxw/nvBU/HTcGIg2cMLGz0slTtgLBB+bsXc+4Lz0MRP4vgKitiBKTTA4mXo+BcgheGwqRlsX0wBK055VM7ilYcZAPO6+YzdiMGgrElKxgVVXj+3O23YRqUM1OBBcZtZ+Z9fWMPqhjtIO5C
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jun 2026 12:19:22.6556
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 18e57e31-9621-427e-539e-08dec23382e9
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH3PEPF0000000E.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB7845

[ Upstream commit 5a4c828b8b29b47534814ade26d9aee09d5101fc ]

When a USB device is unplugged from the dual-role port, the device-mode
path in tegra_xhci_id_work() explicitly clears both SS and HS port power
via direct hub_control ClearPortFeature(POWER) calls. This preempts the
xHCI controller's normal disconnect processing -- PORT_CSC is never
generated, the USB core never sees the disconnect, and the device remains
in its internal tree as a ghost visible in lsusb.

Add an otg_set_port_power flag to control whether the dual-role switch
path performs explicit port power management. SoCs that need it
(Tegra124 / Tegra210 / Tegra186) set the flag; later SoCs (Tegra194 and
beyond) rely on the PHY mode change to handle disconnect naturally and
skip all port power calls.

Within the port power path, otg_reset_sspi additionally gates the SSPI
reset sequence on host-mode entry for SoCs that require it.

Flags set per SoC:
  Tegra124, Tegra186  -> otg_set_port_power
  Tegra210            -> otg_set_port_power, otg_reset_sspi
  Tegra194 and later  -> (none)

[ Backport to 6.18.y: keep the host-mode snapshot in the existing
  tegra->lock section, retain pm_runtime_mark_last_busy() in the host
  port-power path, preserve str_on_off(), and resolve context around the
  SoC ops/Tegra234 entries. ]

Fixes: f836e7843036 ("usb: xhci-tegra: Add OTG support")
Cc: stable@vger.kernel.org
Signed-off-by: Wei-Cheng Chen <weichengc@nvidia.com>
Link: https://patch.msgid.link/20260505112630.217704-1-weichengc@nvidia.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/usb/host/xhci-tegra.c | 79 ++++++++++++++++++++---------------
 1 file changed, 45 insertions(+), 34 deletions(-)

diff --git a/drivers/usb/host/xhci-tegra.c b/drivers/usb/host/xhci-tegra.c
index 83b1766ff15..b0dcdede1fc 100644
--- a/drivers/usb/host/xhci-tegra.c
+++ b/drivers/usb/host/xhci-tegra.c
@@ -247,6 +247,7 @@ struct tegra_xusb_soc {
 	bool has_ipfs;
 	bool lpm_support;
 	bool otg_reset_sspi;
+	bool otg_set_port_power;
 
 	bool has_bar2;
 };
@@ -1352,14 +1353,17 @@ static void tegra_xhci_id_work(struct work_struct *work)
 	struct tegra_xusb_mbox_msg msg;
 	struct phy *phy = tegra_xusb_get_phy(tegra, "usb2",
 						    tegra->otg_usb2_port);
+	bool host_mode;
 	u32 status;
 	int ret;
 
-	dev_dbg(tegra->dev, "host mode %s\n", str_on_off(tegra->host_mode));
-
 	mutex_lock(&tegra->lock);
 
-	if (tegra->host_mode)
+	host_mode = tegra->host_mode;
+
+	dev_dbg(tegra->dev, "host mode %s\n", str_on_off(host_mode));
+
+	if (host_mode)
 		phy_set_mode_ext(phy, PHY_MODE_USB_OTG, USB_ROLE_HOST);
 	else
 		phy_set_mode_ext(phy, PHY_MODE_USB_OTG, USB_ROLE_NONE);
@@ -1370,42 +1374,44 @@ static void tegra_xhci_id_work(struct work_struct *work)
 								    tegra->otg_usb2_port);
 
 	pm_runtime_get_sync(tegra->dev);
-	if (tegra->host_mode) {
-		/* switch to host mode */
-		if (tegra->otg_usb3_port >= 0) {
-			if (tegra->soc->otg_reset_sspi) {
-				/* set PP=0 */
-				tegra_xhci_hc_driver.hub_control(
-					xhci->shared_hcd, GetPortStatus,
-					0, tegra->otg_usb3_port+1,
-					(char *) &status, sizeof(status));
-				if (status & USB_SS_PORT_STAT_POWER)
-					tegra_xhci_set_port_power(tegra, false,
-								  false);
-
-				/* reset OTG port SSPI */
-				msg.cmd = MBOX_CMD_RESET_SSPI;
-				msg.data = tegra->otg_usb3_port+1;
-
-				ret = tegra_xusb_mbox_send(tegra, &msg);
-				if (ret < 0) {
-					dev_info(tegra->dev,
-						"failed to RESET_SSPI %d\n",
-						ret);
+	if (tegra->soc->otg_set_port_power) {
+		if (host_mode) {
+			/* switch to host mode */
+			if (tegra->otg_usb3_port >= 0) {
+				if (tegra->soc->otg_reset_sspi) {
+					/* set PP=0 */
+					tegra_xhci_hc_driver.hub_control(
+						xhci->shared_hcd, GetPortStatus,
+						0, tegra->otg_usb3_port+1,
+						(char *) &status, sizeof(status));
+					if (status & USB_SS_PORT_STAT_POWER)
+						tegra_xhci_set_port_power(tegra, false,
+									  false);
+
+					/* reset OTG port SSPI */
+					msg.cmd = MBOX_CMD_RESET_SSPI;
+					msg.data = tegra->otg_usb3_port+1;
+
+					ret = tegra_xusb_mbox_send(tegra, &msg);
+					if (ret < 0) {
+						dev_info(tegra->dev,
+							"failed to RESET_SSPI %d\n",
+							ret);
+					}
 				}
-			}
 
-			tegra_xhci_set_port_power(tegra, false, true);
-		}
+				tegra_xhci_set_port_power(tegra, false, true);
+			}
 
-		tegra_xhci_set_port_power(tegra, true, true);
-		pm_runtime_mark_last_busy(tegra->dev);
+			tegra_xhci_set_port_power(tegra, true, true);
+			pm_runtime_mark_last_busy(tegra->dev);
 
-	} else {
-		if (tegra->otg_usb3_port >= 0)
-			tegra_xhci_set_port_power(tegra, false, false);
+		} else {
+			if (tegra->otg_usb3_port >= 0)
+				tegra_xhci_set_port_power(tegra, false, false);
 
-		tegra_xhci_set_port_power(tegra, true, false);
+			tegra_xhci_set_port_power(tegra, true, false);
+		}
 	}
 	pm_runtime_put_autosuspend(tegra->dev);
 }
@@ -2558,6 +2564,7 @@ static const struct tegra_xusb_soc tegra124_soc = {
 	.scale_ss_clock = true,
 	.has_ipfs = true,
 	.otg_reset_sspi = false,
+	.otg_set_port_power = true,
 	.ops = &tegra124_ops,
 	.mbox = {
 		.cmd = 0xe4,
@@ -2596,6 +2603,7 @@ static const struct tegra_xusb_soc tegra210_soc = {
 	.scale_ss_clock = false,
 	.has_ipfs = true,
 	.otg_reset_sspi = true,
+	.otg_set_port_power = true,
 	.ops = &tegra124_ops,
 	.mbox = {
 		.cmd = 0xe4,
@@ -2639,6 +2647,7 @@ static const struct tegra_xusb_soc tegra186_soc = {
 	.scale_ss_clock = false,
 	.has_ipfs = false,
 	.otg_reset_sspi = false,
+	.otg_set_port_power = true,
 	.ops = &tegra124_ops,
 	.mbox = {
 		.cmd = 0xe4,
@@ -2672,6 +2681,7 @@ static const struct tegra_xusb_soc tegra194_soc = {
 	.scale_ss_clock = false,
 	.has_ipfs = false,
 	.otg_reset_sspi = false,
+	.otg_set_port_power = false,
 	.ops = &tegra124_ops,
 	.mbox = {
 		.cmd = 0x68,
@@ -2705,6 +2715,7 @@ static const struct tegra_xusb_soc tegra234_soc = {
 	.scale_ss_clock = false,
 	.has_ipfs = false,
 	.otg_reset_sspi = false,
+	.otg_set_port_power = false,
 	.ops = &tegra234_ops,
 	.mbox = {
 		.cmd = XUSB_BAR2_ARU_MBOX_CMD,
-- 
2.43.0

