Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD077418A54
	for <stable@vger.kernel.org>; Mon,  3 Aug 2026 14:19:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785766786; cv=none; b=ai1kJvSIye2jg44yLV5m4SZvyFFYj4c/jjkVAvqDWGMDdjJitd7LjQ8Kl8PTHSsbRZ0uQuexjXDmJXBfmoi9Roe2VlnTW/9nj4bN31TwdbqAUtsDKqagwRn7VUDbrF3/MGADy/Nu5TQFUoBYs/OoLYpsUyQmBXnYMzI23RXTkqI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785766786; c=relaxed/simple;
	bh=IB0DHNnEK+6FXzL3QZAk3o6azeA38FIaaIhaI1EchEo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lN6zb7LPhX+xj2tO9NJ8+SyZxRTuLbTbRXUvELVRc8x8aEMrxaLUHscuup6S0zonrTEZde8dYABidpgseh9wKpOhqthcJgQgw3FlIVtTSs4djv0vAjZNHTCSrA1BnFv61eGQsuJislKbfYLSfNcDAtAwmhqON/FMpWE4JEXb4L0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NtAqHOel; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NtAqHOel"
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2d01663d816so26042255ad.1
        for <stable@vger.kernel.org>; Mon, 03 Aug 2026 07:19:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785766784; x=1786371584; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=MOFoWlQhXSMlLt2NpqseYEiE1kLb37cCFSxkURFuzbY=;
        b=NtAqHOelRR+JyQyTeNls2rTr2fCMqBusIEtbUCWLG9Pr+mwIpCRzx2HN9LmRsNmkhZ
         CU69bifuaVlhMIsk2dGgLTo7EG5i8zpYVIm32ACBMtWv+IVXFw624Cl3mD6kyiW0zXFH
         mKta8O4NEJ2jDkOopl5SH4SDs0bzNQ0J7xGrSjTivaKEMZFxvnezTiV+sqKYMU/f6ctA
         WVj+9lcZQ1g4YFgZF5RdVpZKf/5dNRPO0CMZ+6OZ3Mwx/lpZhc6K+XWlVaNRuVYj4sJD
         n82gZzf7sk9IDi9TqFj84R8woIFXTBa+jU/0IYkSTRI35t22+tpsXMGvfq17C3ujOmzH
         dDkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785766784; x=1786371584;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=MOFoWlQhXSMlLt2NpqseYEiE1kLb37cCFSxkURFuzbY=;
        b=mHSQZg7zC4HGLA0D8QUxtsiXIcMrmtASYwrlFAERkif9+h7jwf8KJniOYoW1N04b2B
         XbEN7Ofa/2eRCYFphHbBLwZgSQsC/wjfcyzhlTt6JmBD8muwr/NGJj2LwcQIP1mRcUGP
         Y2LLvp28ZYqQq7mlCJQ18cEWWaFMIq4rH3qCgcI16az7GijFTxr46sEtH8cvjkgAErGW
         WRibauObwHOFSd4KZ+uPfMebExrYLxBtTMeXElO1GJESlN3LQOlRRgWSHSakguvVARTU
         LSnxg5BjclI6+nT653UHg0vdiToy+2HkuFNf+dvJVa6rnVSxAyC3FUClwA3F5LnlPJ8H
         YiCQ==
X-Forwarded-Encrypted: i=1; AHgh+RpjztvVoapXsxiejLeBhZZziF+K5rGuqFcIroTP/4kPWQeeFdHsRkz/rblDjM91xQhdbbWNwYU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzQ79UFGJDxTg01V7XhS5BkZ/tOjhEpNgYJtMI/Ibcjih1Ve4HS
	KNIDEjS4G6T5f950lqXWt3yXR6s5SWRKQu7Ef38ms2KpmqwZoE1qNxuo
X-Gm-Gg: AR+sD107YThyuwn8pxeXD77BUeqanEAaG2iVpOwZnGDqOIUd++BPzUQBmSEgQhsgD7Q
	eqouvpUJnAGfpFDPRnWMC+XV+7i3Gr+YgNHj18GnJo4CdSGWODnR3/EYByzm3KZ0qaL0fmf0ZkJ
	ct5AUteBzxql/4l5CtAyOIXc5dMHLw9vwvs8luq+gcC0wXNxd9fTGxVD25a42F9B0FaDpfnRRxz
	JTQ62ppht2brU+bOoGoyudbmp5FG6oTufR1AJL/4egV30YasZoW107Z6RpDzMNR7Ifp9eNEF3MF
	iMcE2xcsnUxH/Gr4ncHi6k36UG2PXzAeEsjrzYETjasBqMR7ghuJtxaW1XDoEFLW65jEMToJPhq
	XgVRDQtslGt13RXDeTDnZT6gd6Nnnh9EcSVi/3CGbgzvrt5t/o8mWfwe18M+WMNexeh+FA0HbkI
	sYpMXXByA89mZLwfEU9mIW43FzHsBPIs5ILMBxHMVTJiS11oZkmWbmfTz6VziIVxbGgRDvG0544
	Ms86LIQ0w+3lpTa1dU4
