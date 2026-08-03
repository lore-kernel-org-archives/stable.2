Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B460F414DCA
	for <stable@vger.kernel.org>; Mon,  3 Aug 2026 14:19:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785766745; cv=none; b=J8qmiw25y7sQ5Fjt1duymWCfkPwyosLlBVP7/BLmxtF4QCQgmhp/YSEJ5cNJCHzo66RItx1DCby9KYroapBS7qKRq+g9FzBGlO96EWR+A3jtqVHJbHJlFGhYiIWZjFUpBwBWOGB3Ny+VnBEz7Ojp8chjdwCczarEKGQk+EKjTb4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785766745; c=relaxed/simple;
	bh=V+xiIh8ybmCYAvwYMo5Mm6jhKxCUQbprWmuQ6vVtMh8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=N74kDOmG+tVvOBHcFtLWG7Z+RlV9uMU1yDIhLGsiTOVcLEZ7OnLOOe6cqowk7/oE9iCy26L1Tkw6MixSmt1lt8xukkcr+t0WKUgVF2zL3nQWT5TUi5VKGiSyvHsVgzQC4WrDH44ffurJL/aBiVlTjdXN+usU+waYRSiLDGILTpA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IrBg/Tyl; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IrBg/Tyl"
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-38dc4553f62so3189495a91.0
        for <stable@vger.kernel.org>; Mon, 03 Aug 2026 07:19:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785766743; x=1786371543; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=m4Z5pWHAYmt7m7KtNfIU1rNnfqDpY05zeAJJ5XpoEVA=;
        b=IrBg/TylTUJZOjlcVpy+GrG3Wb8HJ3ahGe0a3qtcfVH5Z/SFOgCOMMGQuHnD/OqfCL
         PP/lvecXMhEXRvu+l2soEFy3qF0XwZvBAhS89EIiPEEjGg23KACiejaLdkPEXibStrOh
         Mt+ZyHvCN3Wg6jmi8/65upeQhiDakdiHLePLI3yd3XJ586+JIiDTPWR/HW0sMBGalqzI
         M3m30OyvtyARMCBKWosiMleIvXpauksD886fYz36K5Vj9ALZTbVmLbgVh2OgK5U5HLjc
         X/kwgys1w+l6GyNo5q4eQ0qdcDZ1gXxnkap3MkftT7tubkzW5M97PfvCv0wRGgYxkKUT
         LHCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785766743; x=1786371543;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=m4Z5pWHAYmt7m7KtNfIU1rNnfqDpY05zeAJJ5XpoEVA=;
        b=BYPYpjSNRAfbxVOILElSUGqNRCXP4Te7QhqCJ8a5jxVjM/lewR1ankH6RV4xhC0wal
         8UscXkh3nW5CzEGAnAWtRBmUyi26xHFSx/RUElKpHpLCZ2TPYTjlsaD2Z0tHqdI4YREJ
         Hr228jKEya+xt7RrIGgjBkfWycXw811YFdNISSdQuVlnSI8SIlT40NYNPx/jYmE/jv6p
         FXhVangqzqxwgTqc7q6SxIP+EIhg+V9pTlrLxmSgyQvFvJBMgaQ85g/FfzRx1x3wGuXx
         BAYTWyX8NSq9rcigqe4erW6Lk0ZNLdAdfDhM7ys9EKcRhYB15tj/qzIdGHKPyjRHP8D3
         QuZw==
X-Forwarded-Encrypted: i=1; AHgh+RpxsAWlt1bvFS0d7C7ayKP9NJEjZwsjd4eqEfFzIZwKYVKM7mqTxyT36gTC67twSrVwh3IZag0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy1h3Gy25/qO1epGZrk+KC9ZQXeg5Qoyj0rbaZoEoyr+nNTdNkL
	AZQeVJwjS3WpTrAUTyNosmOX7pLgGYvW0KHUr1IZFLCXf3cBffjdrirz
