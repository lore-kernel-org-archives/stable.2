Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8F3F280035
	for <stable@vger.kernel.org>; Thu,  4 Jun 2026 14:30:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780583436; cv=none; b=ewjsC1qDGqPlQ7vOyS2pPw8w2aQYlh0h7XjDy8oVH0RQKmIDE+rE6e3AQkyupzNwvy2q7u1Q8kZi9vS0c6FGxdE55lrRVjJ8M8OjRUVq4NTOrsCYFsZ53cdZ2dScBISBOWFMpa8djYiyVxiSe5x8Y3E2ak6u6CcTwTavM/5Ob1w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780583436; c=relaxed/simple;
	bh=Z7bvcqzoEyZGyrlthHSSSUfqcEKMLRa0Go4r7e6o/+U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WUey4jLwRgxfxuO9J5JlQ5PMlElGJrLNfZCvymKgX+30z/G3P3IrpR+dsmIplk1rzuORd4gr+TSsTpNClhECLDHR0AYwKnvLlw4RmirNQ3sHs219WR8B4WwnVEk+nREVGt/O/kL0jOR6jxYH2vzmXmIc3/ru5yQE7SRCUTlH2wg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Zc/KIUbU; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Zc/KIUbU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BCC2E1F00898;
	Thu,  4 Jun 2026 14:30:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780583435;
	bh=/3nGKjU+EwMm37BtpRMHD0UutW5sm9YOTze8feua0xI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Zc/KIUbUilVxT4/jeWDE1eytwiWqOxA8yG2b2p+ufs17tCb2tK96lxP9lzp1kOZ0u
	 I0KGL4r2coMdfIU0F1SrGYyMIcO49J8jfqQDddxhEgjkPEnAqfFWdm+vjbfQCuAlHm
	 6xLU2L0v3oNNBX/mwiHaO/8kJWwpqZsBc7iONiucvVYcUqbXuOSh3wQeR2MT8+dfke
	 0iWabvoBfeHS8lroq3b2Xm3Ipe/FrhvTfWgV+dhmIZAeFHPO64poVoRVxptCgQHomP
	 J9pJfOMSq6dCB83ift47HaO5aynQRBU+oUT+gQ/Lyly8UJ69rl3M7KDbxZSs6eqa/o
	 qFmAxGLMvQ2Sw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: David Carlier <devnexen@gmail.com>,
	Andy Shevchenko <andriy.shevchenko@intel.com>,
	Stable@vger.kernel.org,
	Jonathan Cameron <jic23@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y 3/3] iio: adc: npcm: fix unbalanced clk_disable_unprepare()
Date: Thu,  4 Jun 2026 10:30:31 -0400
Message-ID: <20260604143031.3608772-3-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260604143031.3608772-1-sashal@kernel.org>
References: <2026060419-driver-wreath-7a8d@gregkh>
 <20260604143031.3608772-1-sashal@kernel.org>
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
 drivers/iio/adc/npcm_adc.c | 25 ++++++++-----------------
 1 file changed, 8 insertions(+), 17 deletions(-)

diff --git a/drivers/iio/adc/npcm_adc.c b/drivers/iio/adc/npcm_adc.c
index 4aecdf908a7e0d..444ada79f32b3d 100644
--- a/drivers/iio/adc/npcm_adc.c
+++ b/drivers/iio/adc/npcm_adc.c
@@ -208,7 +208,7 @@ static int npcm_adc_probe(struct platform_device *pdev)
 	if (IS_ERR(info->reset))
 		return PTR_ERR(info->reset);
 
-	info->adc_clk = devm_clk_get(&pdev->dev, NULL);
+	info->adc_clk = devm_clk_get_enabled(&pdev->dev, NULL);
 	if (IS_ERR(info->adc_clk)) {
 		dev_warn(&pdev->dev, "ADC clock failed: can't read clk\n");
 		return PTR_ERR(info->adc_clk);
@@ -221,17 +221,13 @@ static int npcm_adc_probe(struct platform_device *pdev)
 	info->adc_sample_hz = clk_get_rate(info->adc_clk) / ((div + 1) * 2);
 
 	irq = platform_get_irq(pdev, 0);
-	if (irq < 0) {
-		ret = irq;
-		goto err_disable_clk;
-	}
+	if (irq < 0)
+		return irq;
 
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
@@ -239,7 +235,7 @@ static int npcm_adc_probe(struct platform_device *pdev)
 		ret = regulator_enable(info->vref);
 		if (ret) {
 			dev_err(&pdev->dev, "Can't enable ADC reference voltage\n");
-			goto err_disable_clk;
+			return ret;
 		}
 
 		iowrite32(reg_con & ~NPCM_ADCCON_REFSEL,
@@ -249,10 +245,8 @@ static int npcm_adc_probe(struct platform_device *pdev)
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
@@ -291,8 +285,6 @@ static int npcm_adc_probe(struct platform_device *pdev)
 	iowrite32(reg_con & ~NPCM_ADCCON_ADC_EN, info->regs + NPCM_ADCCON);
 	if (!IS_ERR(info->vref))
 		regulator_disable(info->vref);
-err_disable_clk:
-	clk_disable_unprepare(info->adc_clk);
 
 	return ret;
 }
@@ -309,7 +301,6 @@ static void npcm_adc_remove(struct platform_device *pdev)
 	iowrite32(regtemp & ~NPCM_ADCCON_ADC_EN, info->regs + NPCM_ADCCON);
 	if (!IS_ERR(info->vref))
 		regulator_disable(info->vref);
-	clk_disable_unprepare(info->adc_clk);
 }
 
 static struct platform_driver npcm_adc_driver = {
-- 
2.53.0

