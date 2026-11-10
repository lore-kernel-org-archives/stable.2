Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794316224;
	b=AWWvz7Vjnj/MD/cplUcW3S7Ib7jAr75j1Ux0KWtnp8yNmCrx/PyDSsRKK+0w7GeNafjz
	 9K2rBQtI5S2Bul4wqGsyWf2yWM3qyowxaeZdK1sVj+chOhOBGSHlzxOpytWVeqVvAZf5t
	 8wrpgDPSYv8g/Je/+D/pKXyaMtWAsJYF+Q04x2NueygJabwfx45ywkxhpEC+89eXGOeo2
	 XgUl7DKkpJ4r8JC29kXy5zvvKUjHiC6z60NcB10VZshG3yL9KsYBvysWh0+6mPvM0wCMi
	 H6OI15kHQ1LqVZA4o9HoZhiMWZstvnnl7zOOr7pE/Q1ZIDPDRMPxKmg6SuBZZWNYKhA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794316224;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:References:
	 In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:
	 X-Endpoint-Received;
	bh=AnHw7XXRUHp9Mp0ZPEBPnMwy+2oxoVKw7fR1LwyvpIo=;
	b=qohRidahAIScct9iOhnob6+aXEUoatF9z7iXLfhyrbfjonEsYaHDUzl6QPnMRiisLc4x
	 FbHFv/be/8LUAKKjBZ214XHDdkU6Bg/8tXwHEvHU6y+UhjBjPa8AdVfNxFjQrdzCDmsOU
	 VuuZbQlCMA4pOHSRd8dNl5DRXGuy12YbSxSHUsXUz69jpyTeBt7vd9o0t9ehlkQf2odsC
	 cqxStVeo5EcCel2Jn26DZd/TF7z0WnTLPvQFbuVnIDwcZURGYcd3cF2UeCPOoyvNLHlHa
	 xQq5t29bbOtEjXOS+pULMNmrM1Z4cugIHOS94lbxLfOyYgEKrnrqgKskF8RinD71BSg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=korg header.b="UeOo/oFt";
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB550606A776;
	Tue, 10 Nov 2026 13:10:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=korg header.b=UeOo/oFt
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1794316223;
	b=gnCnQbfGFYwtS/f5PM7iVFVnO3iwpEgeNQLYScusesT1xtzY9GaDui8J9E62VTTZT/h6
	 qXFauVZ26Ci2x8ekk+lUrWNH3PQ3WgpmhifEeSrdLgVPkOVflcPYT8UqmpRkTNoEeGOe5
	 xJLrGeeM8EvNnqFpyQ6Spef0Ek21NXrf8FcVuvT2J9XUiGMdtiApE/xAH3LQ3F+CLeCex
	 DQ3i/2uSxsvX0816kwasZo/rRBDcv5CjGnvRpvIi4k8xmPE9kiDI5v5oDjY56M7XJAZiq
	 YF7sCFh9Zqk4S4KZXLyp1em+C8Ku4xkjBtByU7TytfzvSiMwHYz+2jsLNUPd8Y1dFqA==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1794316223;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key:X-Endpoint-Received;
	bh=AnHw7XXRUHp9Mp0ZPEBPnMwy+2oxoVKw7fR1LwyvpIo=;
	b=uD/PaVEYK+HIVj7eZ8w1lCUwkqrpfuoiOH3x7/TUOShy+DRT+t7+vF/J2iYHvGy5IkrF
	 tqY2jWDvR92JdXKWK933pOB2LDskNgBHZh9U1JDh7aQrp5dS/aVj8FsgdLtq5Tlr5qT1K
	 6YdxKvEDQToynPnXITmNoIzxpxkZQSCJjheNq2a8ss3Kop+DM29/7VnPw0frx1cwhWxYM
	 gbZUPhQfKesJWDQDZIW0JYQbCDgApa8bjpV+PMlqp3R83T+vv405QMPT27PN8jkR7bbWo
	 GafC5MLlypovKjU8PDXouGiVMq3iOuB4CFAb1x/HwgGuwQOKj6oNF67jPX5NUORX8ug==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 782341F008A3;
	Tue, 10 Nov 2026 13:10:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=korg;
	t=1794316223; bh=AnHw7XXRUHp9Mp0ZPEBPnMwy+2oxoVKw7fR1LwyvpIo=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=UeOo/oFt6DmjMV9mNkp98srMuU5js9JpxKjS/gh8MBLiorKlfzj6l2AOT9eRnREIA
	 yz37ErYRwTtb6SXNSeQPl4mYm2H3mFZCaU849tWNgv0Lru76mzYUUWagxTQY7wRnWT
	 Cp1lnL8rpC4Qi5O5GWHmaf97Bq5bv7BtgdM2Dq9I=
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 013B148B6A;
	Tue, 10 Nov 2026 13:10:21 +0000 (UTC)
