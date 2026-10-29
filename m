Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=210.118.77.12
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793278297;
	b=EsBX/JyCmmGv3j98sH4mr7CGPlnl+I4kwz3U5Sp5lbyYWhmIri+M1m6FkA2QPw7NVHFJ
	 QIQOvOgIUaDDhDDYBFBeOUWc7PPavN56NoE7p1EI/r49bvMvELTIHDUPD77ifNQIHstU/
	 nOA9rRDTzxtP+xvk+3Gb2c8lEjFPpAut3aaf38oPjIKQ9owMffnPawo8XyjKzOgoim1ps
	 cNnTIiXZkNo80fGjRdNzsHPBaQdmEyiJoj1wjAXszd31dwqnD9iZU7WfUoph2v7tEtamE
	 L6iDa/HAwhFpVYk6K0TSCzQXgUueKNDR52n2ZskL38YbnbHGStsJFFnDa9mCkwsroxQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793278297;
	h=DMARC-Filter:Received:DKIM-Filter:DKIM-Signature:Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:MIME-Version:
	 Content-Transfer-Encoding:X-CMS-MailID:X-Msg-Generator:Content-Type:
	 X-RootMTR:X-EPHeader:X-CMS-RootMailID:References;
	bh=LXqnjPVoIvX80Y2AzOOGeUQEC4Xg6CbGHN9TjzLorQc=;
	b=Fbx7iiS0Eo4uRXUWtRHBYorlDJca9v5CVQN0A4RHScY/yTh1Hqlpal13XS3DqMCjLltJ
	 xw1R3nGUSmxaLOYbiUzFgbuCUwZPAouotNUY4wxbZo1R/Adsr6QEIJhnEIFzUTvjOmHO0
	 xP3d3a0tpt/g9nnHUiquxmBSMLxoqomb6Z/pfb+rrzbjroPHuXXFCtB3MLGHVhmOWfqHm
	 D8lfXoWm8uIgZW13k1iQj1hVra4c96vwC2fu6eYOQvYMVvgO0pzsK1yJczpNGFufPDlq/
	 /xF7PjNyrm4rH81inejlf8Ic9XE/YhmAVkC4rgUWjHLTGQuIB9m75dWIDhj/1QSPpDA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=samsung.com;
	spf=pass smtp.mailfrom=samsung.com;
	dkim=pass header.d=samsung.com header.i=@samsung.com header.a=rsa-sha256 header.s=mail20170921 header.b=vaxsIe0+;
	arc=none smtp.remote-ip=210.118.77.12
Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com [210.118.77.12])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26393606A325
	for <stable@vger.kernel.org>; Thu, 29 Oct 2026 12:51:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 26393606A325
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=samsung.com header.i=@samsung.com header.a=rsa-sha256 header.s=mail20170921 header.b=vaxsIe0+
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
	by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20261029125129euoutp020ab47cddd01b6cdbde42a4c717c5a66b~jARpIAQ6S2992829928euoutp02G
	for <stable@vger.kernel.org>; Thu, 29 Oct 2026 12:51:29 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20261029125129euoutp020ab47cddd01b6cdbde42a4c717c5a66b~jARpIAQ6S2992829928euoutp02G
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1793278289;
	bh=LXqnjPVoIvX80Y2AzOOGeUQEC4Xg6CbGHN9TjzLorQc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=vaxsIe0+YIFOOy3cfZDngHhRowEamY2LT717GcbxV5i93xGKqSHsyXQsGXrLpl7FI
	 BGpfnNniVVQ07V5jIp2L3bFOCwNsmjxiJnUJREW6g9WVOxxI2vJmhrTCbuBQUwwcn+
	 yMkNTBWAcXKGwO9uUcuq0CoJRclRDZI8JfEFPRqg=
Received: from eusmtip1.samsung.com (unknown [203.254.199.221]) by
	eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
	20261029125128eucas1p1b444765ed47e86e79db4dc516ca42da8~jARotU5vx0763107631eucas1p15;
	Thu, 29 Oct 2026 12:51:28 +0000 (GMT)
Received: from AMDC4653.digital.local (unknown [106.120.51.32]) by
	eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20261029125127eusmtip1f12fed402b94d21ae852444ab691c4a8~jARoHDm3r2292422924eusmtip1W;
	Thu, 29 Oct 2026 12:51:27 +0000 (GMT)
From: Marek Szyprowski <m.szyprowski@samsung.com>
To: linux-samsung-soc@vger.kernel.org, linux-clk@vger.kernel.org
Cc: Marek Szyprowski <m.szyprowski@samsung.com>, Krzysztof Kozlowski
	<krzk@kernel.org>, Sylwester Nawrocki <s.nawrocki@samsung.com>, Chanwoo Choi
	<cw00.choi@samsung.com>, Peter Griffin <peter.griffin@linaro.org>, Alim
	Akhtar <alim.akhtar@samsung.com>, Stephen Boyd <sboyd@kernel.org>, Brian
	Masney <bmasney+clk@redhat.com>, Jerome Brunet <jbrunet+clk@baylibre.com>,
	Henrik Grimler <henrik@grimler.se>, stable@vger.kernel.org
Subject: [PATCH v2 1/3] clk: samsung: exynos-audss: Propagate -EPROBE_DEFER
 from input clocks
Date: Thu, 29 Oct 2026 13:51:14 +0100
Message-ID: <20261029125118.3191455-2-m.szyprowski@samsung.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261029125118.3191455-1-m.szyprowski@samsung.com>
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
X-CMS-MailID: 20261029125128eucas1p1b444765ed47e86e79db4dc516ca42da8
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20261029125128eucas1p1b444765ed47e86e79db4dc516ca42da8
X-EPHeader: CA
X-CMS-RootMailID: 20261029125128eucas1p1b444765ed47e86e79db4dc516ca42da8
References: <20261029125118.3191455-1-m.szyprowski@samsung.com>
	<CGME20261029125128eucas1p1b444765ed47e86e79db4dc516ca42da8@eucas1p1.samsung.com>

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

