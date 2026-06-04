Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B03235F5F2
	for <stable@vger.kernel.org>; Thu,  4 Jun 2026 10:34:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780569276; cv=none; b=Refz5+kQcmtGlUM4PaQh3mKS1dOyPDx8WZ3A3NhGVqvWzo+pfsjLzGaqeTHf3MxpiL9bH95jQnByge8bJMohsAeKVoaBeGELqczBT/jFNmtUfYeZ7i6U7pV1VhVjIyGCV75EKedZPLG9+4OFFgB+LQxnk+bjLUeJ8YbhwR2+Bvo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780569276; c=relaxed/simple;
	bh=UUAkcV9YKXcTGzVgSg++TRsJEIfcjpih+roFhr4gnK4=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=tj1klAJS1n47ZD950DS/QW6FJJ6ziD7oQ4l5YlhYQZp/sdIySm1aLTks5Q6nbUJYJlh45cciW870gc8eAdXKbOB3kMvmB5C3/v9NtRtmlmZ4xrJZgDUKLUw0VQFMcnS8wv1OTa9wYXBKuZQk2H5hJl6PIlAUr1fPnwfyLjZYBdw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=VIq8g7bG; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="VIq8g7bG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 705291F00893;
	Thu,  4 Jun 2026 10:34:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1780569275;
	bh=OfbdKGZX/6PeZPje5t8CXXHScuypmNd2iPj1PBYSN2E=;
	h=Subject:To:Cc:From:Date;
	b=VIq8g7bG7oqtT626hzm5wTbU24zLqTa/VU5/AS8g3qlUqHDY0nwc5SHHQ3NkTDATI
	 1OVDhBnZC/95+N/WVV0ybgnKOIuOZ5TC68eiGLxsylYOHhwzcjvror+UnxtZ0HCzOM
	 908Dx52XJCr0fNxw7NU3qtnL1TMfR6VZAyFfOZPo=
Subject: FAILED: patch "[PATCH] xhci: tegra: Fix ghost USB device on dual-role port unplug" failed to apply to 6.12-stable tree
To: weichengc@nvidia.com,gregkh@linuxfoundation.org,stable@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Thu, 04 Jun 2026 12:33:32 +0200
Message-ID: <2026060432-overnight-groin-0e8e@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.12-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.12.y
git checkout FETCH_HEAD
git cherry-pick -x 5a4c828b8b29b47534814ade26d9aee09d5101fc
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026060432-overnight-groin-0e8e@gregkh' --subject-prefix 'PATCH 6.12.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 5a4c828b8b29b47534814ade26d9aee09d5101fc Mon Sep 17 00:00:00 2001
From: Wei-Cheng Chen <weichengc@nvidia.com>
Date: Tue, 5 May 2026 19:26:30 +0800
Subject: [PATCH] xhci: tegra: Fix ghost USB device on dual-role port unplug

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

Fixes: f836e7843036 ("usb: xhci-tegra: Add OTG support")
Cc: stable <stable@kernel.org>
Signed-off-by: Wei-Cheng Chen <weichengc@nvidia.com>
Link: https://patch.msgid.link/20260505112630.217704-1-weichengc@nvidia.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

diff --git a/drivers/usb/host/xhci-tegra.c b/drivers/usb/host/xhci-tegra.c
index d2214d309e96..d5637b376367 100644
--- a/drivers/usb/host/xhci-tegra.c
+++ b/drivers/usb/host/xhci-tegra.c
@@ -247,6 +247,7 @@ struct tegra_xusb_soc {
 	bool has_ipfs;
 	bool lpm_support;
 	bool otg_reset_sspi;
+	bool otg_set_port_power;
 
 	bool has_bar2;
 };
@@ -1352,12 +1353,13 @@ static void tegra_xhci_id_work(struct work_struct *work)
 	struct tegra_xusb_mbox_msg msg;
 	struct phy *phy = tegra_xusb_get_phy(tegra, "usb2",
 						    tegra->otg_usb2_port);
