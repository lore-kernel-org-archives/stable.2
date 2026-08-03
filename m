Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CADE642BC27
	for <stable@vger.kernel.org>; Mon,  3 Aug 2026 14:19:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785766749; cv=none; b=HO7hTnlfHtyDEKJ2SmotyEpC/oHkbGTZCgUgvIArFewutcFxOu6F916tyRhHj4BFj8HrSkTv5Mz0OqWkDnBIcUrrWU/3/iK0Og1ri5LuGAISnqOYBVuIulu0y7/IeCTsa0W+YIQDDA4aF9S04BW9PrRvBjOcCHHD7xJPoZbgK8s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785766749; c=relaxed/simple;
	bh=36nhEK+XUWu4cXSvoZoTcXr0d9SkWYU9//2aFuA+2gA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=t+QRMuomPN3NZJ1MYwVuzzqWT0dnMvxck91sbwcXMaxhZEKSmrMdXKJvKUfGIbi8HeM/4KyBmome0GVQI+Gu7VylWhcAFuDrA2qY8b7g1znNgiAc7m3TfSema1t8jTf74a++Jjo5Pzqi8s4UaqeKUYVyoy41tEoQHyGcFCDNviM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Cu9uq0Qc; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Cu9uq0Qc"
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-38125cebfdaso4338879a91.1
        for <stable@vger.kernel.org>; Mon, 03 Aug 2026 07:19:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785766747; x=1786371547; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=yBdhWQzJRHYryE9WZhMb9eq0tPTuw8+xNI5NcLDCCxE=;
        b=Cu9uq0Qc+FszB2bOH19bzP+1x8umthmn1+bky+x7pag4Gl1yk1urOnZLMsFXAwDzwL
         aTgQFpCm/72e4f5fPgsHjose8/Ne+rRBmQCqE1vF7nGrhG8sDNQEYAFJmiMGBSaZgs37
         ADriOCxrcFmSbZ3DIU0MzFjT5SPBsUC/qztZppLMVQm7BMvLv+/xZ15K2v61VryuoWrF
         YVP4S3lmtbR41/AeQlMKef6+IYNy/aPyGyiVPczKlD5eOEPLvDEiknXbzwn0tKTqWbVz
         EOngLqbM7k22REd2eyqjsuiLIV++ZMqa5dJPJtf74UFPEPDd50xjb6u3TBbzVK3a04Lg
         W+GA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785766747; x=1786371547;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=yBdhWQzJRHYryE9WZhMb9eq0tPTuw8+xNI5NcLDCCxE=;
        b=BGKuIb0KrwBxHiuVAhNWGlx4Ed/msbNtw34XLAoaCIV8Yy1vKbTB/7MchJkJIRn9R0
         6iHY85q2max6YYfCt4TOZFU1rv4zy/zrqxoJuCKR+uxwFvwFkig8P3U0BDj7GICJUzJx
         RsQqrxAuS299xxWTsCxSZU3bC0BaAhcGI8/xOzQdEfDbrF2i+Azvw2s2aRDbn/rZKtuA
         YCSkF0ZZLRyB3m2MA88dXv9Xwiy7q/3/HFoQ4+WQjS9Leg1vNtN3RLond0Ob+hyIkXxY
         huOk/xopXLgKX3xiYcn3a3130qS9GxtX1CN2p+3kM5diyVa+/qnGQd6O0yAtb0P3LosT
         rTpg==
X-Forwarded-Encrypted: i=1; AHgh+Rquu+BSMQp4RW/uWWyrWh3aefx1CO7qRv84nd6xqeGMU+vdpAN9QB/SxHInsjcIg7tTJA5iSDY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwZwJBf7mNiaWlrHwOumYl6a+ttpnwJVfU1B9r3oGEl1Evvkfxk
	z0rMKffQ9Y/Hi5DAGtxRSSUBicF8HD5tfgAGHPGmEkN9Lso8ywH8zaHH
X-Gm-Gg: AR+sD138THrthr9BMoNhn34NK31gSFKuqvklGyPk/UbEEesye/Y7LZ2RXiUtyzyjWn3
	GtLEZZUpJzOao3XWwLKZyMQC8JT8CcwoNkf2UAYs0fDaurO2d2brV6tt4fY6S3U86klxPZU/CAu
	SY7YmsTp5jwzoQ91HBWrjVh4p4N/gXhNHPgSNnHfyOqp7TQUU1LiRNEtkExiPAA4hQCYdHSs31P
	9WTiEAbh8mTqlpASS3DKhClOOADKeeS+d8YhRBGPPum7bOVTfkpiJJT0B3fENIjxu2ZNQmFAaMi
	/WJk8UPS32VV5h63FPemgbV5mOjmqahTldL8/woTERJSDdmC6M1Q5uRISAITSjqNDrDrEAelzmT
	c3qLKIEnQif40rASGYuBhdkEgFgZ+oc0Xm6xeolmpc6r0ixYcbhMMKHiVMPuzT6NGUYbGySe04+
	A5BZiGdA/6ZoK+tBHmhgjWh6mH7f3LpC1qevfvs+h79N4V/ybjePY+DEz/8WCCSXa4w19x2EaTq
	AIfwnfyQXUvMilPC/I0
