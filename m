Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F3F8420E71
	for <stable@vger.kernel.org>; Mon,  3 Aug 2026 14:18:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785766712; cv=none; b=VJ5vKZOP++1gr+2T3Ojmg2k1wXfFGnFS0cgnuXDB7fZa+gzGOtLFPKoJoMqKiZbh1uv59nuekBx4lSWce1mn1CZDXl1nrldANHnoeFDxlLCjeKQomNjD4xq6YoEDLGCuJqNm7CLqc/AtLhPCAfrUJttwM6izO0p7Fh7DCeO5xNI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785766712; c=relaxed/simple;
	bh=KpBLdYPVy//+CS7htz22Fx/0ErhtTA4pOGm5yTwSpMM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ssgy/9MuiUEgaPqsFlqCcXezRW5ZpXD2pRDg8f1MzPS6AuWG3Il+HC/3UDZH2ZCO9NPo4d9XDY2XnUHMTGEFXtp9Jhdb/VQLXMh+6ZGbbZu/QGtC6kUZMw6/ud0JB86u9Nyvjak6UQyT8LXBAkYt1UGLINL367Rg1BuFKpeqTWE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DdoQ3T6y; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DdoQ3T6y"
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-38ea87caafeso2592516a91.3
        for <stable@vger.kernel.org>; Mon, 03 Aug 2026 07:18:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785766711; x=1786371511; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=dyBWGAUwgPvbG+kxK54yT+71Lwi1XH6IM529yhUdCDI=;
        b=DdoQ3T6yahqwXp+uKCjegRam7D9OTsPYJE1wwcxukyawKYNp6DHyFQqmOyxx/mnlal
         yKdU8Xvl+fjPCYZe153DAGrJ5oPcOIE1sNrGoOcoovb7CKkUOc6vDa/0RNAAogmrMY99
         8snfcllqNGG0a6CYPpTcxZ/60xOvxIa3jAd0un+H+QixNwaRLIBi62z/1XC+hsNIm2Fh
         HWv8h0f2qg7/5Vk9cnBQbseA3t581HJEnXniM3WdrofR5IOKHkOlQb22yRtRfDYDHQ4l
         vDeJ393K0NO/bPZF6NUwjYhi8QnrrDOsBIY9MuRpKUyqNwQeT5QGDRFVtuZs4u/0texS
         VWdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785766711; x=1786371511;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=dyBWGAUwgPvbG+kxK54yT+71Lwi1XH6IM529yhUdCDI=;
        b=P6SQv9srurrFVGajkIopk0TiT9tq3ulzSvm0AFgdRHmjShgvyHKl36h4qhKL989FyX
         2oux1sD6PDwYn9t/B8+lcmqzURhNfG+N7Ncdbf25tH+1PLqLtk6rUQS7/Jc1UNNKPBOi
         FsymP4phYcl9SqY2Plfz0P7Iz5Avg78K8iv+UgmlFII7P7pJjx/5Q44NWVA+RClFBW0q
         FzgBniamz9jLQH1IBF69xVYLAIunbxDnW/UP2PKuQMrH+Hp4o5ZqeKOvuDpX5wSViWJj
         oAhqI0H86QtyTLaEh/BrYAWQ3piq4fh9PXUV++K8hEw0g9GwlqbsTXG2HO+2IsHNvxcC
         mm9A==
X-Forwarded-Encrypted: i=1; AHgh+RpDM3XpjaM80xgswku2y3VaPkLDcG6L/cdkKSJTs20yhThhanBmk1BIP73b63mqwcVyJmbApYw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx6xb39Xzizm2ME+1DbWqsj2Dcy5YT+NtXCA8afIbhHFnELLFc4
	POfRNAI2HxqKJBZ2IpIFolVICcvk8AQz1fyEM1FBmRxeqnQBvAQHejlF
X-Gm-Gg: AR+sD13Jwf+aEYYm4YB36lbld0MXf4etX+gpskTpHmoshbEMxiLwrJWLD+BC6bdncte
	63fjAWunzTPYbVZquT6GAW8M+t9nNviXuqeJutz51FzhpWDXnab0iRNUOOzZ3xy1lIvf7laPsG0
	5tmEFbittwrX6IGRjHNUKrBW4YBi+gUSHQjr0lBEn/xFOr26FACQJrXxo6mTh17aHAeUtU9JNUG
	U+mwqlAaSC0IJ3Qcn1rKVApKlxQaETj1krE5A1z65vz5s1GUTEe6Qn2nCQpXX2jDoXCE1oUXqiK
	3EpOBddG6kjGUOhGvubfPdbbePAHtSe+z8WVQMcRe8aRRQ4TsNuaeq2j8jmf8PezUUYG0Mqj4i6
	XeqeBcy/O+RABoRZnqun7gFVgmD5gfMWal5498JFyDA735AopL0DwtfiMNaJXlLkoCDp2g6DDU8
	h4J0U++VkMqtOcoCB8hQwU0BfpwOePSXgmTFYNDAjdB2yFPb2ewUQ2L8wl9N1I0Bj/hnc8tTWG7
	tOuCXrEHysj3wC74IqJ
