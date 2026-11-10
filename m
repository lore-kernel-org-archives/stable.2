Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794281032;
	b=nsBsf6OjD7Spk9X1jmJDvfcD+FGcPWcdebckfRQ+C67IwUcNVN+uNWeaKqcbx1z1m0z+
	 bo4w8fjJhOGpgyHdutMx46DarKK65NrXWVjqHMjgQtEWXmYEW7wLJBgVAN4T3c2xLaa2+
	 0t0nvZSZuhIYgh8zcTlowOiodVTS1pSLBl7xE5PTnzkgq3vpA+mWCdyPhChllhfJJdwtK
	 u4pgCfw0hdP0ETV467FYhxMiXrhaDojbucy1Tl+Lohbujy6DjOhm3oI5VrwzXUKaKp8zx
	 KhgvX3D5pI3XpH7lyvkkq1nnOWlvn4fCg0R61x95jv2e4hjqQxvms0tqGaBgY35BHkg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794281032;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=ELgAkiC7MISL+N8wtXNIiUezMcEORJm1wqRNL/KmIYg=;
	b=TtlxnO+PHG2BPHAyf8iUmnSzxjvo3bZsKmJyomHByhU2T4FLbCYk3KbcGrMd83u5uMH2
	 czittPP23+eX/fMiX1PRMjv1jSXuOZZ+ZkbZujeP4UqHM3ZQkmjoq7FRmQazwVtvkDOJh
	 SXPDjjPgNdMI4DWk46cT3iQ/vTROvXGuP1NRypC2K3J0C6UnUM2a+8wOWvfK/i++P8/FR
	 l4rWN6x6CU8O4+xAJf6awfy9+iBiXRP5PxQhUEEJhSfDwNxEHrMi325dhgZNb96HRJEyo
	 UqgeGPcO0P5rRny6JaBRE4mwV1zIdauDbbdXNGwqk4+dBnoFOqPUo/GQjA6qAzbWzrw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=B1A11leD;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B288606A336
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 03:23:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=B1A11leD
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5D0601F0089F;
	Tue, 10 Nov 2026 03:23:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794281032;
	bh=ELgAkiC7MISL+N8wtXNIiUezMcEORJm1wqRNL/KmIYg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=B1A11leDaiy8J5tZ5woQ7enNdYAcgKGxADVrlwEKTOjFBG2teBnt4bW6A2F2HhRc2
	 LekG86d9/+hQJTXLUy8Sj+1jSo5q4fboGlBLrHMoN7cfShKMPaCn15P0sHfbVYasZp
	 mGpK+2VLTOJ251IXvRvZUR5LrOU4qh7U/pMJj9M1V7cOC33lzXre8w3PFZoXQp5kct
	 5/ChIf7uYhoTCzv7Y1n3w0ZqTKzVn8U8ac/oj6YO72pskv6NY47v4KY+k2hD0XaUh1
	 RDAyQY1sbbW6Ya9ahkQpLt5JL06Huzsn9zuYvoRIIdfEO7GyNAzes5r199xDT06NTs
	 b+PwfuA+r/LCg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Tarang Raval <tarang.raval@siliconsignals.io>,
	Isaac Scott <isaac.scott@ideasonboard.com>,
	Dave Stevenson <dave.stevenson@raspberrypi.com>,
	Sakari Ailus <sakari.ailus@linux.intel.com>,
	Hans Verkuil <hverkuil+cisco@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18.y 1/2] media: i2c: imx219: Propagate errors from control range updates
Date: Mon,  9 Nov 2026 22:23:49 -0500
Message-ID: <20261110032344.182965-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261107050657-failed-6.18-47576c541e9b@kernel.org>
References: <20261107050657-failed-6.18-47576c541e9b@kernel.org>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Tarang Raval <tarang.raval@siliconsignals.io>

[ Upstream commit dff10c7044e8777bd14bba99444ff8a69d9bb2fe ]

Propagate return values from __v4l2_ctrl_modify_range() and
__v4l2_ctrl_s_ctrl() in imx219_set_ctrl() and imx219_set_pad_format().
This ensures proper error handling instead of ignoring possible
failures. Also return the result of imx219_set_pad_format() from
imx219_init_state().

Signed-off-by: Tarang Raval <tarang.raval@siliconsignals.io>
Reviewed-by: Isaac Scott <isaac.scott@ideasonboard.com>
Reviewed-by: Dave Stevenson <dave.stevenson@raspberrypi.com>
Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>
Signed-off-by: Hans Verkuil <hverkuil+cisco@kernel.org>
Stable-dep-of: 47576c541e9b ("media: imx219: The horizontal blanking step is 8")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/media/i2c/imx219.c | 61 +++++++++++++++++++++++++-------------
 1 file changed, 40 insertions(+), 21 deletions(-)

