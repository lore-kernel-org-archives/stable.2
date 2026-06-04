Received: from PH7PR06CU001.outbound.protection.outlook.com (mail-westus3azon11010054.outbound.protection.outlook.com [52.101.201.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E877426EC9
	for <stable@vger.kernel.org>; Thu,  4 Jun 2026 12:19:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.201.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780575581; cv=fail; b=kNUkzcz8LQ13sck1RGNlrwkkwB4sSEieR7kXgy9mA4dGt7wF8gw09yQcboE2nEv5Td0WaAqmFwMyvfEn3qLhO/2IYrHF76aPgyjN7+v3or7XCdAaqU56UtbLvAmDyooY+bypTycAIavRnPyUzamGX/nvG6ZKqaddg9GrCiyUI5c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780575581; c=relaxed/simple;
	bh=Rd4Xq8vgTRc1xexClfGL0gmerIXyd5zvNxn5xt6t5bs=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=j2GXdrGJbkbOkIoc+xP/vYNKc0ARZM/7TgtVmRGH4HVyMVyFxYkZmCcJzV9eg9/KBJxIjCOlzCIi0QDIR/bDYh9bY613Y8cY2Bdrr1msA1sQhoZBPv4W015+f9hpbrEeftPmJ4MTQm+X5IId0ZeNVqT/1gKzW52dxm6BOuW1XgY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=AWXwSCpd; arc=fail smtp.client-ip=52.101.201.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="AWXwSCpd"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DAlcqRSIhPlmxGrZJzEBuPvMuDJGTUva6h87Q52kbbx3iCqLwZ/N3RVxqxOJAJQXe7tylbQyTwnc6JVtYtKtRyoK4BypUmgFZPoet19D6HySPXecuYQbLZ+293QcQccdTWQw1gFf2i370AgAEkoiF6XvQvs/pQjew8hU+iyN4dW+u5ULvfVUMTQa28ApY66gbRNi5tjfokTnVlQrVCkG+lW8w9e3eME7FEzmws2ak9witI8itcytHe7D7n5i95tgmgQ0eTAkdtG0LrhqeS7hTeDV4oLHc/eMm3EUO2Fw78O5FfvgrzDcgGUZ28laJHElI1BD1VcaQefS5gTwH3D7Dg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2d+UTQuqfNaBuLkv8qKrwdsWEEam4eqKyqHENK7vTI4=;
 b=cdz5zsaf7E0VnDA4acLGWjTzDWkokq+Ph4stn9PTyXWx6RngZLpFzi0RugEynMgx5m746qZQ/G/2/PgoCPzpu3tMO0NoC5iB9Tcj1MIuq7hPgwp56nJq7Nz69sDjfw3x94lizMd4aSHtVv6qzfxzKajn2AkI6yLTJ7OscGPvTbVwVp8J3TKxJYB6TvfoOQOsA+Rp8JCpRP90aFFDIq85fyahuPgBxfO6K2W0g6b8lQ4oi7MhtgGPBSkmYa+h/X1Vq3MroHghm/1P5nGjMr6bz5MuJUhJztyYSarieVHE79FbaI1AHN9ITqk+ja0fLq27BGskHTe+cx0iVTpvySTTPA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2d+UTQuqfNaBuLkv8qKrwdsWEEam4eqKyqHENK7vTI4=;
 b=AWXwSCpdL3CzH5pgLgyZodGdkEYr3Dt7ZufDUpVlAXU5W6pFfOXaltr4hfWOdXWBIIZ9TqBA9eF/kKHiDkCEWc+MsFNr2COpheh/5GGaoqPr6b00ktykTM+nW8uykbAOIJC3GmrhGL4GA0yGj2wM+RMGzVkugJ90wrJbNPzGwsa4c0ilZqU8U0x42WxxnSfegx31TFGYdlN9ngpsaV3XASYRjC1zsviMDzkEstoeVHxZZO/+pXYKib7YL+2KUXRrtjqlCI+6u+Jtfk5+vTfbR28Wa23P/MpPkU/TozEdKbJ33icq9OFhYdo1K/k8hxn20dJ3/te271mmVN1xH1H2HQ==
Received: from BN9PR03CA0710.namprd03.prod.outlook.com (2603:10b6:408:ef::25)
 by PH7PR12MB5808.namprd12.prod.outlook.com (2603:10b6:510:1d4::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.8; Thu, 4 Jun 2026
 12:19:30 +0000
Received: from BN2PEPF000055DA.namprd21.prod.outlook.com
 (2603:10b6:408:ef:cafe::37) by BN9PR03CA0710.outlook.office365.com
 (2603:10b6:408:ef::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.92.8 via Frontend Transport; Thu, 4
 Jun 2026 12:19:29 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BN2PEPF000055DA.mail.protection.outlook.com (10.167.245.4) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.113.2 via Frontend Transport; Thu, 4 Jun 2026 12:19:29 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 4 Jun
 2026 05:19:13 -0700
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 4 Jun
 2026 05:19:13 -0700
Received: from 5b171f0-lcelt.nvidia.com (10.127.8.13) by mail.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Thu, 4 Jun 2026 05:19:12 -0700
From: Wei-Cheng Chen <weichengc@nvidia.com>
To: <stable@vger.kernel.org>
CC: <weichengc@nvidia.com>
Subject: [PATCH 6.6.y] xhci: tegra: Fix ghost USB device on dual-role port unplug
Date: Thu, 4 Jun 2026 20:19:11 +0800
Message-ID: <20260604121911.150179-1-weichengc@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <2026060433-palace-registry-511c@gregkh>
References: <2026060433-palace-registry-511c@gregkh>
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
X-MS-TrafficTypeDiagnostic: BN2PEPF000055DA:EE_|PH7PR12MB5808:EE_
X-MS-Office365-Filtering-Correlation-Id: aac32fe3-0225-450d-1362-08dec23386ef
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|376014|36860700016|18002099003|22082099003|56012099006|11063799006|13003099007;
X-Microsoft-Antispam-Message-Info:
	afICvLmnL+ITPWdvGrrgrPCQ6v4+GHyzr4ZHv2Uzj4nXlMIjlnD6Wg4OtZc6PR9kDAThzmw+DkNkHctEbwVye4C3+uXbzZf40BUBkAO2qMvHYdq3htBzAO+bPjw9pw217XFO93DN4t2BErKzA5sUMRe0u1cvhdyUfuneTBnUY4/G6tkP4tcBGWjJ8ZuIxrKw0enTHcQAcyXa9rqQwaVzCETaZk3QQkjtfr/Wo9EO6ewLavoU6xf9Th3OVEqbIOzZdKg7hs1sOqhSZVz/JMI9uONkV+TuiHe91bhJyXWpyMy9TnfAxLThI/PkOlTM8hl3ytq3VfRTxebE3x6ugsT+nXsjpY1TJ2sRQ6mLy/4chhp0KzmkOGmjSFdNDKXyuoNiTnDbJ106d1oXbQRao+ObW9zz3CahuJcN7uyIkeJj/BabDFp0o6cNZETM75jmKpgIeeZG+6ARCG0CB4lDPav9UHSg1aIeIulHSXegUPX23iuUGtZL1fFJsuRNdrepZEIYyUaGJIhTfx5NIHKRIlySLLqAkwv2zOirAf0yV8sYD5lhcsBPJr8/q67PjNXj/z4W4Om3sERLjX9BjCc3gwjKR88ZYt8wGyzwE20Qjz6ZOnWxMXQTYZST1j0IvSJKCu+z7/t6GlwP6rQBIB4BCC9a3s1S0TSackkd64aihBwP3/JEXkALO4jnmDh93E2RUWFecKykhOk7w4b6ZyOpFyWBgZ1WSAIlOsP+1gBnBq5lZh0=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(376014)(36860700016)(18002099003)(22082099003)(56012099006)(11063799006)(13003099007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	4R+EdDpdKK19XQYce09Pqc3vofDXs2hyPp04wyb4UoC7ady6ai4xsB/KVcc1mOL8WJ/H+++Y1zYT7oFS9hX7kHBUeWO9SLMm5n1SDO2ZOyUtPoQMm9cNdXb5sMdpNze6kmtMSVmK4xCWEohcgPwJxiGxFKSML3LzKjwrDu3hxqXBi8wbssATlxoURURENtx71NBK9hT6yaIkLMd163mrZWQBVXd5CuKDb5hZMVPcwkqKtX4GhHB3ne6MvHQfWALDXJ4NETQqkbT4/P8rfecE7B4GtdDKVyNlEmFz9okdEs48c+14K+if1K7/AwjOV65wmIGVH8K9GtXAeuQNUEQ5Esvj5ng9bVzy9DXsRTEC7Kee6KL7vAGel0pdpnuXcYzG3hgOH4hHCOWgkG/RWC/aoYMhjAFjBscKYf4ZfJ6lSIpF6iqIkq0pwby1f/QOL2LZ
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jun 2026 12:19:29.3367
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: aac32fe3-0225-450d-1362-08dec23386ef
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN2PEPF000055DA.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5808

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

[ Backport to 6.6.y: keep the host-mode snapshot in the existing
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