X-Received: by 2002:a17:90b:4b12:b0:38f:57f3:4dc7 with SMTP id 98e67ed59e1d1-38fbc4c66c4mr9869202a91.26.1785766710548;
        Mon, 03 Aug 2026 07:18:30 -0700 (PDT)
Received: from buffalo-ssd (M014013071096.v4.enabler.ne.jp. [14.13.71.96])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-38fb30dff2esm4078462a91.13.2026.08.03.07.18.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Aug 2026 07:18:30 -0700 (PDT)
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
Subject: [PATCH 14/32] clk: mediatek: mt2712-apmixedsys: Switch to common probe/remove helpers
Date: Mon,  3 Aug 2026 23:16:41 +0900
Message-ID: <20260803141659.559129-15-akkun11.open@gmail.com>
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

The MT2712 apmixedsys driver can use the MediaTek clock framework
common initialization sequence. Reduce boilerplate code by creating
struct mtk_clk_desc and using the mtk_clk_simple_probe/remove helpers.

Signed-off-by: Akari Tsuyukusa <akkun11.open@gmail.com>
---
 drivers/clk/mediatek/clk-mt2712-apmixedsys.c | 50 +++-----------------
 1 file changed, 7 insertions(+), 43 deletions(-)

diff --git a/drivers/clk/mediatek/clk-mt2712-apmixedsys.c b/drivers/clk/mediatek/clk-mt2712-apmixedsys.c
index 087cf574bcdc..1e06f87e71d0 100644
--- a/drivers/clk/mediatek/clk-mt2712-apmixedsys.c
+++ b/drivers/clk/mediatek/clk-mt2712-apmixedsys.c
@@ -109,56 +109,20 @@ static const struct mtk_pll_data plls[] = {
 	    0, 31, 0x0300, 4, 0, 0, 0, 0x0304, 0),
 };
 
-static int clk_mt2712_apmixed_probe(struct platform_device *pdev)
-{
-	struct clk_hw_onecell_data *clk_data;
-	int r;
-	struct device_node *node = pdev->dev.of_node;
-
-	clk_data = mtk_alloc_clk_data(CLK_APMIXED_NR_CLK);
-	if (!clk_data)
-		return -ENOMEM;
-
-	r = mtk_clk_register_plls(&pdev->dev, plls, ARRAY_SIZE(plls), clk_data);
-	if (r)
-		goto free_clk_data;
-
-	r = of_clk_add_hw_provider(node, of_clk_hw_onecell_get, clk_data);
-	if (r) {
-		dev_err(&pdev->dev, "Cannot register clock provider: %d\n", r);
-		goto unregister_plls;
-	}
-
-	platform_set_drvdata(pdev, clk_data);
-
-	return 0;
-
-unregister_plls:
-	mtk_clk_unregister_plls(plls, ARRAY_SIZE(plls), clk_data);
-free_clk_data:
-	mtk_free_clk_data(clk_data);
-	return r;
-}
-
-static void clk_mt2712_apmixed_remove(struct platform_device *pdev)
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
 
 static const struct of_device_id of_match_clk_mt2712_apmixed[] = {
-	{ .compatible = "mediatek,mt2712-apmixedsys" },
+	{ .compatible = "mediatek,mt2712-apmixedsys", .data = &apmixed_desc },
 	{ /* sentinel */ }
 };
 MODULE_DEVICE_TABLE(of, of_match_clk_mt2712_apmixed);
 
 static struct platform_driver clk_mt2712_apmixed_drv = {
-	.probe = clk_mt2712_apmixed_probe,
-	.remove = clk_mt2712_apmixed_remove,
+	.probe = mtk_clk_simple_probe,
+	.remove = mtk_clk_simple_remove,
 	.driver = {
 		.name = "clk-mt2712-apmixed",
 		.of_match_table = of_match_clk_mt2712_apmixed,
-- 
2.55.0

