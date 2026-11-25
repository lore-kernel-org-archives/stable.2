Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795608690;
	b=n0lTheptw32X81JAPnTfgkVC6ybZqR5aGYUgW17gbH0VQzPfVKyO/FCQZPjzxTaaSZmm
	 NML/kvupITwY0HZddXJA3iCbT+e2sUBvNeehNMhXc53LOEujoe/SqXGBFSB/z5JoSAh/p
	 N+OMtT+bmJZdRHO+qdNB8gdhOJAA3feYx6+1CCpVhD2FXa6a+0vsD8Z+0+wdsy8arDlTl
	 keCCgXdL2Ujy+bORZ1pTiVNwUq/vS8/mUTuhAwPUM2SnyJjPDUFLre/OIjcAtuCxr4Tr4
	 BbiweaAtcOqPYUEGjvZus5Cw5NS4194bFKTpU45T2BnZLAGzOPlulK1SekZ4zU2Hu3w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795608690;
	h=Received:DKIM-Signature:Subject:To:Cc:From:Date:Message-ID:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=YGZjaHdKZHKBRvDI+6quwGpqy+T/VVJI0kpWlOLxR58=;
	b=AkJVIDHBkhRbfwGUH0a5pHopy1ACrbp7KD0VcCMbYpkNijRtT0ccSVE8ps9CJSc6mbvZ
	 93v4nQ3yJBBF2mjPto/8cGgmUk8TkTQ9rKBwlz2pSFC2ONNrsRdeDQRAqBgolf1vHMEtL
	 plkAhmxNgMRMBOadb5BMd2Yk5hlgl3bUbeX2DU8hWu/gJipofMztvGuUftS56JfqZOm/D
	 qxQqsRmhEry8STBlwoYcXiUfDrvX7pyGnAoM9P9UVA8DPVvfdzfJrmvA7TgrzomP4M14O
	 iCX1cA7sdFevnBAO8Fl85+HOdleHrFu5441J7hu+KWlLBqYRy+APYWZKj/9u34MF/8Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=OcygigDS;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B95CB606A31E
	for <stable@vger.kernel.org>; Wed, 25 Nov 2026 12:11:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=OcygigDS
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D27031F000C4;
	Wed, 25 Nov 2026 12:11:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1795608690;
	bh=YGZjaHdKZHKBRvDI+6quwGpqy+T/VVJI0kpWlOLxR58=;
	h=Subject:To:Cc:From:Date;
	b=OcygigDS5buSbwx8WBh1cNG5QwYnv1YoEgWxRhCnZMOdowmQAKLoBx1jkD511MWEk
	 80+EzFjGusjPobubCezfxvzKVHbB3JbIKM5rdkKD1pA5BQGBhh306S+6c7u9cxvHRn
	 AnnvU1IvaX8l7FOePxkN1XfN7oiHyFdm0kTXZ0SE=
Subject: FAILED: patch "[PATCH] usb: dwc3: xilinx: unwind ZynqMP platform init on probe" failed to apply to 6.6-stable tree
To: radhey.shyam.pandey@amd.com,Thinh.Nguyen@synopsys.com,gregkh@linuxfoundation.org,p.zabel@pengutronix.de,stable@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 25 Nov 2026 13:04:13 +0100
Message-ID: <2026112512-unbolted-sleep-4b3c@gregkh>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.6-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.6.y
git checkout FETCH_HEAD
git cherry-pick -x 6c6508e742b47539224eb18cb23f7ed5d401dcb6
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026112512-unbolted-sleep-4b3c@gregkh' --subject-prefix 'PATCH 6.6.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 6c6508e742b47539224eb18cb23f7ed5d401dcb6 Mon Sep 17 00:00:00 2001
From: Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>
Date: Mon, 28 Sep 2026 17:30:15 +0530
Subject: [PATCH] usb: dwc3: xilinx: unwind ZynqMP platform init on probe
 failure and remove

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
Cc: stable <stable@kernel.org>
Suggested-by: Philipp Zabel <p.zabel@pengutronix.de>
Assisted-by: Claude:claude-opus-5
Signed-off-by: Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>
Acked-by: Thinh Nguyen <Thinh.Nguyen@synopsys.com>
Link: https://patch.msgid.link/20260928120015.3152461-4-radhey.shyam.pandey@amd.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

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
 

