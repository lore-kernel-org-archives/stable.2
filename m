Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21AB44570E0
	for <stable@vger.kernel.org>; Tue,  4 Aug 2026 10:47:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785840467; cv=none; b=PRQJouOaTHP/ycAZ1IqPgdfAL8VjZQKnDiJBqx8V4FdtTfvhwr2+Bzqoqj/q1FZhH+Vu2t/sbJlE7Qm/HH+gcT6xfWICjzcSm7xyN3VRfPff4vQfa8Ng3tmMEARSe3yKShUGuqK09HbPQpWS8MDN1GGWs/QXzBBCLNP7kAJHzgM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785840467; c=relaxed/simple;
	bh=W8squY0T+hYVLx4q7mQjuGi9LPxXNWgnyrucGgLfMpc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TUgDCEppVyAATHVAk9uFNfvcX2vNgqaaixJWqv5K92E7VsWt7VeaBU3tvy+sIXzcdfY2EG87oPpfGjJshXHYwFIwzFpHWl9IZEvQYGEjDImJpUPTe4IBkTBlLAw57mFzrC5iXRwd07xuXOt5UXTpLb7HBBqUu0qYOriMZBmLjF8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=F7FMWF2g; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="F7FMWF2g"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 646501F00AC4;
	Tue,  4 Aug 2026 10:47:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785840464;
	bh=q6uJV4tdUk617n7X738/QV2VsRnKh5yXixuDdZJn5Gc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=F7FMWF2g5ATr9d9j8q3jNJQbM7oO5GkEM594a0AsYnCjv3LxJZtEwTAIInKZYvorS
	 f9dZmlMc9Dg33/E0pab+LHNkJh2IbW+hZZytKrpWtII9ML2E12BBf0fPTJNt+1OtVi
	 Ua53fsjDfrwO3ua8RnLtyLC7FdjBAJVsnr1BdoumTWe6awkyACCkapY0KmnYp0tziB
	 wwW/pGodsqr8oEUTTIZtUcaSvZSobusHU7IJlMBT3uDB8rXebu3mwA48Hpf7l00e6G
	 pOLJPEEv4Drl+1JPH6aAErpLvBgvq6rNZuADgUOskKB2mY+u2G9m7kBSaE35a/CwzN
	 FAqEUrenotHvg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
	Jacopo Mondi <jacopo.mondi@ideasonboard.com>,
	Sakari Ailus <sakari.ailus@linux.intel.com>,
	Hans Verkuil <hverkuil-cisco@xs4all.nl>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y 5/7] media: i2c: imx219: Calculate crop rectangle dynamically
Date: Tue,  4 Aug 2026 06:47:35 -0400
Message-ID: <20260804104737.2827302-5-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260804104737.2827302-1-sashal@kernel.org>
References: <2026072955-retouch-favorably-ee17@gregkh>
 <20260804104737.2827302-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

[ Upstream commit 0af46fbc333d1a52c72823d935590410357bab47 ]

Calculate the crop rectangle size and location dynamically when setting
the format, instead of storing it in the imx219_mode structure. This
removes duplicated information from the mode, to guarantee consistency.

Signed-off-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Reviewed-by: Jacopo Mondi <jacopo.mondi@ideasonboard.com>
Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>
Signed-off-by: Hans Verkuil <hverkuil-cisco@xs4all.nl>
Stable-dep-of: 2c4f1ba73543 ("media: imx219: Fix maximum frame length in lines")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/media/i2c/imx219.c | 45 +++++++++++++-------------------------
 1 file changed, 15 insertions(+), 30 deletions(-)

diff --git a/drivers/media/i2c/imx219.c b/drivers/media/i2c/imx219.c
index f8c563430d639..4c5388edc10b0 100644
--- a/drivers/media/i2c/imx219.c
+++ b/drivers/media/i2c/imx219.c
@@ -18,6 +18,7 @@
 #include <linux/delay.h>
 #include <linux/gpio/consumer.h>
 #include <linux/i2c.h>
