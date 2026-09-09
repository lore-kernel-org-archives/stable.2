Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54A8C56E075
	for <stable@vger.kernel.org>; Wed,  9 Sep 2026 14:14:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788963279; cv=none; b=EhRPiNbFcPEIa9RtNnYcEJAmJdlfO7qqpfMwkUvy4IKjQcpD2XeU2V47dr/C0sHBEP+5z5e/D+ucehwIsMSEnEFVfusQbvJR3CWeVYPj06dEZuCYgpJzD3c9NFN7QjGY/lkfb4a6u3vvNNiVxs3HZmVGPWtZSj5H1eH8YIEIySU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788963279; c=relaxed/simple;
	bh=pNnAp3m2GiHdtRN6FQno3LI/4DdEunomHEOxSBPi/oI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=boYb2yKQ4m4xfu+F/kOpG52l1qmqPe/W6wbHBX249s1KwRwRZ+SM5fyhT9jCLKBQIygimjS7qnM4BuJ9d/2K5s8VtNjT2p7pMrSd20Jhbl8CLRZs7LHtmRI6GlPmy0ZbWEhnjoHSQLWOF6EbUD5SPoeweXz1IyO+T31AJpI/8SE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FSxh0Kwq; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FSxh0Kwq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8C4EB1F00ACA;
	Wed,  9 Sep 2026 14:14:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788963278;
	bh=ZeNjUbzSMGZoXgBndnJC0B2k+NODl5TxDLmCu534prc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=FSxh0KwqTH/WIvTd+MdWB14xPhLEETzM36XuMQW2eHH8tnXVvsuEBD7FbretKP0gZ
	 gjdtMHCsXfCC9AlsrbrCUOLAPshhzNYfq9DwgB379vZB6TEY9H3MJlG3nO47muS1zS
	 MtA70KP4jtTlSahbTVQo2zJtrRlbQcL9z5bJGxftJspW6yKF6W1XeY+/UbuAPP2xbX
	 oKxtmnF2+mqzLuthNVldEhx6lzAKnUzgQq565fGgGtscqRB77012hLy9IvQdfLKuR8
	 jKlhk4CC+ttC+m9L4G1eyiYwxaZxeV7u01ikPfuSiFjijBg8iBOIjAwW2oS4gRjfu7
	 qiJkdIn/Vyy5A==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Zhang Heng <zhangheng@kylinos.cn>,
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
	Joerg Roedel <jroedel@suse.de>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y 1/2] iommu/msm: Use helper function devm_clk_get_prepared()
Date: Wed,  9 Sep 2026 10:14:35 -0400
Message-ID: <20260909141436.2391480-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026090342-cost-opposing-2086@gregkh>
References: <2026090342-cost-opposing-2086@gregkh>
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
index 79d89bad5132b..d6526908f1504 100644
--- a/drivers/iommu/msm_iommu.c
+++ b/drivers/iommu/msm_iommu.c
@@ -712,47 +712,32 @@ static int msm_iommu_probe(struct platform_device *pdev)
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
 
@@ -767,8 +752,7 @@ static int msm_iommu_probe(struct platform_device *pdev)
 
 	if (!par) {
 		pr_err("Invalid PAR value detected\n");
-		ret = -ENODEV;
-		goto fail;
+		return -ENODEV;
 	}
 
 	ret = devm_request_threaded_irq(iommu->dev, iommu->irq, NULL,
@@ -778,7 +762,7 @@ static int msm_iommu_probe(struct platform_device *pdev)
 					iommu);
 	if (ret) {
 		pr_err("Request IRQ %d failed with ret=%d\n", iommu->irq, ret);
-		goto fail;
+		return ret;
 	}
 
 	list_add(&iommu->dev_node, &qcom_iommu_devices);
@@ -787,23 +771,19 @@ static int msm_iommu_probe(struct platform_device *pdev)
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
@@ -811,20 +791,11 @@ static const struct of_device_id msm_iommu_dt_match[] = {
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

