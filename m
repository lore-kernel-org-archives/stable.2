Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEE35424649
	for <stable@vger.kernel.org>; Mon,  3 Aug 2026 14:18:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785766726; cv=none; b=HuB0+c/oNJ5EMbHPCDme7YPvtrMHqUl7qkWvRn1Xtm6vyLqjCHzV7f53ZADGIBNq4CGK2JdXYiX2dXlT1wppPIZNqHOOzizPW9ITbkFgBGwWnxjj6vmrx5bS7qYFt8xhQWqiECZPHfieY445iv2OolVb3AslI8hydfLKK//fivE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785766726; c=relaxed/simple;
	bh=DEkXoPqeykLyPJeGL/sBQwgfm3AhGE80Cdttg5nIiMs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=p5yAw0CxMuuzysUKInkhwJb2sbZuHbVi60cln9Eyq6FDYperTaziYkb26kMR5lNKDBPARYLi4/s7JB9SlUQttTPk1kbjR8tb+pWDty2NEFioE1dimV8AiQp8Ud56EudwRON2D9d2Icm+FV5RzxHBnEogQj2ftyy+TkrmxWInjJ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UkLE69oL; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UkLE69oL"
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-38ea87caafeso2592892a91.3
        for <stable@vger.kernel.org>; Mon, 03 Aug 2026 07:18:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785766724; x=1786371524; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=bfbhvjCps3TvY9ALK0rieR0dmwrL7uiQ1/04JBGNXFs=;
        b=UkLE69oLEfBy/sg47XjPEfbJ2fnE8GdvxyDz7UMXvUTmxAxtFwlixtnR6eeQ7LC6As
         s4yD+AhePmcrf19wu+N7wD9g5ulh/CTxOSupdLH9RCQASWv/mjU25jd6ObWcwmyCZJXq
         7a4usHybzOhuVUQcOCPSlvju4F1LU6oFF6/bgNMzr8hk/TqLkK+3XJ8y5Wr1W54mMn6G
         jyoTKdjhcez8eBq/F5RFOTY3rP7cIo/11L/UgHeycurdHS1VR+fe4xI5Ukk9HviV5r+L
         VOiBzZU/gzKHBTXnOZX3CezGMyt+ptOFOe/o5P9GSWCDeVliT4wqpk+RWa50HE31aEv4
         SZLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785766724; x=1786371524;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=bfbhvjCps3TvY9ALK0rieR0dmwrL7uiQ1/04JBGNXFs=;
        b=nJxSSVTA6dl9XARCJ7iMIjA8r1Db36Xm/0zQZgzyrpgpc/Nx9xobE6s9eg2ZGbxF09
         MqfVz+mu9GzzOmSVCXXohAZvwW13v+4peVaej6hpRsrPW8ihppZTdd4Wpb5b+uI5u6sE
         XhOwUhfGwTemSahUNmzsIuXdzYv/ZIfLF3MxarFk6PPklNc+RIvip7183bK4NBs+MaCK
         oSNhplHbNRfUujN/qvnPlv7aip8M9p/t/OvNJ8Cl4ggf7UscJG7LdPaC3RYWcOzndwWB
         B7jTU6iajKSE3Jd8P8YQcCtGmivWmZW9uRmMt0TJUsDBjLPhXcf3qFvnwZe6i38SXxlE
         fFHA==
X-Forwarded-Encrypted: i=1; AHgh+Rq5HRLVUujaGWnWRhzL6ptpDlNnAB42UXAVbJyZishwk4mHCE5k0Yc2Tmlb0AI1a05UqsLLu40=@vger.kernel.org
X-Gm-Message-State: AOJu0YxRdk15TVAjMZuQfvaLtJOs5+xoXD5/WCCQ6KzJgi96eMFf3b0E
	S3DR47fTx4PT6Mn+TVrge8qKKs2+ZBihHMX4+3X2C2j0FXPmBYyS89wv
