Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6F0B41A4E4
	for <stable@vger.kernel.org>; Mon,  3 Aug 2026 14:19:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785766791; cv=none; b=rN7icq0IBjXJ2V2OuLQhl03AzGK2z8D2emaEKHW6/xtpuZz24wrh/cjYt/a7cbNuyleS/7tDQZZs2tMZ8pUXqLUjD/uQlP8KUXyK2+GubvA0jG0S7p4dc5bAEyNIyvwhHDnmgtCUhJBlnlNBLqinq+qh2TD5BSBbuzPkSGSW+nw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785766791; c=relaxed/simple;
	bh=Zvi/v9GQjWY+QpP7E/KC/nJx/uAl9MsblO4lMOmqHHI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=u/+RE1JzlmbQCggygw+POZDDq+5JelifmrhOgckH6sONcwNAS5WerKGUEK+KDUSkw4bodw2jyuoUJHt8e93nC5UYzf81LxxLxuKktAMLr+Di/ayYSl4D+NKe2055ZJGuerRa2yGBFr4bUvruINyCW32ifCW6mqwXYFaYoiphBLw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TPPf/yR8; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TPPf/yR8"
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-382ef647e20so3628063a91.1
        for <stable@vger.kernel.org>; Mon, 03 Aug 2026 07:19:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785766789; x=1786371589; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=pVSyODgpLB8kzwF/P+aweBPyvt+kaNsYNaxOR9uV3rM=;
        b=TPPf/yR83nnutiJRJZIzuynbmBU7id9mXIa4Pn1uRgjUhrJrygr0a35DYvBu/YJSD2
         slT9bajxQaHfELqAw+5c3IyxV4sTGfkUugziOcoD92y++IDfKtMeumGopI+mm87Zs/RO
         ohBi1Zh8jrspBIU1c/XjIzEap1v9QoHLlZqgKJj3JRxpDHcigEoDkUs4wAQcq0Nin6ls
         LdBwiX9E+7Yi6SUYNQh+H1K1CApPvTLqIFzyKlu5wsQj+1fPQxsKWMCM/aLvvfGMs67a
         YmggHzEOZrLgDyBf5B/Irnowz1R9dDpM++7eKzGtb2N/dz7KgMezoehD1M/gXuuOsftD
         kH7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785766789; x=1786371589;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=pVSyODgpLB8kzwF/P+aweBPyvt+kaNsYNaxOR9uV3rM=;
        b=PlpYxeuF5CXqOeKpkVscfeM/D3w/oDRtYGiPKAPUHWZbADoF9mbwzNjB/lrSml69lm
         JnAcARevSTooD+Oeh0PjirPE3EdLQre6kd+cmP9xcaDa6a7C6TEygm+3EzoD4PPIU877
         75E6nh1HPDbcpdLqxzUkyRSEHT1bQbkPLiYQGF2/oUnOHUzNBNxRCMgNhk29o7fZuFTy
         sm2WOUbeqRrPNQwP8TWuuJEoZxDC/Lfq9QokDTRCZxu3FTOc1hkxgtjXiHw+B+NRXdkn
         8HNQv0wD4l7FnxD0deUazoi91CsYuhQ0QE3NCsHcobY//Mn4LSqIjIQyzqfiJsgTdFDo
         pjeg==
X-Forwarded-Encrypted: i=1; AHgh+Rr/+AmiR+BhK5vGKjiMSnkxatJD6u4m8PWsTpVtwJdYtgDBRFMKtePVL7wRKcQ8mIargQETnFE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwllMdvNKd7njfgk2bybGWu7woow20hr73sh6/kLTQ00uj+Avy5
	afiBhKfU7awDM0IC1urjIzQBguPTEOx2Q+pQ+xvkXQsGMQPgdSiyTLUn
