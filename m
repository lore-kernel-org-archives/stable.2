Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 924AD47F2CB
	for <stable@vger.kernel.org>; Thu,  4 Jun 2026 17:12:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780593121; cv=none; b=ZLgiRjksFHLuD5H6jRKVa/i+jRKE1g/C21mKLViJRPmcGVCdPYNS/UkixmMwdZxaCdGQ9uncmp5ThMBLc4Uj0uq1B0kufMnbIT8/dURtrWHKnJ9YkHfeVVeFXQOBUArAcLG7+PgKUxHU0nUkZ6cS8YGZg0hcx48XEPAXIie4ibk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780593121; c=relaxed/simple;
	bh=jHiGYah9eJD22DhEQto0HYvl1A57BcoQBnAKL//N2xA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tz/lF5mnhpTrUfhgLuvUSBp3spKdyn6gBEn/5Hz9HZ9bUglmxoVYHmUplUBhEAbjsnl8vtcL81izSMUhSoZ/D1C/Wg6jGmCS/VwfJEmP3ArzaDmBYORofQ+WV4TD8KKNfgA7nfytrRSPJLN2IplPbWF68gQGjbxZKykcAXs5OUM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nr+aUajD; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nr+aUajD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 878111F00893;
	Thu,  4 Jun 2026 17:11:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780593120;
	bh=+KfencWrqOin6sU25jTmppmAZ4EVudRSg2Q1fZ+LYCY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=nr+aUajD/aKAiJk++bpzdqR/yYQBh+UIz0x7kZd09+nAIR7YpLcyvgqArFGhBofEF
	 rBQ8ZxhypYEtXlQdp0CsehuqUH3fLlHjU4LWevD0GsEcQT/b/vQtx9LIHtNcH9dK45
	 pqFCMVYEcIMIEm+SY7/+6Votp2CG5u1Bx44yLoN2btOhpLepaHtcV/YmUeAPJrhVju
	 zfQVYPhZVzkKlKqZ8y2jDCuGedk4rxBF21b8zezvbkWuiIHOh3O3yV1eOCl/76SANN
	 8QgF7supVUNXygqEMY3tRTFNEguvp8M19qzFHsH1mhb+PkGkVJ4kcPWD/HghRK7tbV
	 glkL2Srt3Yb5g==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: David Carlier <devnexen@gmail.com>,
	Andy Shevchenko <andriy.shevchenko@intel.com>,
	Stable@vger.kernel.org,
	Jonathan Cameron <jic23@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y] iio: adc: npcm: fix unbalanced clk_disable_unprepare()
Date: Thu,  4 Jun 2026 13:11:57 -0400
Message-ID: <20260604171157.4039872-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026060420-falcon-onlooker-44bb@gregkh>
References: <2026060420-falcon-onlooker-44bb@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: David Carlier <devnexen@gmail.com>

[ Upstream commit 0d42e2c0bd6ceb89e44c6e065f9bdf9b1df3ef0c ]

The driver acquired the ADC clock with devm_clk_get() and read its
rate, but never called clk_prepare_enable(). The probe error path and
npcm_adc_remove() both called clk_disable_unprepare() unconditionally,
causing the clk framework's enable/prepare counts to underflow on
probe failure or module unbind.

The issue went unnoticed because NPCM BMC firmware leaves the ADC
clock enabled at boot, so the driver happened to work in practice.

Switch to devm_clk_get_enabled() so the clock is properly enabled
during probe and automatically released by the device-managed
cleanup, and drop the now-redundant clk_disable_unprepare() from
both the probe error path and remove().

While at it, drop the duplicate error message on devm_request_irq()
failure since the IRQ core already logs it.

Fixes: 9bf85fbc9d8f ("iio: adc: add NPCM ADC driver")
Signed-off-by: David Carlier <devnexen@gmail.com>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: <Stable@vger.kernel.org>
Signed-off-by: Jonathan Cameron <jic23@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/iio/adc/npcm_adc.c | 26 ++++++++------------------
 1 file changed, 8 insertions(+), 18 deletions(-)

