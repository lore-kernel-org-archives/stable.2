Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=210.118.77.11
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793346817;
	b=o+jA53Nj4YU7m0FQ9Za33oNmCrl0JkgNZAyIG3IeNaugqr3RWwL9j29L7WnvK2PJ49VG
	 utN2r5QiN+71uJuBCGOnLjCWuFtSH6dnbIk9LXXKBmwnkX1iBdKCCjC60IGQ9+DgabF6B
	 O1ih09bYYf4dM3XeGKqII0BQAuZl7zew2JuGH57fUPDA5l3YJgri5PIKeZURC3qVIb4kp
	 nCQPVG4jcgSQ9yh5pkP5erhZV0bC6JH8zfhgeBtZqt6917/7rKFhcvOvLV2023JGkp7pt
	 FWUU7ZyGu0uskqKP34b2KaNn4UIaHa+EFCb9hTX2s1ZkPLaxMmjlP42xMCTfFujSD2Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793346817;
	h=DMARC-Filter:Received:DKIM-Filter:DKIM-Signature:Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:MIME-Version:
	 Content-Transfer-Encoding:X-CMS-MailID:X-Msg-Generator:Content-Type:
	 X-RootMTR:X-EPHeader:X-CMS-RootMailID:References;
	bh=LXqnjPVoIvX80Y2AzOOGeUQEC4Xg6CbGHN9TjzLorQc=;
	b=3CkYGXJb+cgtDICO9cEoD3hn6VPpdeOJmjXmpqPxOfp1DJ6mb2w4CaavHvX3cnqJE8/D
	 XolMCPHEg1McLkdCWNNm9tkzr0fSZUm5RmuQSAUTKP4/pNis3cjSey+rNaBmc4zASYOx+
	 sTiW+gHzR8k4AQ3BVjAwk6lcsyfleC2L3mGNqFxUDkFKq5vCm/Wsbel5sY0K+P/Oa9aNy
	 hb0q8txJDn0heTmmJwOZvPYPW45xSFu2Mr3fIzrlPYx1v+t+iSAxLadmVs38mXZCAoUyd
	 jO193F6Cqe+emcCZEjuyntWPmhQXjAtWehwXwBdaCMj6uJoA8rzH3l4bcikTEc9+fMQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=samsung.com;
	spf=pass smtp.mailfrom=samsung.com;
	dkim=pass header.d=samsung.com header.i=@samsung.com header.a=rsa-sha256 header.s=mail20170921 header.b=VkG8BhgB;
	arc=none smtp.remote-ip=210.118.77.11
Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com [210.118.77.11])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44159606A31F
	for <stable@vger.kernel.org>; Fri, 30 Oct 2026 07:53:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 44159606A31F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=samsung.com header.i=@samsung.com header.a=rsa-sha256 header.s=mail20170921 header.b=VkG8BhgB
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
	by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20261030075333euoutp019a2c8ffb573d4172578d9ee67bddc310~jP2zwY3jP0215602156euoutp01o
	for <stable@vger.kernel.org>; Fri, 30 Oct 2026 07:53:33 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20261030075333euoutp019a2c8ffb573d4172578d9ee67bddc310~jP2zwY3jP0215602156euoutp01o
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1793346813;
	bh=LXqnjPVoIvX80Y2AzOOGeUQEC4Xg6CbGHN9TjzLorQc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=VkG8BhgBE3ry6YvdmaSaHgOGtlV9oik14Tb7T2ZIzfaeOtw081vGlqRqAVFB3MdrD
	 z9b2r4NUuJilhzHO0vbeNOxD572eKJXKHefEVYrZYpMzl2KA+KKSdjGT+0dJPMyFrB
	 0g1ou0Pt1nHS/0p3ZDDHO/qdb8OxH/vVS+KXnjf0=
Received: from eusmtip2.samsung.com (unknown [203.254.199.222]) by
	eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
	20261030075333eucas1p21e27f19273b7e71c53d6ef620e52bf55~jP2zaCV4A0356003560eucas1p2u;
	Fri, 30 Oct 2026 07:53:33 +0000 (GMT)
Received: from AMDC4653.digital.local (unknown [106.120.51.32]) by
	eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20261030075332eusmtip2cb3cfd6011c45526ccce1e7e135f69ad~jP2yyvwt42924129241eusmtip2c;
	Fri, 30 Oct 2026 07:53:32 +0000 (GMT)
From: Marek Szyprowski <m.szyprowski@samsung.com>
To: linux-samsung-soc@vger.kernel.org, linux-clk@vger.kernel.org
Cc: Marek Szyprowski <m.szyprowski@samsung.com>, Krzysztof Kozlowski
	<krzk@kernel.org>, Sylwester Nawrocki <s.nawrocki@samsung.com>, Chanwoo Choi
	<cw00.choi@samsung.com>, Peter Griffin <peter.griffin@linaro.org>, Alim
	Akhtar <alim.akhtar@samsung.com>, Stephen Boyd <sboyd@kernel.org>, Brian
	Masney <bmasney+clk@redhat.com>, Jerome Brunet <jbrunet+clk@baylibre.com>,
	Henrik Grimler <henrik@grimler.se>, stable@vger.kernel.org
Subject: [PATCH v3 1/3] clk: samsung: exynos-audss: Propagate -EPROBE_DEFER
 from input clocks
