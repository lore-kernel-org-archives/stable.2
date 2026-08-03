Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D03341D134
	for <stable@vger.kernel.org>; Mon,  3 Aug 2026 14:18:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785766698; cv=none; b=XsUlKRsPF3vfjqmNKdiSpD3gUz9d4lc9wpLps7dCJxDbe6pM7iMvHXMtPEfT8khhobpMtRflwxrhqpuT770k72zb9vtJXFNxDAohguVgcmFd3Seg2Btr9oEzUpCuww3GkfohYr5Bqw7H35b/pub3zj2/Z0s7QfSWVSbFtmlYciY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785766698; c=relaxed/simple;
	bh=MXdYkoJOWU7nHQn0EZ6AYJo6j4YPL0512kkd9ogUwIY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hKnjLuEy6q7UsPJjoyxxDNDRDTa0DKshl+TQo5HwHE5x0viQKc8c5Qe6EONbd+XnuqrC2AqHCZn74s7BcuV9p4ETyIfdpKx2Ix5xjS3MLvcca4+hdm8nPn0Cn9Iph++Ca9qF2XywXLpW/SLFneWUbnURB9/fT8E+l3IHXubFzWk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GJMBTMA8; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GJMBTMA8"
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-38e041ea211so3565081a91.0
        for <stable@vger.kernel.org>; Mon, 03 Aug 2026 07:18:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785766697; x=1786371497; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=LDSgzdM6Me9LLVj79/WXjjcDnuicd8z67Cux6+E8JMA=;
        b=GJMBTMA8X+gqZB1NPVsAO2/G1KZI/g4AqbS2hEUUx1+bRI9+1Vnycai7uxCDVIgcj8
         4X6tb8IBbXgk0j4C9mtES6LzrA9NaUWJjRRl74xiNVkCxYVc1Lfa0k67UvPR47NG/f/5
         uGsAPGh28Mz5jwasnTVO5132Sq1LDKP2zgRRBJZu+o8xZIj+p4d/9u/oazjvtKj+xUKI
         Igh+/8y1gygARYYss1TRAwNiqZE9mw+JvmPKdVrfAhPa6D4iagTJZZHXGWEXwQJ5Ql+P
         TqKdeaxVFh8LDRpRUMkQj1ym7J2lriXmNlGugN2M80sOsXEYWJ8abA/Hf1AHwDR0FGj5
         2f4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785766697; x=1786371497;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=LDSgzdM6Me9LLVj79/WXjjcDnuicd8z67Cux6+E8JMA=;
        b=KiWU2uR+6qz3SUCXhb9gsuEMydWAR868UTTNC+T/mZhUzEMTdwTdbWwPj8XX+ngNuv
         cLOCO/r6kdhCw2ISIkzVx+DIcxeOwN58mqN0mvJVwMix8ybhDOgWlQLnG3Lk4GGX9bYP
         x3RUMNBIAIW6KcpJ9PXM1gNgTl6z6GKDV91JywN0BMyzXh3rkqpwEQSC3Pr2GgCWAGvC
         oaWZCZnRUHf4vmFgIF4PnVm/wNRxKfUt0iID6m5bZ0Dk8rLXvWEuqnGPMAKtq8IHor1t
         KHGYDiWvsqvWR09fLe/WBW7LSPBtgeL/Jvx3w3xtxQxAePMcFc/zyx4ycS1ffy8VI4rR
         +57A==
X-Forwarded-Encrypted: i=1; AHgh+RqAxRAzpqcuWldyNtgXXkPZbSZYZeUHMru1Oupidw1HA3NSXZUXJP4zJc9i8mo9/Pp/6L3eNgo=@vger.kernel.org
X-Gm-Message-State: AOJu0YxXhQz+m10+3WLl0kXy3O2seeyB5A0hQpRGeURC9Q7MWiteExr4
	UxaLSB5vDd0jY5Qu3tHggMYKcv3sc66aJtmGjtMGW84pwq6vBE5t2HXJywjFqXB9
