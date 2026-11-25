Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795608447;
	b=ahXoiT8W6U9dpu0C8KhGAZF08JHHSNDREpuJI4r9y+gPsTPE+0ikECqob9prCz0hs2a1
	 8UK1PStaxSogvFhyKCnQ+/T4jZNW6F4BUW+wgtMsyZSnaGU7p/McvtfaWr1IZJXzEcbWt
	 oJzReulkHeRzjd5/yg9EO/unqJjINfEzsCT+mG3IWSKDWJXge+h7JymkP5IFzrFoRzXuy
	 qqnbhgejdEcvByRM9KphxoGlHHYYiISipc3HkDQoAcOINuZEddoYVTxPtKlE3MDrllU00
	 jcDr54BiqoOLIwSCDUCcTvQybXRQWuN/bGI8LRGdsioDb+Q4YhYsjCXqSBJj6QrC26g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795608447;
	h=Received:DKIM-Signature:Subject:To:Cc:From:Date:Message-ID:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=T6Or9vMH3EpRjyu1nOI9pd7l5KqbeZ+8ZPVILuF9Yec=;
	b=Tjtr6dQM6O79IhdBlYFkzPtKCB3fONsjgp2qJMZP0tKArjaNBGBlaPy6kZIbTSg+Q8BD
	 r8ZqXaFKFtBkAQEoOOFLsWnfjJsvcxu+fEDBoZ8KNwsAS8J1TzjkLLRX+cdEjFtT3AB/j
	 c7/jrfLnz2ofeQ5t2AoEG677mhKt1IvnTUmt1McqfYIs0wkoPXxYko1FWSINExB9fIpsR
	 K6eH0JjXmmlB6jBcj53RBvBpZtkSLeP7sWBWF6JUEcmXmrvTWsplVk/XYTomHdf24Flyl
	 9nwrkEzvO4biWtRwsIzpcy/dJ5Ll1rhg7dq0DJQtv8O47D4S5eNmD+lDS3hXE3GRB1w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=XhZAWxk4;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4056606A321
	for <stable@vger.kernel.org>; Wed, 25 Nov 2026 12:07:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=XhZAWxk4
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EF29B1F000CF;
	Wed, 25 Nov 2026 12:07:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1795608447;
	bh=T6Or9vMH3EpRjyu1nOI9pd7l5KqbeZ+8ZPVILuF9Yec=;
	h=Subject:To:Cc:From:Date;
	b=XhZAWxk4xjgLQA5oGKULrnUR00hp/l8Da6q8Gxg87OZnjmTrxbgFITlC8PP54CO9X
	 k504ST3dQbT5+ndCgeaXeteTxTBVHW/63WMTg4ANnidkXMVn1tMGINS9zJVPJe8s7H
	 RMaE/Y/CqXh96/j4Obi1bnB7HJGdwdO+wwsppt3c=
Subject: FAILED: patch "[PATCH] usb: dwc3: xilinx: re-assert resets on ZynqMP init error" failed to apply to 6.1-stable tree
To: radhey.shyam.pandey@amd.com,Thinh.Nguyen@synopsys.com,gregkh@linuxfoundation.org,stable@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 25 Nov 2026 12:42:02 +0100
Message-ID: <2026112502-upper-democracy-a1fc@gregkh>
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


The patch below does not apply to the 6.1-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.1.y
git checkout FETCH_HEAD
git cherry-pick -x f33f0dd2eb014bffda02ecfd182de3ddab058596
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026112502-upper-democracy-a1fc@gregkh' --subject-prefix 'PATCH 6.1.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From f33f0dd2eb014bffda02ecfd182de3ddab058596 Mon Sep 17 00:00:00 2001
From: Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>
Date: Mon, 28 Sep 2026 17:30:14 +0530
Subject: [PATCH] usb: dwc3: xilinx: re-assert resets on ZynqMP init error
 paths

If reset deassert or PHY setup fails partway through
dwc3_xlnx_init_zynqmp(), re-assert the resets that were already
released before unwinding the PHY.

Only undo the reset cycle the function actually performed. The cycle is
skipped when no usb3-phy is present, because asserting the core resets
can break a USB3 configuration that is live but missing from the device
tree, so the error path skips it for the same reason. Asserting an
already asserted reset is harmless, so one block covers however far the
deasserts progressed.

Save the ZynqMP reset handles in driver private data so later probe
teardown can re-assert released resets.

Fixes: 84770f028fab ("usb: dwc3: Add driver for Xilinx platforms")
Cc: stable <stable@kernel.org>
Assisted-by: Claude:claude-opus-5
Signed-off-by: Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>
Acked-by: Thinh Nguyen <Thinh.Nguyen@synopsys.com>
Link: https://patch.msgid.link/20260928120015.3152461-3-radhey.shyam.pandey@amd.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

diff --git a/drivers/usb/dwc3/dwc3-xilinx.c b/drivers/usb/dwc3/dwc3-xilinx.c
index 8c63e02575f1..d2315573b3d3 100644
--- a/drivers/usb/dwc3/dwc3-xilinx.c
+++ b/drivers/usb/dwc3/dwc3-xilinx.c
@@ -48,6 +48,9 @@ struct dwc3_xlnx {
 	void __iomem			*regs;
 	int				(*pltfm_init)(struct dwc3_xlnx *data);
 	struct phy			*usb3_phy;
+	struct reset_control		*usb_crst;
+	struct reset_control		*usb_hibrst;
+	struct reset_control		*usb_apbrst;
 };
 
 static void dwc3_xlnx_mask_phy_rst(struct dwc3_xlnx *priv_data, bool mask)
