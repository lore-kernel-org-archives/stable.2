Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.49
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792695441;
	b=uKnx95RKEf7WJR4tuAZdTHbBO8mbmMOQhP6ttjG5g8vZE3rIk01zCwDVUtbem98MDM2U
	 fmMPMHu45ne+go9vuaPQisVYvN/iO9MWO2Avybmw8EMOTCm4C4HbZxBPwZ65bPOV09gmB
	 PQq8bSyW83e4EP3mBCjEpTHVifMC8FujhatG8DvaQfQXEv5ZWTKgIX8v7Bxs6TBQpCp7G
	 QSANXyirCUTkfTT+KdlADJWaViAr0C4LuYK+uQFZR+IjPMf1ybLa8MgmtnD0Y9FNlJ/Rb
	 6ZROrUWxuOxdu+37mN104JxxDHHTT4ZJT0p2Mi3jg9JGI4ydub7KmFkO2R0kr5PJ4Bg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792695441;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer;
	bh=k6t6hNWD/TCa3KhqajK3ikKYHbg8LQCXp5YTHqmRyGM=;
	b=aPV7Ypjbo2gX1FBLfmTAz1+H/FVgyPt+sNNr39E2ZT1rGN5qnKtgx8wwqV1kprrbPOYE
	 IeQo8a+OXelMFMukSXEt08pbtr68xnrBkRT1aogGLyHSQUiptZWN/LbJq5n2Gi4O/7A6P
	 1u0AZIHF+kOsRqztFew40fRCTkCOWDYxTepYvosLU0c34oXpOK3NbnoGGy8pAvLYEzfqO
	 ZQCtl8qhs6oK4gcpXup7qVBI5b52y+QpWNudGvUdQdOHgBelHmCfnfjPsA7lfjmMYZfUn
	 th37YDkXtXzVSO0UpthGT5es3d6qS4gB9Jk72vExzXg0kF+Z+VrHcfc00nmiSpaFwWg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=MLzRKjna;
	arc=none smtp.remote-ip=209.85.128.49
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9730B606A324
	for <stable@vger.kernel.org>; Thu, 22 Oct 2026 18:57:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9730B606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=MLzRKjna
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-4a1dede3c2cso1491485e9.2
        for <stable@vger.kernel.org>; Thu, 22 Oct 2026 11:57:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792695440; x=1793300240; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=k6t6hNWD/TCa3KhqajK3ikKYHbg8LQCXp5YTHqmRyGM=;
        b=MLzRKjna5tBlkK/Gjzbdvr9H5iYwVtu4YaemWrVLYuqP0k0eQXsYf4jp+ayNbNLacE
         Ry9e1xaNZwDTFONAUWYZe0feqk3Mb0ndNDRTyIBoLpxbM7y9QTmHn1RAtNGC5PMjNiZk
         6wZ8uMoEwwimYxC7pT1mFoVccRZQHgTAiNBWTwq7xhGTiY2pW5lJ1JJzUpI/iLIM/I9N
         O+aXcqYNwj8ZW7q6deN8xrp6RqmCilmWhWi8OaPHau8yY87dowJ3LoQ42dpMFMZm3k45
         2gGSWqsTnbeTYNgRMl9kKi9WhTWauHso7D6F4kfyGRw52msBzGzL3W9HHY43DA1dfwlM
         XmDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792695440; x=1793300240;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=k6t6hNWD/TCa3KhqajK3ikKYHbg8LQCXp5YTHqmRyGM=;
        b=QAzwuUVa8XaBRBnhpO/Hq9ZirEmfDlfsrwfBmzlIpk0XR9Pi84jtaPo9aBhSM+/vc2
         UCrsKoJQA/5kQBGtR0e96XXedXXtyU8Wu/c8cF88ZLVuLn4BArweGimjCRe5cSJ6VV/G
         m7eFH1ljoF8y3QKSaGpvN6cKthIEHl4sbKhHzI7eaIasS7i4ZyoKq3BqFTj3lenNqAHB
         78rKL8W3xThIYx9DpnjSumLDz8r4xsdxHcCNAf7+/l64MHPExM1h7XN9vcQEYABnCaPZ
         lEkqvFkKevyZfQioedjRp26K71h2P3tha4Z81Cw0aQ4S3dgz4yF7HCCRhJjaprfQWUTN
         ipMg==
X-Forwarded-Encrypted: i=1; AKwUvBxYxjq44Xpep17kZRije8gu8ABDc7Omq13+AdonBgv4VcrvKW1SDN87oA2g0kAkFq6wcwTrmVM=@vger.kernel.org
X-Gm-Message-State: AFq9FYJ56QYz4B/TOUaP35e6X//wmlHjX7R8yYijGr+K++mg0wmNzYop
	d6sxmkbNQHqpcO1NpoxrFNbtEi90361Md1EPEoTFZ1uc/BCrxMKrXR/w
X-Gm-Gg: AYBFou2889nfbtR0h67M+uSzseM7gTJw3W2F7qEqnn89IH6KdxljNk0m5DJ9YK6Bn2k
	cpqSrmVVJG5Lm91UQzB8pIoYl5bgMq6d1D18nhNkJyM1+5BC551PtYLP81YQVZYJx4YK+CzZsZI
	TFc3/A8AkF4QyR8zWYB0oTxmhttEqvNYuTKt4Qt2Eo8gfLgSPn0fdRxfkWspfodoWYtCfEBnTBd
	Al80qoOhImG8TbMKb0T8xHY4lOutYOtIkkMKZuzXKuiWF3SRXOfSvd57JtByf/FBxzfjvffFr0D
	tbAyBgmGn3qyCi6l6EmWBP+MrnFl/mtRqYloxuxQ6IW85Fm0h+4RifXBwjyHBDu+5qxkfxRp7+3
	MfWx/HjCEpsFVxvkhJBZdKdO0rIYujGVKW67u3NQlysaKOWClt2Rgs9nLMViRZ1JuqtJtbfFqbM
	eQ44YIzQle+Su9Zpil7eRTmzAvg/gI9LQyS8jR93JtayNAXw9P/tQ8H2ae2kEG0T6bGxfQQkXfP
	EiiZMFz7li1Y9z6PXNU1dMLWF16W+oB2CYKODAdGRwF2FYHZYVhp5+1EtUiAToMB4WhtRl+eSg=
X-Received: by 2002:a05:600c:a0b:b0:4a1:7bae:d80a with SMTP id 5b1f17b1804b1-4a1fdd245bcmr119483665e9.9.1792695439903;
        Thu, 22 Oct 2026 11:57:19 -0700 (PDT)
Received: from localhost ([2a02:8308:b092:fd00:d900:ff27:14a1:f032])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e379f0695sm162442f8f.37.2026.10.22.11.57.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Oct 2026 11:57:19 -0700 (PDT)
From: Jan Remes <ciakval@gmail.com>
Date: Thu, 22 Oct 2026 20:56:40 +0200
Subject: [PATCH v4 1/4] iio: light: tsl2591: don't divide by zero
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261022-first-patch-v4-1-90b2fc6e8e28@mycroftmind.com>
References: <20261022-first-patch-v4-0-90b2fc6e8e28@mycroftmind.com>
In-Reply-To: <20261022-first-patch-v4-0-90b2fc6e8e28@mycroftmind.com>
To: Jonathan Cameron <jic23@kernel.org>, 
 David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>, Joe Sandom <joe.g.sandom@gmail.com>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Jan Remes <jan.remes@mycroftmind.com>, Jonathan Cameron <jic23@kernel.org>, 
 stable@vger.kernel.org, Martin Triska <martin.triska@mycroftmind.com>, 
 Andy Shevchenko <andriy.shevchenko@intel.com>
X-Mailer: b4 0.16.0

From: Jan Remes <jan.remes@mycroftmind.com>

The TSL2591 has two raw light channels - CH0 and CH1. The algorithm for
calculating illumination from the raw channels requires division by CH0
(which can be zero) and by "counts per lux" (CPL) value which is also zero
for (gain = LOW, integration time <= 400 ms).

Furthermore, the algorithm assumes CH0 > CH1, which can be violated in
almost complete darkness.

As a result, reading from 'in_illuminance_input' results in
division-by-zero whenever CH0 is 0 (complete darkness) or whenever the
parameters result in CPL being zero. This results in kernel oops on
x86_64 and in reading the value as 0 on arm64.

Fix that by:
- reporting CH0 <= CH1 as zero (catches also CH0 = 0)
- updating the lux algorithm to only do the division at the end

Fixes: 2335f0d7c790 ("iio: light: Added AMS tsl2591 driver implementation")
Cc: stable@vger.kernel.org
Reported-by: Martin Triska <martin.triska@mycroftmind.com>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>
Signed-off-by: Jan Remes <jan.remes@mycroftmind.com>
---
 drivers/iio/light/tsl2591.c | 32 ++++++++++++++++++++++----------
 1 file changed, 22 insertions(+), 10 deletions(-)

diff --git a/drivers/iio/light/tsl2591.c b/drivers/iio/light/tsl2591.c
index ef3ed9635a1e..f56d31404c25 100644
--- a/drivers/iio/light/tsl2591.c
+++ b/drivers/iio/light/tsl2591.c
@@ -16,6 +16,7 @@
 #include <linux/interrupt.h>
 #include <linux/iopoll.h>
 #include <linux/kernel.h>
+#include <linux/math64.h>
 #include <linux/module.h>
 #include <linux/mutex.h>
 #include <linux/pm_runtime.h>
@@ -362,6 +363,10 @@ static int tsl2591_wait_adc_complete(struct tsl2591_chip *chip)
  * Scale values to get more representative value of lux i.e.
  * lux = ((C0DATA - C1DATA) * (1000 - ((C1DATA * 1000) / C0DATA))) / CPL
  *
+ * CPL is not computed on its own: at 1x gain it is below 1 for integration
+ * times under 500 ms, so the division by LUX DF is folded into the final
+ * division instead.
+ *
  * Channel 0 = IR + Visible
  * Channel 1 = IR only
  */
@@ -373,8 +378,10 @@ static int tsl2591_read_channel_data(struct iio_dev *indio_dev,
 	struct tsl2591_als_settings *settings = &chip->als_settings;
 	struct i2c_client *client = chip->client;
 	u8 als_data[TSL2591_NUM_DATA_REGISTERS];
-	int counts_per_lux, int_time_fval, gain_multi, lux;
+	int int_time_fval, gain_multi;
 	u16 als_ch0, als_ch1;
+	u64 lux;
+	u32 rem;
 	int ret;
 
 	ret = tsl2591_wait_adc_complete(chip);
@@ -410,23 +417,28 @@ static int tsl2591_read_channel_data(struct iio_dev *indio_dev,
 			return gain_multi;
 		}
 
-		int_time_fval = TSL2591_FVAL_TO_MSEC(settings->als_int_time);
-		/* Calculate counts per lux value */
-		counts_per_lux = (int_time_fval * gain_multi) / TSL2591_LUX_COEFFICIENT;
+		/* No visible light, this also catches C0DATA == 0 */
+		if (als_ch0 <= als_ch1) {
+			*val = 0;
+			*val2 = 0;
+			break;
+		}
 
-		dev_dbg(&client->dev, "Counts Per Lux: %d\n", counts_per_lux);
+		int_time_fval = TSL2591_FVAL_TO_MSEC(settings->als_int_time);
 
 		/* Calculate lux value */
-		lux = ((als_ch0 - als_ch1) *
-		       (1000 - ((als_ch1 * 1000) / als_ch0))) / counts_per_lux;
+		lux = (u64)(als_ch0 - als_ch1) *
+		      (1000 - ((als_ch1 * 1000) / als_ch0)) *
+		      TSL2591_LUX_COEFFICIENT;
+		lux = div_u64(lux, int_time_fval * gain_multi);
 
-		dev_dbg(&client->dev, "Raw lux calculation: %d\n", lux);
+		dev_dbg(&client->dev, "Raw lux calculation: %llu\n", lux);
 
 		/* Divide by 1000 to get real lux value before scaling */
-		*val = lux / 1000;
+		*val = div_u64_rem(lux, 1000, &rem);
 
 		/* Get the decimal part of lux reading */
-		*val2 = (lux - (*val * 1000)) * 1000;
+		*val2 = rem * 1000;
 
 		break;
 	default:

-- 
2.53.0

