Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83EFC4534B3
	for <stable@vger.kernel.org>; Tue,  4 Aug 2026 10:47:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785840462; cv=none; b=IgGt3K+cXbs+lHP0LrCQBVwuHCWS6y6Kd4n0+IJHFxz3zfxvGha8Dl4WQDwlACgL+LIflxClpIWKfB4LX9BNwBCrBvGEX4t6xhUOmUSZqfWN4HkG/BiU6VWhXsZpO5DPyI66izvZEHmIBlhLhkcLxScan0Lv5DicC5ec+LvMVtE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785840462; c=relaxed/simple;
	bh=dPlFNlz9GZi3SDlsyu3C5kSmDMI1+j5jPIygStp5MPg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UZjQeXghiD3IBAcA/LETEWqcErflV/mAxOhP5mmK3K2q7xKgd7p7dFaYYFm93eh2OImiU6K6R/hY7hnXr+igDhNVu2uul/UabYZTvXRBl1yQb6P8Ylo7Jwo+l8/oIyJxT6Ww/0IcF5JJ8AhpTfKIDj0iZa9Xvs0zEOIuke/oBgA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kDdpNuh8; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kDdpNuh8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8083F1F00A3D;
	Tue,  4 Aug 2026 10:47:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785840461;
	bh=WBEM2Bw7oIV2uhJHAO1ErOFh/H1myTlSJ2HiLtYSVpU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=kDdpNuh8YiqPehi7mEC8U+ygNvN86oIMwPcH56PBXY48iD07xPqDr6EBSlc2KukvE
	 coiKOozCFZuSnye1Uuh3JuLXBvwgwXrRLjAk7u7lAPQT4y8wTLBd384BJuufncczpC
	 4I8Eug/COaPW4zKoNSdBncGmW+IEwWD7AIzkbLKcqxtH/lqKvDTFfwRmVIt8Ghe9jp
	 5cfNsp4rVBI0AwageNlRY59RG/bxXqCjD5tmEaXttwRHFsj02vdppLe4+eAL2CVqJh
	 Dt746r89kVgy6KB63Kj13i+WXqWJi49GLgRp5en7qdhn1OTe0uj7XPKykpo++whBpT
	 Tlo3YKiYX7Thw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
	Jacopo Mondi <jacopo.mondi@ideasonboard.com>,
	Dave Stevenson <dave.stevenson@raspberrypi.com>,
	Sakari Ailus <sakari.ailus@linux.intel.com>,
	Hans Verkuil <hverkuil-cisco@xs4all.nl>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y 2/7] media: i2c: imx219: Don't store the current mode in the imx219 structure
Date: Tue,  4 Aug 2026 06:47:32 -0400
Message-ID: <20260804104737.2827302-2-sashal@kernel.org>
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

[ Upstream commit e3e5d172d5fce9151bc101427554a158d4759856 ]

The mode field of the imx219 structure is only used in
imx219_init_controls(), after the probe function sets it to point to the
default mode. Use the default mode directly when initializing controls,
and drop the mode field from the imx219 structure.

Signed-off-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Reviewed-by: Jacopo Mondi <jacopo.mondi@ideasonboard.com>
Reviewed-by: Dave Stevenson <dave.stevenson@raspberrypi.com>
Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>
Signed-off-by: Hans Verkuil <hverkuil-cisco@xs4all.nl>
Stable-dep-of: 2c4f1ba73543 ("media: imx219: Fix maximum frame length in lines")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/media/i2c/imx219.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/drivers/media/i2c/imx219.c b/drivers/media/i2c/imx219.c
index 64c4d2d538bd1..c34a8bb5854ad 100644
--- a/drivers/media/i2c/imx219.c
+++ b/drivers/media/i2c/imx219.c
@@ -1067,8 +1067,8 @@ static unsigned long imx219_get_pixel_rate(struct imx219 *imx219)
 static int imx219_init_controls(struct imx219 *imx219)
 {
 	struct i2c_client *client = v4l2_get_subdevdata(&imx219->sd);
+	const struct imx219_mode *mode = &supported_modes[0];
 	struct v4l2_ctrl_handler *ctrl_hdlr;
-	unsigned int height = imx219->mode->height;
 	struct v4l2_fwnode_device_properties props;
 	int exposure_max, exposure_def, hblank;
 	int i, ret;
@@ -1097,15 +1097,15 @@ static int imx219_init_controls(struct imx219 *imx219)
 	/* Initial vblank/hblank/exposure parameters based on current mode */
 	imx219->vblank = v4l2_ctrl_new_std(ctrl_hdlr, &imx219_ctrl_ops,
 					   V4L2_CID_VBLANK, IMX219_VBLANK_MIN,
-					   IMX219_VTS_MAX - height, 1,
-					   imx219->mode->vts_def - height);
-	hblank = IMX219_PPL_DEFAULT - imx219->mode->width;
+					   IMX219_VTS_MAX - mode->height, 1,
+					   mode->vts_def - mode->height);
+	hblank = IMX219_PPL_DEFAULT - mode->width;
 	imx219->hblank = v4l2_ctrl_new_std(ctrl_hdlr, &imx219_ctrl_ops,
 					   V4L2_CID_HBLANK, hblank, hblank,
 					   1, hblank);
 	if (imx219->hblank)
 		imx219->hblank->flags |= V4L2_CTRL_FLAG_READ_ONLY;
-	exposure_max = imx219->mode->vts_def - 4;
+	exposure_max = mode->vts_def - 4;
 	exposure_def = (exposure_max < IMX219_EXPOSURE_DEFAULT) ?
 		exposure_max : IMX219_EXPOSURE_DEFAULT;
 	imx219->exposure = v4l2_ctrl_new_std(ctrl_hdlr, &imx219_ctrl_ops,
@@ -1298,7 +1298,8 @@ static int imx219_probe(struct i2c_client *client)
 	/* Set default mode to max resolution */
 	imx219->mode = &supported_modes[0];
 
-	/* sensor doesn't enter LP-11 state upon power up until and unless
+	/*
+	 * Sensor doesn't enter LP-11 state upon power up until and unless
 	 * streaming is started, so upon power up switch the modes to:
 	 * streaming -> standby
 	 */
-- 
2.53.0

