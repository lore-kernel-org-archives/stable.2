Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36AB2413D62
	for <stable@vger.kernel.org>; Mon,  3 Aug 2026 14:18:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785766740; cv=none; b=E9ny8kHUn4rMZ8e6qU2QLSKn1NeJKbpploYMvWLYiGUyBNHBePC/RaLIzvgEkYY7RjSjOBAw7Y0l/i7In9H8irRfxQL0NULkYBTDR9X86QfbkqGr5KO1m3He4x81mPvbjg76obyjXqtASFf291fMdk7MBg4v8xYzXE1bctjBQ9M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785766740; c=relaxed/simple;
	bh=TfeXiYj8llhfrsV1efKFeIRRIiNS2pbhNesZ8nprYFU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OdOHrpNe5EMLabGH+t0OEn0njH2fxjocoBos/fWfQfpz0+cbYDFoLZ+euR3Qn2EN8pOibGHyNSUMgBpUY0qWpXHFRP9NWY7GJrN1ik3IvgR/8E7fEUQqopp0geYLsIYrWDXpDGWsXQW5JXbzwFViL9Be8LLlRwjzeJOAsnmifpg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PeeRQRna; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PeeRQRna"
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-382ef647e20so3626826a91.1
        for <stable@vger.kernel.org>; Mon, 03 Aug 2026 07:18:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785766738; x=1786371538; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=EFy5iVZEOfPquGcw+vh6esYYUXcjeKTrkCboYc9Z/fs=;
        b=PeeRQRnahyguEvnI/QWPZ203dv9CEG6EFhSRGjI0V8697ptWuwRnclM8OZscNyUyDO
         AXHdQG6h3ctVFuKnmVeQWEL6sr050Qx2ijVXe9uqpEm5N+P2azdZ+e38cougv3MTvwf4
         yHJg0lgn13rNPQ14P939R7LlbJVZSLdgDintnJ3kB5HpUAe9KAjDxaYIR46rSlLF6awd
         8QHidZpiRBxBf7fQW5qqHlAtc6OzTpe9BWX2tzSA3nwyEosxarlagk9uHYQw1oPc0Jd3
         uMzXrIbLPK8sUqhBvQiUDhfR9Sx+lnCO0AJMog3wrGON+Py02caN8z0NZrVHhuMeVr/P
         A0eA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785766738; x=1786371538;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=EFy5iVZEOfPquGcw+vh6esYYUXcjeKTrkCboYc9Z/fs=;
        b=fayq1hjoqQCy1aqei9itrh47Ie4bo8PwNmnvkenZxQ+DawTBPL3K+1GCR00Hm1jHFi
         /t9PxMDqaKLporlJWPzzNwWmZHPFJMvAKBizopayzdx3b8rKHI6W+esdV95n4C3Q/1nB
         k9WonV4D4SVuVwSWc8HuM5IKQa2/T6Wu+X8TQug0AkzV8aIvMVcAEwsmLPSf31eRtRgl
         1ZBeHCIiO+wyaHxOKK6fzTJG4NRRwH8QifzNem+ot2w9uXA15ucu6s3muGGzCofQ05jw
         4xNFxhkn7dKEqaiUodomFu8yYMALQRRdQU2TGAgd2C62PZZ3LZedzb5cmWLW5wEmWDuX
         WoNQ==
X-Forwarded-Encrypted: i=1; AHgh+RqVQwiAsA8x5INcZxdc1F4GBtowdlke0N6aHONjRKiNOtbtpqYTrcscf3M4FEXI170T6NyOOSs=@vger.kernel.org
X-Gm-Message-State: AOJu0YyRsqp9tfJ5vkmwLSQvHFnYtsTF6l+/4BAulqKsL0SO4vQmvG/F
	v4z/j5CGjcRD9zWFeJgSeETuNV0t2yFg8zrbz4JjxREtDLspuE9n+0BB
X-Gm-Gg: AR+sD11LZePsVfh1DsE9Wr5fy5LZwX+gMPIkC+gYkNmaJWGIX3/vNO5vXJ611/Z3TN0
	LNIqIBR8cZka+3QgVSjIFp24xltqnW/y6ACmDKAxRsMeWuNsPBIzscLnvbmmbekZ6IBrfY3GA1B
	tbMUtFkR+Xxv6K+Xe6AyCMRQw/KXwAvyBssaB0RhK8D4+KrbBsn7lvO40XOv+Jb6VZB1ANyG0r6
	NOy+BgnIuMhCsl5MITr2KFIZwdpuD0jX+1wPjoFnqrMntRFuMvK333hPWA7HtzJXiVUDnGAayt9
	Dz2By7EMCah2GhT2x5UOJZdo7XYF64rVj0VZlT/7Ns1gDem5MUIQeWrJf/TazVScd+RcaP5yoAy
	PmhENeFJ/DZJb4z/72VNPbcVNxuXwAS+RCJvBpV9TeUbPYi2MZ1+8YNPQwZIuWRY3lPw5lpSeyt
	n95bjbb7aNP2CvQrsKlG2byXc6FYXDLsuIanbiw9Z3yFCHlaaBG1xcL4TGxFljdGK9iXsqbxqgi
	21jabJHMFED62bsYgDA
