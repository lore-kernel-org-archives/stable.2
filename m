Received: from CH5PR02CU005.outbound.protection.outlook.com (mail-northcentralusazon11012013.outbound.protection.outlook.com [40.107.200.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23BA935AC13
	for <stable@vger.kernel.org>; Thu,  4 Jun 2026 12:19:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.200.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780575576; cv=fail; b=YObw+WTwM79E9HZiU2L72/BZRyMQU+IONDpFVqYwbfm5lVV9rvCcflSlg7J/eLzgrvfcVUDLjci0kElrGuBpkHSXUIxWe8RuO+ShjZhzb/+rMbfIuPpmeDckdhP0X97vEvZRV7sl9PCPI0LK23cuH1f3lhIXx2e/IVFx7DwfM+M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780575576; c=relaxed/simple;
	bh=CT9dELPCt67yVC0d/n4bNvisQVJ9l6L0IiG3n8ljgUI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fndgWC7DPAh7wfSvQADBsosU1UD99Hj1XxwjU/Kr1KmW1g8hor80WE9u7sDBMSD8ghBorQrI46gmYXbGhcflJUKsb/JuA+CpytkIv3kGuOEfkTf3wNrdJfGS3wknP57I+wr+BLkBCEROi7MdgvKdBiAwf1vPCIHhxcukSEeAhe0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=kgk8pYXE; arc=fail smtp.client-ip=40.107.200.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="kgk8pYXE"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ACKhtlqBXvIo/w79c/NGZgzuCDlRt9juTXinM5cVKdafRwIuIpw4yPT6KGqiZzYe7TmTgYlriuJKd/oXmYSsKdW6PXm4p0TdxIYtr/bMjDxX98G/ZHfdUfeLQeR9xNq948oD82guK5nrVVy8M7Adpn/hu3aCjfKtWLNrF7xETtXsmhzzmFrHG7/D2jkqFKsM8zHzzUvzVdpPCRs5kVYbXFap/YOxiazytUwCtjpuTtyoxoBULAVrYqr1M79ecD1hO2scqlxqcunJERKw0V84l8XYexEmSdA5+WSN77+CWi5mdi/fKfEwt85KLzOSLYqSf4q/Wu/lCV5aGNFe3XxNMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xXDLMI0nQN1ZjEni6Z03o7n34qn799oUB/Nn14W79GA=;
 b=enVEjWiZod+N19eeK06A7xEsey3qDQqU+Lk+U3zXb+RWYK5o9us2+twAWxekJWAZQjD1X7YExiz9N0cTDRjDHMTe5dL3h85YadYOns1bcSyvEzlMiOokVyO76MKAVHsAcHaBbmtpiTa59xH5pDA8HcsOTLbT18dzXJhuhoUhOnsf8QKBpOhQxwE2k1B6OguqtA6tRabXZbf8kKmFWcB2Ntj69STwDw/Pnye6iN36Ui/mzpiUCFNwSnBHBFlAetQ3n35hG+zcCGhehRnA0P30Re/y5aS+pyFojUyOHF59xzAhNb8rIB4LcrGDJ/G1DgnX1ecmWojiOYIheykklJcAOw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xXDLMI0nQN1ZjEni6Z03o7n34qn799oUB/Nn14W79GA=;
 b=kgk8pYXEB1Pi23IpUKKeBxDB5szdzXkf2rJGPwoKao2i1e6p0NQ8VsNVF9flUn29AgmPFmbBUA51iGlri7Jw68aibjqh7TNhhjTKO8bXhENuxg73oqoJbu0avpSWK+FqW9qlttoKZQB/TTsKLuUNKZsPm4hfzxkvNd6OqjnTv8o9dN39wPO6glhI9EAjMheff5i08gA4xymUBCAvtWos/V+VUDrCn3ZzmvA76EO1YcxLKtsPbVfiWrx2g1EcbKO6BfOuvR1Os8eVyJS3TWzz/2ANiyxWQEPL6pbAczL83RW/2LuHZ0cvKKJ7RTM8CGRfGitvM+cubOjRRwQodMIxDA==
Received: from IA1P220CA0010.NAMP220.PROD.OUTLOOK.COM (2603:10b6:208:461::7)
 by CH3PR12MB7547.namprd12.prod.outlook.com (2603:10b6:610:147::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.7; Thu, 4 Jun 2026
 12:19:27 +0000
Received: from BN2PEPF000055DC.namprd21.prod.outlook.com
 (2603:10b6:208:461:cafe::f) by IA1P220CA0010.outlook.office365.com
 (2603:10b6:208:461::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.92.8 via Frontend Transport; Thu, 4
 Jun 2026 12:19:27 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BN2PEPF000055DC.mail.protection.outlook.com (10.167.245.6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.113.2 via Frontend Transport; Thu, 4 Jun 2026 12:19:27 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 4 Jun
 2026 05:19:11 -0700
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 4 Jun
 2026 05:19:10 -0700
Received: from 5b171f0-lcelt.nvidia.com (10.127.8.13) by mail.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Thu, 4 Jun 2026 05:19:10 -0700
From: Wei-Cheng Chen <weichengc@nvidia.com>
To: <stable@vger.kernel.org>
CC: <weichengc@nvidia.com>
Subject: [PATCH 6.12.y] xhci: tegra: Fix ghost USB device on dual-role port unplug
Date: Thu, 4 Jun 2026 20:19:09 +0800
Message-ID: <20260604121909.150108-1-weichengc@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <2026060432-overnight-groin-0e8e@gregkh>
References: <2026060432-overnight-groin-0e8e@gregkh>
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
X-MS-TrafficTypeDiagnostic: BN2PEPF000055DC:EE_|CH3PR12MB7547:EE_
X-MS-Office365-Filtering-Correlation-Id: 4d53af93-1ac9-49d0-1ec3-08dec2338593
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700016|82310400026|376014|13003099007|22082099003|18002099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info:
	aP4JCUMo7fQdINRBHxGmAY+6bYfqCUzao1ZsIUibTx/GYF1hzULkn9VWV+AkflupNPNHDvg8Mt0WgNWtmRScATVo2C8WgsRkLtf7w5Fw4ESDxFOBZmGneBnSAJhe/uZtLoawXdHhKAEtd8cbQaYY+8qFfhujklEUFHLYrpMF9y3F20GUcyrcZGlo8obc2V3KVHJwQtMtTIOnTwO2poC0TG03YntJF3JqQ9SAQg2R9pYoa4+Q5xogZBOw0/oBD84OyxAhgX48ejlmXC1JVEk8G+h53seSl+vRPwm4VcRVcOXd8wRAkyti/ul7ZbMNlQ/V3NyvTHzxDHV2muwvvHfeYQkiDzPo0Ys4k1uojU8NFllGbrLT/T+cYnkNLcJHQ2fh+UTnoj4I2+tliSifByhcE2mNaxZjm0PpMUdRsBFsuL0sv++33uEDIdIMQ4wPf2rEw3QJxk0rEtKOF/BbGqGpNr7zzgLrba2zSgVHk3Om3CIvO4S8T793BLN53cKwxzcuQugw8MSy0G5EDh2BGAQDPmsQ7A0jDQ5fBN/Pexehpoovvjeb1xTLY6Cy+w23DGHPmSTVzCmbuqWupGjIXGL/9oUBaWAAumRllR+7CHZDNR910tVN6WZAqPgkK27PVzyWHfbvP6SrtU79IOupthUwzKjLjl87Dwc9Q+YMq3jBlZSpR4LnvDI7k5GbhqDdcZFE5UugZAaEqkbL2UMq+h0lIML0jxCMHK9GqHVtIMImkjQ=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(36860700016)(82310400026)(376014)(13003099007)(22082099003)(18002099003)(56012099006)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	U0GbeXsIpYIRRP4I7nvPEpV1wD7o4Uv/+pmaxzv1GzsigA6ShBCyhZC3+RORyiBnM1Ngt8nyQ1wSspLRFdbEohP3w+YCEL7SRPejiOhqBL8GI1YqcYhV++xucG5MBNY8Ogo/uGJkYbdWr4cVdv6X9HDGWT55lB49DX2QZTD+L4IQyzK/41BOHvbzpUalhAvH5WS5XUs6iiPyw20xsmdV/5WjsLUYSBQKnfPN9oIwJM1MTA8rpWgYsUR/C4EUjgQT0XeMvRfrysyjf7xDtv0S3LcNzdYO/LoEhkIvVRLKCl2yf238rQ7XhTGZDd0xXtf+4wGGR/3fP1APHjLf1S0BNbRDgDR/pYrHCMZj88zzwzTLe3fF1KtTyuG5sgsl7Q5Nj4cFvCY3YvdHwcfU6gXnhBpuMlhWJE48rZkKvjkBeALhQ5JwkQOssQp4UJwggzBu
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jun 2026 12:19:27.1308
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4d53af93-1ac9-49d0-1ec3-08dec2338593
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN2PEPF000055DC.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB7547

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

[ Backport to 6.12.y: keep the host-mode snapshot in the existing
  tegra->lock section, retain pm_runtime_mark_last_busy() in the host
  port-power path, and resolve context around the SoC ops/Tegra234
  entries. ]

Fixes: f836e7843036 ("usb: xhci-tegra: Add OTG support")
Cc: stable@vger.kernel.org
Signed-off-by: Wei-Cheng Chen <weichengc@nvidia.com>
Link: https://patch.msgid.link/20260505112630.217704-1-weichengc@nvidia.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/usb/host/xhci-tegra.c | 79 ++++++++++++++++++++---------------
 1 file changed, 45 insertions(+), 34 deletions(-)

diff --git a/drivers/usb/host/xhci-tegra.c b/drivers/usb/host/xhci-tegra.c
index 89b3079194d..2eb1aa25be1 100644
--- a/drivers/usb/host/xhci-tegra.c
+++ b/drivers/usb/host/xhci-tegra.c
@@ -243,6 +243,7 @@ struct tegra_xusb_soc {
 	bool has_ipfs;
 	bool lpm_support;
 	bool otg_reset_sspi;
+	bool otg_set_port_power;
 
 	bool has_bar2;
 };
@@ -1346,14 +1347,17 @@ static void tegra_xhci_id_work(struct work_struct *work)
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
@@ -1364,42 +1368,44 @@ static void tegra_xhci_id_work(struct work_struct *work)
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
@@ -2497,6 +2503,7 @@ static const struct tegra_xusb_soc tegra124_soc = {
 	.scale_ss_clock = true,
 	.has_ipfs = true,
 	.otg_reset_sspi = false,
+	.otg_set_port_power = true,
 	.ops = &tegra124_ops,
 	.mbox = {
 		.cmd = 0xe4,
@@ -2535,6 +2542,7 @@ static const struct tegra_xusb_soc tegra210_soc = {
 	.scale_ss_clock = false,
 	.has_ipfs = true,
 	.otg_reset_sspi = true,
+	.otg_set_port_power = true,
 	.ops = &tegra124_ops,
 	.mbox = {
 		.cmd = 0xe4,
@@ -2578,6 +2586,7 @@ static const struct tegra_xusb_soc tegra186_soc = {
 	.scale_ss_clock = false,
 	.has_ipfs = false,
 	.otg_reset_sspi = false,
+	.otg_set_port_power = true,
 	.ops = &tegra124_ops,
 	.mbox = {
 		.cmd = 0xe4,
@@ -2611,6 +2620,7 @@ static const struct tegra_xusb_soc tegra194_soc = {
 	.scale_ss_clock = false,
 	.has_ipfs = false,
 	.otg_reset_sspi = false,
+	.otg_set_port_power = false,
 	.ops = &tegra124_ops,
 	.mbox = {
 		.cmd = 0x68,
@@ -2643,6 +2653,7 @@ static const struct tegra_xusb_soc tegra234_soc = {
 	.scale_ss_clock = false,
 	.has_ipfs = false,
 	.otg_reset_sspi = false,
+	.otg_set_port_power = false,
 	.ops = &tegra234_ops,
 	.mbox = {
 		.cmd = XUSB_BAR2_ARU_MBOX_CMD,
-- 
2.43.0

