Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 369CF415F33
	for <stable@vger.kernel.org>; Mon,  3 Aug 2026 14:19:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785766758; cv=none; b=EW0gem5YzGO+GIygmOpGD418ImrvLR0q177vq+/tzYRvVVAsTmhHtj+3D5mW7p4Y0ju72K1ZcrLNWxTVwMoAlNuBWoN9wSIzR1vPfQ0EYYSKb6J2xDCFn0m5Jpoc68XOnnVli5GUA7MfhhE8RSaDzVJsyinqlhanyeVGMBtwDDA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785766758; c=relaxed/simple;
	bh=N9PJNuDDiLBhepO6N7YXvt675JCR2tfbOBTORDs0p5I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Gurmb4oL/v9QJmSetF6i4fmPMfQEKpufocgIIx/Gdw7VBw+1IG+gOVVnb411O4yj8w5sGnoc6heHrEhNhtVFR9H712A702SGa8BM6JyBDrXvvTXwFqc4Btkl6pONpwvHL9YDKVDhWwJnZx3of93Ne3d0GYYaJcWvjrj+B41+FVQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hR2P9c8P; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hR2P9c8P"
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-38e08baf860so3007213a91.2
        for <stable@vger.kernel.org>; Mon, 03 Aug 2026 07:19:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785766756; x=1786371556; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Sg8Jme5PexkyEgenMV9ZNSXBG0k75+HQtQ7Cc373Klc=;
        b=hR2P9c8PQe4ZUojn06ijOGHt51zXd8KoyNf2byyorBaskKsEgcP8mT4/BgecxhCPBz
         fnfLiUp3412eDcQnz5ZgClR3qL7tfXspzJ/TLv+VcZLDFePpVY1XtIrV88KX0HhgjiWl
         EMC7QJnrnXDrgGZxZemmSP8yQ6HZq+enUF7lLLOjqVxBN4pRPonkoZV8zMIdeTvMsOOG
         30VyxRxAj9PbM+vn39KKEshQUJjO1F06MEF49VNbdnJuhhSFeAedaFVSS/e+mxcIzdrA
         QL9tm+ah7XS1cEgtqJDZvLg25yuliJb3SYU5cz1Z3sFFe+rsGjg6hjuYyxfrOp8kKWAo
         ztaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785766756; x=1786371556;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Sg8Jme5PexkyEgenMV9ZNSXBG0k75+HQtQ7Cc373Klc=;
        b=qnNItrp3jIzd8T8JKhRV1FMn7E4+wBDK42NkoE3Gr12PZVk27KR+7w1vocmxjXCOi6
         QB5WIWa6tNCQjP5pLyvxf0hrEc0niRox8T4sY+DE1u0fu9A3lKbBbWmDZhhbrsJNp4y2
         3aejggyPVj4dHgCxXYJzfqr/y5QsnsLAHUM2rRciTchMeBOIws9iBDd4kGF5JRz5YC2U
         JYdZlolORGXVEBm7Jf9ksFybe+ofEChlRBLKJoW56EZHiEie3IYZKkcotmoVfrHO+a/5
         c5HJLJxkE0FGpKMrh104WnYgmz4umV+MOHSOiZ8MT1DAwxwncZxYgiG6v+gREpd7bav+
         rY8g==
X-Forwarded-Encrypted: i=1; AHgh+Rqz0l5EzZ/2v1ZQ8QOXPV6jjbjtiU8QuI99g5Y0RtH3oGPNHuxanv9L82fivt9A91tKVmX2ZeM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwOy0TIBFpGir+uCtEwMbtrIFEGdX2RHxxGN6Md//xWnr2d2IiG
	oaSTBGRvaISJixi9Wk06WhYMBeD8iHV3EvMnmrXxg/MBmPu181SjSV2J
X-Gm-Gg: AR+sD11ozRv90a8Jr1+YhqLSYjJNMSL4WUhfc8qoHkfln+ViuYgJdMc9ATWly6ugXI3
	uGzCwcdCvcLSLadYSovx9qJCahfFk2VPRdKTNFlbDMTH5aW+/xH8/HZyag66Pw+GGN5vDkAGPzQ
	HbBQpVLAYAQ3G5k/lqOhp5uORvomOGLOiO/rffJee8gQf2Pt37rPng4I1o3P6rTtsxYyQewjqf2
	HrjVGKoS70ET+tBN76hfgLeDy2A3GrzfAP4zBJyHGO1MdKvgXQFGdvSUdsx7npt772HC1BekrZz
	WsU9zMmUsRwVGHzwOKfI73HUFlpBERDLxsKnOmH/cLL+/+BBKxyStLzdMwNYPpsFoBurXn2HJ3u
	of8fSAPo4NzJ9OUP/Ob2pB37UYazwgsvlLXHpxKgqLDdODCO0+zXvbDO7mTSI7iAgeZowM+boCC
	l1zN7IeTyQbwNEZutBuqf+dpUDZmvE4eR5UX96OkZoLjjBQoY2BGJFT+Um7CPNMKtemw2rOlijL
	swn2pMDY9Is8Fz5/vOX