X-Received: by 2002:a17:90b:58c3:b0:389:8f6c:4d59 with SMTP id 98e67ed59e1d1-38fbc4bc3cbmr9364512a91.24.1785766784006;
        Mon, 03 Aug 2026 07:19:44 -0700 (PDT)
Received: from buffalo-ssd (M014013071096.v4.enabler.ne.jp. [14.13.71.96])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-38fb30dff2esm4078462a91.13.2026.08.03.07.19.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Aug 2026 07:19:43 -0700 (PDT)
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
Subject: [PATCH 30/32] clk: mediatek: mt8195: Switch to common probe/remove helpers
Date: Mon,  3 Aug 2026 23:16:57 +0900
Message-ID: <20260803141659.559129-31-akkun11.open@gmail.com>
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

The MT8195 apusys_pll and apmixedsys drivers can use the MediaTek clock
framework common initialization sequence. Reduce boilerplate code by
creating struct mtk_clk_desc and using the mtk_clk_simple_probe/remove
helpers.

Note that the topckgen driver is excluded from this conversion because
it requires devm_mtk_clk_mux_notifier_register(), which is not
currently supported by the common simple probe helper.

Since all MT8195 clock drivers can now be built as modules,
change Kconfig setting to "tristate".

Signed-off-by: Akari Tsuyukusa <akkun11.open@gmail.com>
---
 drivers/clk/mediatek/Kconfig                 | 12 ++--
 drivers/clk/mediatek/clk-mt8195-apmixedsys.c | 67 ++++----------------
 drivers/clk/mediatek/clk-mt8195-apusys_pll.c | 49 ++------------
 3 files changed, 25 insertions(+), 103 deletions(-)

diff --git a/drivers/clk/mediatek/Kconfig b/drivers/clk/mediatek/Kconfig
index 6449b77d56ed..ac992cfc6c3e 100644
--- a/drivers/clk/mediatek/Kconfig
+++ b/drivers/clk/mediatek/Kconfig
@@ -909,13 +909,13 @@ config COMMON_CLK_MT8192_VENCSYS
 	  This driver supports MediaTek MT8192 vencsys clocks.
 
 config COMMON_CLK_MT8195
-        bool "Clock driver for MediaTek MT8195"
-        depends on ARM64 || COMPILE_TEST
-        select COMMON_CLK_MEDIATEK
+	tristate "Clock driver for MediaTek MT8195"
+	depends on ARM64 || COMPILE_TEST
+	select COMMON_CLK_MEDIATEK
 	select COMMON_CLK_MEDIATEK_FHCTL
-        default ARCH_MEDIATEK
-        help
-          This driver supports MediaTek MT8195 clocks.
+	default ARCH_MEDIATEK
+	help
+	  This driver supports MediaTek MT8195 clocks.
 
 config COMMON_CLK_MT8195_APUSYS
 	tristate "Clock driver for MediaTek MT8195 apusys"
diff --git a/drivers/clk/mediatek/clk-mt8195-apmixedsys.c b/drivers/clk/mediatek/clk-mt8195-apmixedsys.c
index a120c3305547..fc60cd4d9382 100644
--- a/drivers/clk/mediatek/clk-mt8195-apmixedsys.c
+++ b/drivers/clk/mediatek/clk-mt8195-apmixedsys.c
@@ -161,68 +161,25 @@ static struct mtk_pllfh_data pllfhs[] = {
 	FH(CLK_APMIXED_TVDPLL2, FH_TVDPLL1, 0x154),
 };
 
+static const struct mtk_clk_desc apmixed_desc = {
+	.clks = apmixed_clks,
+	.num_clks = ARRAY_SIZE(apmixed_clks),
+	.plls = plls,
+	.num_plls = ARRAY_SIZE(plls),
+	.fhctl_node = "mediatek,mt8195-fhctl",
+	.pllfhs = pllfhs,
+	.num_pllfhs = ARRAY_SIZE(pllfhs),
+};
+
 static const struct of_device_id of_match_clk_mt8195_apmixed[] = {
 	{ .compatible = "mediatek,mt8195-apmixedsys", },
 	{}
 };
 MODULE_DEVICE_TABLE(of, of_match_clk_mt8195_apmixed);
 