X-Gm-Gg: AR+sD12CkvbttvzQdBamJOtEQ+skMHWX+/3pFd4+FIHOt+Bx5ptq1bBcEv7w7DeuZnV
	eUbcRG/B/87KgejJjenl1iQGTG6y0WxOJadApHKsZc+MazJbB+draSmqJJppjNou9d2UNyWzXxi
	auHqTBpXA+hwtG6jeC6pHgksho8Y4NFHnQzat6R5AfvVHzwqEq6c/97kQ6i0bACDxNkjF73LhU9
	okZcXkmxrJ18uniWMZ8WTbG4uxGLDJhasqYCVJYzID3d1vziqdjWqtHjMNKdbSweWNLmIG2zGYV
	tThIJs+OSvYPhbk0IoZTUoQk9H0NHsILHD3hISaIKLe04ZY28hmyP8pvt/AYqbTWBt2qNRB7EJa
	Lh3nKN2SW9rgRVMoBmHNR+H+MWy8Z8TGo99n07cS+E1m34fCrbZtnBb8SxDSHYlKxNKy8Lsy5Q1
	UJ4WoevQgRAMuv3mC/++1tkKi7sTJ6diy599NUE7Aic7cDaBWGWHDa2Ed+VizKYmP3EWaPK0t0a
	tkSGIwRDomHpAvRbu/9
X-Received: by 2002:a17:90a:d2c8:b0:381:1c96:829b with SMTP id 98e67ed59e1d1-38fbc40e00cmr8678919a91.3.1785766788659;
        Mon, 03 Aug 2026 07:19:48 -0700 (PDT)
Received: from buffalo-ssd (M014013071096.v4.enabler.ne.jp. [14.13.71.96])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-38fb30dff2esm4078462a91.13.2026.08.03.07.19.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Aug 2026 07:19:48 -0700 (PDT)
From: Akari Tsuyukusa <akkun11.open@gmail.com>
To: Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Brian Masney <bmasney@redhat.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Yassine Oudjana <y.oudjana@protonmail.com>,
	Richard Cochran <richardcochran@gmail.com>
Cc: Laura Nao <laura.nao@collabora.com>,
	=?UTF-8?q?N=C3=ADcolas=20F=2E=20R=2E=20A=2E=20Prado?= <nfraprado@collabora.com>,
	Chen-Yu Tsai <wenst@chromium.org>,
	Akari Tsuyukusa <akkun11.open@gmail.com>,
	Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>,
	Danilo Krummrich <dakr@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig=20=28The=20Capable=20Hub=29?= <u.kleine-koenig@baylibre.com>,
	Nicolas Frattaroli <nicolas.frattaroli@collabora.com>,
	Takashi Sakamoto <o-takashi@sakamocchi.jp>,
	Haotian Zhang <vulab@iscas.ac.cn>,
	Kees Cook <kees@kernel.org>,
	Miles Chen <miles.chen@mediatek.com>,
	Daniel Golle <daniel@makrotopia.org>,
	Sam Shih <sam.shih@mediatek.com>,
	linux-clk@vger.kernel.org (open list:COMMON CLK FRAMEWORK),
	linux-kernel@vger.kernel.org (open list),
	linux-arm-kernel@lists.infradead.org (moderated list:ARM/Mediatek SoC support),
	linux-mediatek@lists.infradead.org (moderated list:ARM/Mediatek SoC support),
	netdev@vger.kernel.org (open list:PTP HARDWARE CLOCK SUPPORT:Keyword:(?:\b|_)ptp(?:\b|_)),
	stable@vger.kernel.org
Subject: [PATCH 31/32] clk: mediatek: mt8196: Switch to common probe/remove helpers
Date: Mon,  3 Aug 2026 23:16:58 +0900
Message-ID: <20260803141659.559129-32-akkun11.open@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260803141659.559129-1-akkun11.open@gmail.com>
References: <20260803141659.559129-1-akkun11.open@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The MT8196 apmixedsys, mcusys and mfg clock drivers can use the
MediaTek clock framework common initialization sequence.
Reduce boilerplate code by creating struct mtk_clk_desc and using the
mtk_clk_simple_probe/remove helpers.

Note that the vlpckgen driver is excluded from this conversion because
its probe callback needs to initialize the APLL tuner registers, which
is not currently supported by the common simple probe helper.

Signed-off-by: Akari Tsuyukusa <akkun11.open@gmail.com>
---
 drivers/clk/mediatek/clk-mt8196-apmixedsys.c | 67 ++------------
 drivers/clk/mediatek/clk-mt8196-mcu.c        | 96 +++++++-------------
 drivers/clk/mediatek/clk-mt8196-mfg.c        | 84 +++++------------
 3 files changed, 63 insertions(+), 184 deletions(-)

