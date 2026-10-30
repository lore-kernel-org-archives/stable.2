Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=210.118.77.12
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793346820;
	b=PCIy4JnlUnTrmEMztM6p+Do1rGQNWb1UK0ce4md96xYRlm85MgW/tvYQmCpHIgvbeId6
	 omveZjtBWaRMhM15OoOEddsDr+jF4PEXMQz1LZ8RKbw7ZPvpW9MQDkdcdvbDxsqfNXt4Y
	 76dpoNZKop43pqB7fRpR14brzO8Y1d59Qax2iimWQkE3X97Tznq6/mZmEJO9MXeZoq2ut
	 caHKRnF89TMazCg1E7qOwAUi7R7SfC2HnsCQSnvSL0Hfe9FMtw58e55mqf8Dr6Jjtlg4N
	 zNxAB6FXOAijOmW9y5/pQeKCrARtoNdM0qrNncSVgHZoVrj71pbGxAnC2Qr0k9KIPpA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793346820;
	h=DMARC-Filter:Received:DKIM-Filter:DKIM-Signature:Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:MIME-Version:
	 Content-Transfer-Encoding:X-CMS-MailID:X-Msg-Generator:Content-Type:
	 X-RootMTR:X-EPHeader:X-CMS-RootMailID:References;
	bh=dNsdzMnIWIgSUYFJZxnobXEaPMHaHj9cukEbNwFe1y0=;
	b=oQy/LhF9f6o0TGIHxlN4PlxK81a2vG2snTQdzyxgpg9yXFtMXe/Jw5b1J7ThsAG1sIVD
	 x45bcsUfAmg4h3gzn+PCLKOFw8iHBkxIsibNVpgml+i1C3OKuN7n1oqNzeD45QCj9YH2s
	 CXb73aVraHVzPZfYZoDXbqZUa0FkyxESQ+Mhkj8LbDseyzXmtc/pAKM9YCBCCP/6KbCXN
	 12XNcc8q4vRdL0ksMukTfjRiWNFwYvR0QTkQXngPP0FQPJFS0tzNGZ43WSbzaBy4jj5es
	 g4TA8YtPp3/70jtpRVemYQTBMBP9sGt1vGWOGWU5wa7+SuEGuJEKPPUfX6Df1vBEsRg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=samsung.com;
	spf=pass smtp.mailfrom=samsung.com;
	dkim=pass header.d=samsung.com header.i=@samsung.com header.a=rsa-sha256 header.s=mail20170921 header.b="Je/i7fO3";
	arc=none smtp.remote-ip=210.118.77.12
Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com [210.118.77.12])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D99F606A322
	for <stable@vger.kernel.org>; Fri, 30 Oct 2026 07:53:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7D99F606A322
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=samsung.com header.i=@samsung.com header.a=rsa-sha256 header.s=mail20170921 header.b=Je/i7fO3
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
	by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20261030075335euoutp02fccf509fcd778b4ee593831ac413297c~jP21KvzxC0860508605euoutp02X
	for <stable@vger.kernel.org>; Fri, 30 Oct 2026 07:53:35 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20261030075335euoutp02fccf509fcd778b4ee593831ac413297c~jP21KvzxC0860508605euoutp02X
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1793346815;
	bh=dNsdzMnIWIgSUYFJZxnobXEaPMHaHj9cukEbNwFe1y0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Je/i7fO3zUIKVbR1Fhz6ZTn94e2nQ5HWIgfDH3MpgwiHazSJojExbiz/KTuf2CDv8
	 RtaVyOKBrIWmyeJJqsxHFeNB4XsxWG3+k/stj1olq1cNuUO0gKAGSR5beR7kzcwY3L
	 hc8ZkSM7MitCvG4vB7iITAE6ZrUHCi/5+Yz/fBuA=
Received: from eusmtip2.samsung.com (unknown [203.254.199.222]) by
	eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
	20261030075334eucas1p2e7e9891c55aec194248c72f739276daf~jP20zu7Hy0356003560eucas1p2v;
	Fri, 30 Oct 2026 07:53:34 +0000 (GMT)
Received: from AMDC4653.digital.local (unknown [106.120.51.32]) by
	eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20261030075334eusmtip225f15a1fa8974ef98b96438c49f142a8~jP20MBvnA3112331123eusmtip2c;
	Fri, 30 Oct 2026 07:53:34 +0000 (GMT)
