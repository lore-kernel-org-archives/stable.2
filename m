Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31F42256C6D
	for <stable@vger.kernel.org>; Wed,  5 Aug 2026 00:08:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785888523; cv=none; b=W9i0T/2lpFHnMKst7y8s3pTj3YBzbDLwh6LsSmkv7YkXbH4CIOQ8lt+raJ/PxGgal9NXTkMjhoOQXYjTd4P7nLGbrGJWCzogaXTVhsNrbj09mqok00trFfqKvHlGwWk+fwLZkbCgoXvMttQ0+arJSYjuzQDxgkElYb1XnvWPJRk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785888523; c=relaxed/simple;
	bh=4Mq4O7vsKqFAgdnBJsC9TDh7VyyDANvy4kaNJ014d+I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NoRjFXI4al9MVYDTTQHvBfx43RW3fAMkoTlAHSxWhx5Sr9thHyjg4tRFxHTBU1iY8HXpbvwCPygwg+lUwfTVB/sWP1OElW1UdA47DpsG8CAnYaEPfLQ7KebVtkoewuY1bAxafZTH0aBwSaUhcddT2BKWQVB0nb8m7EE81QvxN8M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mEbGo6fg; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mEbGo6fg"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6F7E01F00A3A;
	Wed,  5 Aug 2026 00:08:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785888522;
	bh=Iht3wk1//1rAN9VZ76GJALUj3SMGtQvZaq9p/pO5P0A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=mEbGo6fg0zOAU6ifaOWZ1+Ei77ZczkjNSNDGmsGEA3I5p1FNP0/Wy+AnA3U4SNMkG
	 aEGTqzW8T80Xnp8PBzvs8dmIq3oKAthsigrcXcj6stWtrKxAqOLSfNvx32WpccKW5D
	 A3VYW33/BWD4ZSNrENXKamc0sNChXsfxYKFsn7I2yny4ZkPj+r8KknJdd48LvGFsA1
	 OifksDJ2YsN9SpyhrtYsQ1Wa1ahAj++Bo7Y9IpkN3npInNZqVC0RQZE04CavOmBmqc
	 hekkAh/ho8oeSwdh+ZUd9ectj4qBqtJeOqqld90RJ4ctUqhKATHH4p02zP3RxvRhEl
	 KRs3RiKfpjrkA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Jai Luthra <jai.luthra@ideasonboard.com>,
	Dave Stevenson <dave.stevenson@raspberrypi.com>,
	Sakari Ailus <sakari.ailus@linux.intel.com>,
	Hans Verkuil <hverkuil@xs4all.nl>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y 3/4] media: i2c: imx219: Rename VTS to FRM_LENGTH
Date: Tue,  4 Aug 2026 20:08:36 -0400
Message-ID: <20260805000837.3912288-3-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260805000837.3912288-1-sashal@kernel.org>
References: <2026072955-ice-rug-c64f@gregkh>
 <20260805000837.3912288-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jai Luthra <jai.luthra@ideasonboard.com>

[ Upstream commit 04f78503f99ae7e9887c7fe5e4bc54a7cfb10fe0 ]

The IMX219 datasheet refers to the vertical length + blanking as
FRM_LENGTH instead of VTS.

Reviewed-by: Dave Stevenson <dave.stevenson@raspberrypi.com>
Signed-off-by: Jai Luthra <jai.luthra@ideasonboard.com>
Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>
Signed-off-by: Hans Verkuil <hverkuil@xs4all.nl>
Stable-dep-of: 2c4f1ba73543 ("media: imx219: Fix maximum frame length in lines")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/media/i2c/imx219.c | 33 ++++++++++++++++-----------------
 1 file changed, 16 insertions(+), 17 deletions(-)

diff --git a/drivers/media/i2c/imx219.c b/drivers/media/i2c/imx219.c
index 7917277b18bc7..1c51886d3a073 100644
--- a/drivers/media/i2c/imx219.c
+++ b/drivers/media/i2c/imx219.c
@@ -47,12 +47,6 @@
 
 #define IMX219_DEFAULT_LINK_FREQ	456000000
 
-/* V_TIMING internal */
-#define IMX219_REG_VTS			0x0160
-#define IMX219_FLL_MAX			0xffff
-
-#define IMX219_VBLANK_MIN		32
-
 /* HBLANK control - read only */
 #define IMX219_PPL_DEFAULT		3448
 
@@ -77,6 +71,11 @@
 #define IMX219_DGTL_GAIN_DEFAULT	0x0100
 #define IMX219_DGTL_GAIN_STEP		1
 
