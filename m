Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794837046;
	b=2IjwKAdrKuwVwMgSc4ir2nncoFnW8YLH0pxz7gH5+LsL60kryRzUmWWv7l84lal4gkWI
	 7XM63Lq02oAsVnpvkHxGiQFwuwIa9DFYsEtY3IjNLxtobxTU5bXG8f2Sk5yeWt8y6VPMJ
	 zBudkUCmHHXG1rz3TXJkHZ8qSWF/mBoCZxvl6b31pZb9+vv9ubdKIB3IP7OhjNXrCnEmq
	 qH3pVtXPgmSGaDOzsVYHlAd+HmTbFqY10FsVhIN09e1t/Hx1xThDu8+lL8fnYzT3bYAAR
	 ersYOKW+QFR9WRpuNOX1Ia0BwYWbztH0ukZDBrXHs12ogCRiIUvQUdUiD6LryJwnqaw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794837046;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:References:
	 In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:
	 X-Endpoint-Received;
	bh=Re7W5/eKCo6eKSogzAyPlklt0Xg0EivHiisen/hp5CE=;
	b=CbWGYRKfzCcK7LAWS4opDUmU0wv42OUpa+ts5M8SK6c5Pvai2aVBR1x0y6/Eyqsu/eQB
	 kFKGpGtgRz4Wr+h1ZS/byOteC5mPYmCxov44eeJbCXyTT7tHKAoVmJfWeP1W6DbxiRa+m
	 OpOZGn4YVuxstlkxp19Gnvy6muTFjdtyKOoODVZvBdZEzSUghKuSgMUk3vxXjM7CPkkTc
	 Iq156b92xpJvpT3TMqmPF4079lImTp01FpEME/jncise+oX7iGMno5qK1ut+IvYlLOP75
	 VelE2lI7wz2/lvCw9riNIxx4/hbI4faKc5fr35pBcprtQMkVk5O8F6LX14ttIk3o+1A==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=korg header.b="15cW6/Kg";
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B03860A2606;
	Mon, 16 Nov 2026 13:50:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=korg header.b=15cW6/Kg
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1794837046;
	b=Mbze5yWJ13jvm41LF7xny+rjHTd2vR+ifZv9mtAfFdsvV4Sit2SBwBtFlfeIl6xVZKS1
	 6ISMJ4wvfG0zmYw3XHH9FurO9chJcxFGRitghSdgWawitkNnOmZ/ruRfKBevTbgBsopAQ
	 NRcyaTxoHvMkcEfF2lj8RgsokEooeIFGY+4cammCJG7+IJ2OuvWx6FbK32jMJMH3dtKi7
	 nLti2AayDrr4zjtH6LQYC56f6vCyT4mTAZnjAo8R7oSWPzIDOOzsgLGFXpF4zrK5JIHYR
	 lTF5Ax/aJD7os2MfMDMcIf/OiP7YewqUIUkANd7ryiDBl5ttk2oSJKMVl8Je6EjP4qQ==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1794837046;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key:X-Endpoint-Received;
	bh=Re7W5/eKCo6eKSogzAyPlklt0Xg0EivHiisen/hp5CE=;
	b=MsnG2bNq9jLXS+FXzM+u6bCm53HTJcz1if9ULOAelAL3ZfDqpLnxyGuBxFUmVRWQEDs5
	 amVONnuaTZvsH02cvYHHGSpYktGzzOvs+PQWeCBsH2sS5RdOe9ApDP52pw8Qxmx0V01QM
	 VsoBQde9KXPXaOs1HA19snYnjsFrrKIG9Lom2CapoUrei79pSdNWjFjydRSX73hmHszb+
	 fZddiDRSj81qWUs2CxX9TtiNRCqwizi3SXSqRkQSNvLaHC78LrkynbTncjT9msKxZ1h31
	 mMmTOfxWLODH4bBhRyKuEaiqNOD/zqjUkdYOtszcPYOeHoalVvwCVbYCs8Z0meIayhw==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 6BACF1F000CC;
	Mon, 16 Nov 2026 13:50:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=korg;
	t=1794837045; bh=Re7W5/eKCo6eKSogzAyPlklt0Xg0EivHiisen/hp5CE=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=15cW6/KgRAM1od1BKgALIdi8v2ne+F7gTOSlSVmbhiOpCxrKLQUwFYpa7octlDtWS
	 56iaXGxuLPsyRF1hSOjHO8kwah6yXbwO2t9gQxJcA6dwMteACKCp64Idtp6IC3jsBr
	 OMLh5H91ZOptc6p+D4T11g0+Akpy9cAz9Sz4301Y=
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id E82924A49B;
	Mon, 16 Nov 2026 13:50:43 +0000 (UTC)
