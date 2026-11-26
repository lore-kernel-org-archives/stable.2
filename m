Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795709793;
	b=V+D+FX7MSfnmPyRf94lTvqygEMxzGqMOBLy/U/2FnWNgWKvhdTpU7FHoOzME0ACWRrTi
	 NYVU3trowAG3XP3pXBBQltyQkQDzhRIAe8sI0xizFLat2eUYus5ST/cOJ6RU7M9HL/IQH
	 xvmZBbw6Sj4ncBADP/PKDbPzcBYx+B54l2LvURnOpDvoGhN/n/QGTcmZ+YkJtEV7ATCP1
	 u2C8rtF1B8zARTngcgYMr9JfPxBCbsgEoyJzvwG6MBAt1z+jwFSTzlDXsY0Ahscgjr0/z
	 8CUDSO0FqkDa1Pnj0/Yb/iyLlZ5gBaTfdPvdECBHBcaXYhfHG075GEXWwgkiPUgEtJA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795709793;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=XzdcHK6sPem9AFIfHQQwNou55wtq3kdg3qM42aalKxU=;
	b=UpKTeqCX/5c45NZzHa2CBwj4miR1R5HizXABnBt8dFPtV5TeoqgyZTjgiWnjHtZRz34n
	 kL3zogANqcwyzqUUVLf/mSco0RWsKVgkCEk7wKsR2da0P1tsXv1mjVorPZWm4w4MYknod
	 cU0bN+0ynXZUbn7pPK3EO3ty8b3fzUOUpmDrQ1wOwtCF3Fo7jssgeaDeD1QDo4dpYAJNZ
	 Bjakxvz++jmPencA9oXSLLsSYcFuVQlGEAiiXiyPoNJXERToHdoNLDfDB4gNJ8ijDx226
	 Pqe/59os0lGy1gSvRyB+AoW4uCOpTnKcnG3lNgOcKAqOHX65OTTSmizlWtod/z+X/Ow==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Yfrjl9mq;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0599D606A31E
	for <stable@vger.kernel.org>; Thu, 26 Nov 2026 16:16:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Yfrjl9mq
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A9C101F000CA;
	Thu, 26 Nov 2026 16:16:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795709792;
	bh=XzdcHK6sPem9AFIfHQQwNou55wtq3kdg3qM42aalKxU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Yfrjl9mqXjOYRQJXdrlD9YmGCL6t071HlE1oRvmJwQKcEmlybdxkcuq+jXT8ReI1L
	 zq5DIjRc4pcYmSzDgLqI7Jn7CtaGqpNY5RSbUFnaX8Z2ry/AfV7T0mV7lv6Ym4YAvb
	 dzjtWEm5F8cbU9s5A889BmeayCHXheaIf+dcxinOkfqdVJfUKRq00kYcPHpVm/2d07
	 AeG6tqPONM8pZPpoMxddnAMVuEcLff2SHtftACEX8rZ436P8JoDH9l7gqemVLvVOa7
	 Z5m+PGwR0g/twuR0Qm5djAVRvPD0cwgDTON0+Z10NMIwmI0+buAnsrNzFvBFhDpZxX
	 3bCK37dHRJxmg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sean Anderson <sean.anderson@linux.dev>,
	Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y 1/2] usb: dwc3: Always deassert xilinx resets
Date: Thu, 26 Nov 2026 11:16:29 -0500
Message-ID: <20261126161615.2569078-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026112502-trailing-living-e804@gregkh>
References: <2026112502-trailing-living-e804@gregkh>
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

From: Sean Anderson <sean.anderson@linux.dev>

[ Upstream commit ec06c8039d396a1b558cc138f5c5aba17698e175 ]

If we don't have a usb3 phy we don't need to assert the core resets.
Deassert them even if we didn't assert them to support booting when the
bootloader never released the core from reset.

Signed-off-by: Sean Anderson <sean.anderson@linux.dev>
Acked-by: Thinh Nguyen <Thinh.Nguyen@synopsys.com>
Link: https://patch.msgid.link/20260106171018.501612-1-sean.anderson@linux.dev
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Stable-dep-of: f33f0dd2eb01 ("usb: dwc3: xilinx: re-assert resets on ZynqMP init error paths")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/usb/dwc3/dwc3-xilinx.c | 71 ++++++++++++++++------------------
 1 file changed, 34 insertions(+), 37 deletions(-)

diff --git a/drivers/usb/dwc3/dwc3-xilinx.c b/drivers/usb/dwc3/dwc3-xilinx.c
index 96ff5789f7f45..135fa9d3c747a 100644
--- a/drivers/usb/dwc3/dwc3-xilinx.c
+++ b/drivers/usb/dwc3/dwc3-xilinx.c
@@ -112,21 +112,6 @@ static int dwc3_xlnx_init_zynqmp(struct dwc3_xlnx *priv_data)
 		goto err;
 	}
 