From: Richard Leitner <richard.leitner@linux.dev>
Date: Tue, 10 Nov 2026 14:10:11 +0100
Subject: [PATCH v3 2/8] media: i2c: ov9282: fix pixel rate and line time
 calculation
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
Content-Transfer-Encoding: 8bit
Message-Id: <20261110-ov9282-fixes-v3-2-cb6df80cbc22@linux.dev>
References: <20261110-ov9282-fixes-v3-0-cb6df80cbc22@linux.dev>
In-Reply-To: <20261110-ov9282-fixes-v3-0-cb6df80cbc22@linux.dev>
To: Sakari Ailus <sakari.ailus@linux.intel.com>, 
 Dave Stevenson <dave.stevenson@raspberrypi.com>, 
 Mauro Carvalho Chehab <mchehab@kernel.org>, 
 Daniele Alessandrelli <daniele.alessandrelli@gmail.com>, 
 "Paul J. Murphy" <paul.j.murphy@intel.com>, 
 Martina Krasteva <martinax.krasteva@intel.com>, 
 Richard Leitner <richard.leitner@linux.dev>, 
 Hans Verkuil <hverkuil+cisco@kernel.org>, Bryan O'Donoghue <bod@kernel.org>, 
 Jacopo Mondi <jacopo@jmondi.org>
Cc: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>, 
 Gyula Kelemen <gyula.kelemen@advasolutions.com>, 
 linux-media@vger.kernel.org, linux-kernel@vger.kernel.org, 
 stable@vger.kernel.org
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794316220; l=4128;
 i=richard.leitner@linux.dev; s=20250225; h=from:subject:message-id;
 bh=vEUkcmhrgbccMnrDYbK6Bg1byQZHGlfGlZNdCKAMiuU=;
 b=mEqQuSHLSwfITSoGjXfDyvKub52W7OZOymcD+YY09BUBQkTWVW01eU4cOX0ErxhtOY+8AXVHQ
 cSx2x3kBY2zD2N3Zrmda0yGMKy20sl4bqgqg9rMicZnP7GSLjf/Wdt4
X-Developer-Key: i=richard.leitner@linux.dev; a=ed25519;
 pk=8hZNyyyQFqZ5ruVJsSGBSPIrmJpfDm5HwHU4QVOP1Pk=
X-Endpoint-Received: by B4 Relay for richard.leitner@linux.dev/20250225
 with auth_id=350

The OV9282_PIXEL_RATE_8BIT is calculated incorrectly from the
OV9282_LINK_FREQ. The hardware scales the pixel rate by changing the
multiplier from 0x50 (for 10 bit) to 0x60 (for 8 bit). Resulting in a
x1.2 factor.

The current OV9282_PIXEL_RATE_8BIT calculation scales from /10
(for 10 bit) to /8 (for 8 bit). This results in a x1.25 factor.

As all the inputs to the pixel rate calculation are constant in this
driver also define the OV9282_PIXEL_RATE_{8,10}BIT as constants.
Additionally introduce a new function to calculate the current
line time in nanoseconds and use it in ov9282_exposure_to_us().

Kudos to Dave Stevenson for pointing me into the right direction!

Link: https://lore.kernel.org/linux-media/CAPY8ntBaSHjztuSLTOtv9KYvEbmcbinSMJ78ZDg+0sZg-1fz3Q@mail.gmail.com/
Fixes: df60764ea5210 ("media: i2c: ov9282: dynamic flash_duration maximum")
Fixes: 43ac0cac18f41 ("media: i2c: ov9282: Add support for 8bit readout")
Cc: stable@vger.kernel.org
Reviewed-by: Dave Stevenson <dave.stevenson@raspberrypi.com>
Signed-off-by: Richard Leitner <richard.leitner@linux.dev>
---
 drivers/media/i2c/ov9282.c | 50 +++++++++++++++++++++++++++++++++-------------
 1 file changed, 36 insertions(+), 14 deletions(-)