+#include <linux/minmax.h>
 #include <linux/module.h>
 #include <linux/pm_runtime.h>
 #include <linux/regulator/consumer.h>
@@ -161,9 +162,6 @@ struct imx219_mode {
 	/* Frame height */
 	unsigned int height;
 
-	/* Analog crop rectangle. */
-	struct v4l2_rect crop;
-
 	/* V-timing */
 	unsigned int vts_def;
 
@@ -365,12 +363,6 @@ static const struct imx219_mode supported_modes[] = {
 		/* 8MPix 15fps mode */
 		.width = 3280,
 		.height = 2464,
-		.crop = {
-			.left = IMX219_PIXEL_ARRAY_LEFT,
-			.top = IMX219_PIXEL_ARRAY_TOP,
-			.width = 3280,
-			.height = 2464
-		},
 		.vts_def = 3526,
 		.reg_list = {
 			.num_of_regs = ARRAY_SIZE(mode_3280x2464_regs),
@@ -382,12 +374,6 @@ static const struct imx219_mode supported_modes[] = {
 		/* 1080P 30fps cropped */
 		.width = 1920,
 		.height = 1080,
-		.crop = {
-			.left = 688,
-			.top = 700,
-			.width = 1920,
-			.height = 1080
-		},
 		.vts_def = 1763,
 		.reg_list = {
 			.num_of_regs = ARRAY_SIZE(mode_1920_1080_regs),
@@ -399,12 +385,6 @@ static const struct imx219_mode supported_modes[] = {
 		/* 2x2 binned 30fps mode */
 		.width = 1640,
 		.height = 1232,
-		.crop = {
-			.left = IMX219_PIXEL_ARRAY_LEFT,
-			.top = IMX219_PIXEL_ARRAY_TOP,
-			.width = 3280,
-			.height = 2464
-		},
 		.vts_def = 1763,
 		.reg_list = {
 			.num_of_regs = ARRAY_SIZE(mode_1640_1232_regs),
@@ -416,12 +396,6 @@ static const struct imx219_mode supported_modes[] = {
 		/* 640x480 30fps mode */
 		.width = 640,
 		.height = 480,
-		.crop = {
-			.left = 1008,
-			.top = 760,
-			.width = 1280,
-			.height = 960
-		},
 		.vts_def = 1763,
 		.reg_list = {
 			.num_of_regs = ARRAY_SIZE(mode_640_480_regs),
@@ -966,6 +940,7 @@ static int imx219_set_pad_format(struct v4l2_subdev *sd,
 	int exposure_max, exposure_def, hblank;
 	struct v4l2_mbus_framefmt *format;
 	struct v4l2_rect *crop;
+	unsigned int bin_h, bin_v;
 
 	mode = v4l2_find_nearest_size(supported_modes,
 				      ARRAY_SIZE(supported_modes),
@@ -975,10 +950,20 @@ static int imx219_set_pad_format(struct v4l2_subdev *sd,
 	imx219_update_pad_format(imx219, mode, &fmt->format, fmt->format.code);
 
 	format = v4l2_subdev_get_pad_format(sd, sd_state, 0);
-	crop = v4l2_subdev_get_pad_crop(sd, sd_state, 0);
-
 	*format = fmt->format;
-	*crop = mode->crop;
+
+	/*
+	 * Use binning to maximize the crop rectangle size, and centre it in the
+	 * sensor.
+	 */
+	bin_h = min(IMX219_PIXEL_ARRAY_WIDTH / format->width, 2U);
+	bin_v = min(IMX219_PIXEL_ARRAY_HEIGHT / format->height, 2U);
+
+	crop = v4l2_subdev_get_pad_crop(sd, sd_state, 0);
+	crop->width = format->width * bin_h;
+	crop->height = format->height * bin_v;
+	crop->left = (IMX219_NATIVE_WIDTH - crop->width) / 2;
+	crop->top = (IMX219_NATIVE_HEIGHT - crop->height) / 2;
 
 	if (fmt->which == V4L2_SUBDEV_FORMAT_ACTIVE) {
 		imx219->mode = mode;
-- 
2.53.0