X-Gm-Gg: AR+sD13l9alW+w+kkUZaB0nGeaiCLG74hLVU3nld/mASvhqD8s1250GXaJupZU5+Xaz
	aS3Q4V/qb7i0vADEZ258xTYJ401cxcvcdwqbL5Xa/uYOue+RRCpocTJWzX6yvd8fQI/WkXHjbQK
	rlHbEbVKKTfXhLlZvddN+SWrrapCxgvvnnq5kotoEAo3fguF2LaSRCp0zUVoo0+K1lQgNQLNHbf
	29ZXrQDK4OoKv9zYonlh0vFq5dtFZsuCqcgXPpG3TaygLtCaCGASrTl2v5w84mIUCU8XPL3ThvD
	Xal8FAKNDTNJvoYfDkfw/AYHGuel4/qmWjkjHY28ZdnF/KTiD0pMh/bHmVAfpe9hsfmNU9HIgf8
	Xz/G1wNmFcXqrdM9c5oVFCPE9cOCtbcj/Il7AGXwWv2k0HbHFL/5XNurRf/A8PQIAQhCDN+Jh0Q
	5tzIqYjI+YcNbBz1ibCK80BxRlAh8ScPUvPtMPPYtSVdqVF+A1jl4Px+uCtAw/6yEB7OQIKsZM7
	UyHXpQlYBeKybviUd6y
X-Received: by 2002:a17:90b:5690:b0:38e:5ab7:ce9b with SMTP id 98e67ed59e1d1-38fbc4bc25dmr8700516a91.21.1785766724256;
        Mon, 03 Aug 2026 07:18:44 -0700 (PDT)
Received: from buffalo-ssd (M014013071096.v4.enabler.ne.jp. [14.13.71.96])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-38fb30dff2esm4078462a91.13.2026.08.03.07.18.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Aug 2026 07:18:43 -0700 (PDT)
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
Subject: [PATCH 17/32] clk: mediatek: mt6795: Switch to common probe/remove helpers
Date: Mon,  3 Aug 2026 23:16:44 +0900
Message-ID: <20260803141659.559129-18-akkun11.open@gmail.com>
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

The MT6795 infracfg and pericfg drivers can use the MediaTek clock
framework common initialization sequence. Reduce boilerplate code by
creating struct mtk_clk_desc and using the mtk_clk_simple_probe/remove
helpers.

Note that the apmixedsys driver is excluded from this conversion because
it requires ref2usb_tx clock handling, which is not currently supported
by the common simple probe helper.

Signed-off-by: Akari Tsuyukusa <akkun11.open@gmail.com>
---
 drivers/clk/mediatek/clk-mt6795-infracfg.c | 72 ++++-----------------
 drivers/clk/mediatek/clk-mt6795-pericfg.c  | 73 ++++------------------
 2 files changed, 23 insertions(+), 122 deletions(-)

diff --git a/drivers/clk/mediatek/clk-mt6795-infracfg.c b/drivers/clk/mediatek/clk-mt6795-infracfg.c
index 914bb069aa85..6aefc577ece5 100644
--- a/drivers/clk/mediatek/clk-mt6795-infracfg.c
+++ b/drivers/clk/mediatek/clk-mt6795-infracfg.c
@@ -8,7 +8,6 @@
 #include <dt-bindings/reset/mediatek,mt6795-resets.h>
 #include <linux/module.h>
 #include <linux/platform_device.h>
-#include "clk-cpumux.h"
 #include "clk-gate.h"
 #include "clk-mtk.h"
 #include "reset.h"
@@ -77,76 +76,27 @@ static const struct mtk_clk_rst_desc clk_rst_desc = {
 	.rst_idx_map_nr = ARRAY_SIZE(infra_ao_idx_map),
 };
 
