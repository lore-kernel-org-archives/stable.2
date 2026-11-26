Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795709794;
	b=JuisPrbbu6wjMcMgjZokpFVKqifOjt5G9Rx6mziFyX9SurpWRSkTYTuMjqIgyc1p6KKX
	 rVOPM4llIE4LYR2MRExQgRbtjScyxJlla9H+ovKhmc45wlzC1p8JLl52sTYE/8VqV1Y5J
	 vBkoF12bW2e4vMoZd4ezSdQXQYbqRsn0m7VWb8Nhi+EfJPqyc5VGAW4Z9g0SB35pUKBan
	 dR+mUN/jr3/KePis8PviXl0OgrWxjk50/tia9rzqMukkzXTJduLV+x3CDgMYrMCQ+rb64
	 pGarBU+oXM9+cZKTpy0pqJFXokJ9YyUw71haqxNO7Jm4sHU1bru8p+wVBJyt6csBWqw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795709794;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=3brOEDASwlL6eb+KhBSUoWZzXY6vVjXruAtcg542T0g=;
	b=TNyB0xHuBjf6WJiZmn0ejjaAiCgOORi10/32N0Zuwq6lBbfhlPOo/Q4NZB99lRcVJZ15
	 qOZCzeqv5DXXQR9EpNovfoExnotSYViZa+3piBdT3lbtHWhg8iDHBXpZBeFiMUZYhY7rH
	 PvS8SgZ/Ww9bbf0vzRfyHsNCKVYsV56EzTHBbQ9xKOmd44VPggaqgcpfJnXSBn/1qMDg8
	 jWHIJNJX/AxmuY5ZfK46/uoTnYwX8i9L/94b5lcpKYU7fzOZouY8f92IvzB/X8I9eTOkw
	 FPZMvKiefbiDwXx5SAveyocUBHfqkfzNzu55YXMhMJwAcI5E8rPIzw15GVlvfvH9weg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=UL5+hRKP;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30F65606A31C
	for <stable@vger.kernel.org>; Thu, 26 Nov 2026 16:16:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=UL5+hRKP
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D5DAD1F000D1;
	Thu, 26 Nov 2026 16:16:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795709793;
	bh=3brOEDASwlL6eb+KhBSUoWZzXY6vVjXruAtcg542T0g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=UL5+hRKPnp3TT210tlOcz9T93C4dkNO5oip2ehEfYm5WW+4owiePaqiKNedeqZsC0
	 7nqLokcuMfcZwzUTLD1ZBd3/9qAFMz4+jF+ub7eigo43ZAkfBTY5EMYYtPbqOsNrCq
	 k2GRtSfzL0nxrHzoLimYQv2jf2oSkbb1/2ROOnSRhjSqCFxu24kIk0YFhbvYTLDnF1
	 8iKLJ17AvG36X2AOT3a3A/vbmH4bkldGvoRdaw8ja7V65Q2JMjCnIOKlbnLian9vOm
	 LN5wrZhCeCf8TqgnhV9sBpu8FSilRemBOyrSM3ou7m7Z2sXRMMR7dOML/939ud2xiC
	 51mbQ4jlqRLyg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>,
	stable <stable@kernel.org>,
	Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y 2/2] usb: dwc3: xilinx: re-assert resets on ZynqMP init error paths
Date: Thu, 26 Nov 2026 11:16:30 -0500
Message-ID: <20261126161615.2569078-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261126161615.2569078-1-sashal@kernel.org>
References: <2026112502-trailing-living-e804@gregkh>
 <20261126161615.2569078-1-sashal@kernel.org>
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
index 135fa9d3c747a..103a9e6ef35c4 100644
--- a/drivers/usb/dwc3/dwc3-xilinx.c
+++ b/drivers/usb/dwc3/dwc3-xilinx.c
@@ -45,6 +45,9 @@ struct dwc3_xlnx {
 	void __iomem			*regs;
 	int				(*pltfm_init)(struct dwc3_xlnx *data);
 	struct phy			*usb3_phy;
+	struct reset_control		*usb_crst;
+	struct reset_control		*usb_hibrst;
+	struct reset_control		*usb_apbrst;
 };
 
 static void dwc3_xlnx_mask_phy_rst(struct dwc3_xlnx *priv_data, bool mask)
@@ -99,7 +102,6 @@ static int dwc3_xlnx_init_versal(struct dwc3_xlnx *priv_data)
 static int dwc3_xlnx_init_zynqmp(struct dwc3_xlnx *priv_data)
 {
 	struct device		*dev = priv_data->dev;
-	struct reset_control	*crst, *hibrst, *apbrst;
 	struct gpio_desc	*reset_gpio;
 	int			ret = 0;
 	u32			reg;
@@ -112,25 +114,25 @@ static int dwc3_xlnx_init_zynqmp(struct dwc3_xlnx *priv_data)
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
@@ -144,19 +146,19 @@ static int dwc3_xlnx_init_zynqmp(struct dwc3_xlnx *priv_data)
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
@@ -167,7 +169,7 @@ static int dwc3_xlnx_init_zynqmp(struct dwc3_xlnx *priv_data)
 	if (ret < 0)
 		goto err;
 
-	ret = reset_control_deassert(apbrst);
+	ret = reset_control_deassert(priv_data->usb_apbrst);
 	if (ret < 0) {
 		dev_err(dev, "Failed to release APB reset\n");
 		goto err_phy_exit;
@@ -183,21 +185,21 @@ static int dwc3_xlnx_init_zynqmp(struct dwc3_xlnx *priv_data)
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
@@ -227,6 +229,21 @@ static int dwc3_xlnx_init_zynqmp(struct dwc3_xlnx *priv_data)
 
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

