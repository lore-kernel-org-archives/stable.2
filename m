Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 944F842BEBA
	for <stable@vger.kernel.org>; Mon,  3 Aug 2026 14:19:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785766753; cv=none; b=gJ8JbkeKGL7fF9/ZUAk/tZFCIrMffUAMd9EYp77rV2GGsmPIT5yEJJGjkzFvqPxAGE9rMg3iPv9WH3s81ZTmZaGf2DCjqySZsOOHE+fOPkBxb9ghkr5FYNej9cV98KMFc+eNeF7L6aRGy2Y6oJfqiSdR9FPbtAOctheauhmbcPI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785766753; c=relaxed/simple;
	bh=FiNUOG5lpIRCVkzgrGZsNUKDelC7YMC7J0dgcf8wdGo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=k3kGOoGoEvmpZevUwmX93jEO8+8o7G98dMTE1XdyJhDTIKqZlpao/l/m3Vq9ZsfZs3vW4JflOZwIO+uapbVIPonshzvyPJ9xcUFiY75sRIDaC0Fl0AlUBCQd0PdSpZHMFwilZnL//2HmOdrZerSr+C9+OY9HjUXDaX9u7RJP1rI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GBdfYaK1; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GBdfYaK1"
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-38e071ed6aeso2608849a91.0
        for <stable@vger.kernel.org>; Mon, 03 Aug 2026 07:19:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785766752; x=1786371552; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=SZCNDtviR1JC6xXXbBCpthup0l4v5bhXrxKWkP3TttE=;
        b=GBdfYaK18rWEHhM+OB1LqR5TpssdIlkAvNuJymT0Iq7XlDokG8LmZrIKK4uSvwAB7N
         Cb25vRvye/dq36pihamU0yfyc27riJTTjtPhqUBgmTcMxx9G2C2r6vDDxaX0gE2dHVtQ
         +7cqGWWCksuVZX+fsANCsE3b6l7gvj3KGwi0GYgoB+uDQZ0C62RZ78j/hLHGX2DA1KF4
         Th9OhvXWPTjdXuP/WNlmG1kqc+JBUKzCyq5dzm83QrOfc8Ed73SeFoq5oteimOlNaQNr
         sCVBMACN4mKw6+NFkbfAx7jKAIkPcx2bM52fSo3hOAATli6DXvezqMuMa1ewlALt8ck5
         v8YA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785766752; x=1786371552;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=SZCNDtviR1JC6xXXbBCpthup0l4v5bhXrxKWkP3TttE=;
        b=Ah1dD3prRRv6FQg2RXlQ5ebn5OtH8xC7hSVoo2/MB+6tB5PYSPb9huWUdS432e3uok
         8PWQ4eLEeaK7fFpn5IFhCH9rNQrC2kvPCoMJkSHCqhzjJjc/hsWLKsNbyz6KrTzRfpVq
         sYOSTd2k5oI0y3oVXW/vGC66VbM1QAWLK5cyNFuunLl/1oFOd/cOjO5mpJsviMPWFYyx
         /1jmc0ccsjWmM+uj2+22qTn9NH5N6ypacIwS91O/m4/UySsNlYciuGlUJ4UQMnqQXsy2
         +UO4UbIVxyVSqzpNzgJNJ5Cr3npKKHMZ0U777b6l5eiDtXg8op7gOnV3pCH94CYHAfbx
         BVXA==
X-Forwarded-Encrypted: i=1; AHgh+RoEQlnBjrM7L+GL8DqJAi/6Wq0mAFO+T1SroznTabXt+V2cCcx0NXSHEugGpwaO1BAM8fbLkJE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyLrLC7s1KFPcQIqMLmrzk110nSTTjJNKzMlTFzD1vwkxYCoAv4
	9Ud4nc/rfM+KNiGgDXoeWX6UC1Je3IvLLDo8VXwGDA1rIbugMA8T0JB/
X-Gm-Gg: AR+sD12OfZAPQcy0wsgmaMoWzGe4mO7Izbk8svyCcu59GRZVs9SEQcDB8IdrkLOCiNl
	JouB62+SsrGivPCCj4Vq5BrtIC0Ty4Z53OkhsofepuurQNx4deDQDrYp1RQ3Fm6PpCIGb4dUSZ+
	MLM1XtqvI+SKzJP1xFAO5IVF3G+dSIcv+11etLRLP4hNGn5Cz21oassFLsc+oyBdjLq0erUpq5I
	pdH/C6T7rIXefpZR2syfU8kPjxfQgkc7IpyricqC8DMIm5AwZ5loSvxvi5vXI6Y7pvS+eXCYAMa
	vtBYybEcZbUHvVHpgBkM5I+4D8M6oIPGJmaDhoEWrej1IwFiaTxN8ltdCLEO179rrr1p07xDiSr
	9psiXglbhLFHlsMGWDr+n6XkpKK7O7WzkDDujI8leqE60l9Hae5g3qW47yWSt/lF5rldAxjD080
	PQyzf+Ifr7hawW3+lsUUhIgvdnqSLHVI8iyxZYmy5bQvBs1CCh/yAVB9f3hLoukBVwCRJJrW9cJ
	hbME4bcH5mjNJv45pVz