+/* V_TIMING internal */
+#define IMX219_REG_FRM_LENGTH_A		0x0160
+#define IMX219_FLL_MAX			0xffff
+#define IMX219_VBLANK_MIN		32
+
 #define IMX219_REG_ORIENTATION		0x0172
 
 /* Binning  Mode */
@@ -135,7 +134,7 @@ struct imx219_mode {
 	struct v4l2_rect crop;
 
 	/* V-timing */
-	unsigned int vts_def;
+	unsigned int fll_def;
 
 	/* Default register values */
 	struct imx219_reg_list reg_list;
@@ -376,7 +375,7 @@ static const struct imx219_mode supported_modes[] = {
 			.width = 3280,
 			.height = 2464
 		},
-		.vts_def = 3526,
+		.fll_def = 3526,
 		.reg_list = {
 			.num_of_regs = ARRAY_SIZE(mode_3280x2464_regs),
 			.regs = mode_3280x2464_regs,
@@ -393,7 +392,7 @@ static const struct imx219_mode supported_modes[] = {
 			.width = 1920,
 			.height = 1080
 		},
-		.vts_def = 1763,
+		.fll_def = 1763,
 		.reg_list = {
 			.num_of_regs = ARRAY_SIZE(mode_1920_1080_regs),
 			.regs = mode_1920_1080_regs,
@@ -410,7 +409,7 @@ static const struct imx219_mode supported_modes[] = {
 			.width = 3280,
 			.height = 2464
 		},
-		.vts_def = 1763,
+		.fll_def = 1763,
 		.reg_list = {
 			.num_of_regs = ARRAY_SIZE(mode_1640_1232_regs),
 			.regs = mode_1640_1232_regs,
@@ -427,7 +426,7 @@ static const struct imx219_mode supported_modes[] = {
 			.width = 1280,
 			.height = 960
 		},
-		.vts_def = 1763,
+		.fll_def = 1763,
 		.reg_list = {
 			.num_of_regs = ARRAY_SIZE(mode_640_480_regs),
 			.regs = mode_640_480_regs,
@@ -665,7 +664,7 @@ static int imx219_set_ctrl(struct v4l2_ctrl *ctrl)
 				       imx219->vflip->val << 1);
 		break;
 	case V4L2_CID_VBLANK:
-		ret = imx219_write_reg(imx219, IMX219_REG_VTS,
+		ret = imx219_write_reg(imx219, IMX219_REG_FRM_LENGTH_A,
 				       IMX219_REG_VALUE_16BIT,
 				       imx219->mode->height + ctrl->val);
 		break;
@@ -832,11 +831,11 @@ static int imx219_set_pad_format(struct v4l2_subdev *sd,
 		/* Update limits and set FPS to default */
 		__v4l2_ctrl_modify_range(imx219->vblank, IMX219_VBLANK_MIN,
 					 IMX219_FLL_MAX - mode->height, 1,
-					 mode->vts_def - mode->height);
+					 mode->fll_def - mode->height);
 		__v4l2_ctrl_s_ctrl(imx219->vblank,
-				   mode->vts_def - mode->height);
+				   mode->fll_def - mode->height);
 		/* Update max exposure while meeting expected vblanking */
-		exposure_max = mode->vts_def - 4;
+		exposure_max = mode->fll_def - 4;
 		exposure_def = (exposure_max < IMX219_EXPOSURE_DEFAULT) ?
 			exposure_max : IMX219_EXPOSURE_DEFAULT;
 		__v4l2_ctrl_modify_range(imx219->exposure,
@@ -1252,14 +1251,14 @@ static int imx219_init_controls(struct imx219 *imx219)
 	imx219->vblank = v4l2_ctrl_new_std(ctrl_hdlr, &imx219_ctrl_ops,
 					   V4L2_CID_VBLANK, IMX219_VBLANK_MIN,
 					   IMX219_FLL_MAX - height, 1,
-					   imx219->mode->vts_def - height);
+					   imx219->mode->fll_def - height);
 	hblank = IMX219_PPL_DEFAULT - imx219->mode->width;
 	imx219->hblank = v4l2_ctrl_new_std(ctrl_hdlr, &imx219_ctrl_ops,
 					   V4L2_CID_HBLANK, hblank, hblank,
 					   1, hblank);
 	if (imx219->hblank)
 		imx219->hblank->flags |= V4L2_CTRL_FLAG_READ_ONLY;
-	exposure_max = imx219->mode->vts_def - 4;
+	exposure_max = imx219->mode->fll_def - 4;
 	exposure_def = (exposure_max < IMX219_EXPOSURE_DEFAULT) ?
 		exposure_max : IMX219_EXPOSURE_DEFAULT;
 	imx219->exposure = v4l2_ctrl_new_std(ctrl_hdlr, &imx219_ctrl_ops,
-- 
2.53.0

