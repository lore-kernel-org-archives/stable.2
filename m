Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794837047;
	b=pfC0WsQhsTE2Mgd1ihXb3MhJ2CwgteOu0DYQCpRd5NKSCZt82pDgy2kX69K2zx0xoEZm
	 arqiDhJZ8/Cscb/JwgPr2J16PgJnJz53H30lF2uLziWYz/BgCAVF5PSaPrb8ak3qOJN3E
	 RXPA9RiP8dKT9F4WQUodW9B1ZYXN6hvrczGX4rGV3tytenZNWyk61gjBQg1H7Rbiey9BS
	 Oc9JtQ3SLkUygRCp97jjUR6TX+OxMxMbUlRVDIq4N0e4GqZlDGynvNGzmt0JVTl1fTLKl
	 cWfTXz0/XhbewKNGZWa92qJt0nIwDONwb1y1uVC/tVrhZNngF0fAuQn92ROkO3N6TuA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794837047;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:References:
	 In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:
	 X-Endpoint-Received;
	bh=AnHw7XXRUHp9Mp0ZPEBPnMwy+2oxoVKw7fR1LwyvpIo=;
	b=GWFP1dUuyF8Dv1jdq6ITG+Aezx6qNl4GAF9t1M5KsjPLjLaGxAH5Fp5XfP3+yZyweMgv
	 CXG1o7jr2lxfM1Hzw6vQWYNh2qdIWdCUNBgfdvSR7UvC01vQkYMIwAZEl0ZZLZCs/TH5y
	 5s23NnJTvMtJk/5FN+o/1JVztYD5wNex6/nLhxTNibgKLwDAApjeC5mKU4Pqj7UA2Kt94
	 /xNQVo4sf6vk8zeGcUopK3GGRhWcNfOxFMtd3Vqc+VmyN8aQqaKhhDHXxL54imMhdQu28
	 R8BPo3q7hfU9qxuFNKSJfYaycn62KemKigG6bX67LQtLlM7q3fj0VWtbgWOd/0IPFdw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=korg header.b=OXzhkJ21;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99F9760A3819;
	Mon, 16 Nov 2026 13:50:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=korg header.b=OXzhkJ21
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1794837047;
	b=D+rtPd3Aue+tqmoBmMjTuBPQBho8Z8I1UKRf66DhkDbftBFiT4IFnCsFrq8g6xNxmZsi
	 xBfIw74QthvzUiVYmJ26luXhk041CBZOwWdtoYNxf+ayAFqFv2Yewju+JtEksT1+RfdMK
	 +HrHApIoPcSkxCVmUBbcnjk4CFsgp2PMB5/UQsBuibRVqvHMEkO/zllMPZY1WAqA5RRjZ
	 8LIVUxWDvbsjAPh0CkmKzqK8XQtt7l0nwVOXpXgk565Ku+txuPFQcuQO4+IY+wo0PAI5C
	 7O2Ut8li35ztJ4zpdjwypWI7LORqwBxO5iCn6S0S1nyJgE0CwBvy3qmqXhfRRfm7CeQ==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1794837047;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key:X-Endpoint-Received;
	bh=AnHw7XXRUHp9Mp0ZPEBPnMwy+2oxoVKw7fR1LwyvpIo=;
	b=Fv9HWNjLHRXdrOMCVcf8CGO/J/DMFveBIoILWLg8/BBhgx1D/QaAb+au1pN/SFgB1Drc
	 5Crlap4wwogS1tIma1aqvfnNI7OHinF2NowezPrB4KEUUegVJMobJqpQBV6xD0C7wbdBr
	 mDgofjFodWczmH/0tc3SMATLlBdpm6dr290YxcjugFMwb+2/vJr4XcTMezssl3TJszn0p
	 nj2jYoyiuGsqNEHJJ9VFEhDcoLj/BLmsaFjHPGajfUTQautlkekcdmc8EMLgZCWgLATVz
	 fK9PbzoozsBGMkFp5v3nnhu2bORRhv/0acpsbY6NdUNh3sUqC/C2W90F83V/Fn8LMOA==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 550641F000C9;
	Mon, 16 Nov 2026 13:50:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=korg;
	t=1794837047; bh=AnHw7XXRUHp9Mp0ZPEBPnMwy+2oxoVKw7fR1LwyvpIo=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=OXzhkJ21h3GAJscp8lFQszj+Ft//QWB0vW2QS2N1FLLML+AAAfTZE6XWfA8k/Hyf8
	 ygi+3FC2ra/2cGAqy1igFhRMyjFXKaM5Ifu9NWIvfJcn72whsXPiGrF7X+grVN2OFB
	 C5c0STEmXpYVz3ZCMi9WplYJVsIJl56brxkd8nqo=
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id D18674A497;
	Mon, 16 Nov 2026 13:50:43 +0000 (UTC)
From: Richard Leitner <richard.leitner@linux.dev>
Date: Mon, 16 Nov 2026 14:50:23 +0100
Subject: [PATCH v4 2/8] media: i2c: ov9282: fix pixel rate and line time
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
Message-Id: <20261116-ov9282-fixes-v4-2-f78e5d415c6f@linux.dev>
References: <20261116-ov9282-fixes-v4-0-f78e5d415c6f@linux.dev>
In-Reply-To: <20261116-ov9282-fixes-v4-0-f78e5d415c6f@linux.dev>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794837042; l=4128;
 i=richard.leitner@linux.dev; s=20250225; h=from:subject:message-id;
 bh=vEUkcmhrgbccMnrDYbK6Bg1byQZHGlfGlZNdCKAMiuU=;
 b=vGyppGJ3kA1UIUPhz5jsBOPT/R/tYjLegkuOjWITqiQW39aQvGFDNnhHhJtzxG1C6wqHNfjzc
 bXza5MNjxXVCFNsRl7LyhXa2S4nL9s2roKS/sUPRqK7L/CBQKxlwgxO
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


