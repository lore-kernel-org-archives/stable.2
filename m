Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0ADF4431A55
	for <stable@vger.kernel.org>; Mon,  3 Aug 2026 14:19:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785766772; cv=none; b=bwl/eSJT0kv0ZSIRWl6EjN/nZ4nLrpMGrR3mUGZuquMFlAnZygPz6V4fZn87EMfWKcWUoucpW1IGX/SNErERzYYO0AU3LjsIfrNi9TRvvKOHFNPuBgDjMYrtwywSBVEjdu77TiLvrS+2DAC4JfQ+JZbrFfUbPP73G5vgGU0iG5Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785766772; c=relaxed/simple;
	bh=4I+MI8qXG6FOG9I4oRBJfXG/G2SOGeNCj7057KK5f40=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CAZ9zUjbVdDrGzT42UnscUfDe2A9E602Z7IwKowKSUbiwxy0i5UB6fbb08kpHKBe2NInDHh/XWrMIiZBx6lvhLuwsAJbakPUW16TjC1YxKa/0YGOrAsugLGxb4KpOUHw+0fuBlitxLq7uKVnvdpgH8ZChQQKKmMLCpd1QmH2h34=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ObObo36w; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ObObo36w"
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-38e7109321dso1960649a91.3
        for <stable@vger.kernel.org>; Mon, 03 Aug 2026 07:19:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785766770; x=1786371570; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=I4vjRsmYjATMWW3awrsZtoWhxsLcy7oInLDZqihXyW8=;
        b=ObObo36wz7GUtsLx+tFrZS6iEf3t3VGzGmk7p3fjtdp7DJKSSHBZE8/CoGrFfMVLmQ
         Ce5KcetOnFxM/WedCpzXpI1wZbOIwZrZ50Ob8qnZSKWCZJ+6K0085qg9tnHpgsitHc/q
         HxnEUeDlGOjGt2U4A/c3fzF8w3XjWq6UUlJQS6NI0w02LygU1MA8F5c/f+/eEBVw1irD
         nRix7RN6eNwRvDnwvRN4QG6VEreb3T2wPAdryFuUs4i5H3yOQmh7KvqVcjD1LV3z2Tqr
         1uI4lyq9+kU3FCBHKjmNGabiaFb5idPgeDOU0ZXll93YVBWIH81UzLyNj8T8ruf2oa8z
         /FCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785766770; x=1786371570;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=I4vjRsmYjATMWW3awrsZtoWhxsLcy7oInLDZqihXyW8=;
        b=cjr/GRw89xkDmgRyDjM6UNEDQyRe5cCpiCRtNRUcJrVCe66zC/EWaD+Hdlik2qON0j
         rcLurfygak8vyHNAIKkcbQsRDkHsKNvjs0nvyUPBKaZ2L9J8anm7TghyNRZ9ZPVTX5kJ
         gltjPgBrsqHAMNGoMQtoo405LTlNPw2uVLlvLc2a6EbfNUt5odGPxXLksWf8PexnQlOe
         QdpQzx4ngIFJ/jXunJm6GG4USF0KNIaJtCVoMTB1vHbieXFhG0nmE/grQpqqVu4Ppx+F
         t7kNmbIFMcc0hGrAoNKk0I6p2+XHD5+jjcOxoryYohMoksDdLs6/fcsbacJ2YBSXMM/k
         DbTw==
X-Forwarded-Encrypted: i=1; AHgh+RqxdUsx6/pr6tH/sj98bLb1TCw1TlzCEOMaoW5rscDl24FnChISUXMeaAB1YSRetMaltc2PTn8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxlRVIa1/ZyWbJBeV5yk8qRGdcmpkgK1swcLq7it/s+D0zZsikb
	pBnU86GS1VWJ3i1cHrczDhWDwNGkXR+7AG1071wbJ1LhrmwT2DUoJn14
X-Gm-Gg: AR+sD10zm65RRy93SMxiBw1Xsmdw3lm+GV2hAD8DPZOu/fSziLpVg+/aC92s5XHigaD
	MMy5FhsPgxwYJ5aW3mi/q9i9jLQpWRPcazEuKXxFy8e4Wk5LeZihPj1XeQLrOB/8Ecd4kygPp1i
	HXqPy6CmyBV6kpVWZQTLojM7wCNiEPxckUUBtNbR04zOYFTopyeZCgTrYIYJUuxIGzlgo9mA39b
	XHnOqG7vZEnSY6UfmiEoEdoFahtX6Z0F71ZzjxuUMnwLYbu7vXaMG6JU/jn/3oPbbXQmpvkb6l9
	rrF4WtroIXAyCzPgC4x4beu/G1lQGHyG6pw996JQ1vTU+o71j+7ClNNeyzNz3v5INTjJqS5FC9l
	fg2XQyweiI6UNuCYWNJVej5mjbFqH8U5jvDmuR5mcnSFp6by8PJi3B33rj6/7tirQ4ZGIueZevF
	GUi3jMePLdRootjEt92u7CbaEH9cjnPpYHN2LAR0LECtWST6jD77b2vDrxyPO9Mld7pqF3xZcms
	EB4Lm6ra0LLccamJ+nn
