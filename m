Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A5E921FF2E
	for <stable@vger.kernel.org>; Thu,  4 Jun 2026 14:30:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780583435; cv=none; b=i56PoHAgJndcY59ae6tX/UcnpTxmT9v0wztGrYSRCg52fp2GBnXjmQruDzAadUymjdllGKKVs5STp25VnLO5PZLqTA3LtKTkJ4k1DlOeZI6VqajLsgPhjaZTS0uxLgEVo9tt2FzFoxLtJ7UlhwQqnXVs/5D/6N9Mk5pGfaJJfkc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780583435; c=relaxed/simple;
	bh=piGXxaIQ0sY06t29VuJyIokAhKjyWOQWcUJKqoStP4I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oK8sxoKMtLjzdy49XWCNlCQnmfByplsCA5+p2HyI9/xjIr2pYwhZdW/rxP980gEM8UCKkq1QD3YavqhN64QSEccl2YO+mdQeM7qopYMl0yWuThK45FRcxEF5v1fU/iUQneFJRliwh3q2+Ci1KZ6DxyxY2vvpmTAsu0kTYbH6DdI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Xc8Ew31U; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Xc8Ew31U"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 43A9A1F00893;
	Thu,  4 Jun 2026 14:30:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780583433;
	bh=CHJJ7+FWu2+pbj+48SaEPFC42CyFuiO7+AAiqX55T/w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Xc8Ew31U3lokabz4NwL+uA73F6jWdh90xAPZWhkjYJ1QEtmHOxZcaGGbilDqB1Knh
	 OCNwJx/NjCx1qE18ThpBs8WNp7+sZrUHOR6rsZDUFGp/dl14sOdirKOKdlSkUnR2Rm
	 xelMMVH4QPY2gHTo1M2cB0kA88FLZIVQ31XT8pd7TO/7ZmpxKHXfYS5Zc6FHNtXbCW
	 D2jW2HdTxapwhZ/83PtmtLy4JOYCQSQ+x0EVyIi4cdtAhXYEhq+2Ca9TByI4SOy82E
	 01zWbSEJY8BbFlvn/TJGKZsPRWrb8d1SWGzZ+x+26jIqE2jPwrVGf1XK+V49VaHg3e
	 3xSWtNgfycSiA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Ruan Jinjie <ruanjinjie@huawei.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y 1/3] iio: adc: fix the return value handle for platform_get_irq()
Date: Thu,  4 Jun 2026 10:30:29 -0400
Message-ID: <20260604143031.3608772-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026060419-driver-wreath-7a8d@gregkh>
References: <2026060419-driver-wreath-7a8d@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Ruan Jinjie <ruanjinjie@huawei.com>

[ Upstream commit c09ddcdd4dd32ee9768dc233ead4b3d726f26d38 ]

There is no possible for platform_get_irq() to return 0
and the return value of platform_get_irq() is more sensible
to show the error reason.

Signed-off-by: Ruan Jinjie <ruanjinjie@huawei.com>
Link: https://lore.kernel.org/r/20230727131607.2897937-1-ruanjinjie@huawei.com
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Stable-dep-of: 0d42e2c0bd6c ("iio: adc: npcm: fix unbalanced clk_disable_unprepare()")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/iio/adc/bcm_iproc_adc.c | 4 ++--
 drivers/iio/adc/lpc32xx_adc.c   | 4 ++--
 drivers/iio/adc/npcm_adc.c      | 4 ++--
 drivers/iio/adc/spear_adc.c     | 4 ++--
 4 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/iio/adc/bcm_iproc_adc.c b/drivers/iio/adc/bcm_iproc_adc.c
index 44e1e53ada7294..0d6885413a7ee2 100644
--- a/drivers/iio/adc/bcm_iproc_adc.c
+++ b/drivers/iio/adc/bcm_iproc_adc.c
@@ -540,8 +540,8 @@ static int iproc_adc_probe(struct platform_device *pdev)
 	}
 
 	adc_priv->irqno = platform_get_irq(pdev, 0);
-	if (adc_priv->irqno <= 0)
-		return -ENODEV;
+	if (adc_priv->irqno < 0)
+		return adc_priv->irqno;
 
 	ret = regmap_update_bits(adc_priv->regmap, IPROC_REGCTL2,
 				IPROC_ADC_AUXIN_SCAN_ENA, 0);
diff --git a/drivers/iio/adc/lpc32xx_adc.c b/drivers/iio/adc/lpc32xx_adc.c
index b56ce15255cfb5..10a370ca7d5f81 100644
--- a/drivers/iio/adc/lpc32xx_adc.c
+++ b/drivers/iio/adc/lpc32xx_adc.c
@@ -173,8 +173,8 @@ static int lpc32xx_adc_probe(struct platform_device *pdev)
 	}
 
 	irq = platform_get_irq(pdev, 0);
-	if (irq <= 0)
-		return -ENXIO;
+	if (irq < 0)
+		return irq;
 
 	retval = devm_request_irq(&pdev->dev, irq, lpc32xx_adc_isr, 0,
 				  LPC32XXAD_NAME, st);
diff --git a/drivers/iio/adc/npcm_adc.c b/drivers/iio/adc/npcm_adc.c
index f7bc0bb7f11249..beaa52512991a9 100644
--- a/drivers/iio/adc/npcm_adc.c
+++ b/drivers/iio/adc/npcm_adc.c
@@ -221,8 +221,8 @@ static int npcm_adc_probe(struct platform_device *pdev)
 	info->adc_sample_hz = clk_get_rate(info->adc_clk) / ((div + 1) * 2);
 
 	irq = platform_get_irq(pdev, 0);
-	if (irq <= 0) {
-		ret = -EINVAL;
+	if (irq < 0) {
+		ret = irq;
 		goto err_disable_clk;
 	}
 
diff --git a/drivers/iio/adc/spear_adc.c b/drivers/iio/adc/spear_adc.c
index 8fda16dd012f70..602ed05552bfd4 100644
--- a/drivers/iio/adc/spear_adc.c
+++ b/drivers/iio/adc/spear_adc.c
@@ -311,8 +311,8 @@ static int spear_adc_probe(struct platform_device *pdev)
 	}
 
 	irq = platform_get_irq(pdev, 0);
-	if (irq <= 0) {
-		ret = -EINVAL;
+	if (irq < 0) {
+		ret = irq;
 		goto errout2;
 	}
 
-- 
2.53.0