Date: Fri, 30 Oct 2026 08:53:14 +0100
Message-ID: <20261030075325.517182-2-m.szyprowski@samsung.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261030075325.517182-1-m.szyprowski@samsung.com>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CMS-MailID: 20261030075333eucas1p21e27f19273b7e71c53d6ef620e52bf55
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20261030075333eucas1p21e27f19273b7e71c53d6ef620e52bf55
X-EPHeader: CA
X-CMS-RootMailID: 20261030075333eucas1p21e27f19273b7e71c53d6ef620e52bf55
References: <20261030075325.517182-1-m.szyprowski@samsung.com>
	<CGME20261030075333eucas1p21e27f19273b7e71c53d6ef620e52bf55@eucas1p2.samsung.com>

exynos_audss_clk_probe() fetches the optional pll_ref/pll_in/cdclk/
sclk_audio/sclk_pcm_in input clocks with devm_clk_get() and only
checks IS_ERR() before falling back to a default parent clock name.
This means a transient -EPROBE_DEFER (e.g. because the clock provider
behind "pll_in" has not registered its real clock yet) is silently
treated the same as the clock simply not being present, so the
mout_audss/mout_i2s muxes get permanently registered with the wrong
parent name.

Fix this by checking for -EPROBE_DEFER on each of these clocks right
after fetching them, before anything is registered, and bailing out
of probe so it gets retried once the real clocks are available.

Fixes: 547f33509ccc ("clk: exynos-audss: allow input clocks to be specified in device tree")
Cc: stable@vger.kernel.org
Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
---
 drivers/clk/samsung/clk-exynos-audss.c | 33 +++++++++++++++++++-------
 1 file changed, 24 insertions(+), 9 deletions(-)

diff --git a/drivers/clk/samsung/clk-exynos-audss.c b/drivers/clk/samsung/clk-exynos-audss.c
index e11ac67819ef..950c67491dad 100644
--- a/drivers/clk/samsung/clk-exynos-audss.c
+++ b/drivers/clk/samsung/clk-exynos-audss.c
@@ -152,7 +152,25 @@ static int exynos_audss_clk_probe(struct platform_device *pdev)
 	clk_table = clk_data->hws;
 
 	pll_ref = devm_clk_get(dev, "pll_ref");
+	if (PTR_ERR(pll_ref) == -EPROBE_DEFER)
+		return -EPROBE_DEFER;
+
 	pll_in = devm_clk_get(dev, "pll_in");
+	if (PTR_ERR(pll_in) == -EPROBE_DEFER)
+		return -EPROBE_DEFER;
+
+	cdclk = devm_clk_get(dev, "cdclk");
+	if (PTR_ERR(cdclk) == -EPROBE_DEFER)
+		return -EPROBE_DEFER;
+
+	sclk_audio = devm_clk_get(dev, "sclk_audio");
+	if (PTR_ERR(sclk_audio) == -EPROBE_DEFER)
+		return -EPROBE_DEFER;
+
+	sclk_pcm_in = devm_clk_get(dev, "sclk_pcm_in");
+	if (PTR_ERR(sclk_pcm_in) == -EPROBE_DEFER)
+		return -EPROBE_DEFER;
+
 	if (!IS_ERR(pll_ref))
 		mout_audss_p[0] = __clk_get_name(pll_ref);
 	if (!IS_ERR(pll_in)) {
@@ -169,6 +187,12 @@ static int exynos_audss_clk_probe(struct platform_device *pdev)
 			}
 		}
 	}
+	if (!IS_ERR(cdclk))
+		mout_i2s_p[1] = __clk_get_name(cdclk);
+	if (!IS_ERR(sclk_audio))
+		mout_i2s_p[2] = __clk_get_name(sclk_audio);
+	if (!IS_ERR(sclk_pcm_in))
+		sclk_pcm_p = __clk_get_name(sclk_pcm_in);
 
 	/*
 	 * Enable runtime PM here to allow the clock core using runtime PM
@@ -185,12 +209,6 @@ static int exynos_audss_clk_probe(struct platform_device *pdev)
 				CLK_SET_RATE_NO_REPARENT | CLK_SET_RATE_PARENT,
 				reg_base + ASS_CLK_SRC, 0, 1, 0, &lock);
 
-	cdclk = devm_clk_get(dev, "cdclk");
-	sclk_audio = devm_clk_get(dev, "sclk_audio");
-	if (!IS_ERR(cdclk))
-		mout_i2s_p[1] = __clk_get_name(cdclk);
-	if (!IS_ERR(sclk_audio))
-		mout_i2s_p[2] = __clk_get_name(sclk_audio);
 	clk_table[EXYNOS_MOUT_I2S] = clk_hw_register_mux(dev, "mout_i2s",
 				mout_i2s_p, ARRAY_SIZE(mout_i2s_p),
 				CLK_SET_RATE_NO_REPARENT,
@@ -224,9 +242,6 @@ static int exynos_audss_clk_probe(struct platform_device *pdev)
 				 "sclk_pcm", CLK_SET_RATE_PARENT,
 				reg_base + ASS_CLK_GATE, 4, 0, &lock);
 
-	sclk_pcm_in = devm_clk_get(dev, "sclk_pcm_in");
-	if (!IS_ERR(sclk_pcm_in))
-		sclk_pcm_p = __clk_get_name(sclk_pcm_in);
 	clk_table[EXYNOS_SCLK_PCM] = clk_hw_register_gate(dev, "sclk_pcm",
 				sclk_pcm_p, CLK_SET_RATE_PARENT,
 				reg_base + ASS_CLK_GATE, 5, 0, &lock);
-- 
2.43.0

