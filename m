Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DE614562A9;
	Wed, 14 Oct 2026 06:49:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791960588; cv=none; b=uendiwM5EsgWkvA9B0LXmJE4n7tJwJYRPyIQa7U7axqeb3L/WE7WV0mizyk4HqbTfkUuTfsOWJcie93I1/Kw/tUtj1Wgrm106++Vi7qJhyJc6KDcmP/u5wu1tk+GqCT29lVhHRXYWLbhoccjSh2opsdnYWFBkmL6akxR+KDLtSc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791960588; c=relaxed/simple;
	bh=/TZMWM5u1jhdfw45vVJQm0syeDKeBCYD9MP5LfiRMB4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=isWn7yJl2R8gepGcY4ANYTZ52GqdyRttNDKee68UIL+jI5g2yu7fCfN6v7BLtWbwR++9Cx+rOGN8GoP4XKrrSv5/qnRKV68JMeE9rzrtmB8naXMlMfhyjq6LQJvBhcCczL980nWXP1IOKOtfomd7+gbBJjGEvlsku5i5kHymq9s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=HgdJrgE+; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="HgdJrgE+"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 4EA16C2BCFD;
	Wed, 14 Oct 2026 06:49:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux.dev; s=korg;
	t=1791960588; bh=/TZMWM5u1jhdfw45vVJQm0syeDKeBCYD9MP5LfiRMB4=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=HgdJrgE+z+KHb0XTr36+CVt7POnIaFjSO96reV2MRLbHxBJnlXYGNnq4vOFjXQb8D
	 dm1tHNlita0JDNVZBKCG7mptnfjbjh48wA4zWvxj8py1oIQfGQUby8NKaqn+T2F/M7
	 ClfZ8Odr6VUvCLm6clS/TOELVRekkjmxcVB163u8=
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34CC7CC6B1A;
	Wed, 14 Oct 2026 06:49:48 +0000 (UTC)
From: Richard Leitner <richard.leitner@linux.dev>
Date: Wed, 14 Oct 2026 08:49:10 +0200
Subject: [PATCH v2 3/8] media: i2c: ov9282: fix flash duration to/from
 microseconds conversion
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20261014-ov9282-fixes-v2-3-3bb376d8b1a9@linux.dev>
References: <20261014-ov9282-fixes-v2-0-3bb376d8b1a9@linux.dev>
In-Reply-To: <20261014-ov9282-fixes-v2-0-3bb376d8b1a9@linux.dev>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1791960586; l=5802;
 i=richard.leitner@linux.dev; s=20250225; h=from:subject:message-id;
 bh=/TZMWM5u1jhdfw45vVJQm0syeDKeBCYD9MP5LfiRMB4=;
 b=FGOsHYmd0t4EfOzxtNN5BPFiS2yOBMuE7k74IsGsGiSlWy4K1qDheO1N/drj/1Y9b0uwVei01
 +qTe6BXoDu+BCV+ZsRAzNLgCnQyfVMlL1+FsJ+30pUM+l3emQg0Q/j6
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
Signed-off-by: Richard Leitner <richard.leitner@linux.dev>
---
 drivers/media/i2c/ov9282.c | 65 +++++++++++++++++-----------------------------
 1 file changed, 24 insertions(+), 41 deletions(-)

diff --git a/drivers/media/i2c/ov9282.c b/drivers/media/i2c/ov9282.c
index 5907f57b34523..e2a1f875160b9 100644
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
+	return DIV_ROUND_UP((u64)duration * NSEC_PER_USEC,
+			    ov9282_line_time_ns(ov9282));
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
@@ -1277,7 +1260,7 @@ static int ov9282_init_controls(struct ov9282 *ov9282)
 	v4l2_ctrl_new_std(ctrl_hdlr, &ov9282_ctrl_ops,
 			  V4L2_CID_FLASH_STROBE_OE, 0, 1, 1, 0);
 
-	exposure_us = ov9282_exposure_to_us(ov9282, OV9282_EXPOSURE_DEFAULT);
+	exposure_us = ov9282_lines_to_us(ov9282, OV9282_EXPOSURE_DEFAULT);
 	ov9282->flash_duration =
 		v4l2_ctrl_new_std(ctrl_hdlr, &ov9282_ctrl_ops,
 				  V4L2_CID_FLASH_DURATION, 0, exposure_us, 1,

-- 
2.53.0


