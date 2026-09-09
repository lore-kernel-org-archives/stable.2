Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBB09566C78
	for <stable@vger.kernel.org>; Wed,  9 Sep 2026 14:53:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788965620; cv=none; b=jlpqVm/sAP1Qi5v7bHTQkqAQ+ZCbuTzLQ9hw6ZEOn1C8pVtLYAMEfEz+VkxKq1aDBMVYy/EhcpjU5Ng5TBrtP6qjJSK0CqCpRyT5noexeOA8TnpibiYJEF91HHDyLhLGSWF/5semulE18NHe1Vkbvom6Vs9+lxS+Cpw+VAZu8V0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788965620; c=relaxed/simple;
	bh=Lr3GrectKLMplNIN8BuMhK1J4pPZ0sDHuQKwjZ5Pt1c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Do7PHN4YGfcA0vX3O+Rrv4LTOfc03XiqHr3ICb0uXWtpmGJdqtixgnWZQL8iIs1kIFAEOSpOHxI5bwnNc2/urgRbOPUvbVsIRVHQzkIpwFMcp9qA+H0YG5+7MExQzr3Fprnq2Z3r0Y/wvpawEHJB3xSrgVxv5LwAbss235hR6UU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=a8bTxQGw; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="a8bTxQGw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F01A01F00A3A;
	Wed,  9 Sep 2026 14:53:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788965618;
	bh=K+mjlC2yAuBA6h2bQ0TARtyO7BC2xyRS09wU95nP4As=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=a8bTxQGwWos6lbnEqcg1ghv0GjIitoxyQC200U93qkypXRdI8kSAeqtWFFgxpVKwR
	 1Y5cP3pjaa2gLcdSFzU2fD3/HwFJ4CvtdHkpw3jlpsNFQEgpP0DDsUfldqzRDq+NCH
	 FN88JmTiKcF/BxmwI0cfR9ZIEEZQir28lM7j68lackDsCjYh6jkAgBhY/ADO9zlOGA
	 jqVlJlQGeWuOcUX/Vp0KCThpxuxJE255baozq2YZ/46bt/xT5pnAzYWXkUi0uvI0nv
	 07+z9S3pIvgYE+bU+f6frNW1UQ206qLYaOnv3YO0KRcPUF6tFU1J5vnhi92Xq4kEWD
	 czx6w1ksZ6Xig==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Zhang Heng <zhangheng@kylinos.cn>,
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
	Joerg Roedel <jroedel@suse.de>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y 1/2] iommu/msm: Use helper function devm_clk_get_prepared()
Date: Wed,  9 Sep 2026 10:53:35 -0400
Message-ID: <20260909145336.2697541-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026090343-premises-stoning-828d@gregkh>
References: <2026090343-premises-stoning-828d@gregkh>
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

[5.15 dependency adaptation]
Retain this branch's dev_err() diagnostics, bus_set_iommu() call and
subsys_initcall() registration. Convert both clocks to the already
available devm_clk_get_prepared() helper, return directly from probe
failures, and remove the obsolete int-returning remove callback and
manual clk_unprepare() calls. No new functions are introduced.

This preserves the managed clock cleanup required by the registration
failure unwind in 535a200220ca2c83bc8bf54bd2cbe045d6ee70c4. That target
applies cleanly with a three-way merge while retaining the stable bus
registration.

Stable-dep-of: 535a200220ca ("iommu/msm: Unwind probe state on registration failure")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/iommu/msm_iommu.c | 52 ++++++++-------------------------------
 1 file changed, 10 insertions(+), 42 deletions(-)

diff --git a/drivers/iommu/msm_iommu.c b/drivers/iommu/msm_iommu.c
index c9eaf27cbb743..87663e7302da4 100644
--- a/drivers/iommu/msm_iommu.c
+++ b/drivers/iommu/msm_iommu.c
@@ -712,51 +712,34 @@ static int msm_iommu_probe(struct platform_device *pdev)
 	iommu->dev = &pdev->dev;
 	INIT_LIST_HEAD(&iommu->ctx_list);
 
-	iommu->pclk = devm_clk_get(iommu->dev, "smmu_pclk");
+	iommu->pclk = devm_clk_get_prepared(iommu->dev, "smmu_pclk");
 	if (IS_ERR(iommu->pclk)) {
 		dev_err(iommu->dev, "could not get smmu_pclk\n");
 		return PTR_ERR(iommu->pclk);
 	}
 
-	ret = clk_prepare(iommu->pclk);
-	if (ret) {
-		dev_err(iommu->dev, "could not prepare smmu_pclk\n");
-		return ret;
-	}
-
-	iommu->clk = devm_clk_get(iommu->dev, "iommu_clk");
+	iommu->clk = devm_clk_get_prepared(iommu->dev, "iommu_clk");
 	if (IS_ERR(iommu->clk)) {
 		dev_err(iommu->dev, "could not get iommu_clk\n");
-		clk_unprepare(iommu->pclk);
 		return PTR_ERR(iommu->clk);
 	}
 
-	ret = clk_prepare(iommu->clk);
-	if (ret) {
-		dev_err(iommu->dev, "could not prepare iommu_clk\n");
-		clk_unprepare(iommu->pclk);
-		return ret;
-	}
-
 	r = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	iommu->base = devm_ioremap_resource(iommu->dev, r);
 	if (IS_ERR(iommu->base)) {
 		dev_err(iommu->dev, "could not get iommu base\n");
-		ret = PTR_ERR(iommu->base);
-		goto fail;
+		return PTR_ERR(iommu->base);
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
 
@@ -771,8 +754,7 @@ static int msm_iommu_probe(struct platform_device *pdev)
 
 	if (!par) {
 		pr_err("Invalid PAR value detected\n");
-		ret = -ENODEV;
-		goto fail;
+		return -ENODEV;
 	}
 
 	ret = devm_request_threaded_irq(iommu->dev, iommu->irq, NULL,
@@ -782,7 +764,7 @@ static int msm_iommu_probe(struct platform_device *pdev)
 					iommu);
 	if (ret) {
 		pr_err("Request IRQ %d failed with ret=%d\n", iommu->irq, ret);
-		goto fail;
+		return ret;
 	}
 
 	list_add(&iommu->dev_node, &qcom_iommu_devices);
@@ -791,13 +773,13 @@ static int msm_iommu_probe(struct platform_device *pdev)
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
 
 	bus_set_iommu(&platform_bus_type, &msm_iommu_ops);
@@ -806,10 +788,6 @@ static int msm_iommu_probe(struct platform_device *pdev)
 		iommu->base, iommu->irq, iommu->ncb);
 
 	return ret;
-fail:
-	clk_unprepare(iommu->clk);
-	clk_unprepare(iommu->pclk);
-	return ret;
 }
 
 static const struct of_device_id msm_iommu_dt_match[] = {
@@ -817,22 +795,12 @@ static const struct of_device_id msm_iommu_dt_match[] = {
 	{}
 };
 
-static int msm_iommu_remove(struct platform_device *pdev)
-{
-	struct msm_iommu_dev *iommu = platform_get_drvdata(pdev);
-
-	clk_unprepare(iommu->clk);
-	clk_unprepare(iommu->pclk);
-	return 0;
-}
-
 static struct platform_driver msm_iommu_driver = {
 	.driver = {
 		.name	= "msm_iommu",
 		.of_match_table = msm_iommu_dt_match,
 	},
 	.probe		= msm_iommu_probe,
-	.remove		= msm_iommu_remove,
 };
 
 static int __init msm_iommu_driver_init(void)
-- 
2.53.0

