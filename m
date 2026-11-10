Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794316223;
	b=vnAs9iIpP/IVAgaPUdm8iR8/xnOB/XheUaTYHvgep0Bu0TZnPxELNK++pwsvuztL0Mwt
	 rz5j50X0UxqsU7W6zUET6DuluorFp8vXatQFTiZmwARAdehFxPAjTlcncf0jAXchbhWZD
	 TQ6OypHXIfR2eG8/IkhsoQbytEpRMtO05w5fu4uxFI/w0NoBzGmmo51HBxkx7IRElLv9S
	 WgMrpJCHwZi8icj2upLRAEia/UgjkDFBHU3ZrP+7mnHXCf7QIGKLpyicZ4vVJFKOKiZW6
	 Y329HXIXUP42Rtyu8SRg/DCGd3eor/XYSf0viDe2WXoT8bFnKtzuTj+gWHl2pKdXdGA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794316223;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:References:
	 In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:
	 X-Endpoint-Received;
	bh=LqMiD0XkT5N3kO9m0vJOTEGBA05EDYmMTnOj0puIq8A=;
	b=ok15mdnr4AThI5tAPDbHGsnJG6dSeGFbxAgHLceGoWAiCDuX8Nfya3ZZKPXZqwnFTwba
	 Uez4B6A/wokTl3zkQfFC+oRVcvVul9S8RT8O7MIkJw5okIl38YuMGeI9f9hCD5VkC99HD
	 BebjDrQOnrTj1HN6/EjozAYXreO1TVvBvGx48r/bqchVZk1b4H+OSzHQh9RRMfAI+C42B
	 iRWLrljP+spxKEwYjojVc5kAGLvASBCMR6lB4sYDwaZ1xGee9fT9DmI3v2T2EQstJ1H2W
	 jZba5AgvNpm34kg/0zfmgSIXwkRs2NAA8WpF6BMhhHQsPFIWgjOIdKInkdC4GE/gPyw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=korg header.b=MPvOEwYN;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C5E4606A760;
	Tue, 10 Nov 2026 13:10:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=korg header.b=MPvOEwYN
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1794316222;
	b=nBOYu8wK1XF9GQbIESbALXbnKFrC9aPOvJMn/5Isqi+hZp7BJTjLYWYdkZY9wN23kwvK
	 hzMOwJBbj2SMGUnj5T6kwKLe+a4RwqCAAr7Zcwe8J4iFmhELF42M9KfbWndE0mSHaocMj
	 E7akaLTFpMUUdgLRTeXy2ZKlB8cB032Dwc4ZAIfI2n7xmoo9UvYLAW5dk/L0Xqqi8wCry
	 jgXPAMUM5hopru1x1KWX5/uWY4sP2FfJHOjH+k+Xx3b5g+tVt3WS91vn4Ua42yC29Vxdh
	 gTf0es2bhn278S92fxakgUz2xiWKGgpnpsZFfe++E64+4H5inP9nuFP1QjXwr06jRug==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1794316222;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key:X-Endpoint-Received;
	bh=LqMiD0XkT5N3kO9m0vJOTEGBA05EDYmMTnOj0puIq8A=;
	b=2kbzvSBnT1NZ4j2cFCwq13unbDUWUVrkp3HEXKY/dWLRr65emBHbD6XCHrj40A2MYYnN
	 +ucGSwQ5VWGHfIY3KOkw/JM0RGCKxQ351Ko+vUfD7MzVoR6YMlvVo9UU8w533mm80DPKd
	 IbhKNJiLKDpT0uVspujbzjqb9DvaiFjZVNaXcaFE26VpDNdHNFiwXtYOeSawdlEzJkRhp
	 q+PaloPhl2HobGmthnwUgjKhF6tvL16EZNo+jwMa84jsdrofn8Uo02ksOXiZlE89NTCau
	 O8RiaCrkON+KX7jErnaMUeiLnFeZqOZmN4j4DZ3jaQ3Bz4vAJo4eac7ozZpYdAMvAJg==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 89BA61F008A4;
	Tue, 10 Nov 2026 13:10:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=korg;
	t=1794316222; bh=LqMiD0XkT5N3kO9m0vJOTEGBA05EDYmMTnOj0puIq8A=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=MPvOEwYNFY19k9/wqQ/wg7UqwHn/uuq5P3X7A1ThfQtV22/fKI33uTYmu35xli1KC
	 EBQT4StBXogg8TJ/B3SIZURdccJuKPGUkFh5nWaBDghtleZ/qDZmyLja1G4vOfPzIb
	 T9AO6d5d9GMwQNa8BqkXHnOrv0lAwzpG3znm22Q4=
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 1595148B6E;
	Tue, 10 Nov 2026 13:10:21 +0000 (UTC)
From: Richard Leitner <richard.leitner@linux.dev>
Date: Tue, 10 Nov 2026 14:10:12 +0100
Subject: [PATCH v3 3/8] media: i2c: ov9282: fix flash duration to/from
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
Message-Id: <20261110-ov9282-fixes-v3-3-cb6df80cbc22@linux.dev>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794316220; l=5864;
 i=richard.leitner@linux.dev; s=20250225; h=from:subject:message-id;
 bh=sFAsSai1H8mqjPv48p0oNAtuGFDOfbrY1Rs4595uPMw=;
 b=1WtJ2tgcV1MEnedoxITWlh1yKowcbhhvhMzb9AFG1+Ht+G3SG2/UrR0hmNhD4QdIrQaTSxA51
 YJRf+iXn6j2DKCX3BVG1BwWJ03i6+cPhWYPLXbpgl003bkdyJaizrJH
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
index d60396e46ab0f..9dfee500a73af 100644
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


