Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=210.118.77.12
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793346817;
	b=jPhoTbuo19IW4dEnHui8Rpy7mQ0ultUIOrLfWGrtWgyACgZBF5aOnFq49sjDZpN8sXCW
	 wSVqIczO3/fxkXQ1z2xdf5x8QaL/785j+VH2kAXbnPBYRUr/X6rPTzwAHgPcW0VbXVdsS
	 YOfFiE/nGTJWJ5RkVfw4PwY5irL7u+wgtE8+yOFJoyGsTuYyUqeJf75+qrYQgOP5adFg1
	 moSRviVp7QpMqIstreivHesk8pjhKTgZgW5n+xH6O3fl7U+DjWSBu8XXFb/Ei/m/TrIqP
	 Q3B0jLICcSlGxCyxYUtH2kbfrbxFiGpW7HA2ZGqSi3xxRkZdCiMyXBLTc239fkkTyXQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793346817;
	h=DMARC-Filter:Received:DKIM-Filter:DKIM-Signature:Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:MIME-Version:
	 Content-Transfer-Encoding:X-CMS-MailID:X-Msg-Generator:Content-Type:
	 X-RootMTR:X-EPHeader:X-CMS-RootMailID:References;
	bh=0z8I7+VZAbfeTmBO2ZoCkH8Xj6XUxaC9cA+avhAcoWY=;
	b=BQbCWoZEJAGXqYaksKQhK6mgsch3DuiBvt2+IW61tXSosMRmMZO5Z37CdmXpzwHwzYWi
	 zD3Y3ozYOPIseOlxyOebgiD9Hw4XaHD//Cqi6Q7O4qZCsXhFRa25N9r/XetU6AU+Drwd+
	 rZ7hLA/zxJmAL8rj6XTgqhh8VJ5dr8ydcdJQdX7ICC0CNPC32W/JjElxeYZKg9yPYxrm1
	 QfdmgBUvN0DYfqSLTzRYszkbTzX7UIDQ4ifOdF05gCvAkSRVpbNwWjQdY8PwpfmnzkTly
	 9F6KM4Ge+qxkfDMyhVuqmSeHVmePva7pAsEDxKv3eC8Tk87j/RZDbgAEIos3xVtpo9w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=samsung.com;
	spf=pass smtp.mailfrom=samsung.com;
	dkim=pass header.d=samsung.com header.i=@samsung.com header.a=rsa-sha256 header.s=mail20170921 header.b=sDTVPC0R;
	arc=none smtp.remote-ip=210.118.77.12
Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com [210.118.77.12])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C01A7606A321
	for <stable@vger.kernel.org>; Fri, 30 Oct 2026 07:53:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C01A7606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=samsung.com header.i=@samsung.com header.a=rsa-sha256 header.s=mail20170921 header.b=sDTVPC0R
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
	by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20261030075334euoutp02d458977d09668cd8de9c68a167ca83a9~jP20XgB8R0904409044euoutp02J
	for <stable@vger.kernel.org>; Fri, 30 Oct 2026 07:53:34 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20261030075334euoutp02d458977d09668cd8de9c68a167ca83a9~jP20XgB8R0904409044euoutp02J
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1793346814;
	bh=0z8I7+VZAbfeTmBO2ZoCkH8Xj6XUxaC9cA+avhAcoWY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=sDTVPC0RwMbkcj6UpduZQr+0F9N2vx6Do+DSc5m4+cvtxP4PapbtVpVDRgJKIHWfr
	 biGymmlJRooiJEoi/MRxpDSh/tX0ylW1vGAvDKLmgDJbESE08+Dyfr0hfpBUUaQBNL
	 njjnbyr9oCwAfzYTv6Kx5Wlrip0ewodDMsl5ZHIg=
Received: from eusmtip2.samsung.com (unknown [203.254.199.222]) by
	eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
	20261030075334eucas1p14657a963949b4a32165d667f387a9389~jP20GmseG0285002850eucas1p1S;
	Fri, 30 Oct 2026 07:53:34 +0000 (GMT)
Received: from AMDC4653.digital.local (unknown [106.120.51.32]) by
	eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20261030075333eusmtip2051c75c7cdf265268d7f2176c28496c3~jP2zfZX5N3101431014eusmtip25;
	Fri, 30 Oct 2026 07:53:33 +0000 (GMT)
From: Marek Szyprowski <m.szyprowski@samsung.com>
To: linux-samsung-soc@vger.kernel.org, linux-clk@vger.kernel.org
Cc: Marek Szyprowski <m.szyprowski@samsung.com>, Krzysztof Kozlowski
	<krzk@kernel.org>, Sylwester Nawrocki <s.nawrocki@samsung.com>, Chanwoo Choi
	<cw00.choi@samsung.com>, Peter Griffin <peter.griffin@linaro.org>, Alim
	Akhtar <alim.akhtar@samsung.com>, Stephen Boyd <sboyd@kernel.org>, Brian
	Masney <bmasney+clk@redhat.com>, Jerome Brunet <jbrunet+clk@baylibre.com>,
	Henrik Grimler <henrik@grimler.se>, stable@vger.kernel.org
Subject: [PATCH v3 2/3] clk: samsung: exynos5-subcmu: Use
 pm_runtime_get_sync() during probe
Date: Fri, 30 Oct 2026 08:53:15 +0100
Message-ID: <20261030075325.517182-3-m.szyprowski@samsung.com>
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
X-CMS-MailID: 20261030075334eucas1p14657a963949b4a32165d667f387a9389
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20261030075334eucas1p14657a963949b4a32165d667f387a9389
X-EPHeader: CA
X-CMS-RootMailID: 20261030075334eucas1p14657a963949b4a32165d667f387a9389
References: <20261030075325.517182-1-m.szyprowski@samsung.com>
	<CGME20261030075334eucas1p14657a963949b4a32165d667f387a9389@eucas1p1.samsung.com>

The clocks are registered right after pm_runtime_get(), which only
schedules a resume asynchronously and doesn't guarantee the device (and
its power domain) is active yet. Use pm_runtime_get_sync() to ensure the
power domain is really on while the clock registers are accessed during
the registration.

Fixes: b06a532bf1fa ("clk: samsung: Add Exynos5 sub-CMU clock driver")
Cc: stable@vger.kernel.org
Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
---
 drivers/clk/samsung/clk-exynos5-subcmu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clk/samsung/clk-exynos5-subcmu.c b/drivers/clk/samsung/clk-exynos5-subcmu.c
index 373129847301..1d7eb98b72cf 100644
--- a/drivers/clk/samsung/clk-exynos5-subcmu.c
+++ b/drivers/clk/samsung/clk-exynos5-subcmu.c
@@ -103,7 +103,7 @@ static int __init exynos5_subcmu_probe(struct platform_device *pdev)
 
 	pm_runtime_set_suspended(dev);
 	pm_runtime_enable(dev);
-	pm_runtime_get(dev);
+	pm_runtime_get_sync(dev);
 
 	ctx->dev = dev;
 	samsung_clk_register_div(ctx, info->div_clks, info->nr_div_clks);
-- 
2.43.0