From: Richard Leitner <richard.leitner@linux.dev>
Date: Mon, 16 Nov 2026 14:50:24 +0100
Subject: [PATCH v4 3/8] media: i2c: ov9282: fix flash duration to/from
 microseconds conversion
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
Message-Id: <20261116-ov9282-fixes-v4-3-f78e5d415c6f@linux.dev>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794837042; l=5865;
 i=richard.leitner@linux.dev; s=20250225; h=from:subject:message-id;
 bh=5YuxaPoguP/LT8COFykwKcIysxVhcpq82Zcy7hQWmhU=;
 b=bn2IJADhhrV/3Wxz5+RzZkXJctrdKBKR0j1z6Lx+23ppMS23HCKJbaeJPx9uIPT+I4UvtRMk+
 b/UiCOU/YxMBc2ADBXVqLR3iBaZIW7u2tG8BnfYpKODyB2RyVtVp4fI
X-Developer-Key: i=richard.leitner@linux.dev; a=ed25519;
 pk=8hZNyyyQFqZ5ruVJsSGBSPIrmJpfDm5HwHU4QVOP1Pk=
X-Endpoint-Received: by B4 Relay for richard.leitner@linux.dev/20250225
 with auth_id=350

Currently the flash duration is converted to/from microseconds using a
fixed OV9282_STROBE_SPAN_FACTOR constant. This is inaccurate as it was
found that the "step width of shift and span" (which is not documented
further in the datasheet) scales with the line, so the span is counted
in lines. This was verified by comparing the stobe pulses measured on
the camera module against the calculated line times.

As this is the same conversion as for the exposure: rename those functions
to a more generic ov9282_us_to_lines/ov9282_lines_to_us and use them also
for the flash/strobe duration.

Fixes: b95d8058a2786 ("media: i2c: ov9282: implement try_ctrl for strobe_duration")
Cc: stable@vger.kernel.org
Reviewed-by: Dave Stevenson <dave.stevenson@raspberrypi.com>
Signed-off-by: Richard Leitner <richard.leitner@linux.dev>
---
 drivers/media/i2c/ov9282.c | 65 +++++++++++++++++-----------------------------
 1 file changed, 24 insertions(+), 41 deletions(-)

diff --git a/drivers/media/i2c/ov9282.c b/drivers/media/i2c/ov9282.c
index d60396e46ab0f..368f881eccbbf 100644
--- a/drivers/media/i2c/ov9282.c
+++ b/drivers/media/i2c/ov9282.c
@@ -136,8 +136,6 @@
 #define OV9282_REG_MIN		0x00
 #define OV9282_REG_MAX		0xfffff
 
-#define OV9282_STROBE_SPAN_FACTOR	192
-
 static const char * const ov9282_supply_names[] = {
 	"avdd",		/* Analog power */
 	"dovdd",	/* Digital I/O power */
@@ -491,18 +489,31 @@ static u32 ov9282_line_time_ns(struct ov9282 *ov9282)
 }
 
 /**
- * ov9282_exposure_to_us() - Convert an exposure register value to microseconds
+ * ov9282_lines_to_us() - Convert a number of lines to microseconds
  * @ov9282: pointer to ov9282 device
- * @exposure: exposure register value to convert
+ * @lines: line count to convert
  *
- * Return: microsecond representation of the given exposure register value.
+ * Return: microsecond representation of the given line count.
  */
