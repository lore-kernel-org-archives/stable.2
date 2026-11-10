Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794311433;
	b=Hvv5bPvdt0jHcl1TTwV8Kd3YZavBemMz09jdKOX+XrxAkVrJBFVfXw43sNo1fs5SQj30
	 p+RQv5ZkPDX16iEZ/PBklrc0EKtiTFNcrXUlPrsmWYwEPI6Yqe7yVYA75FO7OTAkiGy3e
	 b6iFNuvsCQEVHI512H9IhtMkV19SYB0b8BDlGpm/w+XDlgCCmJnyPm1koK99co+NaLXCt
	 +S/MHzbu4LYSIZsExgdkp2QmjwdQWbLaCWDcq63ctGYvzyJLZSYs2gyhz+b1bIRBFA4WC
	 bGlphrff0VApljrnLDcZzBL7bCrmJEF3gMeqTu+aJI7Rs3lFYddzmfps4toMu8zKdtg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794311433;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=hLHnTCX+XqtEwDQH+pbwlVTXpuT7hvq7AVAfioowBa0=;
	b=wPLQ1/nu34MLJ+5g5xAVBv5wAZxnsIxy4QopkQTqAy5L+29NnKOJUk8QFj6nhQEdW8LD
	 ajQEdC0l1w0NoE01PPjmYyckTUnWHbvLPY8cvwqlmBAwI6NPgs3i7VoSOGsYrj4Rqri0i
	 1N7eKOOsWSDijnFU6NUeIrMhgYVmhtQmtV7Tqd+dr6HUMq9hnv2q29B2G/kFsD7yp7pCY
	 4OTvrQG53BPjX6tYtSX3tdJuoidrdaB3Dx2zp2cHks5/5fGo/kQmtqN/NYZiUUW/V80zl
	 4lkFBn97xBo4DHryo3ox7aCeTIL40kMthy1xxVjQSwPisc5NduS1k3xHqn5Fg8tZwhg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hdbI7mDx;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6FCC606A331
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 11:50:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hdbI7mDx
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9318D1F008A1;
	Tue, 10 Nov 2026 11:50:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794311432;
	bh=hLHnTCX+XqtEwDQH+pbwlVTXpuT7hvq7AVAfioowBa0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=hdbI7mDxmyf1p64csJ1Bi1dAAYE+gOCxR6yjd1Lk/SPX5D3lVWV2DsRkvCbFFzPAx
	 xLtKzCgPthdRUhG3JcS1q09+sQASuo92HOuOsS+xrWO3mWjtnQFmZcLp5EobDRdpMk
	 8KJycGP1TKUBkLnAUNWUWw1NWJPR3PBwj1VH39UjShHd++j12DmKWF+OJIzvqqYAnr
	 A+cNyDy4p8BKI52m31EghKbq8R8jeJEbh5XYi3Jh8qcAbGxD6Wq6JXfpe8VzU8DWq6
	 qiwILj+8p2Zp8knsv2YqR0yLJWT25VqH5m0i+v1zLs9bbXNaxZ1AY0f/pNcCpK90HA
	 u/ZXBUShBcXAg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sakari Ailus <sakari.ailus@linux.intel.com>,
	Dave Stevenson <dave.stevenson@raspberrypi.com>,
	Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18.y 3/3] media: imx219: Account for rate_factor in control steps
Date: Tue, 10 Nov 2026 06:50:28 -0500
Message-ID: <20261110115020.612803-3-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261110115020.612803-1-sashal@kernel.org>
References: <20261107050653-failed-6.18-57043aef0a04@kernel.org>
 <20261110115020.612803-1-sashal@kernel.org>
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

From: Sakari Ailus <sakari.ailus@linux.intel.com>

[ Upstream commit 57043aef0a04bd96d97881422590e71c1e4c45b1 ]

The controls that are divided by the rate_factor before writing them to
the registers have the step of the value of the rate_factor. Take this
into account when the control's range is modified. The controls are
created in a configuration where rate_factor is always 1, hence there's no
need to change the code adding new controls.

Fixes: f513997119f4 ("media: i2c: imx219: Scale the pixel rate for analog binning")
Cc: stable@vger.kernel.org
Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>
Reviewed-by: Dave Stevenson <dave.stevenson@raspberrypi.com>
Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/media/i2c/imx219.c | 16 +++++++---------
 1 file changed, 7 insertions(+), 9 deletions(-)

diff --git a/drivers/media/i2c/imx219.c b/drivers/media/i2c/imx219.c
index 87c4d8942135c..e399a87f99266 100644
--- a/drivers/media/i2c/imx219.c
+++ b/drivers/media/i2c/imx219.c
@@ -326,13 +326,13 @@ static const struct imx219_mode supported_modes[] = {
 		/* 2x2 binned 60fps mode */
 		.width = 1640,
 		.height = 1232,
-		.fll_def = 1707,
+		.fll_def = 1706,
 	},
 	{
 		/* 640x480 60fps mode */
 		.width = 640,
 		.height = 480,
-		.fll_def = 1707,
+		.fll_def = 1706,
 	},
 };
 
@@ -469,8 +469,7 @@ static int imx219_set_ctrl(struct v4l2_ctrl *ctrl)
 		ret = __v4l2_ctrl_modify_range(imx219->exposure,
 					       imx219->exposure->minimum,
 					       exposure_max,
-					       imx219->exposure->step,
-					       exposure_def);
+					       rate_factor, exposure_def);
 		if (ret)
 			return ret;
 
@@ -904,7 +903,8 @@ static int imx219_set_pad_format(struct v4l2_subdev *sd,
 
 		/* Update limits and set FPS to default */
 		ret = __v4l2_ctrl_modify_range(imx219->vblank, IMX219_VBLANK_MIN,
-					       IMX219_FLL_MAX - mode->height, 1,
+					       IMX219_FLL_MAX - mode->height,
+					       rate_factor,
 					       mode->fll_def - mode->height);
 		if (ret)
 			return ret;
@@ -922,8 +922,7 @@ static int imx219_set_pad_format(struct v4l2_subdev *sd,
 		ret = __v4l2_ctrl_modify_range(imx219->exposure,
 					       imx219->exposure->minimum,
 					       exposure_max,
-					       imx219->exposure->step,
-					       exposure_def);
+					       rate_factor, exposure_def);
 		if (ret)
 			return ret;
 
@@ -956,8 +955,7 @@ static int imx219_set_pad_format(struct v4l2_subdev *sd,
 			return ret;
 
 		/* Scale the pixel rate based on the mode specific factor */
-		pixel_rate = imx219_get_pixel_rate(imx219) *
-			     imx219_get_rate_factor(state);
+		pixel_rate = imx219_get_pixel_rate(imx219) * rate_factor;
 		ret = __v4l2_ctrl_modify_range(imx219->pixel_rate, pixel_rate,
 					       pixel_rate, 1, pixel_rate);
 		if (ret)
-- 
2.53.0

