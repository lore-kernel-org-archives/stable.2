Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A00454EECA
	for <stable@vger.kernel.org>; Wed,  9 Sep 2026 11:58:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788955100; cv=none; b=DUZBDfoMmEW8uvZQrAwWRRVhz6emohZTIWJSoiq+/mUvskbCIiFlmtr8T2W98HTPSkr1hWiSP3+tOuS/C0OfKPW/26908hDbV4w7d0YmjA5M/UNNcIsU+13x7Nofh4VyrNtIFJ1v8SXvRI9EbnON61DfqRCWRoUoJcobxvm2G1E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788955100; c=relaxed/simple;
	bh=HS4+ZeSn4iyH3WbpxKX5OTN1Lot8OIFSVOg/OY31RDA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AYDlJ2QxmY1CHuAHIJj55Zm+j1ScHQSn4HW+qKHPRBzUhDkIqYKG6woeVtp9sErjU8YmqxBmOIUIHcNLUqNLNwb0xmopPTEA7IYhSuSeQ+te/aQMdj7HTOPxwbRsX50592AqhAINHJJsylJmXpT+iyFk/rD5tK+rswq9diolkLU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=K8p0TLWT; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="K8p0TLWT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 934B31F00AC4;
	Wed,  9 Sep 2026 11:58:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788955099;
	bh=EKOH3D3WhniMAKL0osQnBryxfka/U0dB7QAiPMVlPjc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=K8p0TLWTxWR+cuFrYLWVTTo+w3wHAMMEMYsvceEG/pGmKqwTJTqpvufZ7Uo6Z6Spt
	 YP+BOXksywVS3ACxcBSE2dIe5wbRjJ2zD9xw4FcLHZwa9BkX9p5xH5ntHUI3wsM7Ex
	 wmARswiiuGU8svDosfqASzyXsUUX1aWvObdyRHItjoGRM/IHJt8eQ2r4zHmmD7+elU
	 ZUjOb+5P0Cu9Z7sdlXqtPMoHVIWQolzJZkqKrR4vW5+IgW+OQImBxaZpnwjCeFhOUb
	 pSEhQUWf9BseNSm8nR6pFkTKA9AhkaVpeklqkenXOh2a38LaAXR6ASZ6WuNDfW4XeY
	 R/WROGT5XLYdQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Zhang Heng <zhangheng@kylinos.cn>,
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
	Joerg Roedel <jroedel@suse.de>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y 1/2] iommu/msm: Use helper function devm_clk_get_prepared()
Date: Wed,  9 Sep 2026 07:58:15 -0400
Message-ID: <20260909115816.2182309-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026090341-makeover-snout-3650@gregkh>
References: <2026090341-makeover-snout-3650@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Zhang Heng <zhangheng@kylinos.cn>

[ Upstream commit afc0cbc6e25b37dc9ba11d415ea6858902a7f04b ]