diff --git a/drivers/media/i2c/imx219.c b/drivers/media/i2c/imx219.c
index 00aec91e3d499..ffb04a56419ad 100644
--- a/drivers/media/i2c/imx219.c
+++ b/drivers/media/i2c/imx219.c
@@ -463,10 +463,14 @@ static int imx219_set_ctrl(struct v4l2_ctrl *ctrl)
 		exposure_max = format->height + ctrl->val - 4;
 		exposure_def = (exposure_max < IMX219_EXPOSURE_DEFAULT) ?
 			exposure_max : IMX219_EXPOSURE_DEFAULT;
-		__v4l2_ctrl_modify_range(imx219->exposure,
-					 imx219->exposure->minimum,
-					 exposure_max, imx219->exposure->step,
-					 exposure_def);
+		ret = __v4l2_ctrl_modify_range(imx219->exposure,
+					       imx219->exposure->minimum,
+					       exposure_max,
+					       imx219->exposure->step,
+					       exposure_def);
+		if (ret)
+			return ret;
+
 	}
 
 	/*
@@ -858,6 +862,7 @@ static int imx219_set_pad_format(struct v4l2_subdev *sd,
 	struct v4l2_rect *crop;
 	u8 bin_h, bin_v, binning;
 	u32 prev_line_len;
+	int ret;
 
 	format = v4l2_subdev_state_get_format(state, 0);
 	prev_line_len = format->width + imx219->hblank->val;
@@ -893,19 +898,28 @@ static int imx219_set_pad_format(struct v4l2_subdev *sd,
 		int pixel_rate;
 
 		/* Update limits and set FPS to default */
-		__v4l2_ctrl_modify_range(imx219->vblank, IMX219_VBLANK_MIN,
-					 IMX219_FLL_MAX - mode->height, 1,
+		ret = __v4l2_ctrl_modify_range(imx219->vblank, IMX219_VBLANK_MIN,
+					       IMX219_FLL_MAX - mode->height, 1,
+					       mode->fll_def - mode->height);
+		if (ret)
+			return ret;
+
+		ret = __v4l2_ctrl_s_ctrl(imx219->vblank,
 					 mode->fll_def - mode->height);
-		__v4l2_ctrl_s_ctrl(imx219->vblank,
-				   mode->fll_def - mode->height);
+		if (ret)
+			return ret;
+
 		/* Update max exposure while meeting expected vblanking */
 		exposure_max = mode->fll_def - 4;
 		exposure_def = (exposure_max < IMX219_EXPOSURE_DEFAULT) ?
 			exposure_max : IMX219_EXPOSURE_DEFAULT;
-		__v4l2_ctrl_modify_range(imx219->exposure,
-					 imx219->exposure->minimum,
-					 exposure_max, imx219->exposure->step,
-					 exposure_def);
+		ret = __v4l2_ctrl_modify_range(imx219->exposure,
+					       imx219->exposure->minimum,
+					       exposure_max,
+					       imx219->exposure->step,
+					       exposure_def);
+		if (ret)
+			return ret;
 
 		/*
 		 * With analog binning the default minimum line length of 3448
@@ -916,9 +930,12 @@ static int imx219_set_pad_format(struct v4l2_subdev *sd,
 		imx219_get_binning(state, &bin_h, &bin_v);
 		llp_min = (bin_h & bin_v) == IMX219_BINNING_X2_ANALOG ?
 				  IMX219_BINNED_LLP_MIN : IMX219_LLP_MIN;
-		__v4l2_ctrl_modify_range(imx219->hblank, llp_min - mode->width,
-					 IMX219_LLP_MAX - mode->width, 1,
-					 llp_min - mode->width);
+		ret = __v4l2_ctrl_modify_range(imx219->hblank,
+					       llp_min - mode->width,
+					       IMX219_LLP_MAX - mode->width, 1,
+					       llp_min - mode->width);
+		if (ret)
+			return ret;
 		/*
 		 * Retain PPL setting from previous mode so that the
 		 * line time does not change on a mode change.
@@ -927,13 +944,17 @@ static int imx219_set_pad_format(struct v4l2_subdev *sd,
 		 * mode width subtracted.
 		 */
 		hblank = prev_line_len - mode->width;
-		__v4l2_ctrl_s_ctrl(imx219->hblank, hblank);
+		ret = __v4l2_ctrl_s_ctrl(imx219->hblank, hblank);
+		if (ret)
+			return ret;
 
 		/* Scale the pixel rate based on the mode specific factor */
 		pixel_rate = imx219_get_pixel_rate(imx219) *
 			     imx219_get_rate_factor(state);
-		__v4l2_ctrl_modify_range(imx219->pixel_rate, pixel_rate,
-					 pixel_rate, 1, pixel_rate);
+		ret = __v4l2_ctrl_modify_range(imx219->pixel_rate, pixel_rate,
+					       pixel_rate, 1, pixel_rate);
+		if (ret)
+			return ret;
 	}
 
 	return 0;
@@ -982,9 +1003,7 @@ static int imx219_init_state(struct v4l2_subdev *sd,
 		},
 	};
 
-	imx219_set_pad_format(sd, state, &fmt);
-
-	return 0;
+	return imx219_set_pad_format(sd, state, &fmt);
 }
 
 static const struct v4l2_subdev_video_ops imx219_video_ops = {
-- 
2.53.0

