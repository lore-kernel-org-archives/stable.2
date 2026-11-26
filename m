Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795711342;
	b=1Ts/rCC55mwdks34y+1kWPRvtLTqtxYuv7vr2ptzeb05D/+rbLdl4HUKuvhQUSVB5rj9
	 8QhCbc4JOyUC03b1Yosgzt0NZtt2GRKqipuzkeCTR5TOUiNZEOb01NQ8CDbi69KdBf7wN
	 9GxWd2Y0w4zLP87g80QGNd2kXPg64kcr1ZJH65VnxHvf09g4LhizZ58c5beUEadPbSnsX
	 Cv85DAYEjLavMOc9wOtnDWevmW5Vyo6fPis41e9pGrl1hlMNE69Gv1OAm+sgkgpZ16JX1
	 VvibZVP/nrL5N8ZcitzijuIwHcgHFJ6YjRbx3zoSaXh/0bOKU12amcRv61PE4StzV/A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795711342;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=eEhBLb0ShyBZZbIKa/yjqC+O3k7v4zjFkwVDh6TWFK8=;
	b=OzcnoDt+J+W8pQsX38w/2duxbixVgZlUAAYWqMb5ncHgYgaOd1humRnU+yYdMfjMh5MO
	 SC6EZnfjOqqOYr13XiMEIpo+pNgtit9ba7gme8xN5wstA+lmeeJIF6nuHuQ7B1azQC0gU
	 fSREajCqVdHrs30Af1nq3n62nIuYJrE+E4xAyLjKPDZ3l4wso7BiikBuYqkgLfcn73vdP
	 A+DOl1RuyowCwS49iB6eA3KckejGNHJjeT1PEH+Rz2h9LJZ0bMr6lTKDijfocuDxeSNOg
	 ko/sJDinXYTy6XewJpG2DECUGn2PH3o2liyvRfFFmTvKKBxer+iNonUdNDeN6Kv5YtA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=LwNDL0Jx;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BFDC606A32D
	for <stable@vger.kernel.org>; Thu, 26 Nov 2026 16:42:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=LwNDL0Jx
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 159091F000CA;
	Thu, 26 Nov 2026 16:42:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795711341;
	bh=eEhBLb0ShyBZZbIKa/yjqC+O3k7v4zjFkwVDh6TWFK8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=LwNDL0JxyH1xqxX3xk7nszMe+HMBlZE4obIpQiy+cvFyS/FNBj+emNchskGd9KVmo
	 AJW8QsFSJKnuejljydc2HOQrZLzGEBapdVD1rTLsyvFni+ok7NdRpOXKDgluUPP402
	 EHbBq9BLMOhB3YyBD7mIZbujew0Q7u3JZmgwXe0MzjB9DocPHWLwLk983ztWrf5XrI
	 c29tBYQDm3VAcGHA1ypiBajzDKql0JVPWd/ZiLgblf4xF7lOuAPzDHSb14lIISUrQJ
	 qnZ4yj6gp5KGDbNpBjj4BY80G8iQ1rdKASrdwtZPgHlQ9JqRakriY3iy9YFMbXEPB+
	 qnerGRkqXN+aQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sean Anderson <sean.anderson@linux.dev>,
	Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y 1/2] usb: dwc3: Always deassert xilinx resets
Date: Thu, 26 Nov 2026 11:42:18 -0500
Message-ID: <20261126164205.2611324-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026112502-upper-democracy-a1fc@gregkh>
References: <2026112502-upper-democracy-a1fc@gregkh>
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
index 1156e2df499f6..6afd3769be3a1 100644
--- a/drivers/usb/dwc3/dwc3-xilinx.c
+++ b/drivers/usb/dwc3/dwc3-xilinx.c
@@ -113,21 +113,6 @@ static int dwc3_xlnx_init_zynqmp(struct dwc3_xlnx *priv_data)
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
@@ -152,22 +137,31 @@ static int dwc3_xlnx_init_zynqmp(struct dwc3_xlnx *priv_data)
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
@@ -180,11 +174,15 @@ static int dwc3_xlnx_init_zynqmp(struct dwc3_xlnx *priv_data)
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
@@ -202,7 +200,6 @@ static int dwc3_xlnx_init_zynqmp(struct dwc3_xlnx *priv_data)
 	if (ret < 0)
 		goto err_phy_exit;
 
-skip_usb3_phy:
 	/* ulpi reset via gpio-modepin or gpio-framework driver */
 	reset_gpio = devm_gpiod_get_optional(dev, "reset", GPIOD_OUT_HIGH);
 	if (IS_ERR(reset_gpio)) {
-- 
2.53.0

