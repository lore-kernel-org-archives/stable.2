Received: from azure-sdnproxy.icoremail.net (azure-sdnproxy.icoremail.net [52.187.6.220])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB0484756C3;
	Wed, 23 Sep 2026 09:49:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.187.6.220
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790156954; cv=none; b=Qq6fuuuZjsK1AQtsw/ZhTx7HH46a2//g+aVvLU1IToIY9v9V0ZixsavJV0by3oaCAuNwSxmWyGZd1GojmR3Xx3TxtXbh6y0XtBXOOJHS5dySfbEOCDWbak6Z7UIr+9u42oa+k72UDHyzLEARE8Ofk7Lx8WBS6mAq2XSKhW3ndhM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790156954; c=relaxed/simple;
	bh=onO0Jdhy+n/YPKxtxMu+68vh5d+rvCqvu72aSYGTGzw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=s32/xHsW5TA+HtLW+ti2TSiweH8gUr2VnJNs/eWRN5wJUBKrLybsZGp9RSzyMme2rzMeG4OBenn8U0l8O+o+3BiTYHSIzcf9U/Ygw4ZfelEX4cTg2FwKxtdzaxwMSBYBjEuo0ylh4qb0a0gRWZzemT8X/EsarWoDi7bDQ4YC4Js=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zju.edu.cn; spf=pass smtp.mailfrom=zju.edu.cn; arc=none smtp.client-ip=52.187.6.220
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zju.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zju.edu.cn
Received: from zju.edu.cn (unknown [10.98.66.117])
	by mtasvr (Coremail) with SMTP id _____wCnkH6PoLNqJVExAQ--.7129S3;
	Wed, 23 Sep 2026 17:49:04 +0800 (CST)
Received: from localhost.localdomain (unknown [10.98.66.117])
	by mail-app2 (Coremail) with SMTP id zC_KCgDHFMmOoLNqwoWWBA--.41472S2;
	Wed, 23 Sep 2026 17:49:02 +0800 (CST)
From: Fan Wu <fanwu01@zju.edu.cn>
To: Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>
Cc: linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Song Li <songl@zju.edu.cn>,
	Fan Wu <fanwu01@zju.edu.cn>
Subject: [PATCH] iio: adc: ad_sigma_delta: fix use-after-free on unbind
Date: Wed, 23 Sep 2026 09:48:07 +0000
Message-Id: <20260923094807.503690-1-fanwu01@zju.edu.cn>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:zC_KCgDHFMmOoLNqwoWWBA--.41472S2
X-CM-SenderInfo: qrstjiaswqq6lmxovvfxof0/
X-CM-DELIVERINFO: =?B?ahvVegXKKxbFmtjJiESix3B1w3vZ3A9ovKVTomAyoQazvoRs/NHSP8GI2EvgeEEW7R
	sfncGSG+szpQCInt5Y8rbJUI1PLYSSMdIkt6yCgFAlM7AW1+TnRYI0sOKfrB+5X2+zr7oF
	RbxLB0yqqPXBTpWut0Gp9E6mavGmQbzmcFsnzP86
X-Coremail-Antispam: 1Uk129KBj93XoWxXrWfKry8ArWDAF1DKF4Utrc_yoWrGryUpF
	Z3Kr1xCrWUXF1fXF1jvasY9Fy5twsrWr4UKF4av34I9wn8Zr9YgFyj9ryftFWrAr92yrsr
	tws5Jw4UWF1xtFXCm3ZEXasCq-sJn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUU9Cb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AK
	xVW0oVCq3wAac4AC62xK8xCEY4vEwIxC4wAS0I0E0xvYzxvE52x082IY62kv0487Mc804V
	CY07AIYIkI8VC2zVCFFI0UMc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AK
	xVWUJVWUGwAv7VC2z280aVAFwI0_Gr0_Cr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48Icx
	kI7VAKI48JM4x0Y48IcxkI7VAKI48G6xCjnVAKz4kxMxAIw28IcxkI7VAKI48JMxC20s02
	6xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_Jr
	I_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v2
	6r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVWUJVW8JwCI42IY6xAIw20EY4v20xvaj4
	0_Jr0_JF4lIxAIcVC2z280aVAFwI0_Gr0_Cr1lIxAIcVC2z280aVCY1x0267AKxVW8Jr0_
	Cr1UYxBIdaVFxhVjvjDU0xZFpf9x07jeAp5UUUUU=

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
---
 drivers/iio/adc/ad_sigma_delta.c | 32 +++++++++++++++++++-------------
 1 file changed, 19 insertions(+), 13 deletions(-)

diff --git a/drivers/iio/adc/ad_sigma_delta.c b/drivers/iio/adc/ad_sigma_delta.c
index 1b41029..4f982c6 100644
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
@@ -855,6 +843,24 @@ int devm_ad_sd_setup_buffer_and_trigger(struct device *dev, struct iio_dev *indi
 
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
+		sigma_delta->samples_buf =
+			devm_kzalloc(dev, samples_buf_size, GFP_KERNEL);
+		if (!sigma_delta->samples_buf)
+			return -ENOMEM;
+
 		ret = devm_iio_triggered_buffer_setup(dev, indio_dev,
 						      &iio_pollfunc_store_time,
 						      &ad_sd_trigger_handler,

