Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C51C4137A8
	for <stable@vger.kernel.org>; Mon,  3 Aug 2026 14:18:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785766730; cv=none; b=gjCC15smhNbjx4EKli0v4JtrIR6/Ni//to2C/I5MbgWU8cU0Ni4erl81HZE5PVzRNEDdpf6vx3hDlTsinDsFZItvUBkx8fOlIlxEKTnk3T2t7bEuj/dxRRIh1CdJ6yFVRbmxpz+X0Jcb+Z21cfXCWwdEYCceUzAaGT3FoXA3gsY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785766730; c=relaxed/simple;
	bh=2pRQDrFLqD6lxYrBaH/YXhIbhabJXcqWjd6+JRcnin4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=j+XElBAsrGQSrTHa1FyKgIncKgq/k3esCEM0/c34f3MV8WF+zoya8RhuHxJTBH9IRuf+rF9WkrBLRLO7u++D8vCcwp5kqx4lhepWrxF0AV/xX2HGew1b6oBZTkoatk6SeSgq1CLqSp5MzenXhGQYcxfkuZe1l8tgtAEMXwB+hWM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TFs731V1; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TFs731V1"
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-38f620399a0so2730989a91.2
        for <stable@vger.kernel.org>; Mon, 03 Aug 2026 07:18:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785766729; x=1786371529; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=39P+RjortWOVFz9ynTB4fEoB3TRNicn/WbIapoTBl4w=;
        b=TFs731V1Lm0Op1AtTBdIEqJ2Vdpee95yy6VV76/J44VfLOjxp2S8PLKrjeKLZbJKmP
         To6JChvF88/I+XtrXodaYsrJ1LRZe6ZaBd1s2BBG1uoat/V7V6JgOh1He9vzpj5eIG6X
         3xv0szZGcS922BXYXjk2v3gD9jvcGJ1ZiTEshanlFVqbEOV1i9bH4rPSb9Sw1G/6TvbH
         +UBJIrCOoMVzGrfTFfO+2qmgNKMzJbyazhEyFptTNDCqJd9+LCBWFr1UGKJv4WvEH6+F
         fMuYDrlz4J+NM1j43Dr5wBfPaPZtJ6nGmpEIosCo0djpeQmLqMnqQsT3+Ey+PZJlmLCO
         rdWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785766729; x=1786371529;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=39P+RjortWOVFz9ynTB4fEoB3TRNicn/WbIapoTBl4w=;
        b=a8IVEyCMjcBZ2ZxKTZWWgPlecucDsv9k5YNt4qB1/78ciTmc0ATCykSWQ2T7n9OS29
         ObaXFcRw0y6kpD1Lp/CqnbSfPafU4kiOz+FeGyGd+iDdwcbketowYuo1SVYDPdGtrCb7
         +bbfzlXttgObMH1qRKqCzibjB32mKDVWEg2tBgUntVu4q4zbA2S6tre/LFL3Ys/rsAEU
         UALkg7OFiRPzNAY5dJcfS64kW77sk7BOlMeaHN5sy3ViGkQ8rdSPnh8vBvur6Lvlq96K
         RrlLfEobuI291CSg1l+6+26I6FBHFx+5sGnnI9fiaEFW710pZHkXFm4SzWJuSdFebGIB
         UxWg==
X-Forwarded-Encrypted: i=1; AHgh+Ro/iS3VWASUq9YcgjMDx+DV/t4B19bK8s602qyA/8XRGXNrJa/2G8yG+eFZFUHTU/MTHtApdK8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyey4TBztg2XB3CnHcPpks7ll5ESDNuWBy32eA0Eeq+afT7nHK+
	pP46PpcaxuLNA0GIKXs7Hqh3QTmoYJ/ip94rF1qROwi+42lUPz9B58cz
X-Gm-Gg: AR+sD13IJevDpedmReKIeSXLvZbI5+Zzro6mZZrAcbP5b6P6W9iUzFnx3G3zzp1H0Vr
	2j/h/nXRkvuTNJpKJ8Jd2UHnIuz6XyZpNYEjYbJHUFEMMfIuHB5XS5XjQnmaqwOD88NbZ+zWnVj
	CuuD5+7HRSQkjVYWClYxPFTevsx1g5vO/nxpuNXVVUGKXbmmTyfTE/nZkTWG76MlJmMh3NXFZfh
	b1momkoO4nqPHG/odMWF/DqyuS18+yF36Lp13ecqyoiZ/CDfgD+fDeQdj7/l1z90p+IwDAGnTE4
	qJd/qq0yJQaF9JT5FA955bGKgVOwGfVoxzxKJ+OorIaO4dkFbURDq0081kcm92dHeeiqQgNS2Rv
	L9h2Vn7Kfq59S+RrTmpEIY378d5xDbAFArJwWBgllXYugubYTOQskgVNg89Du8t3hxnC9TDkFqC
	sUyMgshiXfMSTq2JuFl6c0P1LQ02ofx9RiQd2ug14jVDnKnZhrivkycU7BD77j2AF4tbO6jeQo0
	FcW1n5d7KppEJk2oBpd