-static u32 ov9282_exposure_to_us(struct ov9282 *ov9282, u32 exposure)
+static u32 ov9282_lines_to_us(struct ov9282 *ov9282, u32 lines)
 {
-	return div_u64((u64)exposure * ov9282_line_time_ns(ov9282),
+	return div_u64((u64)lines * ov9282_line_time_ns(ov9282),
 		       NSEC_PER_USEC);
 }
 
+/**
+ * ov9282_us_to_lines() - Convert µs to line count
+ * @ov9282: pointer to ov9282 device
+ * @duration: microseconds value to convert
+ *
+ * Return: number of lines fitting into the given duration
+ */
+static u32 ov9282_us_to_lines(struct ov9282 *ov9282, u32 duration)
+{
+	return DIV_ROUND_UP_ULL((u64)duration * NSEC_PER_USEC,
+				ov9282_line_time_ns(ov9282));
+}
+
 /**
  * ov9282_update_controls() - Update control ranges based on streaming mode
  * @ov9282: pointer to ov9282 device
@@ -551,7 +562,7 @@ static int ov9282_update_controls(struct ov9282 *ov9282,
  */
 static int ov9282_update_exp_gain(struct ov9282 *ov9282, u32 exposure, u32 gain)
 {
-	u32 exposure_us = ov9282_exposure_to_us(ov9282, exposure);
+	u32 exposure_us = ov9282_lines_to_us(ov9282, exposure);
 	int ret, ret_hold;
 
 	dev_dbg(ov9282->dev, "Set exp %u (~%u us), analog gain %u",
@@ -579,34 +590,6 @@ static int ov9282_update_exp_gain(struct ov9282 *ov9282, u32 exposure, u32 gain)
 	return ret ? ret : ret_hold;
 }
 
-static u32 ov9282_us_to_flash_duration(struct ov9282 *ov9282, u32 value)
-{
-	/*
-	 * Calculate "strobe_frame_span" increments from a given value (µs).
-	 * This is quite tricky as "The step width of shift and span is
-	 * programmable under system clock domain.", but it's not documented
-	 * how to program this step width (at least in the datasheet available
-	 * to the author at time of writing).
-	 * The formula below is interpolated from different modes/framerates
-	 * and should work quite well for most settings.
-	 */
-	u32 frame_width = ov9282->cur_mode->width + ov9282->hblank_ctrl->val;
-
-	return value * OV9282_STROBE_SPAN_FACTOR / frame_width;
-}
-
-static u32 ov9282_flash_duration_to_us(struct ov9282 *ov9282, u32 value)
-{
-	/*
-	 * Calculate back to microseconds from "strobe_frame_span" increments.
-	 * As the calculation in ov9282_us_to_flash_duration uses an integer
-	 * divison round up here.
-	 */
-	u32 frame_width = ov9282->cur_mode->width + ov9282->hblank_ctrl->val;
-
-	return DIV_ROUND_UP(value * frame_width, OV9282_STROBE_SPAN_FACTOR);
-}
-
 static int ov9282_set_ctrl(struct v4l2_ctrl *ctrl)
 {
 	struct ov9282 *ov9282 =
@@ -672,7 +655,7 @@ static int ov9282_set_ctrl(struct v4l2_ctrl *ctrl)
 		break;
 	case V4L2_CID_FLASH_DURATION:
 		ret = cci_write(ov9282->regmap, OV9282_REG_STROBE_FRAME_SPAN,
-				ov9282_us_to_flash_duration(ov9282, ctrl->val), NULL);
+				ov9282_us_to_lines(ov9282, ctrl->val), NULL);
 		break;
 	default:
 		dev_err(ov9282->dev, "Invalid control %d", ctrl->id);
@@ -691,11 +674,11 @@ static int ov9282_try_ctrl(struct v4l2_ctrl *ctrl)
 
 	if (ctrl->id == V4L2_CID_FLASH_DURATION) {
 		u32 us = ctrl->val;
-		u32 fd = ov9282_us_to_flash_duration(ov9282, us);
+		u32 fd = ov9282_us_to_lines(ov9282, us);
 
 		/* get nearest strobe_duration value */
-		u32 us0 = ov9282_flash_duration_to_us(ov9282, fd);
-		u32 us1 = ov9282_flash_duration_to_us(ov9282, fd + 1);
+		u32 us0 = ov9282_lines_to_us(ov9282, fd);
+		u32 us1 = ov9282_lines_to_us(ov9282, fd + 1);
 
 		if (abs(us1 - us) < abs(us - us0))
 			ctrl->val = us1;
@@ -1279,7 +1262,7 @@ static int ov9282_init_controls(struct ov9282 *ov9282)
 	v4l2_ctrl_new_std(ctrl_hdlr, &ov9282_ctrl_ops,
 			  V4L2_CID_FLASH_STROBE_OE, 0, 1, 1, 0);
 
-	exposure_us = ov9282_exposure_to_us(ov9282, OV9282_EXPOSURE_DEFAULT);
+	exposure_us = ov9282_lines_to_us(ov9282, OV9282_EXPOSURE_DEFAULT);
 	ov9282->flash_duration =
 		v4l2_ctrl_new_std(ctrl_hdlr, &ov9282_ctrl_ops,
 				  V4L2_CID_FLASH_DURATION, 0, exposure_us, 1,

-- 
2.53.0


