Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BBB041A914
	for <stable@vger.kernel.org>; Mon,  3 Aug 2026 14:18:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785766690; cv=none; b=s+GV8fqDjoOwbIMPW6PJhXMnA9dePr2xGKtt/k4LA0AUWS71hqX578ZcimyDoMXFCYU/qD4wh15rWtHkH6sdD3qCthMzOlc/h6ZUQ4kQj9hAVrFmWkPvqUk7WnlcAQtaq5EFaqy3aHSb19lLmEcRAWtC3hKDU8Y13N91PIp/9UU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785766690; c=relaxed/simple;
	bh=MLI5y678+94kda6BFxWOuNupkCQ3DfRm8M73wi7fZVA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=F6KpJRMrsNFMFPxhGfp0OLvcVPN2qvYMrVguaiVUnZtxslEz53KwO1+H/vFnz3XMlVDbcgakviFgkwhYix6g10RxzdqnKcGecy264J0tcwS5PYFC4eIUNzvKS5p3zY52rxXUsQQnMrQBPCUyta/WL1TelFG7EYOR9X6AuJitHss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SHbrm+OP; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SHbrm+OP"
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-381b831d535so3844434a91.0
        for <stable@vger.kernel.org>; Mon, 03 Aug 2026 07:18:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785766688; x=1786371488; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=on4B/LfqkHipeTiwMXYITPpUbegoRxXk89rke8WT6Ak=;
        b=SHbrm+OPfMbEzCX/XgOR5mtFgQMosray+RYKVaV+UKe+Ew4EViThBKkyqKpNkA92KN
         l6m2O8d8KHpCVgJc1utgMck7Eju8mqnsshPjNE+7wjA9Herjm9r97FtznHX9O+W066YC
         hZNAabVft8X82wZj4nUOekdch+FhjxosNpNoPOp004xAzs0rpGiftfx1IuPQS9SdMTjK
         SYnQqV1ei7h51u32xqcLxEDAla6tHWDy8Bp0zjo7rpbdwRDyLvq5jJVYCvTnoL+rsUtz
         KmenlESiK4ET+GCquhvP+fBt4df6bQl+ceAsqs79eq7X4KS7m2dk+VIjkzQuTGfd3pQw
         +ZUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785766688; x=1786371488;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=on4B/LfqkHipeTiwMXYITPpUbegoRxXk89rke8WT6Ak=;
        b=bJ595ibb5VYOwwzAF9LA76fAeZ016Eg9jgDTH/qfN/dMO2os3h+9Ae/FJrpF7w+De6
         G93ASrjRYxtsXhguOzJ5S7aN30dBUiuR+JhdaaRRcFUtSnHX/eKVqqApgzgIVFdZW0+/
         99gIjIR3wx1z7Kluo8WMXwN/JclWEAgLxaranWuPHEYlT2Gg4jUwN5SGZHi+qNTAY7Oh
         TJStGeXflHMURiy/i20GOZJCPiq7pYXRJqXBDGed/F/n1ZpFUpxRNIB7fGmqo5uOX2Eb
         Kr93GbylB0fm2upY7BYl4fgGI9SLOTj29q7dLL/8oY5TWXsX9elqpCD5r707hgBoGuOK
         FVmg==
X-Forwarded-Encrypted: i=1; AHgh+RqflfHpdlG1ylZS1M1KNL8ChPkRt+sRz9uZ59CuUxuiK1tWgUvQGfjSx+l2D98tEdEWYBJolis=@vger.kernel.org
X-Gm-Message-State: AOJu0YzpWlYMUprbKXfq+TmfmfL1li5Vz5kIuELu2fu1bx/Fu/kynWNP
	EZINVpIomoSECvNAtd5GhgZr97WjLVikJbb5niA1YUQSPPD8KoV5H7G7
X-Gm-Gg: AR+sD10Z8weM5EQsj39jduoNt0PZXPocyvUfGbFUJOrJg6soW+5rMWXKLQc/v1zk/iI
	FOb1+l9YCPg75ckMqUbMKIErVYQ5V6+qlvwo1Euy2xqM16+Qsr9OeCWbS7F5slylb8+OfkTW0QE
	T8gX6yIPPPnNMgClS7y/eODRncJVACahDrG659ZinGdw7d+zJp3BoOBzved6ps9wcLJydduJQik
	HsQbYoxvm0NFq0V3zPt1BjD2r8Sya+RGhXYQwnDLIfTTnx5uvCTMHBRMjbLI5nzNoXBz4m1Do4R
	gDVmdQnCwFj2FsBrqs0ZZxWU59L/t0XQVW9134P2mlm8s0VMi0ubN+wWCu5xmS3qbQXdnDT/BX8
	8/AKZpmjHIFO7qETKE8K2spPi79lLa31Yx4FsI0CszqPmfZT5StkvxIxWXuPvFuvNlBr95osqw+
	N0MXiprb9LhE22Z+a+kV0/yLePHft0VehVv3EHF4MC0fdaTt/7khOg1uqqsC0ziZpg0/XgVVSf+
	D1nVTUUzD4UBREwscQE
X-Received: by 2002:a17:90b:5643:b0:38e:2f21:3bb5 with SMTP id 98e67ed59e1d1-38fbc4cfde2mr9523866a91.21.1785766687657;
        Mon, 03 Aug 2026 07:18:07 -0700 (PDT)