X-Received: by 2002:a17:90b:57ec:b0:380:83fc:4315 with SMTP id 98e67ed59e1d1-38fbc4ae59bmr10160754a91.21.1785766728867;
        Mon, 03 Aug 2026 07:18:48 -0700 (PDT)
Received: from buffalo-ssd (M014013071096.v4.enabler.ne.jp. [14.13.71.96])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-38fb30dff2esm4078462a91.13.2026.08.03.07.18.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Aug 2026 07:18:48 -0700 (PDT)
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
Subject: [PATCH 18/32] clk: mediatek: mt6797: Switch to common probe/remove helpers
Date: Mon,  3 Aug 2026 23:16:45 +0900
Message-ID: <20260803141659.559129-19-akkun11.open@gmail.com>
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

The MT6797 clock drivers can use the MediaTek clock framework
common initialization sequence. Reduce boilerplate code by creating
struct mtk_clk_desc and using the mtk_clk_simple_probe/remove helpers.

Drop the CLK_OF_DECLARE_DRIVER early init for infracfg; the kernel's
deferred probe mechanism ensures dependent drivers like cpufreq are
initialized correctly.

Since all MT6797 clock drivers can now be built as modules,
change Kconfig setting to "tristate".

Signed-off-by: Akari Tsuyukusa <akkun11.open@gmail.com>
---
 drivers/clk/mediatek/Kconfig      |   2 +-
 drivers/clk/mediatek/clk-mt6797.c | 140 +++++-------------------------
 2 files changed, 24 insertions(+), 118 deletions(-)

diff --git a/drivers/clk/mediatek/Kconfig b/drivers/clk/mediatek/Kconfig
index b58656a7e8c3..f5460ce3ffba 100644
--- a/drivers/clk/mediatek/Kconfig
+++ b/drivers/clk/mediatek/Kconfig
@@ -342,7 +342,7 @@ config COMMON_CLK_MT6795_VENCSYS
 	  This driver supports MediaTek MT6795 vencsys clocks.
 
 config COMMON_CLK_MT6797
-	bool "Clock driver for MediaTek MT6797"
+	tristate "Clock driver for MediaTek MT6797"
 	depends on (ARCH_MEDIATEK && ARM64) || COMPILE_TEST
 	select COMMON_CLK_MEDIATEK
 	default ARCH_MEDIATEK && ARM64
diff --git a/drivers/clk/mediatek/clk-mt6797.c b/drivers/clk/mediatek/clk-mt6797.c
index ebf850ac57f5..1934420375e8 100644
--- a/drivers/clk/mediatek/clk-mt6797.c
+++ b/drivers/clk/mediatek/clk-mt6797.c
@@ -379,29 +379,13 @@ static const struct mtk_composite top_muxes[] = {
 	    0x0104, 1, 2),
 };
 
