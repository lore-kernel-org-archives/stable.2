Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2FBF582BBA
	for <stable@vger.kernel.org>; Wed,  9 Sep 2026 14:58:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788965910; cv=none; b=pSwA9n2nAQ9QBLF6EZCfRJjjqIhivDM9iO+InawJ6YWiUqVyDmF6g1Rx4gYoGoPuLcRSYGWH/I1NlhPkjEDB4ohPYaw2otZnjlOaFUnbCJIWopHqf1Q5gRdECx66ZYi1jWBpLQ6uWBP3S8+UbDy8NcpS0VWF2V+0xITkhy+OHFs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788965910; c=relaxed/simple;
	bh=3/zJy5Of400ngSCVj63yH4HZNjNIVMN9I38F4lEu58g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oP8cmNucqCtnzi7pOi/arALyGfQ9r3eOt6pxWauIHs/+MesqRbHM3NVjmqO1RzHzOmbPYQHtCNM4zxKBUS6Bv34oS9X3H/dbf7VPsLzvKz9C0o2TCtkc6xecsdFKHUHX/5m0+IbdCmjNDGdjOtzpm+ffVFed8GHR8tkUdziXbuo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UZLGorRE; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UZLGorRE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 366751F00A3F;
	Wed,  9 Sep 2026 14:58:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788965908;
	bh=wTGJVbKHs6f7wcpdV679Jrd8EwuL7N2EUQpk2gQaQAE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=UZLGorREV7ALTbamC70HPzxBgMzolvK6Opff0qSoCy/2DPtihWck5lZIq5S4/SOQe
	 HQJ9tw5qAXL5+Zlp5PXCa6unY0O3eS/V7XS7j9q7kRhHUkrzCHcBtmYfa3/RYeN7CR
	 ENaRPlnwSnwn8+CpFOVm4MOwh7lZXY6Q+x9aEexl5mNe2s7X4VC0qwAaowsgZlIfbN
	 Cw/UZhBtHjBbN9dSBWxNtjMNQ77ZZeTsS7JNF4KpZCgdV0wAkTWoeFpYcGz9Ki9u4v
	 Jo0WubFXMLkJZjamGEEU7c32Sf2zSRguLpUPhOalIshlTHf3ocNmIZsjtIO4H3f8i8
	 QUsoSbUJs90aA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Zhang Heng <zhangheng@kylinos.cn>,
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
	Joerg Roedel <jroedel@suse.de>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y 1/2] iommu/msm: Use helper function devm_clk_get_prepared()
Date: Wed,  9 Sep 2026 10:58:25 -0400
Message-ID: <20260909145826.2742978-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026090343-awkward-washcloth-0722@gregkh>
References: <2026090343-awkward-washcloth-0722@gregkh>
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
index 149f2e53b39d4..5c83cebbf49a7 100644
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
@@ -791,7 +773,7 @@ static int msm_iommu_probe(struct platform_device *pdev)
 				     "msm-smmu.%pa", &ioaddr);
 	if (ret) {
 		pr_err("Could not add msm-smmu at %pa to sysfs\n", &ioaddr);
-		goto fail;
+		return ret;
 	}
 
 	iommu_device_set_ops(&iommu->iommu, &msm_iommu_ops);
@@ -800,7 +782,7 @@ static int msm_iommu_probe(struct platform_device *pdev)
 	ret = iommu_device_register(&iommu->iommu);
 	if (ret) {
 		pr_err("Could not register msm-smmu at %pa\n", &ioaddr);
-		goto fail;
+		return ret;
 	}
 
 	bus_set_iommu(&platform_bus_type, &msm_iommu_ops);
@@ -809,10 +791,6 @@ static int msm_iommu_probe(struct platform_device *pdev)
 		iommu->base, iommu->irq, iommu->ncb);
 
 	return ret;
-fail:
-	clk_unprepare(iommu->clk);
-	clk_unprepare(iommu->pclk);
-	return ret;
 }
 
 static const struct of_device_id msm_iommu_dt_match[] = {
@@ -820,22 +798,12 @@ static const struct of_device_id msm_iommu_dt_match[] = {
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

