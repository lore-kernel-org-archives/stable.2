Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4F2C332EBB
	for <stable@vger.kernel.org>; Fri, 14 Aug 2026 19:50:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786737047; cv=none; b=c378p0NTAekaYsLJN+SGiP9G2e9+/MIYcI6j5GkVkRUYQIOiIfWQaIathBP9GEnYDFrGO2wdBZLm659DPnYmuP+1rqMwcdJN2zVBdsD8am6AuOjEMf4DIF+sSD1+642GkRRv6GZIX8P5o2it21Ccaey+Glfj7/pEJGLRuVYb9sw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786737047; c=relaxed/simple;
	bh=4ZK/xWvk1M6BjKJGtPusdcvzcCKi8KfG5Y7W/o8k0dk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HAqO/hR49hEghpxZ11S76riya7NDbM9O9QD+stszA0eTMOny51VGxsV6OQl+ia+renzyJnMdR33hT473UtaI84mUNb5/3GsxHHIBx6i6aqrGEPwdGoOOHqlsblXckz48MtjNEUiwvDCh+8FIoeYvfDZUfjQ1NJhOAbWso3xjk6E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=irMM0u8I; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="irMM0u8I"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 017161F00A3A;
	Fri, 14 Aug 2026 19:50:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786737045;
	bh=zIM5JFMLtJomYo6C4wJDZIl/TKCaWRvpJ6zLVNk+TVo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=irMM0u8IrGQ1j5QLrH0dvAhffPomVyeDNU+KlPt99Txk7ABh77AYuZL7RbIe/SfMX
	 xvp/JikVI34uryawWTJqAtS+ezxPZj623iTM2fF5AGR+5YyPcqvDpWKSwv0yomrhNU
	 fhpyThYFcBzOoCKGRuyR0TmARe81ReJPToiHpiFUsl+pBwW7p3yLMOQF9eR2bmCl1w
	 kYAZxnhoV4unkWODwlNsqwcFGNGuKUfb67l/omlMWOz8s6b0EusZMa+fCcQPuWcmL0
	 ogzHIrSDiibCpTFNuGoX5DtJJlCnAdUBnTx4Kve37deN4I25NozeVtBXxz1WcfTllI
	 1PB/c1HDCoc6w==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Biju Das <biju.das.jz@bp.renesas.com>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Marc Kleine-Budde <mkl@pengutronix.de>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y 2/4] can: rcar_canfd: Use devm_clk_get_optional() for RAM clk
Date: Fri, 14 Aug 2026 15:50:39 -0400
Message-ID: <20260814195041.365045-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260814195041.365045-1-sashal@kernel.org>
References: <2026080504-effects-snap-d572@gregkh>
 <20260814195041.365045-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Biju Das <biju.das.jz@bp.renesas.com>

[ Upstream commit eda3d6c8d784835cec86f42b3f8118c9eb0cc58c ]

Replace devm_clk_get_optional_enabled()->devm_clk_get_optional() as the
RAM clk needs to be enabled in resume for proper operation in STR mode
for RZ/G3E SoC.

Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Link: https://patch.msgid.link/20251124102837.106973-4-biju.das.jz@bp.renesas.com
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
Stable-dep-of: bef9004c5b91 ("can: rcar_canfd: change the initializing flow for clocks and resets")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/can/rcar/rcar_canfd.c | 19 ++++++++++++++++++-
 1 file changed, 18 insertions(+), 1 deletion(-)

diff --git a/drivers/net/can/rcar/rcar_canfd.c b/drivers/net/can/rcar/rcar_canfd.c
index 7fc9e9f67bf64..f107b55dbf1d2 100644
--- a/drivers/net/can/rcar/rcar_canfd.c
+++ b/drivers/net/can/rcar/rcar_canfd.c
@@ -542,6 +542,7 @@ struct rcar_canfd_global {
 	struct platform_device *pdev;	/* Respective platform device */
 	struct clk *clkp;		/* Peripheral clock */
 	struct clk *can_clk;		/* fCAN clock */
+	struct clk *clk_ram;		/* Clock RAM */
 	enum rcar_canfd_fcanclk fcan;	/* CANFD or Ext clock */
 	unsigned long channels_mask;	/* Enabled channels mask */
 	bool fdmode;			/* CAN FD or Classical CAN only mode */
@@ -1915,6 +1916,11 @@ static int rcar_canfd_probe(struct platform_device *pdev)
 		/* CANFD clock is further divided by (1/2) within the IP */
 		fcan_freq /= 2;
 
+	gpriv->clk_ram = devm_clk_get_optional(&pdev->dev, "ram_clk");
+	if (IS_ERR(gpriv->clk_ram))
+		return dev_err_probe(&pdev->dev, PTR_ERR(gpriv->clk_ram),
+				     "cannot get ram clock\n");
+
 	addr = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(addr)) {
 		err = PTR_ERR(addr);
@@ -1979,10 +1985,18 @@ static int rcar_canfd_probe(struct platform_device *pdev)
 		goto fail_reset;
 	}
 
+	/* Enable RAM clock  */
+	err = clk_prepare_enable(gpriv->clk_ram);
+	if (err) {
+		dev_err(&pdev->dev, "failed to enable RAM clock: %pe\n",
+			ERR_PTR(err));
+		goto fail_clk;
+	}
+
 	err = rcar_canfd_reset_controller(gpriv);
 	if (err) {
 		dev_err(&pdev->dev, "reset controller failed\n");
-		goto fail_clk;
+		goto fail_ram_clk;
 	}
 
 	/* Controller in Global reset & Channel reset mode */
@@ -2032,6 +2046,8 @@ static int rcar_canfd_probe(struct platform_device *pdev)
 		rcar_canfd_channel_remove(gpriv, ch);
 fail_mode:
 	rcar_canfd_disable_global_interrupts(gpriv);
+fail_ram_clk:
+	clk_disable_unprepare(gpriv->clk_ram);
 fail_clk:
 	clk_disable_unprepare(gpriv->clkp);
 fail_reset:
@@ -2056,6 +2072,7 @@ static int rcar_canfd_remove(struct platform_device *pdev)
 
 	/* Enter global sleep mode */
 	rcar_canfd_set_bit(gpriv->base, RCANFD_GCTR, RCANFD_GCTR_GSLPR);
+	clk_disable_unprepare(gpriv->clk_ram);
 	clk_disable_unprepare(gpriv->clkp);
 	reset_control_assert(gpriv->rstc2);
 	reset_control_assert(gpriv->rstc1);
-- 
2.53.0

