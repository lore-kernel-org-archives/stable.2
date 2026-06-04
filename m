Received: from CY7PR03CU001.outbound.protection.outlook.com (mail-westcentralusazon11010032.outbound.protection.outlook.com [40.93.198.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FF7041C313
	for <stable@vger.kernel.org>; Thu,  4 Jun 2026 12:09:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.198.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780574984; cv=fail; b=ghWZDG6Iv80P/V72n/0Gv6ibNleLgM8UT5FatSmwvRYoEDgGJ5UH/IUAuJVWbYUjqXc2qPycy3TO/3pwp5NFLyJOM/imnB6+ruT/TYQizohNb2Wtf+btxsH6i3cIEsdjMcYJilRLj16fQiWDMs5OYjwa63HAu6dLqADMgKYFl20=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780574984; c=relaxed/simple;
	bh=OipPT2a8Igt8gJlpMSX+SU5UYWbTTDDepKyKjXwsZ5E=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CgUnLMOM/JQy3/dlBfNTMxJJ9mig9VDO57DAh/FuAtvd4j3jaSZ5FLZw+TqJePWRb7gsD7oZsiS8lkh27oCoPNc0dggMr63vcJokZATUiCjmuZ43df4aH/pja3jmE4GcgdlxtVKJ/fo2EqAHYQ2y5q08NLATyu4EJjcoUHXEfW4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=BbKwYObF; arc=fail smtp.client-ip=40.93.198.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="BbKwYObF"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RqvknCJlrCjXxtW1pKAvQ3WoF8BxqHmc4QL8bbAbvGRkqqtdvtALZPH8jQmRNz9tjWXRrsmeA6PvWZyfzVFJYSAbm2XqHZwNzwc/GE0QXArAF0Aghva2smNYKYCQTExhSkQsayyHcYrzc2JT2m5IKj1xCCSdCwA/rLiKccr9He31gQ47g7ybyTs3w+VqT2e9kUxdoZZxdTMw08bsxObYuVEHcq10/gkNgWvmEh5Cp4TK6RoUKVQYBNsIX381nl7tonV2TEoQCjfjB9KkDe9rN+x9OzQ68EVwhUM/AlrkB13aYH9egfG/qo8qs+jigwqx8dgKEgFn2bHx8WDXDvRthQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CKgt0pRPWrTtFLIY8WlO0Qo5E3Tz1wCQ94dV/iuhWhI=;
 b=wEtJOqrXawV3M7iDEAkdhSINFUwSzW41XKusbALU5kTKddSNBK06xhcN3CJSJUZ5pI51foDb5O5oXIUkeBwMFHFI9PyFnI+pU1Py9E4EaaYIv5whH3Z2G/vA+5JzON3Rbp7CuSbIhkY9BjW87xn4fYE1C6vCTNIcKbe8fQfC/ZBDFjBJrqynPgJXnuE1WAsqpvnA/TisGcJHRUiVqt3+ZwPgtK+93zXPdwprvhx3dPxDLgiwHfq+Or3xX1Z2vjMQzHoO2s9PeJN51OImOmg8ptsn7Y4e85csDHrmdcb+EyyL3z6o5QzWprczSbljOt8PpCfcAPUvlywuAjHdGgepGg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CKgt0pRPWrTtFLIY8WlO0Qo5E3Tz1wCQ94dV/iuhWhI=;
 b=BbKwYObF3fonekvdwnDic/xFeUk1T3ZM4R5I6qpu2MNxZ6i3LBPzMuVvtc84+SH6hyg2BnGQSvdUto0bcTLJBeGn1xNKW/x91hcMhi3hORVuC4X6FLqe22AvOM91FvaBGfwRh4Unug/Uqqw+ddhLV1hFrDISbhHJJkO+WU0NdeW8/bXH++Et1OpzfykVCGCPURYBdtfzmCvnmT6arw/fSLvIGL8xntpC9xNCh+GkkRXUn9XE8DdLxh9j/Ne7IgXqS2kIZ99AEpMNUpWWLu3alBVh5IIqksfFhqqkO9vuvLYpCXu4oO5XRIDqkWs2EHwbLrc61+fj9wc/uKa/W+Wp8w==
Received: from SA1P222CA0064.NAMP222.PROD.OUTLOOK.COM (2603:10b6:806:2c1::15)
 by DS7PR12MB5814.namprd12.prod.outlook.com (2603:10b6:8:76::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.92.7; Thu, 4 Jun 2026 12:09:35 +0000
Received: from SA2PEPF00001507.namprd04.prod.outlook.com
 (2603:10b6:806:2c1:cafe::5f) by SA1P222CA0064.outlook.office365.com
 (2603:10b6:806:2c1::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.92.8 via Frontend Transport; Thu, 4
 Jun 2026 12:09:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SA2PEPF00001507.mail.protection.outlook.com (10.167.242.39) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.92.5 via Frontend Transport; Thu, 4 Jun 2026 12:09:35 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 4 Jun
 2026 05:09:16 -0700
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 4 Jun
 2026 05:09:16 -0700
Received: from 5b171f0-lcelt.nvidia.com (10.127.8.13) by mail.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Thu, 4 Jun 2026 05:09:15 -0700
From: Wei-Cheng Chen <weichengc@nvidia.com>
To: <stable@vger.kernel.org>
Subject: [PATCH 7.0.y] xhci: tegra: Fix ghost USB device on dual-role port unplug
Date: Thu, 4 Jun 2026 20:09:14 +0800
Message-ID: <20260604120914.131945-1-weichengc@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <2026060430-deluxe-finite-6c5b@gregkh>
References: <2026060430-deluxe-finite-6c5b@gregkh>
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
X-MS-TrafficTypeDiagnostic: SA2PEPF00001507:EE_|DS7PR12MB5814:EE_
X-MS-Office365-Filtering-Correlation-Id: 1e34d1fc-752c-4a3c-d2ca-08dec23224f2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|36860700016|1800799024|56012099006|11063799006|22082099003|18002099003|13003099007;
X-Microsoft-Antispam-Message-Info:
	diM3ifiQDx43G3MMoQzZJVYNAFZbt+FL3jDPmOuBdHQOmfCfOov5eeeOA4o+jVo6eXmNFw0AN+duHS+JcqcmbsO/aiF/NXUft74mUJYrgakn7dD/fD8w9hzKN/5j4h9PCZQsfpHPD/DXRH/IRDe1u5IOYDnT/Hg4HoTPsw5RMQStvfGerczINMEoXwHpUBqVGkRgK4/EJPHAvOrqVMPlhYksuzOLRMofLp4H3BE/NaWp7FtDt1uHw+ZKyM6K+cXENIgnFMAIY4SwYY5bqvxMUMsy+ekEfjJoGYMSe+JiTG3nu8ayvlebxZMBdddjI1TX2HIHQr1PjO9gCtcpTZzLnTANmb7af7dtKLTS+ZlRG4FS49ip2aOtmpTtKiKY2/DbkrwSymU9YBFx7q8DUneF5yWaGEW+qsuHak5160pbcs/HoV/jgGkXo5yNLYGyC+xxd5cZMCAICwb5cFLfhScaDD/I+rG4Mne9V5kNaehh1LedaDEXoVQcE0NgGwn8lVSXhIFXpKKubAMIAi0zWzCFrAr7LSnoyEbpw/ajFOmvrd/i6qIZi8vkvXW+IC+ER/6GDDJsl/zLtzz6hudlZsL4nR9tcaKF5V4xLp7hPxRi3fTwRLKG+ho8yVUQARWqG8kLdKk6/mydpxnKUZEeNIy1pwpMVXYbG4U+ENjQJJnDFT3SNm5SHAu9Bvrayy2SCVrVoRmLlCBAMrh7BLuDKtq0B63IqUMmxcAMrHMZ9J8SSoI=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(376014)(36860700016)(1800799024)(56012099006)(11063799006)(22082099003)(18002099003)(13003099007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	0mPpTD5kVWfwdto69aDFSSZkCyGsY1vRYrcuY1pGvbTv2hI17cHhanFom5d79zg4GW1r4hjDyucfnjzFSYwycJkroGDalu292WzBMEfxwzLNZgOu1K+vinn7BGJAaMCnNmBeYnv0fKI4914Vq8DgrZdqBScYbE6s5Tg3oQrLeccW6Bs+GYfq3DIyoij+tOvZdIcXQXvH2q0EoaVuHswF7TAorJImNcvT4FNMBzFvpOpAO9XSz2CO8NZQeIxGEWzFRrx2R4edl/0keCpipdHJH4iRPU1D8wj+hxNMCNAsoWGPDSPaQgQrhLydsJS9vocEgbZ03A2y1DZhHI1ZN/w3GcVRoiAhS6PoCtIRnzkHpE6dNOVZEZAwqtfVFSgO7+bp5NFk81keRVYqOjYAy6Vvb8cE/L50WyCcQGmJp+94fVT81KfIenXqVM0cRpYzpDvT
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jun 2026 12:09:35.5744
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1e34d1fc-752c-4a3c-d2ca-08dec23224f2
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF00001507.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB5814

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

[ Backport to 7.0.y: keep the host-mode snapshot in the existing
  tegra->lock section, preserve str_on_off(), and resolve context around
  the SoC ops/Tegra234 entries. ]

Fixes: f836e7843036 ("usb: xhci-tegra: Add OTG support")
Cc: stable@vger.kernel.org
Signed-off-by: Wei-Cheng Chen <weichengc@nvidia.com>
Link: https://patch.msgid.link/20260505112630.217704-1-weichengc@nvidia.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/usb/host/xhci-tegra.c | 77 ++++++++++++++++++++---------------
 1 file changed, 44 insertions(+), 33 deletions(-)

diff --git a/drivers/usb/host/xhci-tegra.c b/drivers/usb/host/xhci-tegra.c
index 3f6aa2440b0..ddc52d1e0ed 100644
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
@@ -1370,41 +1374,43 @@ static void tegra_xhci_id_work(struct work_struct *work)
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
+			tegra_xhci_set_port_power(tegra, true, true);
 
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
@@ -2557,6 +2563,7 @@ static const struct tegra_xusb_soc tegra124_soc = {
 	.scale_ss_clock = true,
 	.has_ipfs = true,
 	.otg_reset_sspi = false,
+	.otg_set_port_power = true,
 	.ops = &tegra124_ops,
 	.mbox = {
 		.cmd = 0xe4,
@@ -2595,6 +2602,7 @@ static const struct tegra_xusb_soc tegra210_soc = {
 	.scale_ss_clock = false,
 	.has_ipfs = true,
 	.otg_reset_sspi = true,
+	.otg_set_port_power = true,
 	.ops = &tegra124_ops,
 	.mbox = {
 		.cmd = 0xe4,
@@ -2638,6 +2646,7 @@ static const struct tegra_xusb_soc tegra186_soc = {
 	.scale_ss_clock = false,
 	.has_ipfs = false,
 	.otg_reset_sspi = false,
+	.otg_set_port_power = true,
 	.ops = &tegra124_ops,
 	.mbox = {
 		.cmd = 0xe4,
@@ -2671,6 +2680,7 @@ static const struct tegra_xusb_soc tegra194_soc = {
 	.scale_ss_clock = false,
 	.has_ipfs = false,
 	.otg_reset_sspi = false,
+	.otg_set_port_power = false,
 	.ops = &tegra124_ops,
 	.mbox = {
 		.cmd = 0x68,
@@ -2704,6 +2714,7 @@ static const struct tegra_xusb_soc tegra234_soc = {
 	.scale_ss_clock = false,
 	.has_ipfs = false,
 	.otg_reset_sspi = false,
+	.otg_set_port_power = false,
 	.ops = &tegra234_ops,
 	.mbox = {
 		.cmd = XUSB_BAR2_ARU_MBOX_CMD,
-- 
2.43.0