Received: from buffalo-ssd (M014013071096.v4.enabler.ne.jp. [14.13.71.96])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-38fb30dff2esm4078462a91.13.2026.08.03.07.18.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Aug 2026 07:18:07 -0700 (PDT)
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
Subject: [PATCH 09/32] clk: mediatek: Add cpumux support to common probe/remove helpers
Date: Mon,  3 Aug 2026 23:16:36 +0900
Message-ID: <20260803141659.559129-10-akkun11.open@gmail.com>
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

Extend __mtk_clk_simple_probe() and __mtk_clk_simple_remove() to
support cpumux clocks. This reduces boilerplate code in drivers for
SoCs that require cpumux registration, such as mt6795-infracfg.

Signed-off-by: Akari Tsuyukusa <akkun11.open@gmail.com>
Reviewed-by: Chen-Yu Tsai <wenst@chromium.org>
---
 drivers/clk/mediatek/clk-mtk.c | 18 +++++++++++++++++-
 drivers/clk/mediatek/clk-mtk.h |  2 ++
 2 files changed, 19 insertions(+), 1 deletion(-)

diff --git a/drivers/clk/mediatek/clk-mtk.c b/drivers/clk/mediatek/clk-mtk.c
index 3dfdd3a422f8..8148c21e6099 100644
--- a/drivers/clk/mediatek/clk-mtk.c
+++ b/drivers/clk/mediatek/clk-mtk.c
@@ -19,6 +19,7 @@
 #include "clk-mtk.h"
 #include "clk-gate.h"
 #include "clk-mux.h"
+#include "clk-cpumux.h"
 
 const struct mtk_gate_regs cg_regs_dummy = { 0, 0, 0 };
 EXPORT_SYMBOL_GPL(cg_regs_dummy);
@@ -513,6 +514,7 @@ static int __mtk_clk_simple_probe(struct platform_device *pdev,
 	num_clks = mcd->num_clks + mcd->num_composite_clks;
 	num_clks += mcd->num_fixed_clks + mcd->num_factor_clks;
 	num_clks += mcd->num_mux_clks + mcd->num_divider_clks;
+	num_clks += mcd->num_cpumuxes;
 
 	clk_data = mtk_alloc_clk_data(num_clks);
 	if (!clk_data) {
@@ -542,6 +544,13 @@ static int __mtk_clk_simple_probe(struct platform_device *pdev,
 			goto unregister_factors;
 	}
 
+	if (mcd->cpumuxes) {
+		r = mtk_clk_register_cpumuxes(&pdev->dev, node, mcd->cpumuxes,
+					      mcd->num_cpumuxes, clk_data);
+		if (r)
+			goto unregister_muxes;
+	}
+
 	if (mcd->composite_clks) {
 		/* We don't check composite_lock because it's optional */
 		r = mtk_clk_register_composites(&pdev->dev,
@@ -549,7 +558,7 @@ static int __mtk_clk_simple_probe(struct platform_device *pdev,
 						mcd->num_composite_clks,
 						base, mcd->clk_lock, clk_data);
 		if (r)
-			goto unregister_muxes;
+			goto unregister_cpumuxes;
 	}
 
 	if (mcd->divider_clks) {
@@ -605,6 +614,10 @@ static int __mtk_clk_simple_probe(struct platform_device *pdev,
 	if (mcd->composite_clks)
 		mtk_clk_unregister_composites(mcd->composite_clks,
 					      mcd->num_composite_clks, clk_data);
+unregister_cpumuxes:
+	if (mcd->cpumuxes)
+		mtk_clk_unregister_cpumuxes(mcd->cpumuxes,
+					    mcd->num_cpumuxes, clk_data);
 unregister_muxes:
 	if (mcd->mux_clks)
 		mtk_clk_unregister_muxes(mcd->mux_clks,
@@ -643,6 +656,9 @@ static void __mtk_clk_simple_remove(struct platform_device *pdev,
 	if (mcd->composite_clks)
 		mtk_clk_unregister_composites(mcd->composite_clks,
 					      mcd->num_composite_clks, clk_data);
+	if (mcd->cpumuxes)
+		mtk_clk_unregister_cpumuxes(mcd->cpumuxes,
+					    mcd->num_cpumuxes, clk_data);
 	if (mcd->mux_clks)
 		mtk_clk_unregister_muxes(mcd->mux_clks,
 					 mcd->num_mux_clks, clk_data);
diff --git a/drivers/clk/mediatek/clk-mtk.h b/drivers/clk/mediatek/clk-mtk.h
index 5417b9264e6d..02fab4b166f2 100644
--- a/drivers/clk/mediatek/clk-mtk.h
+++ b/drivers/clk/mediatek/clk-mtk.h
@@ -252,6 +252,8 @@ struct mtk_clk_desc {
 	size_t num_factor_clks;
 	const struct mtk_mux *mux_clks;
 	size_t num_mux_clks;
+	const struct mtk_composite *cpumuxes;
+	size_t num_cpumuxes;
 	const struct mtk_clk_rst_desc *rst_desc;
 	spinlock_t *clk_lock;
 	bool shared_io;
-- 
2.55.0

