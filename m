Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795710260;
	b=XTL7xvktA8hnOpBOPygr6gDn/lV+N956RNpZZ87wurdHHWCeH/FMiznH5RCeDwceo3A/
	 3oYCFhn+qwMWrNgEQ59X5wa5l5tzvAxc3ANe8KheWk0/37rBzCICaKP0nFV5CkdKaBcwx
	 Mqd3JI4qcgpi09HYWdnfMcpogXwjPMTjL50zDzSWQpAtNrvrgroeXffB+OYet883maVYV
	 SkY91LuraMSCYyE86k6Rtw5Ov+vTB9Y0WlS89HMei/238guNM7CEiY2wVXLtvuFxmk3JI
	 maVVHZZ2A84RnX2bbaRogF76YjPKUmTKXJLi9T52HKWSrb4YYU+EtDms7C868yGzMpg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795710260;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=dBUTpxVMZIeGwR97H0+zCKmZHwiY2GBlH9fDmkpLKSo=;
	b=FuU5JCWE/RZgU5olow7fv0KFZGUJ5tejBguNI5eDFLO7XniCkJ/+cjsq/EF7BQsN2y/T
	 ob98uXqHoIhe/l3WGhxaIPsJpHjVLyYz3ClhZwTocSx1BQhfiihyL8v8ciM4Ez6T8CxZe
	 4hizxOa8cB94GfQAUmrzkLHCqyd1xXyHYWehrq9ffi6B9Xf4j4Xcss49fYZTc6+B20iAl
	 3yWeXavP8cX8HMq57oStbZi1T1L1svirveBSpC2+pByL3uWOapbZMLcUfSjMMUUiyXyPE
	 LHEucw8WzeL5/8IO+eK0str4KqOThAwyhzlxsYOcl/ePkRbNvEKWJkJksLguvIYwI7g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=b42ktHfC;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D273C606A31E
	for <stable@vger.kernel.org>; Thu, 26 Nov 2026 16:24:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=b42ktHfC
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BDB821F000C4;
	Thu, 26 Nov 2026 16:24:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795710260;
	bh=dBUTpxVMZIeGwR97H0+zCKmZHwiY2GBlH9fDmkpLKSo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=b42ktHfCZMXaIatyum8UHbg7zPPCn7573CiM2eEwBVoXCbe7RDh2TgbAvzOL2QoTx
	 w9KMizk3LDB1nMJdH1alFxoAgC0Aoxkt74W+OK7i5ffBQsRKpQu9SlkB4UHbk2Nbk4
	 tFl6gJ1XR0IZDdSxB7RFEhBG3MAExfg6GpipDqhWtByfERsZKKTxeIUx47nCV2p7LM
	 QafJud1yZzmEbIF8kANFMKmhg+ZKkIL+KE8QXPJX1+Vv+N50rAfvwMPzYCvDzZ1m/x
	 F5Mfh4cyElrzQuhgwP9nUyxQMcfzonGKyjSs3QXP5AsUdFHWijV+g7cFup5foivGqx
	 W5ewTUz5v6ZnQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sean Anderson <sean.anderson@linux.dev>,
	Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y 1/2] usb: dwc3: Always deassert xilinx resets
Date: Thu, 26 Nov 2026 11:24:17 -0500
Message-ID: <20261126162403.2581038-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026112502-strategic-poking-d0b2@gregkh>
References: <2026112502-strategic-poking-d0b2@gregkh>
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
index d70bd11a09afe..56e6ff46cea82 100644
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