+	bool host_mode = tegra->host_mode;
 	u32 status;
 	int ret;
 
-	dev_dbg(tegra->dev, "host mode %s\n", str_on_off(tegra->host_mode));
+	dev_dbg(tegra->dev, "host mode %s\n", str_on_off(host_mode));
 
-	if (tegra->host_mode)
+	if (host_mode)
 		phy_set_mode_ext(phy, PHY_MODE_USB_OTG, USB_ROLE_HOST);
 	else
 		phy_set_mode_ext(phy, PHY_MODE_USB_OTG, USB_ROLE_NONE);
@@ -1366,41 +1368,43 @@ static void tegra_xhci_id_work(struct work_struct *work)
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
 
-				/* reset OTG port SSPI */
-				msg.cmd = MBOX_CMD_RESET_SSPI;
-				msg.data = tegra->otg_usb3_port+1;
+					/* reset OTG port SSPI */
+					msg.cmd = MBOX_CMD_RESET_SSPI;
+					msg.data = tegra->otg_usb3_port+1;
 
-				ret = tegra_xusb_mbox_send(tegra, &msg);
-				if (ret < 0) {
-					dev_info(tegra->dev,
-						"failed to RESET_SSPI %d\n",
-						ret);
+					ret = tegra_xusb_mbox_send(tegra, &msg);
+					if (ret < 0) {
+						dev_info(tegra->dev,
+							"failed to RESET_SSPI %d\n",
+							ret);
+					}
 				}
+
+				tegra_xhci_set_port_power(tegra, false, true);
 			}
 
-			tegra_xhci_set_port_power(tegra, false, true);
+			tegra_xhci_set_port_power(tegra, true, true);
+
+		} else {
+			if (tegra->otg_usb3_port >= 0)
+				tegra_xhci_set_port_power(tegra, false, false);
+
+			tegra_xhci_set_port_power(tegra, true, false);
 		}
-
-		tegra_xhci_set_port_power(tegra, true, true);
-
-	} else {
-		if (tegra->otg_usb3_port >= 0)
-			tegra_xhci_set_port_power(tegra, false, false);
-
-		tegra_xhci_set_port_power(tegra, true, false);
 	}
 	pm_runtime_put_autosuspend(tegra->dev);
 }
@@ -2553,6 +2557,7 @@ static const struct tegra_xusb_soc tegra124_soc = {
 	.scale_ss_clock = true,
 	.has_ipfs = true,
 	.otg_reset_sspi = false,
+	.otg_set_port_power = true,
 	.ops = &tegra124_ops,
 	.mbox = {
 		.cmd = 0xe4,
@@ -2593,6 +2598,7 @@ static const struct tegra_xusb_soc tegra210_soc = {
 	.scale_ss_clock = false,
 	.has_ipfs = true,
 	.otg_reset_sspi = true,
+	.otg_set_port_power = true,
 	.ops = &tegra124_ops,
 	.mbox = {
 		.cmd = 0xe4,
@@ -2640,6 +2646,7 @@ static const struct tegra_xusb_soc tegra186_soc = {
 	.scale_ss_clock = false,
 	.has_ipfs = false,
 	.otg_reset_sspi = false,
+	.otg_set_port_power = true,
 	.ops = &tegra124_ops,
 	.mbox = {
 		.cmd = 0xe4,
@@ -2673,6 +2680,7 @@ static const struct tegra_xusb_soc tegra194_soc = {
 	.scale_ss_clock = false,
 	.has_ipfs = false,
 	.otg_reset_sspi = false,
+	.otg_set_port_power = false,
 	.ops = &tegra124_ops,
 	.mbox = {
 		.cmd = 0x68,
@@ -2708,6 +2716,7 @@ static const struct tegra_xusb_soc tegra234_soc = {
 	.scale_ss_clock = false,
 	.has_ipfs = false,
 	.otg_reset_sspi = false,
+	.otg_set_port_power = false,
 	.ops = &tegra234_ops,
 	.mbox = {
 		.cmd = XUSB_BAR2_ARU_MBOX_CMD,