X-Gm-Gg: AR+sD10Xb8ZE2lmcJL6Dj9Bf5itC3xlTMSrRFFdTQXL5ed9eNMnTS8S/jCVHPleiKfG
	CsOn63GPtJVts5ZFCKgSUc9lmW9bv6AZSs3vC52n5gFFTCy4avgCk4oHrEV7SoLShe+Wmoc7GqB
	dH+mTKh6P1sM8ynk/oikvinTYNjUMBboaf76sH7BCwrODyGtwCdmGeHzR8e9vPKzY7fDGdsnAOH
	rS8tQzOz/IZE8HTonKoTdUmfGvIvdA7IuOZIDgjsTOQrIROMEoJ2D6UYDUCPs7RxAOvIDMSn/xa
	NrahB1/uyAqJcak1sjceueNT/9nby/6jwNUSGiLcZFUA2WyJdB1lZa1WO8YzBaLUIv3KsUOU2c3
	sRAhQO/eZEn20b8ZeDYwDUKeFMSkV0GKlJboK3GC3/Q0Hg6Ky5/R608xx7jYVVKPQI1ZKRpGo+G
	lyWESl6dxDT2ol1/uzQHXEKWcnoXqcmbIN3JZ0caaHre8OrLtoAA9cI0y8LbGInaqC3jUqHXfAZ
	VLfJr2Y5DmwSahe160D
X-Received: by 2002:a17:90b:4b41:b0:38d:e658:595a with SMTP id 98e67ed59e1d1-38fbc409a24mr9805618a91.2.1785766742716;
        Mon, 03 Aug 2026 07:19:02 -0700 (PDT)
Received: from buffalo-ssd (M014013071096.v4.enabler.ne.jp. [14.13.71.96])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-38fb30dff2esm4078462a91.13.2026.08.03.07.18.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Aug 2026 07:19:02 -0700 (PDT)
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
Subject: [PATCH 21/32] clk: mediatek: mt7986-apmixed: Switch to common probe/remove helpers
Date: Mon,  3 Aug 2026 23:16:48 +0900
Message-ID: <20260803141659.559129-22-akkun11.open@gmail.com>
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

The MT7986 apmixed driver can use the MediaTek clock framework common
initialization sequence. Reduce boilerplate code by creating
struct mtk_clk_desc and using the mtk_clk_simple_probe/remove helpers.
Also, add a remove callback to properly support module unloading.

Signed-off-by: Akari Tsuyukusa <akkun11.open@gmail.com>
---
 drivers/clk/mediatek/clk-mt7986-apmixed.c | 37 ++++++-----------------
 1 file changed, 9 insertions(+), 28 deletions(-)

diff --git a/drivers/clk/mediatek/clk-mt7986-apmixed.c b/drivers/clk/mediatek/clk-mt7986-apmixed.c
index af3e002bbfb7..6df3e9555e4e 100644
--- a/drivers/clk/mediatek/clk-mt7986-apmixed.c
+++ b/drivers/clk/mediatek/clk-mt7986-apmixed.c
@@ -57,45 +57,26 @@ static const struct mtk_pll_data plls[] = {
 	    0x0278, 4, 0, 0x027c, 0),
 };
 
+static const struct mtk_clk_desc apmixed_desc = {
+	.plls = plls,
+	.num_plls = ARRAY_SIZE(plls),
+};
+
 static const struct of_device_id of_match_clk_mt7986_apmixed[] = {
-	{ .compatible = "mediatek,mt7986-apmixedsys", },
+	{ .compatible = "mediatek,mt7986-apmixedsys", .data = &apmixed_desc },
 	{ }
 };
 MODULE_DEVICE_TABLE(of, of_match_clk_mt7986_apmixed);
 
-static int clk_mt7986_apmixed_probe(struct platform_device *pdev)
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
 static struct platform_driver clk_mt7986_apmixed_drv = {
-	.probe = clk_mt7986_apmixed_probe,
+	.probe = mtk_clk_simple_probe,
+	.remove = mtk_clk_simple_remove,
 	.driver = {
 		.name = "clk-mt7986-apmixed",
 		.of_match_table = of_match_clk_mt7986_apmixed,
 	},
 };
-builtin_platform_driver(clk_mt7986_apmixed_drv);
+module_platform_driver(clk_mt7986_apmixed_drv);
 
 MODULE_DESCRIPTION("MediaTek MT7986 apmixedsys clocks driver");
 MODULE_LICENSE("GPL");
-- 
2.55.0

