Received: from CH4PR04CU002.outbound.protection.outlook.com (mail-northcentralusazon11013018.outbound.protection.outlook.com [40.107.201.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BE3935AC13
	for <stable@vger.kernel.org>; Thu,  4 Jun 2026 12:19:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.201.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780575580; cv=fail; b=ZEmNnvjOyozSSzyucjE9xtIK/tXkJyNxqNHt/DkVE7/BCHhYCzkmpECEOtfgTA8rgBLAvyHPhB3RMzKG9Wia5jcccULRw7wDzZYMktfmR5K10IAe6ye3HhA1VED5rwy14Vct9q7FBhGno7/T9hNPIm9Mvr2eATBDoieleGKBLrI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780575580; c=relaxed/simple;
	bh=9hAgUMNYXnjgNsq2fWeMkAzd3ucdzfCP6SDIr0ViQBw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bkxLBJV2HH7idtPm2NFCvy8bAyRC4pk27DngFoJkEfOIna4uPCXNqUAqiIMF45ygVW424ziyYV0JV6kJw6HsDfU86mnMJIhxaXHbEIqp+QRnm8sDaCs2sKJiYYqlhb0y7s50g5cNi1RW8aoosw76H0SpF56Vf0MtoIJKE7MNnNE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=LCyaLi1d; arc=fail smtp.client-ip=40.107.201.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="LCyaLi1d"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mw9MJ0toxq7XjiU0Pvg7um48e0jfQWxd3iS9d5I/Nu5ovo3V0RRBl+tKKhIeFkSXjfl8TkgditKAMnqxnDUluJsG1kYPqc3fD+yFtozZrakUHeI0FsO8asvOb/gqjFPgPg1oGYMk2mrndVJd5guPi+Zpy/wpsNWuYRQBIoigtN4muxdsdv3Ord6l6fEF1fYdiGglvnFCaIl7eFHjf0fmWI8/OA6a2wnFCrLR5zLzg1r/hVBFEMWse2blHOd5xymRIt6Xkbt7NA+mGBwJEfCOSOCrGjXYBjezyVmutJZtlCvmDHk0Obbt/vU+47StDyR5HlA2LOvcPVJCTolkC0kv9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5zf0vjfPLXABeaE7o5vA7Xw6q7drtpKFXWps9RO9IbI=;
 b=ZKcg63jdbGWRd5FmTj+8v3szbsdPIcAQALp2tOeVw3J5uDbygiVjyCfFeJt/EJXms48q488mgtz9QBMU3dYn5fIW4WWYkqOLZlPs3jPqKpEBOjirIp/4fqlHVvlSGKRBfRWUwrnpRSbMcz6m6XVny8udBki4qcUgTJyXys7qpZjLoB7swSFpMjFUJhrBSVo7WYD/HBQkwW5kdL72k+Y4L/9P1pWjgHbqHFOQ3HCBz+ZZbdmSOuLi6fXSYeP7FJo+NvPQuEK9gzy2pgBmwGNCLl4OkFDgSaSuH5EbemuchD3GSeMvAIBe62W/ACayhqT2KUxAUHnYNgbp75t1UJnQiw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5zf0vjfPLXABeaE7o5vA7Xw6q7drtpKFXWps9RO9IbI=;
 b=LCyaLi1dC8L16h6C1LEvYd54S4z8ngYBlmv8yJx5MGy2essVov/1JfvPLcP9Fn7NrPN2AYGR08e/yvBeM5l6h2+D62jZYWoTaxUETyx4m4T1U0xagn+RA4ch1/xiSykxw+ypzj72dltvIiaX+H3zBXjVUDkMLVVFHG02eN11M0hx/j4Z9VfshXiMYs/FTD82L0bVuvD5fspHxfA6Uc8in06Q+n+HlYUbCYRRIj5OmzemtyyisrwUGPZgRAvM3MUoAAY41ElOlHd+Z65UCRRjyBvRMO4fviM/ckkoyHPxx4dtAXrI0XMTkUchqXvwnOiHBvzKFsoSYeKOqoRzoBPwUg==
Received: from MW4PR04CA0121.namprd04.prod.outlook.com (2603:10b6:303:84::6)
 by DS5PPF5C5D42165.namprd12.prod.outlook.com (2603:10b6:f:fc00::64f) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.7; Thu, 4 Jun 2026
 12:19:34 +0000
Received: from SJ5PEPF000001CA.namprd05.prod.outlook.com
 (2603:10b6:303:84:cafe::65) by MW4PR04CA0121.outlook.office365.com
 (2603:10b6:303:84::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.92.8 via Frontend Transport; Thu, 4
 Jun 2026 12:19:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 SJ5PEPF000001CA.mail.protection.outlook.com (10.167.242.39) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.92.5 via Frontend Transport; Thu, 4 Jun 2026 12:19:33 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 4 Jun
 2026 05:19:19 -0700
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Thu, 4 Jun 2026 05:19:19 -0700
Received: from 5b171f0-lcelt.nvidia.com (10.127.8.13) by mail.nvidia.com
 (10.126.190.182) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Thu, 4 Jun 2026 05:19:18 -0700
From: Wei-Cheng Chen <weichengc@nvidia.com>
To: <stable@vger.kernel.org>
CC: <weichengc@nvidia.com>
Subject: [PATCH 5.10.y] xhci: tegra: Fix ghost USB device on dual-role port unplug
Date: Thu, 4 Jun 2026 20:19:18 +0800
Message-ID: <20260604121918.150487-1-weichengc@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <2026060435-implicate-henna-b77d@gregkh>
References: <2026060435-implicate-henna-b77d@gregkh>
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
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001CA:EE_|DS5PPF5C5D42165:EE_
X-MS-Office365-Filtering-Correlation-Id: 6810cc7b-d6d3-4dd8-ef07-08dec2338941
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|82310400026|1800799024|36860700016|22082099003|18002099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info:
	kx8Olmvrzh0W55uWOpoJwogl+ALr/yRaqaK4UgjCdRVLrFz9hjQyIhRCloFn5vjs7DQRlWIL0Ucn6Kem4OzCNXMSNT9IZ20lvGnhIDvzYnq/vl44sZw8oHUjiKN5+YY95OGk5SDh14g0CqJMV/TE1gv1xDErh9IYhd+RlFy/THbNB4L34OByjYGI2K0Jm8WsDwz2aMx5g3oijIf3wdU9X5CJMDVB0Ocvw9Rsy9RAbG1njqH4h/HXh8vOL0++wcbNC+xnBYJXARYDz9eL7UUZPFOAcKYYZUEvjr1VHyJA+fqp4JY1k3snDzpSlymNpRT57hnoeEPzA4IhGKI/MnDPN5SF/Hbnp7c5ENKCVLwi0fgzWay+3uV+cYhF+mj8mdW3qKdhBrPDw94dQRnpdNAM3Ibd8j3kGeSUFgVtQREnM/OgU+0cEnL0b1xKu3EFNRo/lAyZ1cNidetJ9gdyz1YNueHhiGwwTrCLwsouUampzBl3cgPPo0k1zHeaqqZPCjSjfuUv/16F3VoS31DjiFNllMZ5dNAOu/HDqf0LZelB/lk15a7W6TjGsJU6bYKAy304XIzRLzSc2d/ZOP+3jjO+mkwNyEZ1orEnr2kKTQ1M+Ufdro8/L8JZ2bgJM+mSYURPM4IW6PD7dFflyBzQ/oWM7NXYufa6EMlyIZAcgMFayEU4aqeC6YXK4w+2r93UDmxJl0uLcQqDdvlxDoAVnFLQW/ICT6/1MwB7wC+Y8NZxAL8=
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(82310400026)(1800799024)(36860700016)(22082099003)(18002099003)(56012099006)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	qXojCIwzRe+ykw995SJ9kkbGaKhmfSc38wUXQotG9OVVBdsbBXVi0tEbHsX80RFrE9nfNJUmfqJ/iGns7hWsdEIW+/yoQXKu2rfzNZloVA8iEC7vCin54Xi/nAt+cFVoZ1qCZjVZompdGP1O53YjxSTTNOXlr8rw0Ax4wXCuIp5dB6oZL0dVgBoQ32JR9D55oQpkK8yAQlSZBv7+0k9dMkm/I4stFl7H8sqBApFqTij7Nia72u5VWsdnlV0MBfM/wAU8ngzWZJRHhCQDqQa2xILRi40UXNuDBaS+xYWooO2Sx7uEe1/51BB4SxktTZNeXFzvthyGoVO0hDAKnNPrv6vBe0GZznFmbFnE5pA+mGX/L2Rxg7+fzLkfKvdWn7PcRl3IWeuIfavwzBl2e+fnbWaqatMUqe0xcoxaUN5+z49Vu7hJv/+UhMpc2FmL53AG
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jun 2026 12:19:33.4911
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6810cc7b-d6d3-4dd8-ef07-08dec2338941
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF000001CA.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS5PPF5C5D42165

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

[ Backport to 5.10.y: keep the host-mode snapshot in the existing
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
index e2cd145ed49..8b4a6eb8f0b 100644
--- a/drivers/usb/host/xhci-tegra.c
+++ b/drivers/usb/host/xhci-tegra.c
@@ -208,6 +208,7 @@ struct tegra_xusb_soc {
 	bool has_ipfs;
 	bool lpm_support;
 	bool otg_reset_sspi;
+	bool otg_set_port_power;
 };
 
 struct tegra_xusb_context {
@@ -1161,14 +1162,17 @@ static void tegra_xhci_id_work(struct work_struct *work)
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
@@ -1179,42 +1183,44 @@ static void tegra_xhci_id_work(struct work_struct *work)
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
@@ -1925,6 +1931,7 @@ static const struct tegra_xusb_soc tegra124_soc = {
 	.scale_ss_clock = true,
 	.has_ipfs = true,
 	.otg_reset_sspi = false,
+	.otg_set_port_power = true,
 	.mbox = {
 		.cmd = 0xe4,
 		.data_in = 0xe8,
@@ -1961,6 +1968,7 @@ static const struct tegra_xusb_soc tegra210_soc = {
 	.scale_ss_clock = false,
 	.has_ipfs = true,
 	.otg_reset_sspi = true,
+	.otg_set_port_power = true,
 	.mbox = {
 		.cmd = 0xe4,
 		.data_in = 0xe8,
@@ -2002,6 +2010,7 @@ static const struct tegra_xusb_soc tegra186_soc = {
 	.scale_ss_clock = false,
 	.has_ipfs = false,
 	.otg_reset_sspi = false,
+	.otg_set_port_power = true,
 	.mbox = {
 		.cmd = 0xe4,
 		.data_in = 0xe8,
@@ -2033,6 +2042,7 @@ static const struct tegra_xusb_soc tegra194_soc = {
 	.scale_ss_clock = false,
 	.has_ipfs = false,
 	.otg_reset_sspi = false,
+	.otg_set_port_power = false,
 	.mbox = {
 		.cmd = 0x68,
 		.data_in = 0x6c,
-- 
2.43.0

