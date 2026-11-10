Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794311430;
	b=kJwAM66H925IDpi+k2Ib2TMS2xt+oiDbXEAsec6hHOW5TG6jSewDnB7ZGnFCGXgbj4Tg
	 PIjxX5+hjJRStmuKi/zpZUJWcmPDV1TLfqfXSXZiT0fH0KNgWDXdgmv9lR2CDXn75jF2l
	 b+z9kOcsO2A7AX40znrkEXb+WqtfdkbdpHcrywpybTdlfGek+7XIjHxQ4xPRJDvPesUye
	 NFvNO7pfBVLGxGH4Kn/PtK4WdOI/ebNE2jexwKyBEQ9HA7HH83NBPoZucOkojbPGgs7kQ
	 pL1IHmqejrQw3v5SrX/KWNrlGb1sMSfJDcaDDy4X/+G67AaLZKlsVPofRkTOpRYZDZw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794311430;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=p8fzHl7pHL3OuljLT41RGu1TOv9vXkKSa9EZuUlyq4A=;
	b=Oj1eMYSm7AYe7ZbwN2jICsSql/ET2DR2ByKK1Hq5fIXBhqS97hl5jouzc8zyb+4Da7Wq
	 O3a5ooZpOLIm/38vBlkEUBy3jXQT0x7kaKK/ooL5z+j63t67IEzjTOzTpFYEG316w1D2p
	 7yr878/e163GJfw3noMBpGm1UklkZonz+Zr0xeT2H5mbS6zbxvU7DLrlP4VP1WiS2E5Cz
	 TOgQYI9iDeANZi1+HTJY3CVRelVOcjCuwm5A+/0jM8NHHEGEBkxnZ5oBnOpRn9suOA4yO
	 rkVYjT159uKnNoPepIVw4FNd96B8sJebrOps6eZyYCMaTHJ3z6717dUNTv+Z44z5l2g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=lD9Y1JzT;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62EBD606D4FF
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 11:50:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=lD9Y1JzT
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5E7BC1F008A1;
	Tue, 10 Nov 2026 11:50:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794311430;
	bh=p8fzHl7pHL3OuljLT41RGu1TOv9vXkKSa9EZuUlyq4A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=lD9Y1JzTenAUAeljHlnNSsIBIkTsJ+2oDVH3bzYZsqDXIFAVuhuwQXBGdEqkB8q5I
	 jIO6AoHNC3uX63fVH7kD2+ksVl+fE1n83Imf41pF9+rjUrg6UL0ihpHImhhiOraNGh
	 rp65yoCIQ8G00cnj1AYwI0oNTi/COAlNc19kdTvNMUpZVd9WOtc21KNooD8pGxZ74P
	 tD2eJni7ZTApAKmm93RqlwDFpgozu7jzw+0jQ4gIiS/idcV1+uueCrPcLlwaMMEJM1
	 Utwr9BnRGpJoqML6i2Ox72AqQPiJG1C9R55kAVaDFSpi0SUHhvpIVugOm0TE9hyl7t
	 S0+nwLNYTwVZA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Tarang Raval <tarang.raval@siliconsignals.io>,
	Dave Stevenson <dave.stevenson@raspberrypi.com>,
	Kieran Bingham <kieran.bingham@ideasonboard.com>,
	Sakari Ailus <sakari.ailus@linux.intel.com>,
	Hans Verkuil <hverkuil+cisco@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18.y 1/3] media: i2c: imx219: Replace exposure magic value with named constant
Date: Tue, 10 Nov 2026 06:50:26 -0500
Message-ID: <20261110115020.612803-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261107050653-failed-6.18-57043aef0a04@kernel.org>
References: <20261107050653-failed-6.18-57043aef0a04@kernel.org>
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

[ Upstream commit 9a9ba098e7ba6b89efaddeabf0716a84a0f54c99 ]