-static int clk_mt8195_apmixed_probe(struct platform_device *pdev)
-{
-	struct clk_hw_onecell_data *clk_data;
-	struct device_node *node = pdev->dev.of_node;
-	const u8 *fhctl_node = "mediatek,mt8195-fhctl";
-	int r;
-
-	clk_data = mtk_alloc_clk_data(CLK_APMIXED_NR_CLK);
-	if (!clk_data)
-		return -ENOMEM;
-
-	fhctl_parse_dt(fhctl_node, pllfhs, ARRAY_SIZE(pllfhs));
-
-	r = mtk_clk_register_pllfhs(&pdev->dev, plls, ARRAY_SIZE(plls),
-				    pllfhs, ARRAY_SIZE(pllfhs), clk_data);
-	if (r)
-		goto free_apmixed_data;
-
-	r = mtk_clk_register_gates(&pdev->dev, node, apmixed_clks,
-				   ARRAY_SIZE(apmixed_clks), clk_data);
-	if (r)
-		goto unregister_plls;
-
-	r = of_clk_add_hw_provider(node, of_clk_hw_onecell_get, clk_data);
-	if (r)
-		goto unregister_gates;
-
-	platform_set_drvdata(pdev, clk_data);
-
-	return r;
-
-unregister_gates:
-	mtk_clk_unregister_gates(apmixed_clks, ARRAY_SIZE(apmixed_clks), clk_data);
-unregister_plls:
-	mtk_clk_unregister_pllfhs(plls, ARRAY_SIZE(plls), pllfhs,
-				  ARRAY_SIZE(pllfhs), clk_data);
-free_apmixed_data:
-	mtk_free_clk_data(clk_data);
-	return r;
-}
-
-static void clk_mt8195_apmixed_remove(struct platform_device *pdev)
-{
-	struct device_node *node = pdev->dev.of_node;
-	struct clk_hw_onecell_data *clk_data = platform_get_drvdata(pdev);
-
-	of_clk_del_provider(node);
-	mtk_clk_unregister_gates(apmixed_clks, ARRAY_SIZE(apmixed_clks), clk_data);
-	mtk_clk_unregister_pllfhs(plls, ARRAY_SIZE(plls), pllfhs,
-				  ARRAY_SIZE(pllfhs), clk_data);
-	mtk_free_clk_data(clk_data);
-}
-
 static struct platform_driver clk_mt8195_apmixed_drv = {
-	.probe = clk_mt8195_apmixed_probe,
-	.remove = clk_mt8195_apmixed_remove,
+	.probe = mtk_clk_simple_probe,
+	.remove = mtk_clk_simple_remove,
 	.driver = {
 		.name = "clk-mt8195-apmixed",
 		.of_match_table = of_match_clk_mt8195_apmixed,
diff --git a/drivers/clk/mediatek/clk-mt8195-apusys_pll.c b/drivers/clk/mediatek/clk-mt8195-apusys_pll.c
index a2d98ed58e34..36d358141ecb 100644
--- a/drivers/clk/mediatek/clk-mt8195-apusys_pll.c
+++ b/drivers/clk/mediatek/clk-mt8195-apusys_pll.c
@@ -56,55 +56,20 @@ static const struct mtk_pll_data apusys_plls[] = {
 	PLL(CLK_APUSYS_PLL_APUPLL2, "apusys_pll_apupll2", 0x038, 0x044, 0x03c, 0x03c),
 };
 
-static int clk_mt8195_apusys_pll_probe(struct platform_device *pdev)
-{
-	struct clk_hw_onecell_data *clk_data;
-	struct device_node *node = pdev->dev.of_node;
-	int r;
-
-	clk_data = mtk_alloc_clk_data(CLK_APUSYS_PLL_NR_CLK);
-	if (!clk_data)
-		return -ENOMEM;
-
-	r = mtk_clk_register_plls(&pdev->dev, apusys_plls,
-				  ARRAY_SIZE(apusys_plls), clk_data);
-	if (r)
-		goto free_apusys_pll_data;
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
-	mtk_clk_unregister_plls(apusys_plls, ARRAY_SIZE(apusys_plls), clk_data);
-free_apusys_pll_data:
-	mtk_free_clk_data(clk_data);
-	return r;
-}
-
-static void clk_mt8195_apusys_pll_remove(struct platform_device *pdev)
-{
-	struct clk_hw_onecell_data *clk_data = platform_get_drvdata(pdev);
-	struct device_node *node = pdev->dev.of_node;
-
-	of_clk_del_provider(node);
-	mtk_clk_unregister_plls(apusys_plls, ARRAY_SIZE(apusys_plls), clk_data);
-	mtk_free_clk_data(clk_data);
-}
+static const struct mtk_clk_desc apu_pll_desc = {
+	.plls = apusys_plls,
+	.num_plls = ARRAY_SIZE(apusys_plls),
+};
 
 static const struct of_device_id of_match_clk_mt8195_apusys_pll[] = {
-	{ .compatible = "mediatek,mt8195-apusys_pll", },
+	{ .compatible = "mediatek,mt8195-apusys_pll", .data = &apu_pll_desc },
 	{}
 };
 MODULE_DEVICE_TABLE(of, of_match_clk_mt8195_apusys_pll);
 
 static struct platform_driver clk_mt8195_apusys_pll_drv = {
-	.probe = clk_mt8195_apusys_pll_probe,
-	.remove = clk_mt8195_apusys_pll_remove,
+	.probe = mtk_clk_simple_probe,
+	.remove = mtk_clk_simple_remove,
 	.driver = {
 		.name = "clk-mt8195-apusys_pll",
 		.of_match_table = of_match_clk_mt8195_apusys_pll,
-- 
2.55.0

