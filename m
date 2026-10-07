Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CDD92931D5
	for <stable@vger.kernel.org>; Wed,  7 Oct 2026 06:10:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791353408; cv=none; b=oGpmPdY+QmK3OBikyzpFVJ36nL6DDmyzmxdQ0ABL8SOe8j9bO9T7RRoM2aMz7uMllR87yuMuLWnOkDqqAbr6z0L9FyKHR5J6twJ4VNiFqCTqcG69sEYRXmaUx5wwwe+f8phmKDwo9WqaB9IeeSZtBfP8QyLsO9mvcY+jnKRHJ/U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791353408; c=relaxed/simple;
	bh=4qff99gGUezC9oXBblcR5HUqJOPwymeiHHmMIq0E5NM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QgmDDEqyHIZZrtoZZMyplegCcvgO6jLCPMnuMu+dNKAfypkKRIcWf9bYyhoFwmKU9ELB4G7KzveiXKU8rMqwV3sR9OdGlqUwnlEkHRC+DftJqidM3xWqjv4f3Al+sLqmIU1vgZ4dfo1FNyUMmFKHUY40526Oobepyxxa9KVI3Qc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GHSS/+1Z; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GHSS/+1Z"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 17F361F0089B;
	Wed,  7 Oct 2026 06:10:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791353405;
	bh=6dbFY2567bXivwo9ZHKuUyI+3eMpKmbF/wFW+Odyyng=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=GHSS/+1ZI7L+qWwswJLBbHo8VMyv4EYZDwaG965RQvXXVoIrf8g5KY7YSmkHiiapc
	 Ry+Rofp65EqD+wpXIATpuYhwv5iM6q8oiPTqdlmx8kb1z7yekf5G9jK1UUmJxIYnaf
	 Yj2gJYtrnbceR/xlKaW95jfGlRguOi1RDd8z6CiGz3w9xlwA2NUTCc+ol2FYVAScac
	 l5G9fAzuax0KoNe/D45b7JopGwapsHQP4TNnc923Rr5ni3hON++Z9OwOuxy/EKv5qy
	 UxA8jreT64ZzjN+pNxY31ej/xQ7l64kOmu+yt9pIHTsP2k6OC+auBnqnFpmclbsXli
	 5mhEPuIOZlypQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Fan Wu <fanwu01@zju.edu.cn>,
	Song Li <songl@zju.edu.cn>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y] iio: adc: ad_sigma_delta: fix use-after-free on unbind
Date: Wed,  7 Oct 2026 02:10:01 -0400
Message-ID: <20261007060914.1497746-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026100620-buzz-swell-fdb1@gregkh>
References: <2026100620-buzz-swell-fdb1@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Fan Wu <fanwu01@zju.edu.cn>

[ Upstream commit 9ee8306121495d2a25aa5d1bfd519f2748786b83 ]

ad_sd_buffer_postenable() allocates sigma_delta->samples_buf with
devm_krealloc() at runtime, so its devres entry sits after all
probe-time entries of the driver. devm resources are released in
reverse allocation order, which means unbind frees samples_buf before
iio_device_unregister() disables the buffers and detaches the trigger
pollfunc. The data ready IRQ is still enabled at that point, so
ad_sd_trigger_handler() can still run and memcpy() incoming samples
into the freed samples_buf.

Fix this by preallocating the buffer in
devm_ad_sd_setup_buffer_and_trigger(), before the triggered buffer and
the IRQ are set up, so it is freed only after iio_device_unregister()
has drained the trigger handler via free_irq(). Size it for the worst
case of all sequencer slots being active; ad_sd_validate_scan_mask()
already caps the number of active channels at num_slots.

This issue was found by an in-house static analysis tool.

Fixes: 8bea9af887de ("iio: adc: ad_sigma_delta: Add sequencer support")
Cc: stable@vger.kernel.org
Co-developed-by: Song Li <songl@zju.edu.cn>
Signed-off-by: Song Li <songl@zju.edu.cn>
Signed-off-by: Fan Wu <fanwu01@zju.edu.cn>
Reviewed-by: Nuno Sá <nuno.sa@analog.com>
Signed-off-by: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
[ sashal: Made the allocation unconditional because the offload conditional is absent. ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/iio/adc/ad_sigma_delta.c | 27 ++++++++++++++++-----------
 1 file changed, 16 insertions(+), 11 deletions(-)

diff --git a/drivers/iio/adc/ad_sigma_delta.c b/drivers/iio/adc/ad_sigma_delta.c
index 5d0bfabc69ea9..00be58118931f 100644
--- a/drivers/iio/adc/ad_sigma_delta.c
+++ b/drivers/iio/adc/ad_sigma_delta.c
@@ -344,9 +344,8 @@ EXPORT_SYMBOL_NS_GPL(ad_sigma_delta_single_conversion, IIO_AD_SIGMA_DELTA);
 static int ad_sd_buffer_postenable(struct iio_dev *indio_dev)
 {
 	struct ad_sigma_delta *sigma_delta = iio_device_get_drvdata(indio_dev);
-	unsigned int i, slot, samples_buf_size;
+	unsigned int i, slot;
 	unsigned int channel;
-	uint8_t *samples_buf;
 	int ret;
 
 	if (sigma_delta->num_slots == 1) {
@@ -379,15 +378,6 @@ static int ad_sd_buffer_postenable(struct iio_dev *indio_dev)
 			return ret;
 	}
 
-	samples_buf_size = ALIGN(slot * indio_dev->channels[0].scan_type.storagebits / 8, 8);
-	samples_buf_size += sizeof(int64_t);
-	samples_buf = devm_krealloc(&sigma_delta->spi->dev, sigma_delta->samples_buf,
-				    samples_buf_size, GFP_KERNEL);
-	if (!samples_buf)
-		return -ENOMEM;
-
-	sigma_delta->samples_buf = samples_buf;
-
 	spi_bus_lock(sigma_delta->spi->controller);
 	sigma_delta->bus_locked = true;
 	sigma_delta->keep_cs_asserted = true;
@@ -626,6 +616,8 @@ static int devm_ad_sd_probe_trigger(struct device *dev, struct iio_dev *indio_de
 int devm_ad_sd_setup_buffer_and_trigger(struct device *dev, struct iio_dev *indio_dev)
 {
 	struct ad_sigma_delta *sigma_delta = iio_device_get_drvdata(indio_dev);
+	const struct iio_scan_type *scan_type = &indio_dev->channels[0].scan_type;
+	unsigned int samples_buf_size;
 	int ret;
 
 	sigma_delta->slots = devm_kcalloc(dev, sigma_delta->num_slots,
@@ -633,6 +625,19 @@ int devm_ad_sd_setup_buffer_and_trigger(struct device *dev, struct iio_dev *indi
 	if (!sigma_delta->slots)
 		return -ENOMEM;
 
+	/*
+	 * Worst-case size: all sequencer slots can be active, capped
+	 * at num_slots by ad_sd_validate_scan_mask().
+	 */
+	samples_buf_size =
+		ALIGN(sigma_delta->num_slots *
+		      BITS_TO_BYTES(scan_type->storagebits),
+		      sizeof(s64));
+	samples_buf_size += sizeof(s64);
+	sigma_delta->samples_buf = devm_kzalloc(dev, samples_buf_size, GFP_KERNEL);
+	if (!sigma_delta->samples_buf)
+		return -ENOMEM;
+
 	ret = devm_iio_triggered_buffer_setup(dev, indio_dev,
 					      &iio_pollfunc_store_time,
 					      &ad_sd_trigger_handler,
-- 
2.53.0

