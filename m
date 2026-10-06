Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA99C22425B
	for <stable@vger.kernel.org>; Tue,  6 Oct 2026 07:43:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791272606; cv=none; b=toRXEo1QwGYEoWFO8gndHe+qI21wk5uDfAtLkn8skWAg3OFG9plwPgLDDVqgnvxOSZ8Ps4xfgpyUwrXd9JrBVhYAArznAkjLSwgZyLQHMb+ssx/Tue2NdSOjzeLcpIJ1oYcfqfEGANekQvvxDqzO4+YowbXNA5xTKB1x/080SeU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791272606; c=relaxed/simple;
	bh=hDsflyed80wJeiLQ/xAWAdSGfxzUX2LfqwPmfOdpXtU=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=SrpNZAbKiMhk/eBh8dNd7euCKPAO8kAoNa4erub3Axv+WVww/pBYIma9sKcpyj4OITp837Okgh7FB3vOs19PoCiF9O+3+PY39EaBp/ZOpsT7h/SU0qItZWSrNqie95Jqjn8sKwq46hqceIuob/p4Bu062ers1dxTjcd5Z9OR7vI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Fc/UbYnU; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Fc/UbYnU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 53A3F1F00893;
	Tue,  6 Oct 2026 07:43:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1791272604;
	bh=3p6cfcKmRgChO2intVaAL0drGkBgxC+zw3ZiZYKKVuY=;
	h=Subject:To:Cc:From:Date;
	b=Fc/UbYnUML3VdotiyOFIWkaLeoAF8VOZG4q4a8pQAGs1aXWYuom+4BegvQs8U5ku9
	 7A76JGtJGNW+gHvASjNUSovSNyy2XvFrpz782nsAB8raHN0O22dpXyloSjP1k1dimy
	 H/tsgVPNP14p0e1NSg4CJWxUiG0xC07cycY5Zb1w=
Subject: FAILED: patch "[PATCH] iio: adc: ad_sigma_delta: fix use-after-free on unbind" failed to apply to 6.12-stable tree
To: fanwu01@zju.edu.cn,jonathan.cameron@oss.qualcomm.com,nuno.sa@analog.com,songl@zju.edu.cn
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Tue, 06 Oct 2026 09:43:20 +0200
Message-ID: <2026100620-buzz-swell-fdb1@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.12-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.12.y
git checkout FETCH_HEAD
git cherry-pick -x 9ee8306121495d2a25aa5d1bfd519f2748786b83
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026100620-buzz-swell-fdb1@gregkh' --subject-prefix 'PATCH 6.12.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 9ee8306121495d2a25aa5d1bfd519f2748786b83 Mon Sep 17 00:00:00 2001
From: Fan Wu <fanwu01@zju.edu.cn>
Date: Wed, 23 Sep 2026 09:48:07 +0000
Subject: [PATCH] iio: adc: ad_sigma_delta: fix use-after-free on unbind
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

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

diff --git a/drivers/iio/adc/ad_sigma_delta.c b/drivers/iio/adc/ad_sigma_delta.c
index 1b410291da53..119ddc5a13e2 100644
--- a/drivers/iio/adc/ad_sigma_delta.c
+++ b/drivers/iio/adc/ad_sigma_delta.c
@@ -498,7 +498,6 @@ static int ad_sd_buffer_postenable(struct iio_dev *indio_dev)
 	const struct iio_scan_type *scan_type = &indio_dev->channels[0].scan_type;
 	struct spi_transfer *xfer = sigma_delta->sample_xfer;
 	unsigned int i, slot, channel;
-	u8 *samples_buf;
 	int ret;
 
 	if (sigma_delta->num_slots == 1) {
@@ -530,7 +529,7 @@ static int ad_sd_buffer_postenable(struct iio_dev *indio_dev)
 		xfer[1].bits_per_word = scan_type->realbits;
 		xfer[1].len = spi_bpw_to_bytes(scan_type->realbits);
 	} else {
-		unsigned int samples_buf_size, scan_size;
+		unsigned int scan_size;
 
 		if (sigma_delta->active_slots > 1) {
 			ret = ad_sigma_delta_append_status(sigma_delta, true);
@@ -538,17 +537,6 @@ static int ad_sd_buffer_postenable(struct iio_dev *indio_dev)
 				return ret;
 		}
 
-		samples_buf_size =
-			ALIGN(slot * BITS_TO_BYTES(scan_type->storagebits),
-			      sizeof(s64));
-		samples_buf_size += sizeof(s64);
-		samples_buf = devm_krealloc(&sigma_delta->spi->dev,
-					    sigma_delta->samples_buf,
-					    samples_buf_size, GFP_KERNEL);
-		if (!samples_buf)
-			return -ENOMEM;
-
-		sigma_delta->samples_buf = samples_buf;
 		scan_size = BITS_TO_BYTES(scan_type->realbits + scan_type->shift);
 		/* For 24-bit data, there is an extra byte of padding. */
 		xfer[1].rx_buf = &sigma_delta->rx_buf[scan_size == 3 ? 1 : 0];
@@ -855,6 +843,23 @@ int devm_ad_sd_setup_buffer_and_trigger(struct device *dev, struct iio_dev *indi
 
 		indio_dev->setup_ops = &ad_sd_buffer_setup_ops;
 	} else {
+		const struct iio_scan_type *scan_type =
+			&indio_dev->channels[0].scan_type;
+		unsigned int samples_buf_size;
+
+		/*
+		 * Worst-case size: all sequencer slots can be active, capped
+		 * at num_slots by ad_sd_validate_scan_mask().
+		 */
+		samples_buf_size =
+			ALIGN(sigma_delta->num_slots *
+			      BITS_TO_BYTES(scan_type->storagebits),
+			      sizeof(s64));
+		samples_buf_size += sizeof(s64);
+		sigma_delta->samples_buf = devm_kzalloc(dev, samples_buf_size, GFP_KERNEL);
+		if (!sigma_delta->samples_buf)
+			return -ENOMEM;
+
 		ret = devm_iio_triggered_buffer_setup(dev, indio_dev,
 						      &iio_pollfunc_store_time,
 						      &ad_sd_trigger_handler,