X-Received: by 2002:a17:90b:3b83:b0:381:973e:fa08 with SMTP id 98e67ed59e1d1-38fbc48ec1cmr9467935a91.18.1785766770208;
        Mon, 03 Aug 2026 07:19:30 -0700 (PDT)
Received: from buffalo-ssd (M014013071096.v4.enabler.ne.jp. [14.13.71.96])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-38fb30dff2esm4078462a91.13.2026.08.03.07.19.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Aug 2026 07:19:29 -0700 (PDT)
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
Subject: [PATCH 27/32] clk: mediatek: mt8186-apmixedsys: Switch to common probe/remove helpers
Date: Mon,  3 Aug 2026 23:16:54 +0900
Message-ID: <20260803141659.559129-28-akkun11.open@gmail.com>
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

The MT8186 apmixedsys driver can use the MediaTek clock framework
common initialization sequence. Reduce boilerplate code by creating
struct mtk_clk_desc and using the mtk_clk_simple_probe/remove helpers.

Signed-off-by: Akari Tsuyukusa <akkun11.open@gmail.com>
---
 drivers/clk/mediatek/clk-mt8186-apmixedsys.c | 59 ++++----------------
 1 file changed, 11 insertions(+), 48 deletions(-)

diff --git a/drivers/clk/mediatek/clk-mt8186-apmixedsys.c b/drivers/clk/mediatek/clk-mt8186-apmixedsys.c
index d35dd2632e43..b674b1e581a5 100644
--- a/drivers/clk/mediatek/clk-mt8186-apmixedsys.c
+++ b/drivers/clk/mediatek/clk-mt8186-apmixedsys.c
@@ -132,60 +132,23 @@ static struct mtk_pllfh_data pllfhs[] = {
 	FH(CLK_APMIXED_MSDCPLL, FH_MSDCPLL, 0x0118),
 };
 
+static const struct mtk_clk_desc apmixed_desc = {
+	.plls = plls,
+	.num_plls = ARRAY_SIZE(plls),
+	.fhctl_node = "mediatek,mt8186-fhctl",
+	.pllfhs = pllfhs,
+	.num_pllfhs = ARRAY_SIZE(pllfhs),
+};
+
 static const struct of_device_id of_match_clk_mt8186_apmixed[] = {
-	{ .compatible = "mediatek,mt8186-apmixedsys", },
+	{ .compatible = "mediatek,mt8186-apmixedsys", .data = &apmixed_desc },
 	{}
 };
 MODULE_DEVICE_TABLE(of, of_match_clk_mt8186_apmixed);
 
-static int clk_mt8186_apmixed_probe(struct platform_device *pdev)
-{
-	struct clk_hw_onecell_data *clk_data;
-	struct device_node *node = pdev->dev.of_node;
-	const u8 *fhctl_node = "mediatek,mt8186-fhctl";
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
-	r = of_clk_add_hw_provider(node, of_clk_hw_onecell_get, clk_data);
-	if (r)
-		goto unregister_plls;
-
-	platform_set_drvdata(pdev, clk_data);
-
-	return r;
-
-unregister_plls:
-	mtk_clk_unregister_pllfhs(plls, ARRAY_SIZE(plls), pllfhs,
-				  ARRAY_SIZE(pllfhs), clk_data);
-free_apmixed_data:
-	mtk_free_clk_data(clk_data);
-	return r;
-}
-
-static void clk_mt8186_apmixed_remove(struct platform_device *pdev)
-{
-	struct device_node *node = pdev->dev.of_node;
-	struct clk_hw_onecell_data *clk_data = platform_get_drvdata(pdev);
-
-	of_clk_del_provider(node);
-	mtk_clk_unregister_pllfhs(plls, ARRAY_SIZE(plls), pllfhs,
-				  ARRAY_SIZE(pllfhs), clk_data);
-	mtk_free_clk_data(clk_data);
-}
-
 static struct platform_driver clk_mt8186_apmixed_drv = {
-	.probe = clk_mt8186_apmixed_probe,
-	.remove = clk_mt8186_apmixed_remove,
+	.probe = mtk_clk_simple_probe,
+	.remove = mtk_clk_simple_remove,
 	.driver = {
 		.name = "clk-mt8186-apmixed",
 		.of_match_table = of_match_clk_mt8186_apmixed,
-- 
2.55.0