X-Received: by 2002:a17:90b:2251:b0:384:5dbc:cba5 with SMTP id 98e67ed59e1d1-38fbc4cdedamr9399280a91.26.1785766751774;
        Mon, 03 Aug 2026 07:19:11 -0700 (PDT)
Received: from buffalo-ssd (M014013071096.v4.enabler.ne.jp. [14.13.71.96])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-38fb30dff2esm4078462a91.13.2026.08.03.07.19.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Aug 2026 07:19:11 -0700 (PDT)
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
Subject: [PATCH 23/32] clk: mediatek: mt8135-apmixedsys: Switch to common probe/remove helpers
Date: Mon,  3 Aug 2026 23:16:50 +0900
Message-ID: <20260803141659.559129-24-akkun11.open@gmail.com>
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

The MT8135 apmixedsys driver can use the MediaTek clock framework
common initialization sequence. Reduce boilerplate code by creating
struct mtk_clk_desc and using the mtk_clk_simple_probe/remove helpers.

Signed-off-by: Akari Tsuyukusa <akkun11.open@gmail.com>
---
 drivers/clk/mediatek/clk-mt8135-apmixedsys.c | 50 +++-----------------
 1 file changed, 7 insertions(+), 43 deletions(-)

diff --git a/drivers/clk/mediatek/clk-mt8135-apmixedsys.c b/drivers/clk/mediatek/clk-mt8135-apmixedsys.c
index e3b7dc13b458..fe868417de48 100644
--- a/drivers/clk/mediatek/clk-mt8135-apmixedsys.c
+++ b/drivers/clk/mediatek/clk-mt8135-apmixedsys.c
@@ -47,56 +47,20 @@ static const struct mtk_pll_data plls[] = {
 	PLL(CLK_APMIXED_VDECPLL, "vdecpll", 0x304, 0x31c, 0x80000000, 0, 21, 0x2b0, 6, 0x0, 0x308, 0),
 };
 
-static int clk_mt8135_apmixed_probe(struct platform_device *pdev)
-{
-	struct clk_hw_onecell_data *clk_data;
-	struct device_node *node = pdev->dev.of_node;
-	int ret;
-
-	clk_data = mtk_alloc_clk_data(CLK_APMIXED_NR_CLK);
-	if (!clk_data)
-		return -ENOMEM;
-
-	ret = mtk_clk_register_plls(&pdev->dev, plls, ARRAY_SIZE(plls),
-				    clk_data);
-	if (ret)
-		goto free_clk_data;
-
-	ret = of_clk_add_hw_provider(node, of_clk_hw_onecell_get, clk_data);
-	if (ret)
-		goto unregister_plls;
-
-	platform_set_drvdata(pdev, clk_data);
-
-	return 0;
-
-unregister_plls:
-	mtk_clk_unregister_plls(plls, ARRAY_SIZE(plls), clk_data);
-free_clk_data:
-	mtk_free_clk_data(clk_data);
-
-	return ret;
-}
-
-static void clk_mt8135_apmixed_remove(struct platform_device *pdev)
-{
-	struct device_node *node = pdev->dev.of_node;
-	struct clk_hw_onecell_data *clk_data = platform_get_drvdata(pdev);
-
-	of_clk_del_provider(node);
-	mtk_clk_unregister_plls(plls, ARRAY_SIZE(plls), clk_data);
-	mtk_free_clk_data(clk_data);
-}
+static const struct mtk_clk_desc apmixed_desc = {
+	.plls = plls,
+	.num_plls = ARRAY_SIZE(plls),
+};
 
 static const struct of_device_id of_match_clk_mt8135_apmixed[] = {
-	{ .compatible = "mediatek,mt8135-apmixedsys" },
+	{ .compatible = "mediatek,mt8135-apmixedsys", .data = &apmixed_desc },
 	{ /* sentinel */ }
 };
 MODULE_DEVICE_TABLE(of, of_match_clk_mt8135_apmixed);
 
 static struct platform_driver clk_mt8135_apmixed_drv = {
-	.probe = clk_mt8135_apmixed_probe,
-	.remove = clk_mt8135_apmixed_remove,
+	.probe = mtk_clk_simple_probe,
+	.remove = mtk_clk_simple_remove,
 	.driver = {
 		.name = "clk-mt8135-apmixed",
 		.of_match_table = of_match_clk_mt8135_apmixed,
-- 
2.55.0

