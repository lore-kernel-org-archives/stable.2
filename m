Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794337688;
	b=kuITT6dykE3vxhUimHtZmGWfUP7S0k1HNJkKP3zp2xIRY8Bll1XwwPTB39O50Vu2JxMs
	 J62jCM0Gs00MUpeZIXrBmwSyDM7GiQZqr3Hc+IFo2TTwdyTXq+cEvPK37IDmDTJQ5rGku
	 K/qls8J7/t3dg5bP5Mt4pGKtLJ1VubvHPGnvmtrwZMTAPor+7KDMU6lDyGm8W/vvb2piv
	 Ky+G5NuaiCESrToKqGXCMlyaoQn76rQArGZ6nfLubRIE0vhdah0QLxQ6uX0s2IvQOCEU3
	 knswAim71yMy3UyiB4zyxgqqY3Kslv3kn4vB9i9x9SCIm2fhoJ2bQbaV4Jgv9Ck/tdg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794337688;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=ZCl9XGgq4JyYJk6iOy8j4RsuULpXHsxw+8eeHCg3A+o=;
	b=X6gCiPv8VPogPjotD9X23InDQAPXVN+8RIGpU3wm5KRsLuyExBIW29oWzu4pxjwK0s5A
	 W4YdMCcG4gP/NwxSVVGlV/t9Ukdbr2BYSGnayE+/L3879uEYEZjHGIS198toP9m60Zksi
	 JDLFoRvQm++Ljq02i2NeW/3XnhouKInhoVWtTwUZs99nsGdIUEMTBnjezPCxCFZNI61i8
	 YAocYlPfvrOqSdH9u6iMYF0PJ/nBUlSAGRyvz6RzX09PeMXr25L0XAPBGy8FaE5OuNnKQ
	 G2wV9hO0qHnpyyfgMXpEat6PD/0Ms71BPI1yiA+X42fRyE0vRrPzk54R7heudn2pSGw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=c0L+KehB;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CA4A606A327
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 19:08:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=c0L+KehB
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 71E0B1F008A2;
	Tue, 10 Nov 2026 19:08:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794337688;
	bh=ZCl9XGgq4JyYJk6iOy8j4RsuULpXHsxw+8eeHCg3A+o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=c0L+KehB4ukWmU0yx0ttpaRx/EzDk5QvEqtNJwQaKNMfPfkTUsRNUeFMT93MhpKA5
	 wnfY3GHUGtpbkcVmXupM0Q0gN4V96I08Yc33wvY+VktIK3yBBWD9RjEIuR+3fGq2Rz
	 mrv4pDKsgDOeHft6wqnBN4vekiC58DIyAZ69K3d+2FqEwF+TRwqzYG4Zdmo0pYbL/m
	 dXimMKBlKled/U9akC1h76wMd25h/yrgqXtON38NdQt9sqTb7rM4vHwhsrepTMsTUb
	 k8nShx6RFggUhJSAK6APEx4/X+1lZGo8SCC3t0nh+lFELdwXGer2ssC0xbPFPVBJVL
	 9isYtUBQYiSEg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Guangshuo Li <lgs201920130244@gmail.com>,
	Thomas Gleixner <tglx@kernel.org>,
	Frank Li <Frank.Li@nxp.com>,
	Radu Rendec <radu@rendec.net>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y 2/2] irqchip/imx-intmux: Fix runtime PM teardown on remove
Date: Tue, 10 Nov 2026 14:08:04 -0500
Message-ID: <20261110190704.3466855-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261110190704.3466855-1-sashal@kernel.org>
References: <20261107062335-failed-5.10-b167c1a30e9e@kernel.org>
 <20261110190704.3466855-1-sashal@kernel.org>
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

From: Guangshuo Li <lgs201920130244@gmail.com>

[ Upstream commit b167c1a30e9e020e4c5e102c7a555943742c024b ]

imx_intmux_probe() enables the IPG clock and then drops its runtime PM
reference with pm_runtime_put(). With CONFIG_PM enabled, the runtime
suspend callback disables the IPG clock. With CONFIG_PM disabled, the
clock remains enabled after probe.

imx_intmux_remove() accesses the CHANIER registers without first making
sure that the device is runtime active. The device may therefore be
runtime suspended with the IPG clock disabled when these registers are
accessed. In addition, the remove path only calls pm_runtime_disable()
and does not balance the clock enable when CONFIG_PM is disabled.

Resume the device and acquire a runtime PM reference before accessing
the registers. If resume fails, skip the register accesses but still
tear down the chained handlers and IRQ domains. Disable runtime PM
afterwards, drop the acquired reference without triggering another
runtime suspend, and explicitly disable the IPG clock.

This keeps the clock enabled while the hardware registers are accessed
and balances the clk_prepare_enable() performed during probe for both
CONFIG_PM configurations.

This issue was found by manual code inspection.

Fixes: bb403111e017 ("irqchip/imx-intmux: Implement intmux runtime power management")
Signed-off-by: Guangshuo Li <lgs201920130244@gmail.com>
Signed-off-by: Thomas Gleixner <tglx@kernel.org>
Reviewed-by: Frank Li <Frank.Li@nxp.com>
Reviewed-by: Radu Rendec <radu@rendec.net>
Cc: stable@vger.kernel.org
Link: https://patch.msgid.link/20260914134211.1734163-1-lgs201920130244@gmail.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/irqchip/irq-imx-intmux.c | 15 ++++++++++++---
 1 file changed, 12 insertions(+), 3 deletions(-)

diff --git a/drivers/irqchip/irq-imx-intmux.c b/drivers/irqchip/irq-imx-intmux.c
index 576f28c9ebdb3..37f9be67f7c58 100644
--- a/drivers/irqchip/irq-imx-intmux.c
+++ b/drivers/irqchip/irq-imx-intmux.c
@@ -289,12 +289,16 @@ static int imx_intmux_probe(struct platform_device *pdev)
 static void imx_intmux_remove(struct platform_device *pdev)
 {
 	struct intmux_data *data = platform_get_drvdata(pdev);
-	int i;
+	int i, ret;
+
+	ret = pm_runtime_resume_and_get(&pdev->dev);
+	if (ret < 0)
+		dev_warn(&pdev->dev, "failed to resume device: %d\n", ret);
 
 	for (i = 0; i < data->channum; i++) {
 		/* disable all interrupt sources of this channel */
-		writel_relaxed(0, data->regs + CHANIER(i));
-
+		if (ret >= 0)
+			writel_relaxed(0, data->regs + CHANIER(i));
 		irq_set_chained_handler_and_data(data->irqchip_data[i].irq,
 						 NULL, NULL);
 
@@ -302,6 +306,11 @@ static void imx_intmux_remove(struct platform_device *pdev)
 	}
 
 	pm_runtime_disable(&pdev->dev);
+	if (ret >= 0) {
+		pm_runtime_put_noidle(&pdev->dev);
+		clk_disable_unprepare(data->ipg_clk);
+		pm_runtime_set_suspended(&pdev->dev);
+	}
 }
 
 #ifdef CONFIG_PM
-- 
2.53.0