X-Gm-Gg: AR+sD116kez1Rgk+OWeiknLMr2tsLuIcVcplmqoIp3W8lj1dtSs+Czhyx9YWxlOleKG
	fQTN+YkAMK6bxXPwYT6wLUntNPzmyRhB6R8UMueOmynUgKb/SjjUGevWsfrqr/9EmysIN7a+Wn0
	tXjhRIi65FoRZx4XaCfz5XGc444Ulx1TGltLYSnjWvXIJxYRYpkbadsXifR3/IEiFM1Z7IPNaSg
	Y8t8hrXP1vw3Ol6rrpOBcQTYNb0bd7+sWlboB91416+KFP7XLbuLtf3sN4aJjngu55LVVUvEvb5
	Ycc/xU1syUXEiOJ7e6qG/kYxGPl5HCttnZoW9bIOZcKOVJSFEPrphyf+LsS2WZy3kPY1ct6xp21
	DJhNwNBULoUyc2b+7yPAdwR9x9wdtnELQE7eWdvDJBs7vT5d25qRUbs0EqpdNGIwWn5S8N94Im2
	dSpsrq0WlEqzBn3vVmLqpu72dt0gyTbHYtIMOZ6Os8j+DrzU0ydA8rc38+dPud3BnEKuiYEQ96/
	dZbRo+RnBxmhOXhQXXc
X-Received: by 2002:a17:90a:d004:b0:380:873:49cb with SMTP id 98e67ed59e1d1-38fbc4d615emr9615843a91.21.1785766696772;
        Mon, 03 Aug 2026 07:18:16 -0700 (PDT)
Received: from buffalo-ssd (M014013071096.v4.enabler.ne.jp. [14.13.71.96])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-38fb30dff2esm4078462a91.13.2026.08.03.07.18.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Aug 2026 07:18:16 -0700 (PDT)
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
Subject: [PATCH 11/32] clk: mediatek: Add auto-population of sub-devices support in simple probe
Date: Mon,  3 Aug 2026 23:16:38 +0900
Message-ID: <20260803141659.559129-12-akkun11.open@gmail.com>
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

MediaTek audio clock drivers call devm_of_platform_populate() after
mtk_clk_simple_probe(). Extend __mtk_clk_simple_probe() to run
devm_of_platform_populate() when the new 'populate_children' flag is
set, reducing boilerplate.

Note that explicit of_platform_depopulate() calls in remove functions
are unnecessary because devm_of_platform_populate() is managed by
devres and cleans up automatically.

Signed-off-by: Akari Tsuyukusa <akkun11.open@gmail.com>
---
 drivers/clk/mediatek/clk-mtk.c | 7 +++++++
 drivers/clk/mediatek/clk-mtk.h | 1 +
 2 files changed, 8 insertions(+)

diff --git a/drivers/clk/mediatek/clk-mtk.c b/drivers/clk/mediatek/clk-mtk.c
index c3369a04cdec..71d70b5a9990 100644
--- a/drivers/clk/mediatek/clk-mtk.c
+++ b/drivers/clk/mediatek/clk-mtk.c
@@ -12,6 +12,7 @@
 #include <linux/module.h>
 #include <linux/of.h>
 #include <linux/of_address.h>
+#include <linux/of_platform.h>
 #include <linux/platform_device.h>
 #include <linux/pm_runtime.h>
 #include <linux/slab.h>
@@ -609,6 +610,12 @@ static int __mtk_clk_simple_probe(struct platform_device *pdev,
 	if (mcd->need_runtime_pm)
 		pm_runtime_put(&pdev->dev);
 
+	if (mcd->populate_children) {
+		r = devm_of_platform_populate(&pdev->dev);
+		if (r)
+			goto unregister_clks;
+	}
+
 	return r;
 
 unregister_clks:
diff --git a/drivers/clk/mediatek/clk-mtk.h b/drivers/clk/mediatek/clk-mtk.h
index b6504b3e77ed..11939e3e0b38 100644
--- a/drivers/clk/mediatek/clk-mtk.h
+++ b/drivers/clk/mediatek/clk-mtk.h
@@ -265,6 +265,7 @@ struct mtk_clk_desc {
 	unsigned int mfg_clk_idx;
 
 	bool need_runtime_pm;
+	bool populate_children;
 };
 
 int mtk_clk_pdev_probe(struct platform_device *pdev);
-- 
2.55.0

