Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82BAC49D5AE
	for <stable@vger.kernel.org>; Wed,  7 Oct 2026 09:07:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791364071; cv=none; b=Y2kkwejfg54PX+wLAHF/f6j1ZbLe959g+c78W0/+QQ4cuvHJ68zzcUBVl72BuNL24EbBoW1sITUZ1ufNFGaKNt0d4f+EoyVT48G0tGpIiBJPk8YqFNUcGTSYBVTU2T8tOSHDMlt2vdEafFrCuBgEX6+TNKRgl30h+Jb+ROSgr8s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791364071; c=relaxed/simple;
	bh=nWg3q3HI6GYpQpMp/0MyxXtpBGhst7ip1KBYq7u6pnY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DPu+Op93roNlMM66ab/NQEyW5fEYgjMFJRvVSkeRSnNuizXY4AA7Ccb+30zqYdkPM2L2qodk42QpVkMvOeBefgLEC+hYsVNJscTnSD7f7CUH6OUZUS4GucXaWiR/Za0jsG0fMtxB5J/3Hv8ZKT6Hvuw3xufnOll+dE6EX2Or65I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ajXQ+2rH; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ajXQ+2rH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 050D51F0089B;
	Wed,  7 Oct 2026 09:07:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791364034;
	bh=NWpIR/oq263QlgeNSTKxflof72rQCkxLmmHChDq3bBc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ajXQ+2rHlFgccLMPwAR4Tx7a0FmZ8fDHHcRhyLmCAIMQKM2qA9a6AKYbNqizmPF4/
	 C25HR3ioO/Z0+AAMh79FXwGuEYFCfFTa6tzHPmGrGG6V1tVvdoDnyEyG7KFDJ+naxQ
	 B0Z2aizo6a/M9Of8nElATQGvsIYziEXCtAlsJGOKcnJd/1cr74it7QSanWtLOrkUQf
	 CDgEVANQQU8pDIn3vxn6fpntC57f2FEsQg9mfipM8wssIJgemwn1njZlPJEIbSpbsa
	 7hVIRTCHNsS0hjyhCTjY4KQZrQNYJf6mqCOV8coIemgMt6KrZ9VVnq97YgId/3UpC8
	 t6bwxcovCN3Ng==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: =?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18.y 1/2] iio: adc: adi-axi-adc: Make use of dev_err_probe()
Date: Wed,  7 Oct 2026 05:07:09 -0400
Message-ID: <20261007090651.2021301-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026100609-decibel-passing-b1dc@gregkh>
References: <2026100609-decibel-passing-b1dc@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Nuno Sá <nuno.sa@analog.com>

[ Upstream commit 634a6316617e2ced7016b002d0b284a1502e9601 ]

Be consistent and use dev_err_probe() as in all other places in the
.probe() path.

While at it, remove the line break in the version condition. Yes, it
goes over the 80 column limit but I do think the line break hurts
readability in this case. And use a struct device *dev helper for
neater code.

Signed-off-by: Nuno Sá <nuno.sa@analog.com>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Stable-dep-of: 549b71ce0506 ("iio: adc: adi-axi-adc: Initialize state mutex")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/iio/adc/adi-axi-adc.c | 57 ++++++++++++++++-------------------
 1 file changed, 26 insertions(+), 31 deletions(-)