diff --git a/drivers/media/i2c/ov9282.c b/drivers/media/i2c/ov9282.c
index 546b43c209097..d60396e46ab0f 100644
--- a/drivers/media/i2c/ov9282.c
+++ b/drivers/media/i2c/ov9282.c
@@ -10,10 +10,12 @@
 #include <linux/delay.h>
 #include <linux/i2c.h>
 #include <linux/math.h>
+#include <linux/math64.h>
 #include <linux/module.h>
 #include <linux/pm_runtime.h>
 #include <linux/regmap.h>
 #include <linux/regulator/consumer.h>
+#include <linux/time64.h>
 
 #include <media/v4l2-cci.h>
 #include <media/v4l2-ctrls.h>
@@ -111,11 +113,14 @@
 #define OV9282_LINK_FREQ	400000000
 #define OV9282_NUM_DATA_LANES	2
 
-/* Pixel rate */
-#define OV9282_PIXEL_RATE_10BIT		(OV9282_LINK_FREQ * 2 * \
-					 OV9282_NUM_DATA_LANES / 10)
-#define OV9282_PIXEL_RATE_8BIT		(OV9282_LINK_FREQ * 2 * \
-					 OV9282_NUM_DATA_LANES / 8)
+/*
+ * Pixel rate: Derived from the PLL2 clock tree.
+ * For 10 bit it's exactly the same as the sample PLL configuration.
+ * For 8 bit the PLL2 multiplier (REG_PLL_CTRL_0D) is changed 0x50 -> 0x60,
+ * which results in x1.2 and therefore 160 MHz x 1.2 = 192 MHz.
+ */
+#define OV9282_PIXEL_RATE_10BIT	160000000
+#define OV9282_PIXEL_RATE_8BIT	192000000
 
 /*
  * OV9282 native and active pixel array size.
@@ -472,6 +477,32 @@ static inline struct ov9282 *to_ov9282(struct v4l2_subdev *subdev)
 	return container_of(subdev, struct ov9282, sd);
 }
 
+/**
+ * ov9282_line_time_ns() - Calculate duration of one sensor line.
+ * @ov9282: pointer to ov9282 device
+ *
+ * Return: line time in nanoseconds.
+ */
+static u32 ov9282_line_time_ns(struct ov9282 *ov9282)
+{
+	u64 hts = ov9282->cur_mode->width + ov9282->hblank_ctrl->val;
+
+	return div_u64(hts * NSEC_PER_SEC, *ov9282->pixel_rate->p_cur.p_s64);
+}
+
+/**
+ * ov9282_exposure_to_us() - Convert an exposure register value to microseconds
+ * @ov9282: pointer to ov9282 device
+ * @exposure: exposure register value to convert
+ *
+ * Return: microsecond representation of the given exposure register value.
+ */
+static u32 ov9282_exposure_to_us(struct ov9282 *ov9282, u32 exposure)
+{
+	return div_u64((u64)exposure * ov9282_line_time_ns(ov9282),
+		       NSEC_PER_USEC);
+}
+
 /**
  * ov9282_update_controls() - Update control ranges based on streaming mode
  * @ov9282: pointer to ov9282 device
@@ -510,15 +541,6 @@ static int ov9282_update_controls(struct ov9282 *ov9282,
 					mode->vblank_max, 1, mode->vblank);
 }
 
-static u32 ov9282_exposure_to_us(struct ov9282 *ov9282, u32 exposure)
-{
-	/* calculate exposure time in µs */
-	u32 frame_width = ov9282->cur_mode->width + ov9282->hblank_ctrl->val;
-	u32 trow_us = frame_width / (ov9282->pixel_rate->val / 1000000UL);
-
-	return exposure * trow_us;
-}
-
 /**
  * ov9282_update_exp_gain() - Set updated exposure and gain
  * @ov9282: pointer to ov9282 device

-- 
2.53.0


