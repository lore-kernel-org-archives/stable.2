Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazon11011008.outbound.protection.outlook.com [52.101.52.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D873743900F
	for <stable@vger.kernel.org>; Thu,  4 Jun 2026 12:19:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.52.8
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780575583; cv=fail; b=qTc5tjilTz8MIPDvnIGkduGdqjsyo32nBGg0Gae5C8QwHxbWOvY4Y3MYiAGfmujdBSBENpKUeNDA3IrY15vriX4v4FzGyRIBqiU+qF2n7LWoRaJjw57pPqfCJ+w+i11yf+xSlEepRRBZMQy0ehsaHbLK+BNau+2/t+G2Eu30JvM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780575583; c=relaxed/simple;
	bh=qyw5MD1SCIIVfZg/HPrXQ1S0Wcd1TG1kpkKXucPvxmY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZhuBN4Hc+BCn7oBzWYeyblXWX7XZo1DZtVD/+nhq7h5hQVxyzFheu6TxpLb5ihBdxpAnJNShfHSDKSuDf6gdGGssFIB1jAaIQO8hYh4Z5dU+gIve9JD+prKdMCBOnxB5mz4YfPSKviefgfsVwYlhZ7KFOuxO+iOth2/SsHylV+A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=jC+RZ2Ps; arc=fail smtp.client-ip=52.101.52.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="jC+RZ2Ps"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RgOmW0dQNFfTI/VWeD/SuXZbdtBuuD0S8S6zAUVp32pzuV56z8IQLPn6BurH34SCtP/GHYwWoGjjPU9s9tPDLnnaa2isMhBg1ikD0Q/Kebnhb5C7ikAwWbskngFaOVOGcMdBiLJA+irTSaB0uDcFznWUIAEf2CWMzsh/x++hRro+9Ywqv12qJNCc00KkCoTMzsZIZBE56RZwgMNPbxRgvzw7orAcLiOPiNfXkT4Z9PTSx4XSazkO8xMJH+rvR759RuWY8TvoZSclm4M7DnWFNDZ9UjGU8PZXnEwe8ZGBOjFEQkqYmZzyk+RQ0hVN+8RK3ttzr9lBzVzLXQTLyFE/SA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZrC6smWV+hHSAk71OTAXbOSADMrGI8V2eXQVHyhUwUQ=;
 b=fvjLmMsyF+1vq2L33yUW4XKPQxwsquWibcRzOdlAnh26IeF9aUaDOkcHyWmr3LEUWVmvKwmwlBT0DJZV1gdJdctAZYmpNDhgPbMR/L1f6R1gytmUh80wqqyvabeNhjZpbd5BRHk5FtZSIhdklAtBhu6mk18p+cOv7TEIShxny81r/SCQTBnR8OcJEvYc7vEoXjl+q01Akm7b5i556vdU9jpetUwXC1x438e9qRHI397NK18sD2az73rygFUKHWcTXRNsknY09TxKemmgZVCTFM8/l8kto8FVLrBZ0LtpZVg0KIHDtg2ajy+KeD1Slf8ge+4VoMZBwdodIMNUMGfU7w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZrC6smWV+hHSAk71OTAXbOSADMrGI8V2eXQVHyhUwUQ=;
 b=jC+RZ2PsaCju6sLa8vz6YytBHOsA7gmYyBCnGwlyCzuojpBeuWJTgPDfzo+trWxDP3fIhHxekQ8IfF1dQVqCogJ1rgn/U6lq7XWA7eDZBGmDEn3DIAMNFTZraN/VASVZpJwgnH9I08TmnZtFb7VW7CII7SE8lx1Yo7/NytCIFKb+FtlgV5GtWhBQcCT4/GesEvYLzol7ke1rE7qJZMefbt+gPFIcXxDN/7TeqIrS9Z3XFEGrAs3+qRQuYlf9feEqKojQNIEN3XD2Jhc+TTxmk9y5Z8qXWReEclRe0X5rlivItz/JId15Iold8ldWN0jCEFqix2hQ8ZJWeuIMxbarfA==
Received: from BL1PR13CA0023.namprd13.prod.outlook.com (2603:10b6:208:256::28)
 by MW4PR12MB7167.namprd12.prod.outlook.com (2603:10b6:303:225::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.7; Thu, 4 Jun 2026
 12:19:33 +0000
Received: from BL6PEPF0001AB55.namprd02.prod.outlook.com
 (2603:10b6:208:256:cafe::3b) by BL1PR13CA0023.outlook.office365.com
 (2603:10b6:208:256::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.92.7 via Frontend Transport; Thu, 4
 Jun 2026 12:19:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BL6PEPF0001AB55.mail.protection.outlook.com (10.167.241.7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.92.5 via Frontend Transport; Thu, 4 Jun 2026 12:19:32 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 4 Jun
 2026 05:19:15 -0700
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 4 Jun
 2026 05:19:15 -0700
Received: from 5b171f0-lcelt.nvidia.com (10.127.8.13) by mail.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Thu, 4 Jun 2026 05:19:14 -0700
From: Wei-Cheng Chen <weichengc@nvidia.com>
To: <stable@vger.kernel.org>
CC: <weichengc@nvidia.com>
Subject: [PATCH 6.1.y] xhci: tegra: Fix ghost USB device on dual-role port unplug
Date: Thu, 4 Jun 2026 20:19:13 +0800
Message-ID: <20260604121913.150323-1-weichengc@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <2026060434-finlike-uncombed-dc4e@gregkh>
References: <2026060434-finlike-uncombed-dc4e@gregkh>
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
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB55:EE_|MW4PR12MB7167:EE_
X-MS-Office365-Filtering-Correlation-Id: 9c78d983-e013-4349-a448-08dec23388f4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|376014|36860700016|56012099006|22082099003|18002099003|11063799006;
X-Microsoft-Antispam-Message-Info:
	UbPKfav3UOWNgKK12R9jyRQTq0oQRZDsstPSNVK237RBYaDxSkwOby2gl+J15Pk4ndczrorzdXuX4ynAL6W8Nt4xLmQkrwalbZ+m8JUomvaqiO3D8q7miuwlJQMyy8vKbEGws/6zLpNXSORYqKliIr1FRvqdpiheCmk1YdwdpuG6uFVP5+Rx1gVojb7CmHQOJJ7IkxXw4f5WGOSjYVG8M81zwYIatqjv7adU8arA6Kv8sg0bDwWJ/d3qp6blqf2RLGTSlUqw45TrWm3e6A7n+CIWHq3pO4x8MJI5Ztm01Yu6oTZmWXGAeppO5pncaU8jZxLe/KYzFT31v5xEXAH8Pp4ek0R8+Rjq+Vn0sF9pPHnXx3GmZ8VqRlWxQ6x2BSTT0DzYdIBOcuN95+kMR/RKIyS5p3nD1lH3KO65Mdwz+K+VegI4SIW2EAZbWvx1cvbcj5HXV55dPrwTArTnmlooOBTOIqfCulpOANrYCnHXBF2fIebJshQf56ky0ghjGgDkBTx0qOKlRJL4OQGVkHDKU3ItfzR78LrirFfipUmy62bQ9sXIxZ2K3o0+Ha+5THwMx9ClhAR5t2t3A6xcarZ2FWThzkowYTe30VTpmvnNnhvKxzIcE2GdL0J7L6l/uqNiwhnbIK+O573CU+ROLYIC4mTi+ez/XJ3kEg30YU/QlUSuBxMGnwuj5gh9FWdER+5JYDCHHhZ0KUNkwkHMdDpPViIg5G4AMa56hXNKwVQNvUQ=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(376014)(36860700016)(56012099006)(22082099003)(18002099003)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	QfBfT0jV5z6k6bE/+0JYtLCY1gZFLs9ahWlcxeayrtfypyZMn4yhCdeJhyFzns+919MyPVPvY7Ikiy67OXOQIg+5ASmktBpWFsnW9dd/XRLX1x9mWaRWAxlo3/ZpriG8RKj1QcOfsO65p8J1bk1UMorN10TfIqa45b1iBwlNdvRea1EUUxWIqso+cnI88fpZrV6BARg4fsJt0VHvU/xmmB/RbX2AzIUiO160P362ZFOkcU878star5QubNQ3z4YtXjV/QlLC37fz/k9uDRVp5KuoWLULxKE5Ojo2KQDIOfcrFK3tCwOr9tE4NE3rjqVxf8g/2VDh6MXGjTwpqLqu6lJlXDW7wIBBVM3n3Jzt95hL8D4yVgRueSOBtBW7mPzAkyG66L5sd1n4fx7SWiY4qNnjJkjS7hy6JVL9/oK9gxcXH0NfBqmezgFfUbBHW+yW
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jun 2026 12:19:32.7950
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9c78d983-e013-4349-a448-08dec23388f4
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF0001AB55.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7167

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

[ Backport to 6.1.y: keep the host-mode snapshot in the existing
  tegra->lock section, retain pm_runtime_mark_last_busy() in the host
  port-power path, and omit the newer Tegra234 entry. ]

Fixes: f836e7843036 ("usb: xhci-tegra: Add OTG support")
Cc: stable@vger.kernel.org
Signed-off-by: Wei-Cheng Chen <weichengc@nvidia.com>
Link: https://patch.msgid.link/20260505112630.217704-1-weichengc@nvidia.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/usb/host/xhci-tegra.c | 78 ++++++++++++++++++++---------------
 1 file changed, 44 insertions(+), 34 deletions(-)

diff --git a/drivers/usb/host/xhci-tegra.c b/drivers/usb/host/xhci-tegra.c
index 14a772feab7..0f936aeb88d 100644
--- a/drivers/usb/host/xhci-tegra.c
+++ b/drivers/usb/host/xhci-tegra.c
@@ -210,6 +210,7 @@ struct tegra_xusb_soc {
 	bool has_ipfs;
 	bool lpm_support;
 	bool otg_reset_sspi;
+	bool otg_set_port_power;
 };
 
 struct tegra_xusb_context {
@@ -1211,14 +1212,17 @@ static void tegra_xhci_id_work(struct work_struct *work)
 	struct tegra_xusb_mbox_msg msg;
 	struct phy *phy = tegra_xusb_get_phy(tegra, "usb2",
 						    tegra->otg_usb2_port);
+	bool host_mode;
 	u32 status;
 	int ret;
 
-	dev_dbg(tegra->dev, "host mode %s\n", tegra->host_mode ? "on" : "off");
-
 	mutex_lock(&tegra->lock);
 
-	if (tegra->host_mode)
+	host_mode = tegra->host_mode;
+
+	dev_dbg(tegra->dev, "host mode %s\n", host_mode ? "on" : "off");
+
+	if (host_mode)
 		phy_set_mode_ext(phy, PHY_MODE_USB_OTG, USB_ROLE_HOST);
 	else
 		phy_set_mode_ext(phy, PHY_MODE_USB_OTG, USB_ROLE_NONE);
@@ -1229,42 +1233,44 @@ static void tegra_xhci_id_work(struct work_struct *work)
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
@@ -2289,6 +2295,7 @@ static const struct tegra_xusb_soc tegra124_soc = {
 	.scale_ss_clock = true,
 	.has_ipfs = true,
 	.otg_reset_sspi = false,
+	.otg_set_port_power = true,
 	.mbox = {
 		.cmd = 0xe4,
 		.data_in = 0xe8,
@@ -2325,6 +2332,7 @@ static const struct tegra_xusb_soc tegra210_soc = {
 	.scale_ss_clock = false,
 	.has_ipfs = true,
 	.otg_reset_sspi = true,
+	.otg_set_port_power = true,
 	.mbox = {
 		.cmd = 0xe4,
 		.data_in = 0xe8,
@@ -2366,6 +2374,7 @@ static const struct tegra_xusb_soc tegra186_soc = {
 	.scale_ss_clock = false,
 	.has_ipfs = false,
 	.otg_reset_sspi = false,
+	.otg_set_port_power = true,
 	.mbox = {
 		.cmd = 0xe4,
 		.data_in = 0xe8,
@@ -2397,6 +2406,7 @@ static const struct tegra_xusb_soc tegra194_soc = {
 	.scale_ss_clock = false,
 	.has_ipfs = false,
 	.otg_reset_sspi = false,
+	.otg_set_port_power = false,
 	.mbox = {
 		.cmd = 0x68,
 		.data_in = 0x6c,
-- 
2.43.0