X-Received: by 2002:a17:90b:1b07:b0:38e:7f1b:efa with SMTP id 98e67ed59e1d1-38fbc438047mr9182294a91.11.1785766756347;
        Mon, 03 Aug 2026 07:19:16 -0700 (PDT)
Received: from buffalo-ssd (M014013071096.v4.enabler.ne.jp. [14.13.71.96])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-38fb30dff2esm4078462a91.13.2026.08.03.07.19.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Aug 2026 07:19:16 -0700 (PDT)
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
Subject: [PATCH 24/32] clk: mediatek: mt8167-apmixedsys: Switch to common probe/remove helpers
Date: Mon,  3 Aug 2026 23:16:51 +0900
Message-ID: <20260803141659.559129-25-akkun11.open@gmail.com>
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

The MT8167 apmixedsys driver can use the MediaTek clock framework
common initialization sequence. Reduce boilerplate code by creating
struct mtk_clk_desc and using the mtk_clk_simple_probe/remove helpers.
Also, add a remove callback to properly support module unloading.

Signed-off-by: Akari Tsuyukusa <akkun11.open@gmail.com>
---
 drivers/clk/mediatek/clk-mt8167-apmixedsys.c | 50 ++++----------------
 1 file changed, 10 insertions(+), 40 deletions(-)

diff --git a/drivers/clk/mediatek/clk-mt8167-apmixedsys.c b/drivers/clk/mediatek/clk-mt8167-apmixedsys.c
index fb6c21bbeef8..2b1d1de74cdb 100644
--- a/drivers/clk/mediatek/clk-mt8167-apmixedsys.c
+++ b/drivers/clk/mediatek/clk-mt8167-apmixedsys.c
@@ -89,44 +89,13 @@ static const struct mtk_clk_divider adj_divs[] = {
 		     0x1c4, 24, 3, CLK_DIVIDER_POWER_OF_TWO),
 };
 
-static int clk_mt8167_apmixed_probe(struct platform_device *pdev)
-{
-	void __iomem *base;
-	struct clk_hw_onecell_data *clk_data;
-	struct device_node *node = pdev->dev.of_node;
-	struct device *dev = &pdev->dev;
-	int ret;
-
-	base = devm_platform_ioremap_resource(pdev, 0);
-	if (IS_ERR(base))
-		return PTR_ERR(base);
-
-	clk_data = mtk_devm_alloc_clk_data(dev, MT8167_CLK_APMIXED_NR_CLK);
-	if (!clk_data)
-		return -ENOMEM;
-
-	ret = mtk_clk_register_plls(dev, plls, ARRAY_SIZE(plls), clk_data);
-	if (ret)
-		return ret;
-
-	ret = mtk_clk_register_dividers(dev, adj_divs, ARRAY_SIZE(adj_divs), base,
-					&mt8167_apmixed_clk_lock, clk_data);
-	if (ret)
-		goto unregister_plls;
-
-	ret = of_clk_add_hw_provider(node, of_clk_hw_onecell_get, clk_data);
-	if (ret)
-		goto unregister_dividers;
-
-	return 0;
-
-unregister_dividers:
-	mtk_clk_unregister_dividers(adj_divs, ARRAY_SIZE(adj_divs), clk_data);
-unregister_plls:
-	mtk_clk_unregister_plls(plls, ARRAY_SIZE(plls), clk_data);
-
-	return ret;
-}
+static const struct mtk_clk_desc apmixed_desc = {
+	.plls = plls,
+	.num_plls = ARRAY_SIZE(plls),
+	.divider_clks = adj_divs,
+	.num_divider_clks = ARRAY_SIZE(adj_divs),
+	.clk_lock = &mt8167_apmixed_clk_lock,
+};
 
 static const struct of_device_id of_match_clk_mt8167_apmixed[] = {
 	{ .compatible = "mediatek,mt8167-apmixedsys" },
@@ -135,13 +104,14 @@ static const struct of_device_id of_match_clk_mt8167_apmixed[] = {
 MODULE_DEVICE_TABLE(of, of_match_clk_mt8167_apmixed);
 
 static struct platform_driver clk_mt8167_apmixed_drv = {
-	.probe = clk_mt8167_apmixed_probe,
+	.probe = mtk_clk_simple_probe,
+	.remove = mtk_clk_simple_remove,
 	.driver = {
 		.name = "clk-mt8167-apmixed",
 		.of_match_table = of_match_clk_mt8167_apmixed,
 	},
 };
-builtin_platform_driver(clk_mt8167_apmixed_drv)
+module_platform_driver(clk_mt8167_apmixed_drv)
 
 MODULE_DESCRIPTION("MediaTek MT8167 apmixedsys clocks driver");
 MODULE_LICENSE("GPL");
-- 
2.55.0