From: Marek Szyprowski <m.szyprowski@samsung.com>
To: linux-samsung-soc@vger.kernel.org, linux-clk@vger.kernel.org
Cc: Marek Szyprowski <m.szyprowski@samsung.com>, Krzysztof Kozlowski
	<krzk@kernel.org>, Sylwester Nawrocki <s.nawrocki@samsung.com>, Chanwoo Choi
	<cw00.choi@samsung.com>, Peter Griffin <peter.griffin@linaro.org>, Alim
	Akhtar <alim.akhtar@samsung.com>, Stephen Boyd <sboyd@kernel.org>, Brian
	Masney <bmasney+clk@redhat.com>, Jerome Brunet <jbrunet+clk@baylibre.com>,
	Henrik Grimler <henrik@grimler.se>, stable@vger.kernel.org
Subject: [PATCH v3 3/3] clk: samsung: exynos5-subcmu: Defer probe until
 power domains are available
Date: Fri, 30 Oct 2026 08:53:16 +0100
Message-ID: <20261030075325.517182-4-m.szyprowski@samsung.com>
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
X-CMS-MailID: 20261030075334eucas1p2e7e9891c55aec194248c72f739276daf
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20261030075334eucas1p2e7e9891c55aec194248c72f739276daf
X-EPHeader: CA
X-CMS-RootMailID: 20261030075334eucas1p2e7e9891c55aec194248c72f739276daf
References: <20261030075325.517182-1-m.szyprowski@samsung.com>
	<CGME20261030075334eucas1p2e7e9891c55aec194248c72f739276daf@eucas1p2.samsung.com>

Sub-CMU devices are added to their power domains with
of_genpd_add_device() during exynos5_clk_probe(). Its return value is
ignored, so if the power domain provider is not registered yet, the
sub-CMU device is silently left outside of its power domain.

Since commit c09a3e6c97f0 ("soc: samsung: pm_domains: Convert to regular
platform driver"), power domain providers are registered only when their
platform devices are probed, which happens after exynos5_clk_probe() has
already been called.

When a sub-CMU device is outside of its power domain, its runtime PM
callbacks race with the power domain state changes, which might result in
losing the proper hardware state. In practice, some clock muxes are left
switched to the oscillator instead of the respective PLLs.

Fix this by deferring exynos5_clk_probe() until the platform devices for
all available power domains are instantiated. Since the probe function
calls __init code, return -ENODEV if a deferred probe runs after the init
sections have been freed.

Fixes: c09a3e6c97f0 ("soc: samsung: pm_domains: Convert to regular platform driver")
Cc: stable@vger.kernel.org
Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
---
 drivers/clk/samsung/clk-exynos5-subcmu.c | 25 +++++++++++++++++++++---
 1 file changed, 22 insertions(+), 3 deletions(-)

diff --git a/drivers/clk/samsung/clk-exynos5-subcmu.c b/drivers/clk/samsung/clk-exynos5-subcmu.c
index 1d7eb98b72cf..faa59c65a033 100644
--- a/drivers/clk/samsung/clk-exynos5-subcmu.c
+++ b/drivers/clk/samsung/clk-exynos5-subcmu.c
@@ -6,6 +6,7 @@
 
 #include <linux/io.h>
 #include <linux/of.h>
+#include <linux/of_platform.h>
 #include <linux/platform_device.h>
 #include <linux/pm_domain.h>
 #include <linux/pm_runtime.h>
@@ -153,13 +154,31 @@ static int __init exynos5_clk_register_subcmu(struct device *parent,
 	return ret;
 }
 
-static int __init exynos5_clk_probe(struct platform_device *pdev)
+static int __ref exynos5_clk_probe(struct platform_device *pdev)
 {
+	static const char pd_node_name[] = "samsung,exynos4210-pd";
 	struct device_node *np;
 	const char *name;
 	int i;
 
-	for_each_compatible_node(np, NULL, "samsung,exynos4210-pd") {
+	/* Deferred probe might run after the init sections have been freed */
+	if (system_state >= SYSTEM_RUNNING)
+		return -ENODEV;
+
+	/* Defer until all needed power domains are registered */
+	for_each_compatible_node(np, NULL, pd_node_name) {
+		if (of_device_is_available(np)) {
+			struct platform_device *pd = of_find_device_by_node(np);
+
+			if (!pd) {
+				of_node_put(np);
+				return -EPROBE_DEFER;
+			}
+			put_device(&pd->dev);
+		}
+	}
+
+	for_each_compatible_node(np, NULL, pd_node_name) {
 		if (of_property_read_string(np, "label", &name) < 0)
 			continue;
 		for (i = 0; i < nr_cmus; i++)
@@ -177,7 +196,7 @@ static const struct of_device_id exynos5_clk_of_match[] = {
 	{ },
 };
 
-static struct platform_driver exynos5_clk_driver __refdata = {
+static struct platform_driver exynos5_clk_driver = {
 	.driver	= {
 		.name = "exynos5-clock",
 		.of_match_table = exynos5_clk_of_match,
-- 
2.43.0