Since commit 7ef9651e9792 ("clk: Provide new devm_clk helpers for prepared
and enabled clocks"), devm_clk_get() and clk_prepare() can now be replaced
by devm_clk_get_prepared() when driver prepares the clocks for the whole
lifetime of the device. Moreover, it is no longer necessary to unprepare
the clocks explicitly.

Signed-off-by: Zhang Heng <zhangheng@kylinos.cn>
Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Link: https://lore.kernel.org/r/20250103113059.463033-1-zhangheng@kylinos.cn
Signed-off-by: Joerg Roedel <jroedel@suse.de>

Backport to 6.12: remove the .remove_new callback entry used by this
stable tree instead of the upstream .remove entry. The callback only
unprepares clocks, which devm_clk_get_prepared() now handles. Keep
the remaining upstream changes to prepare the probe error paths for
535a200220ca ("iommu/msm: Unwind probe state on registration failure").

Stable-dep-of: 535a200220ca ("iommu/msm: Unwind probe state on registration failure")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/iommu/msm_iommu.c | 51 +++++++++------------------------------
 1 file changed, 11 insertions(+), 40 deletions(-)

diff --git a/drivers/iommu/msm_iommu.c b/drivers/iommu/msm_iommu.c
index 989e0869d8055..2769e4544038c 100644
--- a/drivers/iommu/msm_iommu.c
+++ b/drivers/iommu/msm_iommu.c
@@ -725,47 +725,32 @@ static int msm_iommu_probe(struct platform_device *pdev)
 	iommu->dev = &pdev->dev;
 	INIT_LIST_HEAD(&iommu->ctx_list);
 
-	iommu->pclk = devm_clk_get(iommu->dev, "smmu_pclk");
+	iommu->pclk = devm_clk_get_prepared(iommu->dev, "smmu_pclk");
 	if (IS_ERR(iommu->pclk))
 		return dev_err_probe(iommu->dev, PTR_ERR(iommu->pclk),
 				     "could not get smmu_pclk\n");
 
-	ret = clk_prepare(iommu->pclk);
-	if (ret)
-		return dev_err_probe(iommu->dev, ret,
-				     "could not prepare smmu_pclk\n");
-
-	iommu->clk = devm_clk_get(iommu->dev, "iommu_clk");
-	if (IS_ERR(iommu->clk)) {
-		clk_unprepare(iommu->pclk);
+	iommu->clk = devm_clk_get_prepared(iommu->dev, "iommu_clk");
+	if (IS_ERR(iommu->clk))
 		return dev_err_probe(iommu->dev, PTR_ERR(iommu->clk),
 				     "could not get iommu_clk\n");
-	}
-
-	ret = clk_prepare(iommu->clk);
-	if (ret) {
-		clk_unprepare(iommu->pclk);
-		return dev_err_probe(iommu->dev, ret, "could not prepare iommu_clk\n");
-	}
 
 	r = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	iommu->base = devm_ioremap_resource(iommu->dev, r);
 	if (IS_ERR(iommu->base)) {
 		ret = dev_err_probe(iommu->dev, PTR_ERR(iommu->base), "could not get iommu base\n");
-		goto fail;
+		return ret;
 	}
 	ioaddr = r->start;
 
 	iommu->irq = platform_get_irq(pdev, 0);
-	if (iommu->irq < 0) {
-		ret = -ENODEV;
-		goto fail;
-	}
+	if (iommu->irq < 0)
+		return -ENODEV;
 
 	ret = of_property_read_u32(iommu->dev->of_node, "qcom,ncb", &val);
 	if (ret) {
 		dev_err(iommu->dev, "could not get ncb\n");
-		goto fail;
+		return ret;
 	}
 	iommu->ncb = val;
 
@@ -780,8 +765,7 @@ static int msm_iommu_probe(struct platform_device *pdev)
 
 	if (!par) {
 		pr_err("Invalid PAR value detected\n");
-		ret = -ENODEV;
-		goto fail;
+		return -ENODEV;
 	}
 
 	ret = devm_request_threaded_irq(iommu->dev, iommu->irq, NULL,
@@ -791,7 +775,7 @@ static int msm_iommu_probe(struct platform_device *pdev)
 					iommu);
 	if (ret) {
 		pr_err("Request IRQ %d failed with ret=%d\n", iommu->irq, ret);
-		goto fail;
+		return ret;
 	}
 
 	list_add(&iommu->dev_node, &qcom_iommu_devices);
@@ -800,23 +784,19 @@ static int msm_iommu_probe(struct platform_device *pdev)
 				     "msm-smmu.%pa", &ioaddr);
 	if (ret) {
 		pr_err("Could not add msm-smmu at %pa to sysfs\n", &ioaddr);
-		goto fail;
+		return ret;
 	}
 
 	ret = iommu_device_register(&iommu->iommu, &msm_iommu_ops, &pdev->dev);
 	if (ret) {
 		pr_err("Could not register msm-smmu at %pa\n", &ioaddr);
-		goto fail;
+		return ret;
 	}
 
 	pr_info("device mapped at %p, irq %d with %d ctx banks\n",
 		iommu->base, iommu->irq, iommu->ncb);
 
 	return ret;
-fail:
-	clk_unprepare(iommu->clk);
-	clk_unprepare(iommu->pclk);
-	return ret;
 }
 
 static const struct of_device_id msm_iommu_dt_match[] = {
@@ -824,20 +804,11 @@ static const struct of_device_id msm_iommu_dt_match[] = {
 	{}
 };
 
-static void msm_iommu_remove(struct platform_device *pdev)
-{
-	struct msm_iommu_dev *iommu = platform_get_drvdata(pdev);
-
-	clk_unprepare(iommu->clk);
-	clk_unprepare(iommu->pclk);
-}
-
 static struct platform_driver msm_iommu_driver = {
 	.driver = {
 		.name	= "msm_iommu",
 		.of_match_table = msm_iommu_dt_match,
 	},
 	.probe		= msm_iommu_probe,
-	.remove_new	= msm_iommu_remove,
 };
 builtin_platform_driver(msm_iommu_driver);
-- 
2.53.0