+static const struct mtk_clk_desc infra_desc = {
+	.clks = infra_gates,
+	.num_clks = ARRAY_SIZE(infra_gates),
+	.cpumuxes = cpu_muxes,
+	.num_cpumuxes = ARRAY_SIZE(cpu_muxes),
+	.rst_desc = &clk_rst_desc,
+};
+
 static const struct of_device_id of_match_clk_mt6795_infracfg[] = {
-	{ .compatible = "mediatek,mt6795-infracfg" },
+	{ .compatible = "mediatek,mt6795-infracfg", .data = &infra_desc },
 	{ /* sentinel */ }
 };
 MODULE_DEVICE_TABLE(of, of_match_clk_mt6795_infracfg);
 
-static int clk_mt6795_infracfg_probe(struct platform_device *pdev)
-{
-	struct clk_hw_onecell_data *clk_data;
-	struct device_node *node = pdev->dev.of_node;
-	void __iomem *base;
-	int ret;
-
-	base = devm_platform_ioremap_resource(pdev, 0);
-	if (IS_ERR(base))
-		return PTR_ERR(base);
-
-	clk_data = mtk_alloc_clk_data(CLK_INFRA_NR_CLK);
-	if (!clk_data)
-		return -ENOMEM;
-
-	ret = mtk_register_reset_controller_with_dev(&pdev->dev, &clk_rst_desc);
-	if (ret)
-		goto free_clk_data;
-
-	ret = mtk_clk_register_gates(&pdev->dev, node, infra_gates,
-				     ARRAY_SIZE(infra_gates), clk_data);
-	if (ret)
-		goto free_clk_data;
-
-	ret = mtk_clk_register_cpumuxes(&pdev->dev, node, cpu_muxes,
-					ARRAY_SIZE(cpu_muxes), clk_data);
-	if (ret)
-		goto unregister_gates;
-
-	ret = of_clk_add_hw_provider(node, of_clk_hw_onecell_get, clk_data);
-	if (ret)
-		goto unregister_cpumuxes;
-
-	platform_set_drvdata(pdev, clk_data);
-
-	return 0;
-
-unregister_cpumuxes:
-	mtk_clk_unregister_cpumuxes(cpu_muxes, ARRAY_SIZE(cpu_muxes), clk_data);
-unregister_gates:
-	mtk_clk_unregister_gates(infra_gates, ARRAY_SIZE(infra_gates), clk_data);
-free_clk_data:
-	mtk_free_clk_data(clk_data);
-	return ret;
-}
-
-static void clk_mt6795_infracfg_remove(struct platform_device *pdev)
-{
-	struct device_node *node = pdev->dev.of_node;
-	struct clk_hw_onecell_data *clk_data = platform_get_drvdata(pdev);
-
-	of_clk_del_provider(node);
-	mtk_clk_unregister_cpumuxes(cpu_muxes, ARRAY_SIZE(cpu_muxes), clk_data);
-	mtk_clk_unregister_gates(infra_gates, ARRAY_SIZE(infra_gates), clk_data);
-	mtk_free_clk_data(clk_data);
-}
-
 static struct platform_driver clk_mt6795_infracfg_drv = {
 	.driver = {
 		.name = "clk-mt6795-infracfg",
 		.of_match_table = of_match_clk_mt6795_infracfg,
 	},
-	.probe = clk_mt6795_infracfg_probe,
-	.remove = clk_mt6795_infracfg_remove,
+	.probe = mtk_clk_simple_probe,
+	.remove = mtk_clk_simple_remove,
 };
 module_platform_driver(clk_mt6795_infracfg_drv);
 
diff --git a/drivers/clk/mediatek/clk-mt6795-pericfg.c b/drivers/clk/mediatek/clk-mt6795-pericfg.c
index 27d0ef7d7b2f..53c79e830b6a 100644
--- a/drivers/clk/mediatek/clk-mt6795-pericfg.c
+++ b/drivers/clk/mediatek/clk-mt6795-pericfg.c
@@ -85,77 +85,28 @@ static const struct mtk_clk_rst_desc clk_rst_desc = {
 	.rst_idx_map_nr = ARRAY_SIZE(peri_idx_map),
 };
 