diff --git a/drivers/iio/adc/adi-axi-adc.c b/drivers/iio/adc/adi-axi-adc.c
index 61f7a07f501f9..431b023aff3d7 100644
--- a/drivers/iio/adc/adi-axi-adc.c
+++ b/drivers/iio/adc/adi-axi-adc.c
@@ -704,13 +704,14 @@ static const struct iio_backend_info axi_ad408x = {
 
 static int adi_axi_adc_probe(struct platform_device *pdev)
 {
+	struct device *dev = &pdev->dev;
 	struct adi_axi_adc_state *st;
 	void __iomem *base;
 	unsigned int ver;
 	struct clk *clk;
 	int ret;
 
-	st = devm_kzalloc(&pdev->dev, sizeof(*st), GFP_KERNEL);
+	st = devm_kzalloc(dev, sizeof(*st), GFP_KERNEL);
 	if (!st)
 		return -ENOMEM;
 
@@ -718,20 +719,19 @@ static int adi_axi_adc_probe(struct platform_device *pdev)
 	if (IS_ERR(base))
 		return PTR_ERR(base);
 
-	st->dev = &pdev->dev;
-	st->regmap = devm_regmap_init_mmio(&pdev->dev, base,
-					   &axi_adc_regmap_config);
+	st->dev = dev;
+	st->regmap = devm_regmap_init_mmio(dev, base, &axi_adc_regmap_config);
 	if (IS_ERR(st->regmap))
-		return dev_err_probe(&pdev->dev, PTR_ERR(st->regmap),
+		return dev_err_probe(dev, PTR_ERR(st->regmap),
 				     "failed to init register map\n");
 
-	st->info = device_get_match_data(&pdev->dev);
+	st->info = device_get_match_data(dev);
 	if (!st->info)
 		return -ENODEV;
 
-	clk = devm_clk_get_enabled(&pdev->dev, NULL);
+	clk = devm_clk_get_enabled(dev, NULL);
 	if (IS_ERR(clk))
-		return dev_err_probe(&pdev->dev, PTR_ERR(clk),
+		return dev_err_probe(dev, PTR_ERR(clk),
 				     "failed to get clock\n");
 
 	/*
@@ -746,47 +746,42 @@ static int adi_axi_adc_probe(struct platform_device *pdev)
 	if (ret)
 		return ret;
 
-	if (ADI_AXI_PCORE_VER_MAJOR(ver) !=
-	    ADI_AXI_PCORE_VER_MAJOR(st->info->version)) {
-		dev_err(&pdev->dev,
-			"Major version mismatch. Expected %d.%.2d.%c, Reported %d.%.2d.%c\n",
-			ADI_AXI_PCORE_VER_MAJOR(st->info->version),
-			ADI_AXI_PCORE_VER_MINOR(st->info->version),
-			ADI_AXI_PCORE_VER_PATCH(st->info->version),
-			ADI_AXI_PCORE_VER_MAJOR(ver),
-			ADI_AXI_PCORE_VER_MINOR(ver),
-			ADI_AXI_PCORE_VER_PATCH(ver));
-		return -ENODEV;
-	}
-
-	ret = devm_iio_backend_register(&pdev->dev, st->info->backend_info, st);
+	if (ADI_AXI_PCORE_VER_MAJOR(ver) != ADI_AXI_PCORE_VER_MAJOR(st->info->version))
+		return dev_err_probe(dev, -ENODEV,
+				     "Major version mismatch. Expected %d.%.2d.%c, Reported %d.%.2d.%c\n",
+				     ADI_AXI_PCORE_VER_MAJOR(st->info->version),
+				     ADI_AXI_PCORE_VER_MINOR(st->info->version),
+				     ADI_AXI_PCORE_VER_PATCH(st->info->version),
+				     ADI_AXI_PCORE_VER_MAJOR(ver),
+				     ADI_AXI_PCORE_VER_MINOR(ver),
+				     ADI_AXI_PCORE_VER_PATCH(ver));
+
+	ret = devm_iio_backend_register(dev, st->info->backend_info, st);
 	if (ret)
-		return dev_err_probe(&pdev->dev, ret,
-				     "failed to register iio backend\n");
+		return dev_err_probe(dev, ret, "failed to register iio backend\n");
 
-	device_for_each_child_node_scoped(&pdev->dev, child) {
+	device_for_each_child_node_scoped(dev, child) {
 		int val;
 
 		if (!st->info->has_child_nodes)
-			return dev_err_probe(&pdev->dev, -EINVAL,
+			return dev_err_probe(dev, -EINVAL,
 					     "invalid fdt axi-dac compatible.");
 
 		/* Processing only reg 0 node */
 		ret = fwnode_property_read_u32(child, "reg", &val);
 		if (ret)
-			return dev_err_probe(&pdev->dev, ret,
-					     "invalid reg property.");
+			return dev_err_probe(dev, ret, "invalid reg property.");
 		if (val != 0)
-			return dev_err_probe(&pdev->dev, -EINVAL,
+			return dev_err_probe(dev, -EINVAL,
 					     "invalid node address.");
 
 		ret = axi_adc_create_platform_device(st, child);
 		if (ret)
-			return dev_err_probe(&pdev->dev, -EINVAL,
+			return dev_err_probe(dev, -EINVAL,
 					     "cannot create device.");
 	}
 
-	dev_info(&pdev->dev, "AXI ADC IP core (%d.%.2d.%c) probed\n",
+	dev_info(dev, "AXI ADC IP core (%d.%.2d.%c) probed\n",
 		 ADI_AXI_PCORE_VER_MAJOR(ver),
 		 ADI_AXI_PCORE_VER_MINOR(ver),
 		 ADI_AXI_PCORE_VER_PATCH(ver));
-- 
2.53.0

