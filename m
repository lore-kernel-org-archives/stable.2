Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF8313ACA58
	for <stable@vger.kernel.org>; Tue,  4 Aug 2026 01:06:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785805606; cv=none; b=DKvQBiLRDCmOl6idU4L3Ggi+CN9bMb2FXQsp4eh5YlubRiplDjyRawa5KhV/z2geMO1+Y7HBFzIbzf76l6dgst1h6mQPnnK7p6J5PoTSnViBwPNBhNzB/qBQFTICSP52znhtjevJE6vu55blUq0nvJ9rRoi/5Jx+6Pu06wNHc54=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785805606; c=relaxed/simple;
	bh=qUlCUtfd3rR54SmC2lNsIAF7ZzgCEw2AdeZ9bPBFc6k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uFq9n17LYeMsPyAOH2Sv2JUqQzW8ZQkZeHiJHT3okVNi4yAs+hE5PkFXBIURic0O4TIxrdAUYEWy44I+2aAM2A/qBtVTXWALbCQcQYWpAgTaM32bKuAyuereSGVcZxd8TJNeLJTGH0LxAHL+X8N/WgJkHvwMRx5Y39NgxKbA54Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NLLP9d9H; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NLLP9d9H"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EF0191F000E9;
	Tue,  4 Aug 2026 01:06:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785805604;
	bh=O18bz6uDNCVdRt2nRuB4vewuIannE5nk4f/UKOY5sIM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=NLLP9d9HspSZjg+d7ZeS8mZaiIBLaxpiOZ4CNuPK9oOXeOX7uSfb4vh5Y0AvX154A
	 TwwfBzgPaKg8+1S98NJNQPA6w42Igl4QliZbwrjekU2WbA1kuniMXMDv5OdnFv7nGu
	 kODf0dAtohlO5BUQXTwrw+dJOkHdq/Obr6vewfKYS/a1Mh88HgsoluVMlKbC2ZdP7M
	 jYCx3X+VBhwwaSZAVKDdYUJQyXBICbO3mJoBSsgyJ+ITf0AOo8SughZeloYqrT/Ews
	 RVVrn8fDXl6WkB8Y22C//dxB4iSba12+5XxggerfdCKvJdKODdrbRHqLfs5/6TXUyM
	 koJRTvn1rnpng==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Jai Luthra <jai.luthra@ideasonboard.com>,
	Dave Stevenson <dave.stevenson@raspberrypi.com>,
	Sakari Ailus <sakari.ailus@linux.intel.com>,
	Hans Verkuil <hverkuil@xs4all.nl>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y 1/2] media: i2c: imx219: Rename VTS to FRM_LENGTH
Date: Mon,  3 Aug 2026 21:06:41 -0400
Message-ID: <20260804010642.2350939-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026072955-secret-automaker-f113@gregkh>
References: <2026072955-secret-automaker-f113@gregkh>
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
 drivers/media/i2c/imx219.c | 31 +++++++++++++++----------------
 1 file changed, 15 insertions(+), 16 deletions(-)

diff --git a/drivers/media/i2c/imx219.c b/drivers/media/i2c/imx219.c
index d057c74f7172d..bc4d8ecb60d19 100644
--- a/drivers/media/i2c/imx219.c
+++ b/drivers/media/i2c/imx219.c
@@ -71,9 +71,8 @@
 #define IMX219_EXPOSURE_MAX		65535
 
 /* V_TIMING internal */
-#define IMX219_REG_VTS			CCI_REG16(0x0160)
-#define IMX219_VTS_MAX			0xffff
-
+#define IMX219_REG_FRM_LENGTH_A		CCI_REG16(0x0160)
+#define IMX219_FLL_MAX			0xffff
 #define IMX219_VBLANK_MIN		32
 
 /* HBLANK control - read only */
@@ -156,7 +155,7 @@ struct imx219_mode {
 	unsigned int height;
 
 	/* V-timing */
-	unsigned int vts_def;
+	unsigned int fll_def;
 };
 
 static const struct cci_reg_sequence imx219_common_regs[] = {
@@ -315,25 +314,25 @@ static const struct imx219_mode supported_modes[] = {
 		/* 8MPix 15fps mode */
 		.width = 3280,
 		.height = 2464,
-		.vts_def = 3526,
+		.fll_def = 3526,
 	},
 	{
 		/* 1080P 30fps cropped */
 		.width = 1920,
 		.height = 1080,
-		.vts_def = 1763,
+		.fll_def = 1763,
 	},
 	{
 		/* 2x2 binned 30fps mode */
 		.width = 1640,
 		.height = 1232,
-		.vts_def = 1763,
+		.fll_def = 1763,
 	},
 	{
 		/* 640x480 30fps mode */
 		.width = 640,
 		.height = 480,
-		.vts_def = 1763,
+		.fll_def = 1763,
 	},
 };
 
@@ -444,7 +443,7 @@ static int imx219_set_ctrl(struct v4l2_ctrl *ctrl)
 			  imx219->hflip->val | imx219->vflip->val << 1, &ret);
 		break;
 	case V4L2_CID_VBLANK:
-		cci_write(imx219->regmap, IMX219_REG_VTS,
+		cci_write(imx219->regmap, IMX219_REG_FRM_LENGTH_A,
 			  format->height + ctrl->val, &ret);
 		break;
 	case V4L2_CID_TEST_PATTERN_RED:
@@ -519,15 +518,15 @@ static int imx219_init_controls(struct imx219 *imx219)
 	/* Initial vblank/hblank/exposure parameters based on current mode */
 	imx219->vblank = v4l2_ctrl_new_std(ctrl_hdlr, &imx219_ctrl_ops,
 					   V4L2_CID_VBLANK, IMX219_VBLANK_MIN,
-					   IMX219_VTS_MAX - mode->height, 1,
-					   mode->vts_def - mode->height);
+					   IMX219_FLL_MAX - mode->height, 1,
+					   mode->fll_def - mode->height);
 	hblank = IMX219_PPL_DEFAULT - mode->width;
 	imx219->hblank = v4l2_ctrl_new_std(ctrl_hdlr, &imx219_ctrl_ops,
 					   V4L2_CID_HBLANK, hblank, hblank,
 					   1, hblank);
 	if (imx219->hblank)
 		imx219->hblank->flags |= V4L2_CTRL_FLAG_READ_ONLY;
-	exposure_max = mode->vts_def - 4;
+	exposure_max = mode->fll_def - 4;
 	exposure_def = (exposure_max < IMX219_EXPOSURE_DEFAULT) ?
 		exposure_max : IMX219_EXPOSURE_DEFAULT;
 	imx219->exposure = v4l2_ctrl_new_std(ctrl_hdlr, &imx219_ctrl_ops,
@@ -878,12 +877,12 @@ static int imx219_set_pad_format(struct v4l2_subdev *sd,
 
 		/* Update limits and set FPS to default */
 		__v4l2_ctrl_modify_range(imx219->vblank, IMX219_VBLANK_MIN,
-					 IMX219_VTS_MAX - mode->height, 1,
-					 mode->vts_def - mode->height);
+					 IMX219_FLL_MAX - mode->height, 1,
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
-- 
2.53.0