-static int mtk_topckgen_init(struct platform_device *pdev)
-{
-	struct clk_hw_onecell_data *clk_data;
-	void __iomem *base;
-	struct device_node *node = pdev->dev.of_node;
-
-	base = devm_platform_ioremap_resource(pdev, 0);
-	if (IS_ERR(base))
-		return PTR_ERR(base);
-
-	clk_data = mtk_alloc_clk_data(CLK_TOP_NR);
-	if (!clk_data)
-		return -ENOMEM;
-
-	mtk_clk_register_factors(top_fixed_divs, ARRAY_SIZE(top_fixed_divs),
-				 clk_data);
-
-	mtk_clk_register_composites(&pdev->dev, top_muxes,
-				    ARRAY_SIZE(top_muxes), base,
-				    &mt6797_clk_lock, clk_data);
-
-	return of_clk_add_hw_provider(node, of_clk_hw_onecell_get, clk_data);
-}
+static const struct mtk_clk_desc topckgen_desc = {
+	.factor_clks = top_fixed_divs,
+	.num_factor_clks = ARRAY_SIZE(top_fixed_divs),
+	.composite_clks = top_muxes,
+	.num_composite_clks = ARRAY_SIZE(top_muxes),
+	.clk_lock = &mt6797_clk_lock,
+};
 
 static const struct mtk_gate_regs infra0_cg_regs = {
 	.set_ofs = 0x0080,
@@ -539,58 +523,12 @@ static const struct mtk_fixed_factor infra_fixed_divs[] = {
 	FACTOR(CLK_INFRA_13M, "clk13m", "clk26m", 1, 2),
 };
 
-static struct clk_hw_onecell_data *infra_clk_data;
-
-static void mtk_infrasys_init_early(struct device_node *node)
-{
-	int r, i;
-
-	if (!infra_clk_data) {
-		infra_clk_data = mtk_alloc_clk_data(CLK_INFRA_NR);
-		if (!infra_clk_data)
-			return;
-
-		for (i = 0; i < CLK_INFRA_NR; i++)
-			infra_clk_data->hws[i] = ERR_PTR(-EPROBE_DEFER);
-	}
-
-	mtk_clk_register_factors(infra_fixed_divs, ARRAY_SIZE(infra_fixed_divs),
-				 infra_clk_data);
-
-	r = of_clk_add_hw_provider(node, of_clk_hw_onecell_get,
-				   infra_clk_data);
-	if (r)
-		pr_err("%s(): could not register clock provider: %d\n",
-		       __func__, r);
-}
-
-CLK_OF_DECLARE_DRIVER(mtk_infra, "mediatek,mt6797-infracfg",
-		      mtk_infrasys_init_early);
-
-static int mtk_infrasys_init(struct platform_device *pdev)
-{
-	int i;
-	struct device_node *node = pdev->dev.of_node;
-
-	if (!infra_clk_data) {
-		infra_clk_data = mtk_alloc_clk_data(CLK_INFRA_NR);
-		if (!infra_clk_data)
-			return -ENOMEM;
-	} else {
-		for (i = 0; i < CLK_INFRA_NR; i++) {
-			if (infra_clk_data->hws[i] == ERR_PTR(-EPROBE_DEFER))
-				infra_clk_data->hws[i] = ERR_PTR(-ENOENT);
-		}
-	}
-
-	mtk_clk_register_gates(&pdev->dev, node, infra_clks,
-			       ARRAY_SIZE(infra_clks), infra_clk_data);
-	mtk_clk_register_factors(infra_fixed_divs, ARRAY_SIZE(infra_fixed_divs),
-				 infra_clk_data);
-
-	return of_clk_add_hw_provider(node, of_clk_hw_onecell_get,
-				      infra_clk_data);
-}
+static const struct mtk_clk_desc infracfg_desc = {
+	.clks = infra_clks,
+	.num_clks = ARRAY_SIZE(infra_clks),
+	.factor_clks = infra_fixed_divs,
+	.num_factor_clks = ARRAY_SIZE(infra_fixed_divs),
+};
 
 #define MT6797_PLL_FMAX		(3000UL * MHZ)
 
@@ -646,68 +584,36 @@ static const struct mtk_pll_data plls[] = {
 	    0x2B4, 4, 0x2BC, 0x2B8, 0),
 };
 
-static int mtk_apmixedsys_init(struct platform_device *pdev)
-{
-	struct clk_hw_onecell_data *clk_data;
-	struct device_node *node = pdev->dev.of_node;
-
-	clk_data = mtk_alloc_clk_data(CLK_APMIXED_NR);
-	if (!clk_data)
-		return -ENOMEM;
-
-	mtk_clk_register_plls(&pdev->dev, plls, ARRAY_SIZE(plls), clk_data);
-
-	return of_clk_add_hw_provider(node, of_clk_hw_onecell_get, clk_data);
-}
+static const struct mtk_clk_desc apmixedsys_desc = {
+	.plls = plls,
+	.num_plls = ARRAY_SIZE(plls),
+};
 
 static const struct of_device_id of_match_clk_mt6797[] = {
 	{
 		.compatible = "mediatek,mt6797-topckgen",
-		.data = mtk_topckgen_init,
+		.data = &topckgen_desc,
 	}, {
 		.compatible = "mediatek,mt6797-infracfg",
-		.data = mtk_infrasys_init,
+		.data = &infracfg_desc,
 	}, {
 		.compatible = "mediatek,mt6797-apmixedsys",
-		.data = mtk_apmixedsys_init,
+		.data = &apmixedsys_desc,
 	}, {
 		/* sentinel */
 	}
 };
 MODULE_DEVICE_TABLE(of, of_match_clk_mt6797);
 
-static int clk_mt6797_probe(struct platform_device *pdev)
-{
-	int (*clk_init)(struct platform_device *);
-	int r;
-
-	clk_init = of_device_get_match_data(&pdev->dev);
-	if (!clk_init)
-		return -EINVAL;
-
-	r = clk_init(pdev);
-	if (r)
-		dev_err(&pdev->dev,
-			"could not register clock provider: %s: %d\n",
-			pdev->name, r);
-
-	return r;
-}
-
 static struct platform_driver clk_mt6797_drv = {
-	.probe = clk_mt6797_probe,
+	.probe = mtk_clk_simple_probe,
+	.remove = mtk_clk_simple_remove,
 	.driver = {
 		.name = "clk-mt6797",
 		.of_match_table = of_match_clk_mt6797,
 	},
 };
-
-static int __init clk_mt6797_init(void)
-{
-	return platform_driver_register(&clk_mt6797_drv);
-}
-
-arch_initcall(clk_mt6797_init);
+module_platform_driver(clk_mt6797_drv);
 
 MODULE_DESCRIPTION("MediaTek MT6797 main clocks driver");
 MODULE_LICENSE("GPL");
-- 
2.55.0