diff --git a/drivers/clk/mediatek/clk-mt8196-apmixedsys.c b/drivers/clk/mediatek/clk-mt8196-apmixedsys.c
index c4ebb0170b82..a20fa02070a8 100644
--- a/drivers/clk/mediatek/clk-mt8196-apmixedsys.c
+++ b/drivers/clk/mediatek/clk-mt8196-apmixedsys.c
@@ -86,11 +86,6 @@
 		.ops = &mtk_pll_fenc_clr_set_ops,		\
 }
 
-struct mtk_pll_desc {
-	const struct mtk_pll_data *clks;
-	size_t num_clks;
-};
-
 static const struct mtk_pll_data apmixed_plls[] = {
 	PLL_FENC(CLK_APMIXED_MAINPLL, "mainpll", MAINPLL_CON0, FENC_STATUS_CON0,
 		 7, PLL_AO, MAINPLL_CON1, 24, MAINPLL_CON1, 0, 22, 0),
@@ -110,9 +105,9 @@ static const struct mtk_pll_data apmixed_plls[] = {
 		 0, 0, SGMIIPLL_CON1, 24, SGMIIPLL_CON1, 0, 22, 7),
 };
 
-static const struct mtk_pll_desc apmixed_desc = {
-	.clks = apmixed_plls,
-	.num_clks = ARRAY_SIZE(apmixed_plls),
+static const struct mtk_clk_desc apmixed_desc = {
+	.plls = apmixed_plls,
+	.num_plls = ARRAY_SIZE(apmixed_plls),
 };
 
 static const struct mtk_pll_data apmixed2_plls[] = {
@@ -132,57 +127,11 @@ static const struct mtk_pll_data apmixed2_plls[] = {
 		 0, 0, TVDPLL3_CON1, 24, TVDPLL3_CON1, 0, 22, 6),
 };
 
-static const struct mtk_pll_desc apmixed2_desc = {
-	.clks = apmixed2_plls,
-	.num_clks = ARRAY_SIZE(apmixed2_plls),
+static const struct mtk_clk_desc apmixed2_desc = {
+	.plls = apmixed2_plls,
+	.num_plls = ARRAY_SIZE(apmixed2_plls),
 };
 
-static int clk_mt8196_apmixed_probe(struct platform_device *pdev)
-{
-	struct clk_hw_onecell_data *clk_data;
-	struct device_node *node = pdev->dev.of_node;
-	const struct mtk_pll_desc *mcd;
-	int r;
-
-	mcd = device_get_match_data(&pdev->dev);
-	if (!mcd)
-		return -EINVAL;
-
-	clk_data = mtk_alloc_clk_data(mcd->num_clks);
-	if (!clk_data)
-		return -ENOMEM;
-
-	r = mtk_clk_register_plls(&pdev->dev, mcd->clks, mcd->num_clks,
-				  clk_data);
-	if (r)
-		goto free_apmixed_data;
-
-	r = of_clk_add_hw_provider(node, of_clk_hw_onecell_get, clk_data);
-	if (r)
-		goto unregister_plls;
-
-	platform_set_drvdata(pdev, clk_data);
-
-	return r;
-
-unregister_plls:
-	mtk_clk_unregister_plls(mcd->clks, mcd->num_clks, clk_data);
-free_apmixed_data:
-	mtk_free_clk_data(clk_data);
-	return r;
-}
-
-static void clk_mt8196_apmixed_remove(struct platform_device *pdev)
-{
-	const struct mtk_pll_desc *mcd = device_get_match_data(&pdev->dev);
-	struct clk_hw_onecell_data *clk_data = platform_get_drvdata(pdev);
-	struct device_node *node = pdev->dev.of_node;
-
-	of_clk_del_provider(node);
-	mtk_clk_unregister_plls(mcd->clks, mcd->num_clks, clk_data);
-	mtk_free_clk_data(clk_data);
-}
-
 static const struct of_device_id of_match_clk_mt8196_apmixed[] = {
 	{ .compatible = "mediatek,mt8196-apmixedsys", .data = &apmixed_desc },
 	{ .compatible = "mediatek,mt8196-apmixedsys-gp2",
@@ -192,8 +141,8 @@ static const struct of_device_id of_match_clk_mt8196_apmixed[] = {
 MODULE_DEVICE_TABLE(of, of_match_clk_mt8196_apmixed);
 
 static struct platform_driver clk_mt8196_apmixed_drv = {
-	.probe = clk_mt8196_apmixed_probe,
-	.remove = clk_mt8196_apmixed_remove,
+	.probe = mtk_clk_simple_probe,
+	.remove = mtk_clk_simple_remove,
 	.driver = {
 		.name = "clk-mt8196-apmixed",
 		.of_match_table = of_match_clk_mt8196_apmixed,
diff --git a/drivers/clk/mediatek/clk-mt8196-mcu.c b/drivers/clk/mediatek/clk-mt8196-mcu.c
index 13642fc673c2..e392408c93b2 100644
--- a/drivers/clk/mediatek/clk-mt8196-mcu.c
+++ b/drivers/clk/mediatek/clk-mt8196-mcu.c
@@ -68,29 +68,44 @@
 		.pcwibits = MT8196_INTEGER_BITS,		\
 	}
 
-static const struct mtk_pll_data cpu_bl_plls[] = {
-	PLL(CLK_CPBL_ARMPLL_BL, "armpll-bl", ARMPLL_BL_CON0, ARMPLL_BL_CON0, 0,
-	    0, PLL_AO, BIT(0), ARMPLL_BL_CON1, 24, 0, 0, 0, ARMPLL_BL_CON1, 0, 22),
+static const struct mtk_clk_desc cpu_bl_plls = {
+	.plls = (const struct mtk_pll_data[]){
+		PLL(CLK_CPBL_ARMPLL_BL, "armpll-bl", ARMPLL_BL_CON0, ARMPLL_BL_CON0, 0,
+		    0, PLL_AO, BIT(0), ARMPLL_BL_CON1, 24, 0, 0, 0, ARMPLL_BL_CON1, 0, 22),
+	},
+	.num_plls = 1,
 };
 
-static const struct mtk_pll_data cpu_b_plls[] = {
-	PLL(CLK_CPB_ARMPLL_B, "armpll-b", ARMPLL_B_CON0, ARMPLL_B_CON0, 0, 0,
-	    PLL_AO, BIT(0), ARMPLL_B_CON1, 24, 0, 0, 0, ARMPLL_B_CON1, 0, 22),
+static const struct mtk_clk_desc cpu_b_plls = {
+	.plls = (const struct mtk_pll_data[]){
+		PLL(CLK_CPB_ARMPLL_B, "armpll-b", ARMPLL_B_CON0, ARMPLL_B_CON0, 0, 0,
+		    PLL_AO, BIT(0), ARMPLL_B_CON1, 24, 0, 0, 0, ARMPLL_B_CON1, 0, 22),
+	},
+	.num_plls = 1,
 };
 
-static const struct mtk_pll_data cpu_ll_plls[] = {
-	PLL(CLK_CPLL_ARMPLL_LL, "armpll-ll", ARMPLL_LL_CON0, ARMPLL_LL_CON0, 0,
-	    0, PLL_AO, BIT(0), ARMPLL_LL_CON1, 24, 0, 0, 0, ARMPLL_LL_CON1, 0, 22),
+static const struct mtk_clk_desc cpu_ll_plls = {
+	.plls = (const struct mtk_pll_data[]){
+		PLL(CLK_CPLL_ARMPLL_LL, "armpll-ll", ARMPLL_LL_CON0, ARMPLL_LL_CON0, 0,
+		    0, PLL_AO, BIT(0), ARMPLL_LL_CON1, 24, 0, 0, 0, ARMPLL_LL_CON1, 0, 22),
+	},
+	.num_plls = 1,
 };
 
-static const struct mtk_pll_data cci_plls[] = {
-	PLL(CLK_CCIPLL, "ccipll", CCIPLL_CON0, CCIPLL_CON0, 0, 0, PLL_AO,
-	    BIT(0), CCIPLL_CON1, 24, 0, 0, 0, CCIPLL_CON1, 0, 22),
+static const struct mtk_clk_desc cci_plls = {
+	.plls = (const struct mtk_pll_data[]){
+		PLL(CLK_CCIPLL, "ccipll", CCIPLL_CON0, CCIPLL_CON0, 0, 0, PLL_AO,
+		    BIT(0), CCIPLL_CON1, 24, 0, 0, 0, CCIPLL_CON1, 0, 22),
+	},
+	.num_plls = 1,
 };
 
-static const struct mtk_pll_data ptp_plls[] = {
-	PLL(CLK_PTPPLL, "ptppll", PTPPLL_CON0, PTPPLL_CON0, 0, 0, PLL_AO,
-	    BIT(0), PTPPLL_CON1, 24, 0, 0, 0, PTPPLL_CON1, 0, 22),
+static const struct mtk_clk_desc ptp_plls = {
+	.plls = (const struct mtk_pll_data[]){
+		PLL(CLK_PTPPLL, "ptppll", PTPPLL_CON0, PTPPLL_CON0, 0, 0, PLL_AO,
+		    BIT(0), PTPPLL_CON1, 24, 0, 0, 0, PTPPLL_CON1, 0, 22),
+	},
+	.num_plls = 1,
 };
 
 static const struct of_device_id of_match_clk_mt8196_mcu[] = {
@@ -106,56 +121,9 @@ static const struct of_device_id of_match_clk_mt8196_mcu[] = {
 };
 MODULE_DEVICE_TABLE(of, of_match_clk_mt8196_mcu);
 
-static int clk_mt8196_mcu_probe(struct platform_device *pdev)
-{
-	const struct mtk_pll_data *plls;
-	struct clk_hw_onecell_data *clk_data;
-	struct device_node *node = pdev->dev.of_node;
-	const int num_plls = 1;
-	int r;
-
-	plls = of_device_get_match_data(&pdev->dev);
-	if (!plls)
-		return -EINVAL;
-
-	clk_data = mtk_alloc_clk_data(num_plls);
-	if (!clk_data)
-		return -ENOMEM;
-
-	r = mtk_clk_register_plls(&pdev->dev, plls, num_plls, clk_data);
-	if (r)
-		goto free_clk_data;
-
-	r = of_clk_add_hw_provider(node, of_clk_hw_onecell_get, clk_data);
-	if (r)
-		goto unregister_plls;
-
-	platform_set_drvdata(pdev, clk_data);
-
-	return r;
-
-unregister_plls:
-	mtk_clk_unregister_plls(plls, num_plls, clk_data);
-free_clk_data:
-	mtk_free_clk_data(clk_data);
-
-	return r;
-}
-
-static void clk_mt8196_mcu_remove(struct platform_device *pdev)
-{
-	const struct mtk_pll_data *plls = of_device_get_match_data(&pdev->dev);
-	struct clk_hw_onecell_data *clk_data = platform_get_drvdata(pdev);
-	struct device_node *node = pdev->dev.of_node;
-
-	of_clk_del_provider(node);
-	mtk_clk_unregister_plls(plls, 1, clk_data);
-	mtk_free_clk_data(clk_data);
-}
-
 static struct platform_driver clk_mt8196_mcu_drv = {
-	.probe = clk_mt8196_mcu_probe,
-	.remove = clk_mt8196_mcu_remove,
+	.probe = mtk_clk_simple_probe,
+	.remove = mtk_clk_simple_remove,
 	.driver = {
 		.name = "clk-mt8196-mcu",
 		.of_match_table = of_match_clk_mt8196_mcu,
diff --git a/drivers/clk/mediatek/clk-mt8196-mfg.c b/drivers/clk/mediatek/clk-mt8196-mfg.c
index a317183f1681..a209162f6207 100644
--- a/drivers/clk/mediatek/clk-mt8196-mfg.c
+++ b/drivers/clk/mediatek/clk-mt8196-mfg.c
@@ -61,22 +61,31 @@
 		.parent_name = "mfg_eb",			\
 	}
 
-static const struct mtk_pll_data mfg_ao_plls[] = {
-	PLL(CLK_MFG_AO_MFGPLL, "mfgpll", MFGPLL_CON0, MFGPLL_CON0, 0, 0,
-	    PLL_PARENT_EN, BIT(0), MFGPLL_CON1, 24, 0, 0, 0,
-	    MFGPLL_CON1, 0, 22),
+static const struct mtk_clk_desc mfg_ao_plls = {
+	.plls = (const struct mtk_pll_data[]){
+		PLL(CLK_MFG_AO_MFGPLL, "mfgpll", MFGPLL_CON0,
+		    MFGPLL_CON0, 0, 0, PLL_PARENT_EN, BIT(0),
+		    MFGPLL_CON1, 24, 0, 0, 0, MFGPLL_CON1, 0, 22),
+	},
+	.num_plls = 1,
 };
 
-static const struct mtk_pll_data mfgsc0_ao_plls[] = {
-	PLL(CLK_MFGSC0_AO_MFGPLL_SC0, "mfgpll-sc0", MFGPLL_SC0_CON0,
-	    MFGPLL_SC0_CON0, 0, 0, PLL_PARENT_EN, BIT(0), MFGPLL_SC0_CON1, 24,
-	    0, 0, 0, MFGPLL_SC0_CON1, 0, 22),
+static const struct mtk_clk_desc mfgsc0_ao_plls = {
+	.plls = (const struct mtk_pll_data[]){
+		PLL(CLK_MFGSC0_AO_MFGPLL_SC0, "mfgpll-sc0", MFGPLL_SC0_CON0,
+		    MFGPLL_SC0_CON0, 0, 0, PLL_PARENT_EN, BIT(0),
+		    MFGPLL_SC0_CON1, 24, 0, 0, 0, MFGPLL_SC0_CON1, 0, 22),
+	},
+	.num_plls = 1,
 };
 
-static const struct mtk_pll_data mfgsc1_ao_plls[] = {
-	PLL(CLK_MFGSC1_AO_MFGPLL_SC1, "mfgpll-sc1", MFGPLL_SC1_CON0,
-	    MFGPLL_SC1_CON0, 0, 0, PLL_PARENT_EN, BIT(0), MFGPLL_SC1_CON1, 24,
-	    0, 0, 0, MFGPLL_SC1_CON1, 0, 22),
+static const struct mtk_clk_desc mfgsc1_ao_plls = {
+	.plls = (const struct mtk_pll_data[]){
+		PLL(CLK_MFGSC1_AO_MFGPLL_SC1, "mfgpll-sc1", MFGPLL_SC1_CON0,
+		    MFGPLL_SC1_CON0, 0, 0, PLL_PARENT_EN, BIT(0),
+		    MFGPLL_SC1_CON1, 24, 0, 0, 0, MFGPLL_SC1_CON1, 0, 22),
+	},
+	.num_plls = 1,
 };
 
 static const struct of_device_id of_match_clk_mt8196_mfg[] = {
@@ -90,56 +99,9 @@ static const struct of_device_id of_match_clk_mt8196_mfg[] = {
 };
 MODULE_DEVICE_TABLE(of, of_match_clk_mt8196_mfg);
 
-static int clk_mt8196_mfg_probe(struct platform_device *pdev)
-{
-	const struct mtk_pll_data *plls;
-	struct clk_hw_onecell_data *clk_data;
-	struct device_node *node = pdev->dev.of_node;
-	const int num_plls = 1;
-	int r;
-
-	plls = of_device_get_match_data(&pdev->dev);
-	if (!plls)
-		return -EINVAL;
-
-	clk_data = mtk_alloc_clk_data(num_plls);
-	if (!clk_data)
-		return -ENOMEM;
-
-	r = mtk_clk_register_plls(&pdev->dev, plls, num_plls, clk_data);
-	if (r)
-		goto free_clk_data;
-
-	r = of_clk_add_hw_provider(node, of_clk_hw_onecell_get, clk_data);
-	if (r)
-		goto unregister_plls;
-
-	platform_set_drvdata(pdev, clk_data);
-
-	return r;
-
-unregister_plls:
-	mtk_clk_unregister_plls(plls, num_plls, clk_data);
-free_clk_data:
-	mtk_free_clk_data(clk_data);
-
-	return r;
-}
-
-static void clk_mt8196_mfg_remove(struct platform_device *pdev)
-{
-	const struct mtk_pll_data *plls = of_device_get_match_data(&pdev->dev);
-	struct clk_hw_onecell_data *clk_data = platform_get_drvdata(pdev);
-	struct device_node *node = pdev->dev.of_node;
-
-	of_clk_del_provider(node);
-	mtk_clk_unregister_plls(plls, 1, clk_data);
-	mtk_free_clk_data(clk_data);
-}
-
 static struct platform_driver clk_mt8196_mfg_drv = {
-	.probe = clk_mt8196_mfg_probe,
-	.remove = clk_mt8196_mfg_remove,
+	.probe = mtk_clk_simple_probe,
+	.remove = mtk_clk_simple_remove,
 	.driver = {
 		.name = "clk-mt8196-mfg",
 		.of_match_table = of_match_clk_mt8196_mfg,
-- 
2.55.0

