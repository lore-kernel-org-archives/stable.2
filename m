Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794281033;
	b=xxJDh9wF89CtS0veAbpW0T89zVRsBjvXg1lIeaRZeYx3581xCmqTJU5v4VsKyFgXPUmK
	 w7DcCizUwDulxgxD9EG6WjIXinmoGfHwoWw94PZC1yOoVF9YH3qA4gBBGYa0WrbsTE978
	 uHyTTtYffXMGIQk/5o+vPsIIk5S5dFJrA8RgTG49gHRO20ZtkeMepxNIBq6dt58otSRyv
	 kE3b+ODc9pv71g2fO47YOK/Tbb21hRbwn//q8B6UKwH5ZaSqq0SMOisrrXJkTzM07t3wj
	 CyTYsazFoQEMlSHAGTl74WbJ+3tVM71QGjtv3c0Mf89QQRLaCJujfMld026aX8rGnrA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794281033;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=AIcFzhBqftQpT1dnPCo0oii7gTW7ORuSYLtAkQrUC5I=;
	b=Ek7HCMTr/SXUavSq8D7Lca0KZwfHMP9ReEfG6JbktuLkaJ85UZit2qmHOUL7kl41YAYY
	 4D39e7wDZpi67fAHIhofy/1o4fuRoWeG5n67wJdJeqBMbXUtDKvM90LplSbvrKmcD5iyu
	 a3zB+B0xZery+hxWNMDD+pq9gxsafOl38U5mTUi3D97DUgROFdM2mZBtX5Q6sX0E42N21
	 o48YSbmF2QPQ+xU48nihhCI4kmNvLJFYhKnatpD9/3CJlE2uw5i1Pn9iyehigTAoa4u5a
	 zwsVyJPE0tqwt064hdnycDVFI3aOwxvFMhKogQrfN8oU3+vXguwOl+mVnF7dpnpcK4g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=JNOCig6L;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 757CF606A336
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 03:23:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=JNOCig6L
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7CE611F008A1;
	Tue, 10 Nov 2026 03:23:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794281033;
	bh=AIcFzhBqftQpT1dnPCo0oii7gTW7ORuSYLtAkQrUC5I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=JNOCig6LtzwHQvfB6HYRELhRo/11hj3oLZoZJ8dekSCBtIKrOzOmS1V2EaIU9EydK
	 eEJE/PDSm4PPcACpdQXUKL9nCfcJldTY4ej8TBRQKgEyy6b9YP67CkhBcEL50u34Q/
	 V9AA68pTM/I+3qVtnrzvVzNbBKL0x83E247fZ7EV4kt4/EwiTCpQ26zxnnVr8T9i3v
	 dXbiOHmCpszqD7Zn/dve68Twhj+SqwLRaVERUNjDrbkgiXwUbSCKEr7yjYdY9iNolB
	 aylrLk7chba75gZvtkrWxsaS7hSL5/cF0k+7Mzsy6RQclMYz9SVjtEhYDgGqFTbCVD
	 HxrJrYkD30gVA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sakari Ailus <sakari.ailus@linux.intel.com>,
	Dave Stevenson <dave.stevenson@raspberrypi.com>,
	Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18.y 2/2] media: imx219: The horizontal blanking step is 8
Date: Mon,  9 Nov 2026 22:23:50 -0500
Message-ID: <20261110032344.182965-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261110032344.182965-1-sashal@kernel.org>
References: <20261107050657-failed-6.18-47576c541e9b@kernel.org>
 <20261110032344.182965-1-sashal@kernel.org>
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

[ Upstream commit 47576c541e9b473841742bd0686d4940f5c93564 ]

The step for the LINE_LENGTH_A register on imx219 is 8. Take this into
account in creating and modifying the horizontal blanking control. The
minimum line length in pixels as well as the horizontal blanking values
are already divisible by 8.

Fixes: cd5e2fd89923 ("media: i2c: imx219: make HBLANK r/w to allow longer exposures")
Cc: stable@vger.kernel.org
Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>
Reviewed-by: Dave Stevenson <dave.stevenson@raspberrypi.com>
Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/media/i2c/imx219.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/media/i2c/imx219.c b/drivers/media/i2c/imx219.c
index ffb04a56419ad..76e65cedbb32f 100644
--- a/drivers/media/i2c/imx219.c
+++ b/drivers/media/i2c/imx219.c
@@ -77,6 +77,7 @@
 #define IMX219_LLP_MIN			0x0d78
 #define IMX219_BINNED_LLP_MIN		0x0de8
 #define IMX219_LLP_MAX			0x7ff0
+#define IMX219_LLP_STEP			8
 
 #define IMX219_REG_X_ADD_STA_A		CCI_REG16(0x0164)
 #define IMX219_REG_X_ADD_END_A		CCI_REG16(0x0166)
@@ -587,7 +588,8 @@ static int imx219_init_controls(struct imx219 *imx219)
 	imx219->hblank = v4l2_ctrl_new_std(ctrl_hdlr, &imx219_ctrl_ops,
 					   V4L2_CID_HBLANK,
 					   IMX219_LLP_MIN - mode->width,
-					   IMX219_LLP_MAX - mode->width, 1,
+					   IMX219_LLP_MAX - mode->width,
+					   IMX219_LLP_STEP,
 					   IMX219_LLP_MIN - mode->width);
 	exposure_max = mode->fll_def - 4;
 	exposure_def = (exposure_max < IMX219_EXPOSURE_DEFAULT) ?
@@ -932,7 +934,8 @@ static int imx219_set_pad_format(struct v4l2_subdev *sd,
 				  IMX219_BINNED_LLP_MIN : IMX219_LLP_MIN;
 		ret = __v4l2_ctrl_modify_range(imx219->hblank,
 					       llp_min - mode->width,
-					       IMX219_LLP_MAX - mode->width, 1,
+					       IMX219_LLP_MAX - mode->width,
+					       IMX219_LLP_STEP,
 					       llp_min - mode->width);
 		if (ret)
 			return ret;
-- 
2.53.0

