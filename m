Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1779340D90
	for <stable@vger.kernel.org>; Wed,  7 Oct 2026 06:23:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791354189; cv=none; b=L6RxtLDe8B5nrJgJGM86gRoIsp6bYzUYifsCGFPlxjCygvMAq1/Z46dCCRTM5Jy3cUTl+VTQre7xJ0IzAv8LhVRLrAPfuxZcbnOI0uBRo0VYh90F1UuiC6vp7mJqF7AOSX20b5aJWBzmG3OKeFFwZp/XnsPdsz1Jg6UwZUlfDSQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791354189; c=relaxed/simple;
	bh=KuDhmC+n+J9SNCOXO/gZR18GGFC3KrqtKqU3woaOlcI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=k7a124ZpHls54x9M7+BHINr3+MXvFR2f0xXeVkAHdbFpeYDeu2qS7mINZBWsMexg70jYfHuxF0GBKBAcNNB0MctQKoK3R/xxBk1K7LrhJ3NJRv857GImIxw5+g6SoQ7m5cAhxwl/WsSyLLZ1DdZGWOlYhGB3QpXHDvQJoKwtDis=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ca1vrbKe; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ca1vrbKe"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 98E001F0089B;
	Wed,  7 Oct 2026 06:23:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791354187;
	bh=9E05GAh+CQWpgY0BaPmJUzf1ElQEdsFMALjel9fIFcI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ca1vrbKeQrgl8fLZdGvGtNqThzfcIKA/eNdlsC6KEZURdt0B1zAVfmtyzvt5umqBh
	 ufZkL0YyBUUWiJkXfaxqVAZA66/GEZV2tHkQ6lfSOh+SnQDDQikNZMy+ymRF2Zspqe
	 GIHGT1mwm/qQNJ0Woc0YXm1NVlnRnDWxlj1Wa+Q8thMATNnLgOdS6JLEKDo59mc3Vj
	 A15pi2lypUEPIvmejG/U/o4cxhh/Yq5VyVSuz3Hbc+juExJvwgiuT+DkV5Ch7Kyyaw
	 FaJ7AOoQPkAg52Pt72u+H12ZxWAHmV5SXNBa/lGfqL5nUfeB1GnuJBkdswpmc5gjCX
	 BTeWNlFZ/X6kA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Fan Wu <fanwu01@zju.edu.cn>,
	Song Li <songl@zju.edu.cn>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y] iio: adc: ad_sigma_delta: fix use-after-free on unbind
Date: Wed,  7 Oct 2026 02:23:03 -0400
Message-ID: <20261007062239.1618854-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026100621-scoured-monitor-69e9@gregkh>
References: <2026100621-scoured-monitor-69e9@gregkh>
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
[ sashal: Adapted allocation to setup without SPI offload using direct channel scan_type.storagebits access. ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/iio/adc/ad_sigma_delta.c | 26 +++++++++++++++-----------
 1 file changed, 15 insertions(+), 11 deletions(-)

diff --git a/drivers/iio/adc/ad_sigma_delta.c b/drivers/iio/adc/ad_sigma_delta.c
index 914274ed899ec..45e0f638c0ed1 100644
--- a/drivers/iio/adc/ad_sigma_delta.c
+++ b/drivers/iio/adc/ad_sigma_delta.c
@@ -343,9 +343,8 @@ EXPORT_SYMBOL_NS_GPL(ad_sigma_delta_single_conversion, IIO_AD_SIGMA_DELTA);
 static int ad_sd_buffer_postenable(struct iio_dev *indio_dev)
 {
 	struct ad_sigma_delta *sigma_delta = iio_device_get_drvdata(indio_dev);
-	unsigned int i, slot, samples_buf_size;
+	unsigned int i, slot;
 	unsigned int channel;
-	uint8_t *samples_buf;
 	int ret;
 
 	if (sigma_delta->num_slots == 1) {
@@ -378,15 +377,6 @@ static int ad_sd_buffer_postenable(struct iio_dev *indio_dev)
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
 	spi_bus_lock(sigma_delta->spi->master);
 	sigma_delta->bus_locked = true;
 	sigma_delta->keep_cs_asserted = true;
@@ -620,6 +610,7 @@ static int devm_ad_sd_probe_trigger(struct device *dev, struct iio_dev *indio_de
 int devm_ad_sd_setup_buffer_and_trigger(struct device *dev, struct iio_dev *indio_dev)
 {
 	struct ad_sigma_delta *sigma_delta = iio_device_get_drvdata(indio_dev);
+	unsigned int samples_buf_size;
 	int ret;
 
 	sigma_delta->slots = devm_kcalloc(dev, sigma_delta->num_slots,
@@ -627,6 +618,19 @@ int devm_ad_sd_setup_buffer_and_trigger(struct device *dev, struct iio_dev *indi
 	if (!sigma_delta->slots)
 		return -ENOMEM;
 
+	/*
+	 * Worst-case size: all sequencer slots can be active, capped
+	 * at num_slots by ad_sd_validate_scan_mask().
+	 */
+	samples_buf_size =
+		ALIGN(sigma_delta->num_slots *
+		      BITS_TO_BYTES(indio_dev->channels[0].scan_type.storagebits),
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

