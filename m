Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795709473;
	b=puXDU94clCLE22KevFvMhLYIjrQqVwOqfu0hQZktubxgptHe/fuoU5Eg41/fmIZ8uYuh
	 nI81zJGvAcmMvuavmlF/SJZ3VY+gZ9+EIAtpNghCB6FeoHugBdgIlJFfrYVmBJMW/sZD3
	 wrJcEh/yR3+3pehGbrj0L4JAVwg6xDzvZ5vO1MswOoHcqePZ0oWCrYsZ/aufH8Uy7qtNM
	 KDYN8djK4CFJ4/IGOB59/gegQLozVQ/0Kv1DZHV03g6JKigGpc3I/VUDOeIuJQ+kchRmh
	 zP65WFNS9R/tLSo8MjdOU7qoISG2cF0I2waMOmL6oGk1x4R2QVCUyT86coI0slfqk2Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795709473;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=9PUTKZGGgfgqYuitNa8TnCVCVRf0zoWL9r7h2cVKo54=;
	b=Pi2njIAufAmMvNFPCQua0jEiP7HGeZFrAIAPR60BuKbOjqcxl02PscEN0bj+u+Z4jO2C
	 hdfD7Ycja3+CMoyD5QFFWPo9yl9CJW8eGxY3GSP+hMeuQqQvVN4OMXo5JQUov3vor4R3G
	 2wEbosNAANV0YU6plSShirDWyu44HCS1eM2XPrYzLFl4vDI+ubJw8XV9UnZbcLt/doBct
	 SRyGrRlm1UggGqSKhjCJw08xUq1i/dUbA92bsCOZu0n/nDFIgM9aMF8VLSM4syxwceOmz
	 ywvVodDWnPEyoNwWOZEdgNhZNZOsWrWKvjzjbZf2/Cyr3rpON1Hhx0Kr4pEiYxecbZg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=K2o0pABO;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38A13606A31E
	for <stable@vger.kernel.org>; Thu, 26 Nov 2026 16:11:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=K2o0pABO
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 840671F000C4;
	Thu, 26 Nov 2026 16:11:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795709472;
	bh=9PUTKZGGgfgqYuitNa8TnCVCVRf0zoWL9r7h2cVKo54=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=K2o0pABO5LpyLhTN4+7WwHseEqPd/5gwQcaJPrptg1SSIFegJ9yOJgGlO6PDvX8sS
	 lCPT6QOwdftYMmUoV2yZ4HesmfXtrVnfMJZamL7kt/KSmiA0nNyudZKVj54neGkcvR
	 VsCwE7QzILd6JjUT9cS2oTJb9c5hNvNI/liTVkK24qaqK5U2iU0DGmtiIPwKMmFYwc
	 rNdZ6xEIF3BlpBHDaIoR8Z92KXZ/D8kxD7kFm509JQtF3jByfnEg5yzYKWkDdi2vK5
	 w46b20OAIH/uSpUdb06TqjZdyRaNSADRZYjcA1oXiiyvYi6NE3LEn/BkimvAN0OQ3K
	 NGAoQZDyYRbTQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sean Anderson <sean.anderson@linux.dev>,
	Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18.y 1/2] usb: dwc3: Always deassert xilinx resets
Date: Thu, 26 Nov 2026 11:11:09 -0500
Message-ID: <20261126161055.2530202-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026112501-sloppy-overrun-e142@gregkh>
References: <2026112501-sloppy-overrun-e142@gregkh>
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
index 8897fbe554745..449c03223c7f3 100644
--- a/drivers/usb/dwc3/dwc3-xilinx.c
+++ b/drivers/usb/dwc3/dwc3-xilinx.c
@@ -132,21 +132,6 @@ static int dwc3_xlnx_init_zynqmp(struct dwc3_xlnx *priv_data)
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
@@ -171,22 +156,31 @@ static int dwc3_xlnx_init_zynqmp(struct dwc3_xlnx *priv_data)
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
@@ -199,11 +193,15 @@ static int dwc3_xlnx_init_zynqmp(struct dwc3_xlnx *priv_data)
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
@@ -221,7 +219,6 @@ static int dwc3_xlnx_init_zynqmp(struct dwc3_xlnx *priv_data)
 	if (ret < 0)
 		goto err_phy_exit;
 
-skip_usb3_phy:
 	/* ulpi reset via gpio-modepin or gpio-framework driver */
 	reset_gpio = devm_gpiod_get_optional(dev, "reset", GPIOD_OUT_HIGH);
 	if (IS_ERR(reset_gpio)) {
-- 
2.53.0

