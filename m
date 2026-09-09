Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6871E568FB6
	for <stable@vger.kernel.org>; Wed,  9 Sep 2026 14:35:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788964539; cv=none; b=gZK4AXhuRHSqDan1k1uysChNtfbgD0tuuAL/enwV5b2f9buS93zWnTbTd/N23E5pHdpdgDfVyPnhOVdv9Toj9axddAZkaDZcuVNrYzD+5+xSjGRnSEVkfDxuUbHLlqPFhC3JMjZrTzvbBPtyIneYbYeW7q56Saogg2jPdceQ/B4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788964539; c=relaxed/simple;
	bh=suGlSXrI0xjiwaB+TFxM0LNXOkwfoc3YnjxlVx8ATY0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Hv3K/2d4CsSQgs1lwqcNssVtxvuIl37U8V/NRrR4OdkSJUqLNv1ybNIZKlHoo3JM0PUaMdV+KOTKWPapXWMlg6jbkB2v0uk4yZefF6OvP6hM3kP8ICcg/TA3WzhDaBHbDFdzQYaQyDuf+9BeGlsI5ZrHwhLZs/iZnBW8O4vg+/A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UhVjQrgC; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UhVjQrgC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9B2271F00ACA;
	Wed,  9 Sep 2026 14:35:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788964538;
	bh=WxmePzXqD2/5hULkFy74khiV8u3K68QXvGgrra8NNF0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=UhVjQrgCvJ+N1/+9CpKBHjovabZ4ypGapu/SuqZmfDWcNQ6jyMBiGscYUrpekEggX
	 1fq1H7Jxiifj612deyFydHWcJe8FiItWmwU4s4NcAMyoEFBOeH7xHRjd1fizG/j++P
	 tHIngIwEx1k1jpRmdFTQcUH2YzMiN+UBYP65zYQP4A7nwJEzJ+6oIRkITCp3g40XPk
	 DvHqQV9nGwF+dSvy7AZBk+NGFd8flquUQ+o0O0o7FZg0XknKRCNbglboqQXjrM2aks
	 NJxnglQurCnSDpdbFcyE5pxhC8MJS/dczGo/D9E5q8en1tkxGItNkiWhzFJUmVdWQd
	 E9sfg5lC+Qh8g==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Zhang Heng <zhangheng@kylinos.cn>,
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
	Joerg Roedel <jroedel@suse.de>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y 1/2] iommu/msm: Use helper function devm_clk_get_prepared()
Date: Wed,  9 Sep 2026 10:35:34 -0400
Message-ID: <20260909143535.2525461-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026090342-rising-affidavit-4103@gregkh>
References: <2026090342-rising-affidavit-4103@gregkh>
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
Stable-dep-of: 535a200220ca ("iommu/msm: Unwind probe state on registration failure")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/iommu/msm_iommu.c | 52 +++++++++------------------------------
 1 file changed, 11 insertions(+), 41 deletions(-)

diff --git a/drivers/iommu/msm_iommu.c b/drivers/iommu/msm_iommu.c
index 16179a9a72830..90c7cbabaace3 100644
--- a/drivers/iommu/msm_iommu.c
+++ b/drivers/iommu/msm_iommu.c
@@ -708,47 +708,32 @@ static int msm_iommu_probe(struct platform_device *pdev)
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
 
@@ -763,8 +748,7 @@ static int msm_iommu_probe(struct platform_device *pdev)
 
 	if (!par) {
 		pr_err("Invalid PAR value detected\n");
-		ret = -ENODEV;
-		goto fail;
+		return -ENODEV;
 	}
 
 	ret = devm_request_threaded_irq(iommu->dev, iommu->irq, NULL,
@@ -774,7 +758,7 @@ static int msm_iommu_probe(struct platform_device *pdev)
 					iommu);
 	if (ret) {
 		pr_err("Request IRQ %d failed with ret=%d\n", iommu->irq, ret);
-		goto fail;
+		return ret;
 	}
 
 	list_add(&iommu->dev_node, &qcom_iommu_devices);
@@ -783,23 +767,19 @@ static int msm_iommu_probe(struct platform_device *pdev)
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
@@ -807,21 +787,11 @@ static const struct of_device_id msm_iommu_dt_match[] = {
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
 builtin_platform_driver(msm_iommu_driver);
-- 
2.53.0

