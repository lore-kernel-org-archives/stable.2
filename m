Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D82FB20E702
	for <stable@vger.kernel.org>; Wed,  5 Aug 2026 00:58:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785891494; cv=none; b=jy4sMdfYCHEmP6rtjkbp+L3IJJlnXMvTZkThjwjgQJCDF2I037u2NucoEaXhJm0QuRBAh8CFdEgXTyPP4SHShOidQdEuXcnBa7WTJDMktst6QcfdJlYlvQXfuZzlJjnq5KUfYDXpHI2QTwPbfM0sKc9Zhz486UTHcC+KoCBwncc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785891494; c=relaxed/simple;
	bh=mVDs4tQo7S5e3Z4Fn8ynAUVtsb4z2PXYLwYQmU4kz2k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=loDm4+PuXzWKqh3mcwUPPsgmDB/qsUD3ko3g6NOrmINeooj2CTYQfIruyiPGG/Gh2FJETMVsqsmj330gKHBtk/XKl5FD0ShDiL0lBz6Z8y9Oh9XYzbml6GptroSHfLzfK0SJc+cJhWLG/Oucodq/l24MHVzwWm8ZuTmziA5n9WM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CMsLbD9u; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CMsLbD9u"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0757C1F000E9;
	Wed,  5 Aug 2026 00:58:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785891492;
	bh=388sfEwpdgaU4LBET42fT8ZKmcuIl0e34Orwp6N88+I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=CMsLbD9uTeo+DL1Wcq/pWWyeoDueOqk4w0b5xOpVIuv9GHX/Z+uf6q5fxFOpSa18z
	 sLEoEa7SPESoYGuaDbaKCH6ty3Wky4IxYLQuIbTwOjUtlrYUWKAmpgeobDe7XpsVvS
	 l3f3E69fCk3jMnt1JU8peU3+JFOIjTXtbC574NxHV62hj/2GrFguoCtIhfe7eO0Vy/
	 uqEQyWozPkjho8ziKjX5LyBRNIRNOsacxypl7M4CUxO1DDLczZd74Lq4HvVNjGwkEn
	 Sus9IDAEk2w0UGiCZd/eZmtm67L7jDxOjO+s30WPVk4egQqU2OxW2JLFwtxwZoZ1QR
	 kHxWHZGZzxilw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
	Dave Stevenson <dave.stevenson@raspberrypi.com>,
	Jacopo Mondi <jacopo.mondi@ideasonboard.com>,
	Sakari Ailus <sakari.ailus@linux.intel.com>,
	Hans Verkuil <hverkuil-cisco@xs4all.nl>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y 1/4] media: i2c: imx219: Drop IMX219_VTS_* macros
Date: Tue,  4 Aug 2026 20:58:07 -0400
Message-ID: <20260805005810.3988269-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026072956-fresh-handoff-8044@gregkh>
References: <2026072956-fresh-handoff-8044@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

[ Upstream commit 5ebbdd7aab3321e60a8be23aac1fee4f16644021 ]

The IMX219_VTS_* macros define default VTS values for the modes
supported by the driver. They are used in a single place, and hinder
readability compared to using the value directly as a decimal number.
Drop them.

Signed-off-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Reviewed-by: Dave Stevenson <dave.stevenson@raspberrypi.com>
Reviewed-by: Jacopo Mondi <jacopo.mondi@ideasonboard.com>
Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>
Signed-off-by: Hans Verkuil <hverkuil-cisco@xs4all.nl>
Stable-dep-of: 2c4f1ba73543 ("media: imx219: Fix maximum frame length in lines")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/media/i2c/imx219.c | 24 +++++++-----------------
 1 file changed, 7 insertions(+), 17 deletions(-)

diff --git a/drivers/media/i2c/imx219.c b/drivers/media/i2c/imx219.c
index fa2e4cca0268d..2ed73ce1a646a 100644
--- a/drivers/media/i2c/imx219.c
+++ b/drivers/media/i2c/imx219.c
@@ -49,20 +49,10 @@
 
 /* V_TIMING internal */
 #define IMX219_REG_VTS			0x0160
