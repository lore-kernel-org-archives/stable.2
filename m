Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C16341CB5A
	for <stable@vger.kernel.org>; Mon,  3 Aug 2026 14:18:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785766694; cv=none; b=BTLctgtGNFS4quVAHtSYfrqTw15IeCuQOsl6EdEQk4b+G89UGjMTERcv7NWePg0XapZZx5+6krhqF1tq1CL/mIdMZ1nTxwOQFzxNSRlOiiwFXHRLycvRHSe13JUgFVVMFCFCo7rRefq+g+fyUbd2mZ2Rou+VY7JcZicrLM1Zcfg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785766694; c=relaxed/simple;
	bh=gIBjErd2e3siZ9t2gE19tfKuREF4r0RpkffEpLk6rgw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jEFSsxRxWQQ3z9Pm65ue4cvov6WIVuqQU9E0nrrjHV57jVM/dzpPJUDPSRUdcSo62J15KX3gypTht57L/ZfXLUuUdzQZJGkbAuktuwU3fpU+3BV0QuXKcE6gypRQ6+YZlzXvEYseyjwHaH7+XSlfH5x0ZUWeAisMZ+3SkfDfHcg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VWHvvAAx; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VWHvvAAx"
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-38fdeaed181so849483a91.1
        for <stable@vger.kernel.org>; Mon, 03 Aug 2026 07:18:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785766692; x=1786371492; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=35MPZYKLCACvIdbhYzSIWcM8WhL87zoy/9oei4fzDb4=;
        b=VWHvvAAxlQDBz06vpf9NMcaigKC64zqfYL4A/BqzoLJrhGI2wOiB68k15Sbm5a8Ikt
         PZ/0XTq+fKYsn6OpHOfm6gE8E0g6c+yr7raBAtm2VpQO5hvTHWyXAfo61O2Kva7dws6H
         jRK6N2aV7cU4tSvw1iILbMFgZuO+jHDfTcMEgnAFMMh9C91foQ9CQeirDsdutBlRXksH
         guatefXMU1LTMD8Zthxh3SorDY4fOwBa8v13gPHmKPsAUMzhuQeAzRkZ/dbZbiWsm8ef
         Nec8NK7Ho62Si8zJF9yZ5XndiPPytcyzHxLstN1GKZb7iS0ibktfMjWNZHzOmEo3436o
         yl5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785766692; x=1786371492;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=35MPZYKLCACvIdbhYzSIWcM8WhL87zoy/9oei4fzDb4=;
        b=kSJxFe8ZmZhJe+6kH/hYaCyKThMHchf5rMPoHlMa9za4FpASZcfgQROJlXd5+8+Kjf
         hxPYHRi4148Lo564izy3KUYw0CdPED/KY239O3gCn0SLgyDAG/6SfwnzavWvpwtgoCoE
         v58qmG+i1zykpVKJzI4kdNr8MjjLK32eJw4IFFbdY0BR2fnCpO6+xFHrIHEzAu1/5Hrq
         5LYDr6/cjmon0TphAXuL4LYHqOuHys4qIq8qEqYDjRQhCSJxxCeDpZ0r2cPXcFK3ZGEF
         oVRPaOnCErMtyPUGH10fkEsuSygst9Ru+5wasFL5yvx3Vbv0rjDU1sdX/CQpGX5+NcFH
         XmwA==
X-Forwarded-Encrypted: i=1; AHgh+Rr7dD3E95fA59cfYoweL0/L+XBV1czN7KhW/LvWU4dReNXQk07eyWCbdbAjz61Ckr3EA7u76pI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxuHUqJKtFJEh1vQ6VZ08tlEkeumRrANKgcLa4SO7fc7ndI+3Xt
	Ko4P44mbvTuUMhkvunrGbIg3wCKdypUld262BXJqJC2ZVMCkI1fu5ByZ
X-Gm-Gg: AR+sD10SoMnbb74ZiWdCdMFhQCQHKTkgPZv96XnYDdez62b4ZpDMIbwS18BjsBR32Qf
	TPW9RQe4qZNcS4jGIVYnKCYoA7vjmQh+P2P2qsshka04QnjeptRJhbKXAQXaFnoZ4oGUgUEl0Kq
	RuEX88Vby6DK1+RM9npCU3y02KfWy/fZHkq6tbEgd5wKJkfuWLApn76cKPSucky/8PQpbLyKqp1
	Yf9XFEI105IRUstysp0Vs+gAmH98PW3Fs7gX4BdU6RcdOv4iuRPP0ArtrPGQXTtQ8gTxlFk55xL
	N8ZRuHE0z3pOxdLA93u5eBuIgxynhJ7IYwfrr+lCAdiarSDOlna6qSBe3wkBC+CROZYRWa3Bzi3
	oJ93EknSN549HiIS7f3Ti208bWwgTbpxNHLNR675GbpwP61IyA3EZj02dC1Fe9OcsuVQma9BJWB
	EhbW8PvrDyj7+Cc9i7oR4aBKUc87wirkOb6ZNE7jh0OC2M+Ue46I5SxEupSkeBWHtJl3yfFE0mp
	hWqJMj8aDcXgFDGzL1UPA==
X-Received: by 2002:a17:90b:3e8d:b0:387:e0cb:c8da with SMTP id 98e67ed59e1d1-38fbc57a3b2mr8948527a91.35.1785766692243;
        Mon, 03 Aug 2026 07:18:12 -0700 (PDT)
