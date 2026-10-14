Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5B82474267;
	Wed, 14 Oct 2026 06:49:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791960589; cv=none; b=Aj+JZlhoK/zQLmnK9XfU9daTr/9p2w528aUylqcXoWSwyar4qWvHYvVXf+UAeNWou3E+Gbxe03uUb5ku+f+Q2gfLFxlsYKBwlAr2mnYkGE1zu386hH3R56zGoNaUkVhw+JGgu2cE2wwTTalGLM0zAbix3HR65Ayday6G1WqNPwU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791960589; c=relaxed/simple;
	bh=A5QGZ5IgXXk7+deMtudIMV7FAC1UAVk+Zu6Pozn2kj4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=aPgz5zzPa2yB7yF6dOHsCEKVP6poVUjtmPh26IHgrsaT4GXM5Icw+HxLvV/nfxZ7e/AsAKlga/jj3lkQMKDFwxfOCb3ivllr2UHrTYnYT2OXHt2dVT5np1u/ZzXcrdxau1xX75Db2SBu5MFf74uLTICWN4Cw43kgAra8tew06Mw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=NSEVPrTI; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="NSEVPrTI"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 6E4DAC4AF0E;
	Wed, 14 Oct 2026 06:49:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux.dev; s=korg;
	t=1791960588; bh=A5QGZ5IgXXk7+deMtudIMV7FAC1UAVk+Zu6Pozn2kj4=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=NSEVPrTIiGBATRkrQ2B0LGSn8caIiBgk6umoutfIsmYqlFNAPsFOLLdOXWVN/CJS1
	 tdfjaZL79KyONde1pb96h91blIBap5qQkIWgR66Kh9HZ9zkUpj4hq+q5Dc4MUBvaPS
	 g8xCW5EyIR83v0IpddqTr51CEq8bl6ffrbT9g2ok=
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4ACE0CC6B27;
	Wed, 14 Oct 2026 06:49:48 +0000 (UTC)
From: Richard Leitner <richard.leitner@linux.dev>
Date: Wed, 14 Oct 2026 08:49:11 +0200
Subject: [PATCH v2 4/8] media: i2c: ov9282: fix flash duration range
 calculation
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261014-ov9282-fixes-v2-4-3bb376d8b1a9@linux.dev>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1791960586; l=4514;
 i=richard.leitner@linux.dev; s=20250225; h=from:subject:message-id;
 bh=A5QGZ5IgXXk7+deMtudIMV7FAC1UAVk+Zu6Pozn2kj4=;
 b=3j9p2Csqj3TKbjrOyg+rVYwuzDH9/J/q+eTiWRVQ+oe0j5Q0blPWJpn5QkPulX7YdBvw1EZYd
 EfN0WwxeCd8CXKAPd63VdgRN83zK0FIEkeXM5iv2XvxxB7zGyecSyKE
X-Developer-Key: i=richard.leitner@linux.dev; a=ed25519;
 pk=8hZNyyyQFqZ5ruVJsSGBSPIrmJpfDm5HwHU4QVOP1Pk=
X-Endpoint-Received: by B4 Relay for richard.leitner@linux.dev/20250225
 with auth_id=350

The flash_duration range calculation was broken. The maximum was
calculated from the current exposure time. This limited the hardware
without a strong reason. The minimum was fixed to 0, although the
hardware treats register values 0 and 1 equally for the strobe_duration.
The default value was never calculated from the raw register value to
actual microseconds.

Furthermore the flash_duration range update sat inside
ov9282_update_exp_gain(), which ov9282_set_ctrl() only reaches after
the pm_runtime_get_if_in_use() early return. So with the sensor idle
the range kept whatever value it had when it last streamed.

Fix those issues by correctly calculating the values on line time changes
(i.e. HBLANK updates) as this is the "time base" for the register value.

The maximum is chosen to be S32_MAX microseconds. This was done to keep
the code short and avoid additional back-and-forth conversions. As the
hardware allows strobe durations from 1 up to U32_MAX line times, S32_MAX
microseconds is always in this range. Line times for the supported
modes, hblank values and pixel rates may vary between ~7.5 and ~205
microseconds.

Fixes: b95d8058a2786 ("media: i2c: ov9282: implement try_ctrl for strobe_duration")
Fixes: df60764ea5210 ("media: i2c: ov9282: dynamic flash_duration maximum")
Cc: stable@vger.kernel.org
Signed-off-by: Richard Leitner <richard.leitner@linux.dev>
---
 drivers/media/i2c/ov9282.c | 41 +++++++++++++++++++++++++++++++----------
 1 file changed, 31 insertions(+), 10 deletions(-)

