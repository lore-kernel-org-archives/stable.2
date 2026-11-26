Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795711343;
	b=mRpl5DLGBCstPYIAXsiUHfyobfom1Kt0ip5ZRaakvs4ssuU4WVo8Wt286oXBl7sNGp90
	 7jsQcimYciGKgtOSYhTj7bGSxJIN5GiAvaVy0Vf/lCNPHproraR7KXAmFtDs/3CExbagK
	 6LqR6bXoaoumCi61uCD2OeQTNtZfzQLBJmOEtMMZrTlyuJsWM/Hnfq9LpY8NlkL5gKp8B
	 9qnW3dDCQoch/FfMepW3Rpu1Y1QHQvntUfyoc3c/1xTZNpp1DE0YIyOESfQ54SVWQCtd6
	 fsTP/IXolHiHLqRqJNcpya99OQBTuVYdHBXhn1xzzp/prVdZqSqz3S7Q3rjgLfk1FQg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795711343;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=1Sk/9E05p3DI5jvrOR1OiC0qBpzk1wK2sNjMhPrYj8k=;
	b=k9Jbi9kHdfeZUPabIqtfd6KpvnNKRLCbyextnu/6zv8rFxmjzpmnW5nFmqwWgRZw2eu9
	 zfsDutQ3kxaqrRaZKurGnzJFcS1em/JBor/FMcroSAOLpDkqYJ0Ne/KqtWUp3Q8bQnYuj
	 3qRTnK7cgmseSIZKZNlT5dwtemh3+Wv4N2+dOtN0gR11s6jj3YYO9virhU4Bpbn/y7eGQ
	 2dqOebl2CFpr7s7u0g+Mn3zYJfQL/z9P5yE7o67JdlAvN7229A9teXdrh7gX+bdxCwk7A
	 CDdMEy55CqoB5KKeG0vw9Fs3/hB3YVR23k3FI6v4tyTQ9F1ZfETeCaOxGXFkhL++tnw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=J6eHyZWP;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5292560A5BCA
	for <stable@vger.kernel.org>; Thu, 26 Nov 2026 16:42:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=J6eHyZWP
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F5641F000E0;
	Thu, 26 Nov 2026 16:42:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795711343;
	bh=1Sk/9E05p3DI5jvrOR1OiC0qBpzk1wK2sNjMhPrYj8k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=J6eHyZWPDLcOiGOjtiFtCtfnAmvyQOt8pXbPWOodhpT0CuHUHj+6CQYswiZcNKJL4
	 Y9E7C3YLG2AWxsYzif0CLk5u1sMdHk/T1HVLJ8fmjUyUHq4Lx9w6gJAZZA1h1EM78t
	 ndAOZAT8FqBCfaD2qlHtwyAIKFG0DrLEwl+vk3ysg36dh89YxUpZhjgYatggE4jWzy
	 xwS2r0HImM2AnyUNLUcBkjRQCRxZq3u8uXSvsp88Z6a5BHo4uArX8YkidOZ007ylpX
	 HYhtsIMAG33RGGC/07QSORs1gdZ+VXApHMcyQgvAFZtlWl4pn3H6UeytIFF4SEltCZ
	 omtUEsdywbpLw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>,
	stable <stable@kernel.org>,
	Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y 2/2] usb: dwc3: xilinx: re-assert resets on ZynqMP init error paths
Date: Thu, 26 Nov 2026 11:42:19 -0500
Message-ID: <20261126164205.2611324-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261126164205.2611324-1-sashal@kernel.org>
References: <2026112502-upper-democracy-a1fc@gregkh>
 <20261126164205.2611324-1-sashal@kernel.org>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>

[ Upstream commit f33f0dd2eb014bffda02ecfd182de3ddab058596 ]

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
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/usb/dwc3/dwc3-xilinx.c | 55 ++++++++++++++++++++++------------
 1 file changed, 36 insertions(+), 19 deletions(-)

diff --git a/drivers/usb/dwc3/dwc3-xilinx.c b/drivers/usb/dwc3/dwc3-xilinx.c
index 6afd3769be3a1..ecae90293d1fe 100644
--- a/drivers/usb/dwc3/dwc3-xilinx.c
+++ b/drivers/usb/dwc3/dwc3-xilinx.c
@@ -49,6 +49,9 @@ struct dwc3_xlnx {
 	void __iomem			*regs;
 	int				(*pltfm_init)(struct dwc3_xlnx *data);
 	struct phy			*usb3_phy;
+	struct reset_control		*usb_crst;
+	struct reset_control		*usb_hibrst;
+	struct reset_control		*usb_apbrst;
 };
 
 static void dwc3_xlnx_mask_phy_rst(struct dwc3_xlnx *priv_data, bool mask)
@@ -100,7 +103,6 @@ static int dwc3_xlnx_init_versal(struct dwc3_xlnx *priv_data)
 static int dwc3_xlnx_init_zynqmp(struct dwc3_xlnx *priv_data)
 {
 	struct device		*dev = priv_data->dev;
-	struct reset_control	*crst, *hibrst, *apbrst;
 	struct gpio_desc	*reset_gpio;
 	int			ret = 0;
 	u32			reg;
@@ -113,25 +115,25 @@ static int dwc3_xlnx_init_zynqmp(struct dwc3_xlnx *priv_data)
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
@@ -145,19 +147,19 @@ static int dwc3_xlnx_init_zynqmp(struct dwc3_xlnx *priv_data)
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
@@ -168,7 +170,7 @@ static int dwc3_xlnx_init_zynqmp(struct dwc3_xlnx *priv_data)
 	if (ret < 0)
 		goto err;
 
-	ret = reset_control_deassert(apbrst);
+	ret = reset_control_deassert(priv_data->usb_apbrst);
 	if (ret < 0) {
 		dev_err(dev, "Failed to release APB reset\n");
 		goto err_phy_exit;
@@ -184,21 +186,21 @@ static int dwc3_xlnx_init_zynqmp(struct dwc3_xlnx *priv_data)
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
@@ -228,6 +230,21 @@ static int dwc3_xlnx_init_zynqmp(struct dwc3_xlnx *priv_data)
 
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
-- 
2.53.0