Received: from buffalo-ssd (M014013071096.v4.enabler.ne.jp. [14.13.71.96])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-38fb30dff2esm4078462a91.13.2026.08.03.07.18.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Aug 2026 07:18:11 -0700 (PDT)
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
Subject: [PATCH 10/32] clk: mediatek: Add PLL support to common probe/remove helpers
Date: Mon,  3 Aug 2026 23:16:37 +0900
Message-ID: <20260803141659.559129-11-akkun11.open@gmail.com>
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
support PLLs. This reduces boilerplate code in apmixedsys drivers.

Signed-off-by: Akari Tsuyukusa <akkun11.open@gmail.com>
---
 drivers/clk/mediatek/clk-mtk.c | 19 ++++++++++++++++---
 drivers/clk/mediatek/clk-mtk.h |  3 +++
 2 files changed, 19 insertions(+), 3 deletions(-)

diff --git a/drivers/clk/mediatek/clk-mtk.c b/drivers/clk/mediatek/clk-mtk.c
index 8148c21e6099..c3369a04cdec 100644
--- a/drivers/clk/mediatek/clk-mtk.c
+++ b/drivers/clk/mediatek/clk-mtk.c
@@ -20,6 +20,7 @@
 #include "clk-gate.h"
 #include "clk-mux.h"
 #include "clk-cpumux.h"
+#include "clk-pll.h"
 
 const struct mtk_gate_regs cg_regs_dummy = { 0, 0, 0 };
 EXPORT_SYMBOL_GPL(cg_regs_dummy);
@@ -486,7 +487,7 @@ static int __mtk_clk_simple_probe(struct platform_device *pdev,
 	}
 
 	/* Composite and divider clocks needs us to pass iomem pointer */
-	if (mcd->composite_clks || mcd->divider_clks) {
+	if (mcd->composite_clks || mcd->divider_clks || mcd->plls) {
 		if (!mcd->shared_io)
 			base = devm_platform_ioremap_resource(pdev, 0);
 		else
@@ -514,7 +515,7 @@ static int __mtk_clk_simple_probe(struct platform_device *pdev,
 	num_clks = mcd->num_clks + mcd->num_composite_clks;
 	num_clks += mcd->num_fixed_clks + mcd->num_factor_clks;
 	num_clks += mcd->num_mux_clks + mcd->num_divider_clks;
-	num_clks += mcd->num_cpumuxes;
+	num_clks += mcd->num_cpumuxes + mcd->num_plls;
 
 	clk_data = mtk_alloc_clk_data(num_clks);
 	if (!clk_data) {
@@ -522,11 +523,18 @@ static int __mtk_clk_simple_probe(struct platform_device *pdev,
 		goto free_base;
 	}
 
+	if (mcd->plls) {
+		r = mtk_clk_register_plls(&pdev->dev, mcd->plls,
+					  mcd->num_plls, clk_data);
+		if (r)
+			goto free_data;
+	}
+
 	if (mcd->fixed_clks) {
 		r = mtk_clk_register_fixed_clks(mcd->fixed_clks,
 						mcd->num_fixed_clks, clk_data);
 		if (r)
-			goto free_data;
+			goto unregister_plls;
 	}
 
 	if (mcd->factor_clks) {
@@ -630,6 +638,9 @@ static int __mtk_clk_simple_probe(struct platform_device *pdev,
 	if (mcd->fixed_clks)
 		mtk_clk_unregister_fixed_clks(mcd->fixed_clks,
 					      mcd->num_fixed_clks, clk_data);
+unregister_plls:
+	if (mcd->plls)
+		mtk_clk_unregister_plls(mcd->plls, mcd->num_plls, clk_data);
 free_data:
 	mtk_free_clk_data(clk_data);
 free_base:
@@ -668,6 +679,8 @@ static void __mtk_clk_simple_remove(struct platform_device *pdev,
 	if (mcd->fixed_clks)
 		mtk_clk_unregister_fixed_clks(mcd->fixed_clks,
 					      mcd->num_fixed_clks, clk_data);
+	if (mcd->plls)
+		mtk_clk_unregister_plls(mcd->plls, mcd->num_plls, clk_data);
 	mtk_free_clk_data(clk_data);
 }
 
diff --git a/drivers/clk/mediatek/clk-mtk.h b/drivers/clk/mediatek/clk-mtk.h
index 02fab4b166f2..b6504b3e77ed 100644
--- a/drivers/clk/mediatek/clk-mtk.h
+++ b/drivers/clk/mediatek/clk-mtk.h
@@ -23,6 +23,7 @@
 #define MTK_WAIT_HWV_DONE_US	30
 
 struct platform_device;
+struct mtk_pll_data;
 
 /*
  * We need the clock IDs to start from zero but to maintain devicetree
@@ -254,6 +255,8 @@ struct mtk_clk_desc {
 	size_t num_mux_clks;
 	const struct mtk_composite *cpumuxes;
 	size_t num_cpumuxes;
+	const struct mtk_pll_data *plls;
+	size_t num_plls;
 	const struct mtk_clk_rst_desc *rst_desc;
 	spinlock_t *clk_lock;
 	bool shared_io;
-- 
2.55.0