+static const struct mtk_clk_desc pericfg_desc = {
+	.clks = peri_gates,
+	.num_clks = ARRAY_SIZE(peri_gates),
+	.composite_clks = peri_clks,
+	.num_composite_clks = ARRAY_SIZE(peri_clks),
+	.rst_desc = &clk_rst_desc,
+	.clk_lock = &mt6795_peri_clk_lock,
+};
+
 static const struct of_device_id of_match_clk_mt6795_pericfg[] = {
-	{ .compatible = "mediatek,mt6795-pericfg" },
+	{ .compatible = "mediatek,mt6795-pericfg", .data = &pericfg_desc },
 	{ /* sentinel */ }
 };
 MODULE_DEVICE_TABLE(of, of_match_clk_mt6795_pericfg);
 
-static int clk_mt6795_pericfg_probe(struct platform_device *pdev)
-{
-	struct clk_hw_onecell_data *clk_data;
-	struct device_node *node = pdev->dev.of_node;
-	void __iomem *base;
-	int ret;
-
-	base = devm_platform_ioremap_resource(pdev, 0);
-	if (IS_ERR(base))
-		return PTR_ERR(base);
-
-	clk_data = mtk_alloc_clk_data(CLK_PERI_NR_CLK);
-	if (!clk_data)
-		return -ENOMEM;
-
-	ret = mtk_register_reset_controller_with_dev(&pdev->dev, &clk_rst_desc);
-	if (ret)
-		goto free_clk_data;
-
-	ret = mtk_clk_register_gates(&pdev->dev, node, peri_gates,
-				     ARRAY_SIZE(peri_gates), clk_data);
-	if (ret)
-		goto free_clk_data;
-
-	ret = mtk_clk_register_composites(&pdev->dev, peri_clks,
-					  ARRAY_SIZE(peri_clks), base,
-					  &mt6795_peri_clk_lock, clk_data);
-	if (ret)
-		goto unregister_gates;
-
-	ret = of_clk_add_hw_provider(node, of_clk_hw_onecell_get, clk_data);
-	if (ret)
-		goto unregister_composites;
-
-	platform_set_drvdata(pdev, clk_data);
-
-	return 0;
-
-unregister_composites:
-	mtk_clk_unregister_composites(peri_clks, ARRAY_SIZE(peri_clks), clk_data);
-unregister_gates:
-	mtk_clk_unregister_gates(peri_gates, ARRAY_SIZE(peri_gates), clk_data);
-free_clk_data:
-	mtk_free_clk_data(clk_data);
-	return ret;
-}
-
-static void clk_mt6795_pericfg_remove(struct platform_device *pdev)
-{
-	struct device_node *node = pdev->dev.of_node;
-	struct clk_hw_onecell_data *clk_data = platform_get_drvdata(pdev);
-
-	of_clk_del_provider(node);
-	mtk_clk_unregister_composites(peri_clks, ARRAY_SIZE(peri_clks), clk_data);
-	mtk_clk_unregister_gates(peri_gates, ARRAY_SIZE(peri_gates), clk_data);
-	mtk_free_clk_data(clk_data);
-}
-
 static struct platform_driver clk_mt6795_pericfg_drv = {
 	.driver = {
 		.name = "clk-mt6795-pericfg",
 		.of_match_table = of_match_clk_mt6795_pericfg,
 	},
-	.probe = clk_mt6795_pericfg_probe,
-	.remove = clk_mt6795_pericfg_remove,
+	.probe = mtk_clk_simple_probe,
+	.remove = mtk_clk_simple_remove,
 };
 module_platform_driver(clk_mt6795_pericfg_drv);
 
-- 
2.55.0

