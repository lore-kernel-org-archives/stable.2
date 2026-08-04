Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC2F5456E08
	for <stable@vger.kernel.org>; Tue,  4 Aug 2026 10:47:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785840461; cv=none; b=mH3UmcQ7jCaJm5vWSazjrZcSNt0d9UaOC82SUxMmeA/zSYaXCrqT+PcOPDivT+5x04mWqS4FsREvQTf8HTBOS4RR3EywiNa1NKvkXXQ5UdieX9qT0rvUNcMALVJ/q17DB3rfvYJYdlEurffaV9Bgxh9ZYoSgjTQOJUKN8D6yYkg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785840461; c=relaxed/simple;
	bh=/bnzrbzLyXBzjVal595DsnDjcRILcVBRVFkCP1y2VYo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=omMFr6iwZ/wu+SNtK87zUB+laTSLnXV2EA6Hu/mjC6sDx0NoJ+BxjUAgaO35bsCgCSfPYj5BdOmv8B6CKLDiESnLCHolgXrzOLZMFi+OF2LzTH2dmksmUfr+LbniMxOf7DQCxY7QK5yyFmaXRLx3F89+wNvBz7USQGkYNb7wOSw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=foFz9yVS; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="foFz9yVS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 863C71F000E9;
	Tue,  4 Aug 2026 10:47:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785840460;
	bh=BgI5PjOXYWyvefE7zK/DSrkHqAnKz1UgQ6defLWRGV0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=foFz9yVSbSXIqKeqEFJYtZx8ujXorx7MEJ/VJhbfWFNjcDS6cFGFqHNXVmTInzlnd
	 vX8ynL6tmBaJBFrIGtq8bM+zwaK2W2UoZ8VXIK+eMx3LDcyTyuDPZP6E8+5Tls166U
	 hfDrT6ErI6/wLGQHVaRK6tyig9T5EzXbftR13+kbD3r5BTVTrUO2Hl3iqdVgaikgUJ
	 fBPBMx+xglvUQSA5WaVU+I7Xcr6p+BC82+bW8fhL/sgxJsTWDaLycUkjAOu4r8Tb1Y
	 LV4r5sXH6YJWjsodz6yh2WgpWy91BWuQJTapVQ2rud0HJgdAktCGgojJcgQIpyIHNE
	 jOMQ3/l74jCEw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
	Jacopo Mondi <jacopo.mondi@ideasonboard.com>,
	Dave Stevenson <dave.stevenson@raspberrypi.com>,
	Sakari Ailus <sakari.ailus@linux.intel.com>,
	Hans Verkuil <hverkuil-cisco@xs4all.nl>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y 1/7] media: i2c: imx219: Access height from active format in imx219_set_ctrl
Date: Tue,  4 Aug 2026 06:47:31 -0400
Message-ID: <20260804104737.2827302-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026072955-retouch-favorably-ee17@gregkh>
References: <2026072955-retouch-favorably-ee17@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

[ Upstream commit aa86ac42eec4dd7e987c12390a0a487187e2d9ae ]

Use the active format height instead of the mode height in
imx219_set_ctrl(). This prepares for dropping the mode field from the
imx219 structure.

The state is retrieved using v4l2_subdev_get_locked_active_state() as
the subdev active state and the control handler share the same lock.

Signed-off-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Reviewed-by: Jacopo Mondi <jacopo.mondi@ideasonboard.com>
Reviewed-by: Dave Stevenson <dave.stevenson@raspberrypi.com>
Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>
Signed-off-by: Hans Verkuil <hverkuil-cisco@xs4all.nl>
Stable-dep-of: 2c4f1ba73543 ("media: imx219: Fix maximum frame length in lines")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/media/i2c/imx219.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/media/i2c/imx219.c b/drivers/media/i2c/imx219.c
index 03cbacd77a804..64c4d2d538bd1 100644
--- a/drivers/media/i2c/imx219.c
+++ b/drivers/media/i2c/imx219.c
@@ -500,13 +500,18 @@ static int imx219_set_ctrl(struct v4l2_ctrl *ctrl)
 	struct imx219 *imx219 =
 		container_of(ctrl->handler, struct imx219, ctrl_handler);
 	struct i2c_client *client = v4l2_get_subdevdata(&imx219->sd);
+	const struct v4l2_mbus_framefmt *format;
+	struct v4l2_subdev_state *state;
 	int ret = 0;
 
+	state = v4l2_subdev_get_locked_active_state(&imx219->sd);
+	format = v4l2_subdev_get_pad_format(&imx219->sd, state, 0);
+
 	if (ctrl->id == V4L2_CID_VBLANK) {
 		int exposure_max, exposure_def;
 
 		/* Update max exposure while meeting expected vblanking */
-		exposure_max = imx219->mode->height + ctrl->val - 4;
+		exposure_max = format->height + ctrl->val - 4;
 		exposure_def = (exposure_max < IMX219_EXPOSURE_DEFAULT) ?
 			exposure_max : IMX219_EXPOSURE_DEFAULT;
 		__v4l2_ctrl_modify_range(imx219->exposure,
@@ -546,7 +551,7 @@ static int imx219_set_ctrl(struct v4l2_ctrl *ctrl)
 		break;
 	case V4L2_CID_VBLANK:
 		cci_write(imx219->regmap, IMX219_REG_VTS,
-			  imx219->mode->height + ctrl->val, &ret);
+			  format->height + ctrl->val, &ret);
 		break;
 	case V4L2_CID_TEST_PATTERN_RED:
 		cci_write(imx219->regmap, IMX219_REG_TESTP_RED,
-- 
2.53.0