Introduce IMX219_EXPOSURE_OFFSET (4) and use it instead of the literal
'4' when computing the maximum coarse exposure. The IMX219 datasheet
specifies the maximum storage time as frame_length_lines - 4.
(Ref: Datasheet section 5-7-1)

Also fix one indentation issue for consistency.

Signed-off-by: Tarang Raval <tarang.raval@siliconsignals.io>
Reviewed-by: Dave Stevenson <dave.stevenson@raspberrypi.com>
Reviewed-by: Kieran Bingham <kieran.bingham@ideasonboard.com>
Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>
Signed-off-by: Hans Verkuil <hverkuil+cisco@kernel.org>
Stable-dep-of: 57043aef0a04 ("media: imx219: Account for rate_factor in control steps")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
Depends on <20261110032344.182965-1-sashal@kernel.org>

 drivers/media/i2c/imx219.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/drivers/media/i2c/imx219.c b/drivers/media/i2c/imx219.c
index 76e65cedbb32f..4160a482fdce3 100644
--- a/drivers/media/i2c/imx219.c
+++ b/drivers/media/i2c/imx219.c
@@ -68,6 +68,7 @@
 #define IMX219_EXPOSURE_STEP		1
 #define IMX219_EXPOSURE_DEFAULT		0x640
 #define IMX219_EXPOSURE_MAX		65535
+#define IMX219_EXPOSURE_OFFSET			4
 
 /* V_TIMING internal */
 #define IMX219_REG_FRM_LENGTH_A		CCI_REG16(0x0160)
@@ -461,9 +462,9 @@ static int imx219_set_ctrl(struct v4l2_ctrl *ctrl)
 		int exposure_max, exposure_def;
 
 		/* Update max exposure while meeting expected vblanking */
-		exposure_max = format->height + ctrl->val - 4;
+		exposure_max = format->height + ctrl->val - IMX219_EXPOSURE_OFFSET;
 		exposure_def = (exposure_max < IMX219_EXPOSURE_DEFAULT) ?
-			exposure_max : IMX219_EXPOSURE_DEFAULT;
+				exposure_max : IMX219_EXPOSURE_DEFAULT;
 		ret = __v4l2_ctrl_modify_range(imx219->exposure,
 					       imx219->exposure->minimum,
 					       exposure_max,
@@ -591,9 +592,9 @@ static int imx219_init_controls(struct imx219 *imx219)
 					   IMX219_LLP_MAX - mode->width,
 					   IMX219_LLP_STEP,
 					   IMX219_LLP_MIN - mode->width);
-	exposure_max = mode->fll_def - 4;
+	exposure_max = mode->fll_def - IMX219_EXPOSURE_OFFSET;
 	exposure_def = (exposure_max < IMX219_EXPOSURE_DEFAULT) ?
-		exposure_max : IMX219_EXPOSURE_DEFAULT;
+			exposure_max : IMX219_EXPOSURE_DEFAULT;
 	imx219->exposure = v4l2_ctrl_new_std(ctrl_hdlr, &imx219_ctrl_ops,
 					     V4L2_CID_EXPOSURE,
 					     IMX219_EXPOSURE_MIN, exposure_max,
@@ -912,9 +913,9 @@ static int imx219_set_pad_format(struct v4l2_subdev *sd,
 			return ret;
 
 		/* Update max exposure while meeting expected vblanking */
-		exposure_max = mode->fll_def - 4;
+		exposure_max = mode->fll_def - IMX219_EXPOSURE_OFFSET;
 		exposure_def = (exposure_max < IMX219_EXPOSURE_DEFAULT) ?
-			exposure_max : IMX219_EXPOSURE_DEFAULT;
+				exposure_max : IMX219_EXPOSURE_DEFAULT;
 		ret = __v4l2_ctrl_modify_range(imx219->exposure,
 					       imx219->exposure->minimum,
 					       exposure_max,
-- 
2.53.0