diff --git a/drivers/iio/adc/npcm_adc.c b/drivers/iio/adc/npcm_adc.c
index d9d105920001e9..c06de95716c81c 100644
--- a/drivers/iio/adc/npcm_adc.c
+++ b/drivers/iio/adc/npcm_adc.c
@@ -180,7 +180,6 @@ static int npcm_adc_probe(struct platform_device *pdev)
 	u32 reg_con;
 	struct npcm_adc *info;
 	struct iio_dev *indio_dev;
-	struct device *dev = &pdev->dev;
 
 	indio_dev = devm_iio_device_alloc(&pdev->dev, sizeof(*info));
 	if (!indio_dev)
@@ -197,7 +196,7 @@ static int npcm_adc_probe(struct platform_device *pdev)
 	if (IS_ERR(info->reset))
 		return PTR_ERR(info->reset);
 
-	info->adc_clk = devm_clk_get(&pdev->dev, NULL);
+	info->adc_clk = devm_clk_get_enabled(&pdev->dev, NULL);
 	if (IS_ERR(info->adc_clk)) {
 		dev_warn(&pdev->dev, "ADC clock failed: can't read clk\n");
 		return PTR_ERR(info->adc_clk);
@@ -210,17 +209,13 @@ static int npcm_adc_probe(struct platform_device *pdev)
 	info->adc_sample_hz = clk_get_rate(info->adc_clk) / ((div + 1) * 2);
 
 	irq = platform_get_irq(pdev, 0);
-	if (irq <= 0) {
-		ret = -EINVAL;
-		goto err_disable_clk;
-	}
+	if (irq <= 0)
+		return -EINVAL;
 
 	ret = devm_request_irq(&pdev->dev, irq, npcm_adc_isr, 0,
 			       "NPCM_ADC", indio_dev);
-	if (ret < 0) {
-		dev_err(dev, "failed requesting interrupt\n");
-		goto err_disable_clk;
-	}
+	if (ret < 0)
+		return ret;
 
 	reg_con = ioread32(info->regs + NPCM_ADCCON);
 	info->vref = devm_regulator_get_optional(&pdev->dev, "vref");
@@ -228,7 +223,7 @@ static int npcm_adc_probe(struct platform_device *pdev)
 		ret = regulator_enable(info->vref);
 		if (ret) {
 			dev_err(&pdev->dev, "Can't enable ADC reference voltage\n");
-			goto err_disable_clk;
+			return ret;
 		}
 
 		iowrite32(reg_con & ~NPCM_ADCCON_REFSEL,
@@ -238,10 +233,8 @@ static int npcm_adc_probe(struct platform_device *pdev)
 		 * Any error which is not ENODEV indicates the regulator
 		 * has been specified and so is a failure case.
 		 */
-		if (PTR_ERR(info->vref) != -ENODEV) {
-			ret = PTR_ERR(info->vref);
-			goto err_disable_clk;
-		}
+		if (PTR_ERR(info->vref) != -ENODEV)
+			return PTR_ERR(info->vref);
 
 		/* Use internal reference */
 		iowrite32(reg_con | NPCM_ADCCON_REFSEL,
@@ -280,8 +273,6 @@ static int npcm_adc_probe(struct platform_device *pdev)
 	iowrite32(reg_con & ~NPCM_ADCCON_ADC_EN, info->regs + NPCM_ADCCON);
 	if (!IS_ERR(info->vref))
 		regulator_disable(info->vref);
-err_disable_clk:
-	clk_disable_unprepare(info->adc_clk);
 
 	return ret;
 }
@@ -298,7 +289,6 @@ static int npcm_adc_remove(struct platform_device *pdev)
 	iowrite32(regtemp & ~NPCM_ADCCON_ADC_EN, info->regs + NPCM_ADCCON);
 	if (!IS_ERR(info->vref))
 		regulator_disable(info->vref);
-	clk_disable_unprepare(info->adc_clk);
 
 	return 0;
 }
-- 
2.53.0