@@ -112,7 +115,6 @@ static int dwc3_xlnx_init_versal(struct dwc3_xlnx *priv_data)
 static int dwc3_xlnx_init_zynqmp(struct dwc3_xlnx *priv_data)
 {
 	struct device		*dev = priv_data->dev;
-	struct reset_control	*crst, *hibrst, *apbrst;
 	struct gpio_desc	*reset_gpio;
 	int			ret = 0;
 
@@ -124,25 +126,25 @@ static int dwc3_xlnx_init_zynqmp(struct dwc3_xlnx *priv_data)
 		goto err;
 	}
 
-	crst = devm_reset_control_get_exclusive(dev, "usb_crst");
-	if (IS_ERR(crst)) {
-		ret = PTR_ERR(crst);
+	priv_data->usb_crst = devm_reset_control_get_exclusive(dev, "usb_crst");
+	if (IS_ERR(priv_data->usb_crst)) {
+		ret = PTR_ERR(priv_data->usb_crst);
 		dev_err_probe(dev, ret,
 			      "failed to get core reset signal\n");
 		goto err;
 	}
 
-	hibrst = devm_reset_control_get_exclusive(dev, "usb_hibrst");
-	if (IS_ERR(hibrst)) {
-		ret = PTR_ERR(hibrst);
+	priv_data->usb_hibrst = devm_reset_control_get_exclusive(dev, "usb_hibrst");
+	if (IS_ERR(priv_data->usb_hibrst)) {
+		ret = PTR_ERR(priv_data->usb_hibrst);
 		dev_err_probe(dev, ret,
 			      "failed to get hibernation reset signal\n");
 		goto err;
 	}
 
-	apbrst = devm_reset_control_get_exclusive(dev, "usb_apbrst");
-	if (IS_ERR(apbrst)) {
-		ret = PTR_ERR(apbrst);
+	priv_data->usb_apbrst = devm_reset_control_get_exclusive(dev, "usb_apbrst");
+	if (IS_ERR(priv_data->usb_apbrst)) {
+		ret = PTR_ERR(priv_data->usb_apbrst);
 		dev_err_probe(dev, ret,
 			      "failed to get APB reset signal\n");
 		goto err;
@@ -156,19 +158,19 @@ static int dwc3_xlnx_init_zynqmp(struct dwc3_xlnx *priv_data)
 	 * absent.
 	 */
 	if (priv_data->usb3_phy) {
-		ret = reset_control_assert(crst);
+		ret = reset_control_assert(priv_data->usb_crst);
 		if (ret < 0) {
 			dev_err(dev, "Failed to assert core reset\n");
 			goto err;
 		}
 
-		ret = reset_control_assert(hibrst);
+		ret = reset_control_assert(priv_data->usb_hibrst);
 		if (ret < 0) {
 			dev_err(dev, "Failed to assert hibernation reset\n");
 			goto err;
 		}
 
-		ret = reset_control_assert(apbrst);
+		ret = reset_control_assert(priv_data->usb_apbrst);
 		if (ret < 0) {
 			dev_err(dev, "Failed to assert APB reset\n");
 			goto err;
@@ -179,7 +181,7 @@ static int dwc3_xlnx_init_zynqmp(struct dwc3_xlnx *priv_data)
 	if (ret < 0)
 		goto err;
 
-	ret = reset_control_deassert(apbrst);
+	ret = reset_control_deassert(priv_data->usb_apbrst);
 	if (ret < 0) {
 		dev_err(dev, "Failed to release APB reset\n");
 		goto err_phy_exit;
@@ -195,21 +197,21 @@ static int dwc3_xlnx_init_zynqmp(struct dwc3_xlnx *priv_data)
 		writel(PIPE_CLK_DESELECT, priv_data->regs + XLNX_USB_FPD_PIPE_CLK);
 	}
 
-	ret = reset_control_deassert(crst);
+	ret = reset_control_deassert(priv_data->usb_crst);
 	if (ret < 0) {
 		dev_err(dev, "Failed to release core reset\n");
-		goto err_phy_exit;
+		goto err_reset_assert;
 	}
 
-	ret = reset_control_deassert(hibrst);
+	ret = reset_control_deassert(priv_data->usb_hibrst);
 	if (ret < 0) {
 		dev_err(dev, "Failed to release hibernation reset\n");
-		goto err_phy_exit;
+		goto err_reset_assert;
 	}
 
 	ret = phy_power_on(priv_data->usb3_phy);
 	if (ret < 0)
-		goto err_phy_exit;
+		goto err_reset_assert;
 
 	/* ulpi reset via gpio-modepin or gpio-framework driver */
 	reset_gpio = devm_gpiod_get_optional(dev, "reset", GPIOD_OUT_HIGH);
@@ -230,6 +232,21 @@ static int dwc3_xlnx_init_zynqmp(struct dwc3_xlnx *priv_data)
 
 err_phy_power_off:
 	phy_power_off(priv_data->usb3_phy);
+err_reset_assert:
+	/*
+	 * Undo only the reset cycle performed above.  That cycle is skipped
+	 * when there is no usb3-phy.  The deasserts stay unconditional so a
+	 * core the bootloader left in reset still comes up, but they are
+	 * deliberately not paired with an assert here: resetting a USB3
+	 * configuration that is live but missing from the device tree could
+	 * break it.  Asserting an already asserted reset is harmless, so one
+	 * block covers however far the cycle's deasserts got.
+	 */
+	if (priv_data->usb3_phy) {
+		reset_control_assert(priv_data->usb_hibrst);
+		reset_control_assert(priv_data->usb_crst);
+		reset_control_assert(priv_data->usb_apbrst);
+	}
 err_phy_exit:
 	phy_exit(priv_data->usb3_phy);
 err:

