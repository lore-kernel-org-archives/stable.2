Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.52
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792670044;
	b=vCkib7VQhS55/sIZt5w/TGZXeVdHnOKtbOkA8bVnVtvOeCL8t6YLi8QJpp6sgbuRJTpc
	 GjtfoRTZT1SB7vIF7ePUEFe3RuHIuQmzVNQmmIxHgex0Cf+GSBIusbUhTgqXMOr5XRR8w
	 OQbRtOm7I3G3X1zMgZAdPbB01ZkvPTH2fOpPBd7UL/i+2csILQiebs8z0YumD7QR92gk3
	 0WuOGrTHt/FSyU4VdR1hZ9QtaDZCSEgEE88MZhjc8qsCHTGotrF4nJpJN07OZr8uyefE5
	 WwQmuqaTzVOGicI/7KIxbqiunk00rszPAHIRHCz5FNsgvZ36bWPCJjwwqDjtR/fRB5w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792670044;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer;
	bh=YxlCmOT7eJfl7d21JfpqssCKce37H2r+MwEthBjDzno=;
	b=bmfEf4TVsoAxQWJlaw4/JwzuDaAwEdyv2bu973GlF50MnZmWhmsFn9Rz/p++aV87iufj
	 iNbp0QRA812a1hteWKZrSUXXH5AZWMc1IgLZYCPe8fL0R5elE0TEQLmKiCHuSqbm69CfC
	 BBENBRQh5vZa1tnb57Iw0WoXXGdErqAtSCDgkJD7JszlSax8NoEIaji08jTMT1yOz4X32
	 Ne7jUu063862fE9mwj8XI7BFhp9ee9Nwe65ubwBhPUNVpobQincu4F2grLdrX2tqPbma/
	 9sP26reM/2JQGmRb0DQHvyO77rceoiOkjivBYmhf5jYWzjIUqVMyPZRtPfzYANnhnIg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=ZfTRjXM5;
	arc=none smtp.remote-ip=209.85.128.52
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03564606A321
	for <stable@vger.kernel.org>; Thu, 22 Oct 2026 11:54:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 03564606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=ZfTRjXM5
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-4a1e477fe16so10591545e9.1
        for <stable@vger.kernel.org>; Thu, 22 Oct 2026 04:54:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792670042; x=1793274842; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=YxlCmOT7eJfl7d21JfpqssCKce37H2r+MwEthBjDzno=;
        b=ZfTRjXM5P/KOG3kdqzn3/eIMY8HHK9gUtAuHjAUIDLapWpNiIuwgUoJEJxL3h4cYYV
         vrV2mknc0I/VVKhroieCkxEUzVEloT1zeR/QY0hrZ1v2GWHgqmpXpRfOHQEK/NYeApaI
         G7zxxXaNMwAJdWYBAbp9OxMT0fgB8wuyycvvIg/oEWLm2jz1z2fJEY0ycaDLTQBdXFEs
         n4gT53cuqJRvjbea0+a0d3tqVJrl4SaUQVD4CvLLU79gSIGLqoTBXL9PSoiGmLdRgu7t
         5pVHm6vgT8Te5A/JNBF3q49Asr8y5fn8sznyQaikZxVyARoioC6bYdYxnskdpWqP4B0v
         mdsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792670042; x=1793274842;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=YxlCmOT7eJfl7d21JfpqssCKce37H2r+MwEthBjDzno=;
        b=Uac1uWa5wf9MOmmUsdMy6VVPPzCmhIru77IN3OLuCerGNncQd/d1NB7a/UA57Nsjj7
         zfh1ZzfqPnTVXj8rQBns2cxgd26F2AvdeOde5B+A+UNr3TALeNjnOeCo9GF+MqNJgyQ+
         pmCGQQm4haqXmKduytr89S5u8svh1NFZz3YaQkfeby1sdWAV526UxfT91y0ksKv2t/8z
         C5Yx5t419T6OO2wr+TQk1tdm+wM7mmYPD9M2o1WEltw6OcxZDgvnGcBAGglNUVvfpY2/
         gkMevRH7fjwlpPXypg3yq5HAJCr5vpSuuhS6+uYErVtJe2GwjwOQ3q2m29+ITIe08pVX
         WDqQ==
X-Forwarded-Encrypted: i=1; AKwUvBym4QGwFfuPwTrazrP7iLJ604f9BZtkF9dEpfpQ12OiF35VJcotGARXgs52wd6wexbF4WnAMvU=@vger.kernel.org
X-Gm-Message-State: AFq9FYI6awGctLZZKSexGxffCs3ISU/hERRhmVd+b2+E6eMFiae2hTy6
	hL47dLRRfKqspfS8CaygiVnAdS+nsnmyj7t5/ibsZETgC06Ia8dv+wGw
X-Gm-Gg: AYBFou1G+AJaXoMcF0KkPk0u//8Axt0aezEIuLvqMEtGDExwcJTl6nGDYSEzkXdLRep
	JYVL/1kgJUyxRDDVkGlVtaErK/ceEEnAXK40SRA6VtYzjnidtD9GD6AbzJw/V0SG5ENYexV4xZn
	JWBLjQQim6OQtVyyw+gbSCpAEq3sqwzNeYXFm85rV8JKPpk88FtrXQHcYf3ESz80wIaqjkN9rFo
	2bu8hgOQL+8LKSJl4TwWxaVSVc45MGAnD5zTh8RTW1VcVirgAdVf5od6OIIMZ67ddtZoMOJ9E5R
	ta0MqvBTV8nq4pWeNDeY8lxrOmNSTdMrc0l7PwwwISQnR/x65yX/oDzR7+M39skJwqzAK8a3piU
	N2p6OeS8Y1BOP9H3n1bRpJ86hx+X+ZwwMqLBghPkeF/QwV8xpW84oi+eyvXqPvC4Lqfto+Bj65K
	ZtBaNNZ8LFaQffnRqXveg15AIpluPNIsyP/y7keHWbXuBppn1EgF4KsC1qpRVqSeoan3M40Onwn
	66yMSuGvdV8ZyT8uFKPZz0KLq/zq4zVdQDd1daKNoduEQNDbLs4vLY8jvavDt3eflo8HR7FnjyJ
	KnL/vJXVtg==
X-Received: by 2002:a05:600c:34ce:b0:4a1:dbdf:17a8 with SMTP id 5b1f17b1804b1-4a1fd8a7d77mr102657805e9.2.1792670042298;
        Thu, 22 Oct 2026 04:54:02 -0700 (PDT)
Received: from localhost (ip-94-113-240-150.net.vodafone.cz. [94.113.240.150])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e25828ca3sm11613395f8f.25.2026.10.22.04.54.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Oct 2026 04:54:01 -0700 (PDT)
From: Jan Remes <ciakval@gmail.com>
Date: Thu, 22 Oct 2026 13:53:57 +0200
Subject: [PATCH v3 1/4] iio: light: tsl2591: don't divide by zero
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
Message-Id: <20261022-first-patch-v3-1-b792e89a429a@mycroftmind.com>
References: <20261022-first-patch-v3-0-b792e89a429a@mycroftmind.com>
In-Reply-To: <20261022-first-patch-v3-0-b792e89a429a@mycroftmind.com>
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
Assisted-by: LLM
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