-#define IMX219_VTS_15FPS		0x0dc6
-#define IMX219_VTS_30FPS_1080P		0x06e3
-#define IMX219_VTS_30FPS_BINNED		0x06e3
-#define IMX219_VTS_30FPS_640x480	0x06e3
-#define IMX219_VTS_MAX			0xffff
+#define IMX219_FLL_MAX			0xffff
 
 #define IMX219_VBLANK_MIN		4
 
-/*Frame Length Line*/
-#define IMX219_FLL_MIN			0x08a6
-#define IMX219_FLL_MAX			0xffff
-#define IMX219_FLL_STEP			1
-#define IMX219_FLL_DEFAULT		0x0c98
-
 /* HBLANK control - read only */
 #define IMX219_PPL_DEFAULT		3448
 
@@ -382,7 +372,7 @@ static const struct imx219_mode supported_modes[] = {
 			.width = 3280,
 			.height = 2464
 		},
-		.vts_def = IMX219_VTS_15FPS,
+		.vts_def = 3526,
 		.reg_list = {
 			.num_of_regs = ARRAY_SIZE(mode_3280x2464_regs),
 			.regs = mode_3280x2464_regs,
@@ -399,7 +389,7 @@ static const struct imx219_mode supported_modes[] = {
 			.width = 1920,
 			.height = 1080
 		},
-		.vts_def = IMX219_VTS_30FPS_1080P,
+		.vts_def = 1763,
 		.reg_list = {
 			.num_of_regs = ARRAY_SIZE(mode_1920_1080_regs),
 			.regs = mode_1920_1080_regs,
@@ -416,7 +406,7 @@ static const struct imx219_mode supported_modes[] = {
 			.width = 3280,
 			.height = 2464
 		},
-		.vts_def = IMX219_VTS_30FPS_BINNED,
+		.vts_def = 1763,
 		.reg_list = {
 			.num_of_regs = ARRAY_SIZE(mode_1640_1232_regs),
 			.regs = mode_1640_1232_regs,
@@ -433,7 +423,7 @@ static const struct imx219_mode supported_modes[] = {
 			.width = 1280,
 			.height = 960
 		},
-		.vts_def = IMX219_VTS_30FPS_640x480,
+		.vts_def = 1763,
 		.reg_list = {
 			.num_of_regs = ARRAY_SIZE(mode_640_480_regs),
 			.regs = mode_640_480_regs,
@@ -829,7 +819,7 @@ static int imx219_set_pad_format(struct v4l2_subdev *sd,
 		imx219->mode = mode;
 		/* Update limits and set FPS to default */
 		__v4l2_ctrl_modify_range(imx219->vblank, IMX219_VBLANK_MIN,
-					 IMX219_VTS_MAX - mode->height, 1,
+					 IMX219_FLL_MAX - mode->height, 1,
 					 mode->vts_def - mode->height);
 		__v4l2_ctrl_s_ctrl(imx219->vblank,
 				   mode->vts_def - mode->height);
@@ -1246,7 +1236,7 @@ static int imx219_init_controls(struct imx219 *imx219)
 	/* Initial vblank/hblank/exposure parameters based on current mode */
 	imx219->vblank = v4l2_ctrl_new_std(ctrl_hdlr, &imx219_ctrl_ops,
 					   V4L2_CID_VBLANK, IMX219_VBLANK_MIN,
-					   IMX219_VTS_MAX - height, 1,
+					   IMX219_FLL_MAX - height, 1,
 					   imx219->mode->vts_def - height);
 	hblank = IMX219_PPL_DEFAULT - imx219->mode->width;
 	imx219->hblank = v4l2_ctrl_new_std(ctrl_hdlr, &imx219_ctrl_ops,
-- 
2.53.0

