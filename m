Received: from BL0PR03CU003.outbound.protection.outlook.com (mail-eastusazon11012007.outbound.protection.outlook.com [52.101.53.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F06F23B19B4
	for <stable@vger.kernel.org>; Thu,  4 Jun 2026 12:19:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.53.7
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780575580; cv=fail; b=PeaTWLQC0DKnaX5XjdEuMcjAl3xK12ixxU4CGtO0IHNceSFtPxPIl5RUxvUhxmYH7qO4/SXjS6RgHjif7addrJFc/YGXuKxT+0TS83zsIffn5yXbYVuI9R3nDOT4aYVdO9aOcE6rqQkq9JEPvzsk087QW8jhoEx6JCliDT790YA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780575580; c=relaxed/simple;
	bh=pcdkDZTTKYvjg3pvUw3q+bYWoWbup6SUTaDky9MQ59Y=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ENe8GlRNZIdrNqmwd4dZKItqZvQAA7nQOj2hDUbgL9xfi3gQ9/t53PToglKc2vHX024t8nPd4vzKjw1Hbb2EfGp89vjYNZYvz2DqV8mU+riCQyuIC20C/IEQQlHe8EPKmpiHsTGJkSWhF7uV7meLYiKh6I1SyTzdi9pCSz/FnM4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=OsXnllwO; arc=fail smtp.client-ip=52.101.53.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="OsXnllwO"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FxK4UY7bwU4NqYEFofk6FIX1dHyfpBU/xG22pBn7Eca66uaQSrziYWJ3oTgIvzC6fn5KxUJ3jTkwihMm++uIDVC5m7PtJJxNoUJZlVCibfKZ+IFWn5F3isHWF03UdjMGJcHHAinpL2yDR731lgzVhJU5BDAmg2kQXtDYFDnNw17CQMt6HFJfRBPb1uuo7TtIc8LsvDXBphF5zmcH5Fwa65GvoTREnjgiohTeNB4rvMW+LsMgtz8CCFYdgIyQ8fP9Ctxzj1Gh1MBRtcOYxpiqtrFq+fkyRa1lpxOkqYe87Y8Nr7BTBmuYkqpMpC/KAeSczDNhpXZxceZPUI+YAU7dHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=u6fjdbIVJkzOFzMa5NaGozIzouco8iKRxycQNgE3Yxo=;
 b=bA1EwTM5qEFP8jIJyJjIdDjGpW7c2ypeAe3rQ+vZwEKB4+JjfBMJVcPWbr6OEeMkt7Zl4BQxEviSDQyRB2w7tnOpgnLVZgOlRDAxWpzePNY79xIPgphjDpIt6BxPuh80aPRnqblSsO2xdmVSTE6XVqO2hGBlvwCMimP34zGqt32ePE+RCRsj60iQs1b+2tQY38WsDO1j05qwoXlae3BkYWMBiyob5VQsITlfU0lKeCkASWKfK3zHuv7+NIu3ypN3ZsC3Om1i0LNEqTChNbkKsvLwd0ISQhdl5r0bWldbvI/tsLhUt6jgWFk4kue9yBUWfNl5KEJ16qVfELf+T7QxgA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=u6fjdbIVJkzOFzMa5NaGozIzouco8iKRxycQNgE3Yxo=;
 b=OsXnllwOj2+6zH8EUaZWhb1dovRe37rFP+I6vrzT1qCu71ym9uZhPaKNtNbRL4YmiWh0YQTPKVmsjIY4kQQNywuBw4sCDZw6vFqDZRXnWWjFW02PnyEuK6NkNgACsbTGaxCUQBCeEHmH5Maye0RCVmxSvyTdYTu7hSqpYckDUzVCc4d+RNsH0HhgBipiclNAY4NhL8wVx/BmxR/HkB8Ml4f+8ELbEIquFdDCLS7uhCA3V/Bx77uhIXFdmD97rf/vbKoL3yUEv3b+FgzkrEZl7GaauTyMIJoIHNeOaT7Oz3wame0FD81jAsCtAhQNQIkZYnl77xgk0ErSsL3LlNdOjA==
Received: from BY5PR03CA0002.namprd03.prod.outlook.com (2603:10b6:a03:1e0::12)
 by DS0PR12MB7704.namprd12.prod.outlook.com (2603:10b6:8:138::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.7; Thu, 4 Jun 2026
 12:19:31 +0000
Received: from SJ5PEPF000001C8.namprd05.prod.outlook.com
 (2603:10b6:a03:1e0:cafe::51) by BY5PR03CA0002.outlook.office365.com
 (2603:10b6:a03:1e0::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.92.7 via Frontend Transport; Thu, 4
 Jun 2026 12:19:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 SJ5PEPF000001C8.mail.protection.outlook.com (10.167.242.36) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.92.5 via Frontend Transport; Thu, 4 Jun 2026 12:19:31 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 4 Jun
 2026 05:19:17 -0700
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Thu, 4 Jun 2026 05:19:17 -0700
Received: from 5b171f0-lcelt.nvidia.com (10.127.8.13) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Thu, 4 Jun 2026 05:19:16 -0700
From: Wei-Cheng Chen <weichengc@nvidia.com>
To: <stable@vger.kernel.org>
CC: <weichengc@nvidia.com>
Subject: [PATCH 5.15.y] xhci: tegra: Fix ghost USB device on dual-role port unplug
Date: Thu, 4 Jun 2026 20:19:16 +0800
Message-ID: <20260604121916.150415-1-weichengc@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <2026060435-suitor-humiliate-81e2@gregkh>
References: <2026060435-suitor-humiliate-81e2@gregkh>
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
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001C8:EE_|DS0PR12MB7704:EE_
X-MS-Office365-Filtering-Correlation-Id: 32ed806c-eca1-4845-308b-08dec23387d0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|36860700016|1800799024|56012099006|11063799006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	suyrf++ndyApBW/DMVaLeHJ+kscjCMpfcJH9I9lEicqxUW695iPq6WRYlehK9unkHEgeEltUOV5NmwLzmIQBxxCGXoPnC+YacN4hbW4oRhwV8mvIFTGY3M4dH0mGsq1CCjBPFXcm7q/2WDXYvB3M30G2TJzqrOkmsk3JN5opQ3RS99v62DSNmEHCIiJAN39nhJ4DsQHVYKCJz4VJa5y/INmvoVHTwR0dpbYwf1FTN0CzDL2Oy+W6X1aZIKBnfABLrDTLkqJlWzzrxfGBeWsVHvWWgEl6E4EjyOfl2HzSliESqyfQp6kav64WpsRjsTnYNrGK0TWJaY5PA3tE3h23NU218yEgHFyH32NWaMdpVuy8kcEnbBOVuzIi6R4UhcD3AYWeKs8uO5evrYGBzAkvMSAgsV67k0OTjHdzAIuUWlMlz/JD2C17dUXUGk/Z1vZjApmB0Dz1Yf0DnB/ImTjmTICcWmAXF7a2XEIjjSuzGgtwbYM4VDdCHvY68sD9k2OkSLsGfTt3aHAUl405kkCXK4A7uwKFX3S8jBdJTd0h0rE9ilKoyw8Oepyc0xtOGQbeNcbwZbKwtOnSlibxKMlJjHiZVzWaDR1ZmFDz/W3Jm1d24V/5RMzOIKdnZUjR1dsBH7DalNdNt8ql3RPozwUwRU3QUsPH5qJyzbhmcTXpox5Wq+NGCFq+x7GhNkWuKuv+zAqvLzQyjIoCExJMYMYV/DfNBhuehuHqjQdflm0G8iQ=
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(376014)(36860700016)(1800799024)(56012099006)(11063799006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	krESeLLntQYJwFX6RqF8QzioLhBXSY011AEK2dEmfNB+egemIvdiwLuyXTe6iB2hYwvn00W5Y3JLZSgqjd4FzuoLX/XmSHbOtkOpomN60bqilz30cb8oYyg7KgmNGsGEc4wPaFlXzndPvSVILqYDam/OeEXVRNljZPAbOyJXBvoJLVg27l2PaFQIYrYDj7pCIRAfvfupAqz/lYupnIjR9PO3dOfKG6ZG4sKPmIv81t3NnmAvbeBCDvzHeSyAPoChGVIEJ/ah2gHM8DZe4ChhhQQPbIOlygLqxpgNlek1IWQkTpFRSs+JB9074W6Gh6nLCmqxuYGlDM7kBtL/1LqWVbyxhRmHtu0YxGTIYLJA1UuNUf/B96g8O0Ievi53dm90pFbUpE8P1g7YGhgOcyMMZQTyf7nVlqqjjEbX064rSLKx2oxzu9w6bzHDUhb4jK97
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jun 2026 12:19:31.0689
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 32ed806c-eca1-4845-308b-08dec23387d0
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF000001C8.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7704

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

[ Backport to 5.15.y: keep the host-mode snapshot in the existing
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