X-Received: by 2002:a17:90b:2ecf:b0:38f:e6cf:4d6a with SMTP id 98e67ed59e1d1-38fe6cf4e03mr949891a91.41.1785766747241;
        Mon, 03 Aug 2026 07:19:07 -0700 (PDT)
Received: from buffalo-ssd (M014013071096.v4.enabler.ne.jp. [14.13.71.96])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-38fb30dff2esm4078462a91.13.2026.08.03.07.19.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Aug 2026 07:19:06 -0700 (PDT)
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
Subject: [PATCH 22/32] clk: mediatek: mt7988-apmixed: Switch to common probe/remove helpers
Date: Mon,  3 Aug 2026 23:16:49 +0900
Message-ID: <20260803141659.559129-23-akkun11.open@gmail.com>
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

The MT7988 apmixed driver can use the MediaTek clock framework common
initialization sequence. Reduce boilerplate code by creating
struct mtk_clk_desc and using the mtk_clk_simple_probe/remove helpers.

Signed-off-by: Akari Tsuyukusa <akkun11.open@gmail.com>
---
 drivers/clk/mediatek/clk-mt7988-apmixed.c | 39 ++++++-----------------
 1 file changed, 9 insertions(+), 30 deletions(-)

diff --git a/drivers/clk/mediatek/clk-mt7988-apmixed.c b/drivers/clk/mediatek/clk-mt7988-apmixed.c
index 24f4e7b87a31..f7bb00e7d17a 100644
--- a/drivers/clk/mediatek/clk-mt7988-apmixed.c
+++ b/drivers/clk/mediatek/clk-mt7988-apmixed.c
@@ -71,47 +71,26 @@ static const struct mtk_pll_data plls[] = {
 	    0, 0x0318, 0, 0x0314),
 };
 
+static const struct mtk_clk_desc apmixed_desc = {
+	.plls = plls,
+	.num_plls = ARRAY_SIZE(plls),
+};
+
 static const struct of_device_id of_match_clk_mt7988_apmixed[] = {
-	{ .compatible = "mediatek,mt7988-apmixedsys" },
+	{ .compatible = "mediatek,mt7988-apmixedsys", .data = &apmixed_desc },
 	{ /* sentinel */ }
 };
 MODULE_DEVICE_TABLE(of, of_match_clk_mt7988_apmixed);
 
-static int clk_mt7988_apmixed_probe(struct platform_device *pdev)
-{
-	struct clk_hw_onecell_data *clk_data;
-	struct device_node *node = pdev->dev.of_node;
-	int r;
-
-	clk_data = mtk_alloc_clk_data(ARRAY_SIZE(plls));
-	if (!clk_data)
-		return -ENOMEM;
-
-	r = mtk_clk_register_plls(&pdev->dev, plls, ARRAY_SIZE(plls), clk_data);
-	if (r)
-		goto free_apmixed_data;
-
-	r = of_clk_add_hw_provider(node, of_clk_hw_onecell_get, clk_data);
-	if (r)
-		goto unregister_plls;
-
-	return r;
-
-unregister_plls:
-	mtk_clk_unregister_plls(plls, ARRAY_SIZE(plls), clk_data);
-free_apmixed_data:
-	mtk_free_clk_data(clk_data);
-	return r;
-}
-
 static struct platform_driver clk_mt7988_apmixed_drv = {
-	.probe = clk_mt7988_apmixed_probe,
+	.probe = mtk_clk_simple_probe,
+	.remove = mtk_clk_simple_remove,
 	.driver = {
 		.name = "clk-mt7988-apmixed",
 		.of_match_table = of_match_clk_mt7988_apmixed,
 	},
 };
-builtin_platform_driver(clk_mt7988_apmixed_drv);
+module_platform_driver(clk_mt7988_apmixed_drv);
 
 MODULE_DESCRIPTION("MediaTek MT7988 apmixedsys clocks driver");
 MODULE_LICENSE("GPL");
-- 
2.55.0