-	/*
-	 * The following core resets are not required unless a USB3 PHY
-	 * is used, and the subsequent register settings are not required
-	 * unless a core reset is performed (they should be set properly
-	 * by the first-stage boot loader, but may be reverted by a core
-	 * reset). They may also break the configuration if USB3 is actually
-	 * in use but the usb3-phy entry is missing from the device tree.
-	 * Therefore, skip these operations in this case.
-	 */
-	if (!priv_data->usb3_phy) {
-		/* Deselect the PIPE Clock Select bit in FPD PIPE Clock register */
-		writel(PIPE_CLK_DESELECT, priv_data->regs + XLNX_USB_FPD_PIPE_CLK);
-		goto skip_usb3_phy;
-	}
-
 	crst = devm_reset_control_get_exclusive(dev, "usb_crst");
 	if (IS_ERR(crst)) {
 		ret = PTR_ERR(crst);
@@ -151,22 +136,31 @@ static int dwc3_xlnx_init_zynqmp(struct dwc3_xlnx *priv_data)
 		goto err;
 	}
 
-	ret = reset_control_assert(crst);
-	if (ret < 0) {
-		dev_err(dev, "Failed to assert core reset\n");
-		goto err;
-	}
-
-	ret = reset_control_assert(hibrst);
-	if (ret < 0) {
-		dev_err(dev, "Failed to assert hibernation reset\n");
-		goto err;
-	}
-
-	ret = reset_control_assert(apbrst);
-	if (ret < 0) {
-		dev_err(dev, "Failed to assert APB reset\n");
-		goto err;
+	/*
+	 * Asserting the core resets is not required unless a USB3 PHY is used.
+	 * They may also break the configuration if USB3 is actually in use but
+	 * the usb3-phy entry is missing from the device tree. Therefore, skip
+	 * a full reset cycle and just deassert the resets if the phy is
+	 * absent.
+	 */
+	if (priv_data->usb3_phy) {
+		ret = reset_control_assert(crst);
+		if (ret < 0) {
+			dev_err(dev, "Failed to assert core reset\n");
+			goto err;
+		}
+
+		ret = reset_control_assert(hibrst);
+		if (ret < 0) {
+			dev_err(dev, "Failed to assert hibernation reset\n");
+			goto err;
+		}
+
+		ret = reset_control_assert(apbrst);
+		if (ret < 0) {
+			dev_err(dev, "Failed to assert APB reset\n");
+			goto err;
+		}
 	}
 
 	ret = phy_init(priv_data->usb3_phy);
@@ -179,11 +173,15 @@ static int dwc3_xlnx_init_zynqmp(struct dwc3_xlnx *priv_data)
 		goto err_phy_exit;
 	}
 
-	/* Set PIPE Power Present signal in FPD Power Present Register*/
-	writel(FPD_POWER_PRSNT_OPTION, priv_data->regs + XLNX_USB_FPD_POWER_PRSNT);
-
-	/* Set the PIPE Clock Select bit in FPD PIPE Clock register */
-	writel(PIPE_CLK_SELECT, priv_data->regs + XLNX_USB_FPD_PIPE_CLK);
+	if (priv_data->usb3_phy) {
+		/* Set PIPE Power Present signal in FPD Power Present Register*/
+		writel(FPD_POWER_PRSNT_OPTION, priv_data->regs + XLNX_USB_FPD_POWER_PRSNT);
+		/* Set the PIPE Clock Select bit in FPD PIPE Clock register */
+		writel(PIPE_CLK_SELECT, priv_data->regs + XLNX_USB_FPD_PIPE_CLK);
+	} else {
+		/* Deselect the PIPE Clock Select bit in FPD PIPE Clock register */
+		writel(PIPE_CLK_DESELECT, priv_data->regs + XLNX_USB_FPD_PIPE_CLK);
+	}
 
 	ret = reset_control_deassert(crst);
 	if (ret < 0) {
@@ -201,7 +199,6 @@ static int dwc3_xlnx_init_zynqmp(struct dwc3_xlnx *priv_data)
 	if (ret < 0)
 		goto err_phy_exit;
 
-skip_usb3_phy:
 	/* ulpi reset via gpio-modepin or gpio-framework driver */
 	reset_gpio = devm_gpiod_get_optional(dev, "reset", GPIOD_OUT_HIGH);
 	if (IS_ERR(reset_gpio)) {
-- 
2.53.0