diff --git a/drivers/media/i2c/ov9282.c b/drivers/media/i2c/ov9282.c
index e2a1f875160b9..e6920e18b7818 100644
--- a/drivers/media/i2c/ov9282.c
+++ b/drivers/media/i2c/ov9282.c
@@ -514,6 +514,26 @@ static u32 ov9282_us_to_lines(struct ov9282 *ov9282, u32 duration)
 			    ov9282_line_time_ns(ov9282));
 }
 
+/**
+ * ov9282_update_ctrl_flash_duration() - Update flash_duration control range
+ * @ov9282: pointer to ov9282 device
+ *
+ * As the actual microseconds value of the flash_duration range (default,
+ * minimum, maximum) are dependent on the line time recalculate and apply them
+ * to the v4l2 property in this function.
+ *
+ * Return: 0 if successful, error code otherwise.
+ */
+static int ov9282_update_ctrl_flash_duration(struct ov9282 *ov9282)
+{
+	u32 fd_min_us = ov9282_lines_to_us(ov9282, 1);
+	u32 fd_def_us = ov9282_lines_to_us(ov9282,
+					   OV9282_STROBE_FRAME_SPAN_DEFAULT);
+
+	return __v4l2_ctrl_modify_range(ov9282->flash_duration, fd_min_us,
+					S32_MAX, 1, fd_def_us);
+}
+
 /**
  * ov9282_update_controls() - Update control ranges based on streaming mode
  * @ov9282: pointer to ov9282 device
@@ -577,12 +597,6 @@ static int ov9282_update_exp_gain(struct ov9282 *ov9282, u32 exposure, u32 gain)
 		goto error_release_group_hold;
 
 	ret = cci_write(ov9282->regmap, OV9282_REG_AGAIN, gain, NULL);
-	if (ret)
-		goto error_release_group_hold;
-
-	ret = __v4l2_ctrl_modify_range(ov9282->flash_duration,
-				       0, exposure_us, 1,
-				       OV9282_STROBE_FRAME_SPAN_DEFAULT);
 
 error_release_group_hold:
 	ret_hold = cci_write(ov9282->regmap, OV9282_REG_HOLD, 0, NULL);
@@ -616,6 +630,11 @@ static int ov9282_set_ctrl(struct v4l2_ctrl *ctrl)
 		if (ret)
 			return ret;
 		break;
+	case V4L2_CID_HBLANK:
+		ret = ov9282_update_ctrl_flash_duration(ov9282);
+		if (ret)
+			return ret;
+		break;
 	}
 
 	/* Set controls only if sensor is in power on state */
@@ -1190,8 +1209,9 @@ static int ov9282_init_controls(struct ov9282 *ov9282)
 	const struct ov9282_mode *mode = ov9282->cur_mode;
 	struct v4l2_fwnode_device_properties props;
 	u32 hblank_min;
-	u32 exposure_us;
 	u32 lpfr;
+	u32 fd_min;
+	u32 fd_def;
 	int ret;
 
 	ret = v4l2_ctrl_handler_init(ctrl_hdlr, 12);
@@ -1260,11 +1280,12 @@ static int ov9282_init_controls(struct ov9282 *ov9282)
 	v4l2_ctrl_new_std(ctrl_hdlr, &ov9282_ctrl_ops,
 			  V4L2_CID_FLASH_STROBE_OE, 0, 1, 1, 0);
 
-	exposure_us = ov9282_lines_to_us(ov9282, OV9282_EXPOSURE_DEFAULT);
+	fd_min = ov9282_lines_to_us(ov9282, 1);
+	fd_def = ov9282_lines_to_us(ov9282, OV9282_STROBE_FRAME_SPAN_DEFAULT);
 	ov9282->flash_duration =
 		v4l2_ctrl_new_std(ctrl_hdlr, &ov9282_ctrl_ops,
-				  V4L2_CID_FLASH_DURATION, 0, exposure_us, 1,
-				  OV9282_STROBE_FRAME_SPAN_DEFAULT);
+				  V4L2_CID_FLASH_DURATION, fd_min, S32_MAX, 1,
+				  fd_def);
 
 	ret = v4l2_fwnode_device_parse(ov9282->dev, &props);
 	if (!ret) {

-- 
2.53.0