X-Received: by 2002:a17:90b:3851:b0:38e:dc4:3f64 with SMTP id 98e67ed59e1d1-38fbc52da42mr9027280a91.38.1785766738150;
        Mon, 03 Aug 2026 07:18:58 -0700 (PDT)
Received: from buffalo-ssd (M014013071096.v4.enabler.ne.jp. [14.13.71.96])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-38fb30dff2esm4078462a91.13.2026.08.03.07.18.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Aug 2026 07:18:57 -0700 (PDT)
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
Subject: [PATCH 20/32] clk: mediatek: mt7981-apmixed: Switch to common probe/remove helpers
Date: Mon,  3 Aug 2026 23:16:47 +0900
Message-ID: <20260803141659.559129-21-akkun11.open@gmail.com>
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

The MT7981 apmixed driver can use the MediaTek clock framework common
initialization sequence. Reduce boilerplate code by creating
struct mtk_clk_desc and using the mtk_clk_simple_probe/remove helpers.
This change also makes it possible to build the driver as a module.

Signed-off-by: Akari Tsuyukusa <akkun11.open@gmail.com>
---
 drivers/clk/mediatek/Kconfig              |  2 +-
 drivers/clk/mediatek/clk-mt7981-apmixed.c | 37 ++++++-----------------
 2 files changed, 10 insertions(+), 29 deletions(-)

diff --git a/drivers/clk/mediatek/Kconfig b/drivers/clk/mediatek/Kconfig
index f5460ce3ffba..6449b77d56ed 100644
--- a/drivers/clk/mediatek/Kconfig
+++ b/drivers/clk/mediatek/Kconfig
@@ -427,7 +427,7 @@ config COMMON_CLK_MT7629_HIFSYS
 	  to PCI-E and USB.
 
 config COMMON_CLK_MT7981
-	bool "Clock driver for MediaTek MT7981"
+	tristate "Clock driver for MediaTek MT7981"
 	depends on ARCH_MEDIATEK || COMPILE_TEST
 	select COMMON_CLK_MEDIATEK
 	default ARCH_MEDIATEK
diff --git a/drivers/clk/mediatek/clk-mt7981-apmixed.c b/drivers/clk/mediatek/clk-mt7981-apmixed.c
index 851d0bc7840a..810395aff253 100644
--- a/drivers/clk/mediatek/clk-mt7981-apmixed.c
+++ b/drivers/clk/mediatek/clk-mt7981-apmixed.c
@@ -59,45 +59,26 @@ static const struct mtk_pll_data plls[] = {
 	    0x0278, 4, 0, 0x027C, 0),
 };
 
+static const struct mtk_clk_desc apmixed_desc = {
+	.plls = plls,
+	.num_plls = ARRAY_SIZE(plls),
+};
+
 static const struct of_device_id of_match_clk_mt7981_apmixed[] = {
-	{ .compatible = "mediatek,mt7981-apmixedsys", },
+	{ .compatible = "mediatek,mt7981-apmixedsys", .data = &apmixed_desc },
 	{ /* sentinel */ }
 };
 MODULE_DEVICE_TABLE(of, of_match_clk_mt7981_apmixed);
 
-static int clk_mt7981_apmixed_probe(struct platform_device *pdev)
-{
-	struct clk_hw_onecell_data *clk_data;
-	struct device_node *node = pdev->dev.of_node;
-	int r;
-
-	clk_data = mtk_alloc_clk_data(ARRAY_SIZE(plls));
-	if (!clk_data)
-		return -ENOMEM;
-
-	mtk_clk_register_plls(&pdev->dev, plls, ARRAY_SIZE(plls), clk_data);
-
-	r = of_clk_add_hw_provider(node, of_clk_hw_onecell_get, clk_data);
-	if (r) {
-		pr_err("%s(): could not register clock provider: %d\n",
-		       __func__, r);
-		goto free_apmixed_data;
-	}
-	return r;
-
-free_apmixed_data:
-	mtk_free_clk_data(clk_data);
-	return r;
-}
-
 static struct platform_driver clk_mt7981_apmixed_drv = {
-	.probe = clk_mt7981_apmixed_probe,
+	.probe = mtk_clk_simple_probe,
+	.remove = mtk_clk_simple_remove,
 	.driver = {
 		.name = "clk-mt7981-apmixed",
 		.of_match_table = of_match_clk_mt7981_apmixed,
 	},
 };
-builtin_platform_driver(clk_mt7981_apmixed_drv);
+module_platform_driver(clk_mt7981_apmixed_drv);
 
 MODULE_DESCRIPTION("MediaTek MT7981 apmixedsys clocks driver");
 MODULE_LICENSE("GPL");
-- 
2.55.0

