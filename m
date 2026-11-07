Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794046015;
	b=Jrc//gkB5fb5GKhq8ARUKWjIe1t8czI93Yl12N1OBLJICot4dbiYh50Wfxvebvq1TiTB
	 NJzkQq8oIsNuDddjTQ8sZehMfU3xlYryOtqxx50SreK+VXqJuPnZATrOcHfWIk0nYNNB7
	 Tg+w8tQO9HbFKMZ/FpTyhXPnAdZ0k0V5WK31eV1cVBDMA/r4jEYlVA0dE9iMHtnb2kSFm
	 5DaowOynovVHjOCTVBjvav5p1RGCxxbjw3tOahO4UAnzT/+uuJIstGd1OZTj5tLpi4p9H
	 m6p6wS0wsxb7X95rYC70sU26cRm8g3PmvqxcE4Tw3JYdsi8RntQRljNVOXN1/9/aseg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794046015;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=RIMJDE0yi/dmjiNKw7fSUW39wOcby5TLUoYzht5ygDY=;
	b=4Ubcx1Db1/U+sYffOACSA5rhyoX4MeZYlIx6tlCaaY4gm0ZwpvvGZykBfLFy4bWNKrq8
	 10sQDZGVF9jxeym+ZTaCDiJbC+AkB/ykaANNPlD2lpCJ9haURkcfAhgH+iSqvb2x1sTO9
	 Kohl4xMSg1Ig7SjArJZ/PC7t5f3q5YHE5G4khdsQT/WLxdw649UgEN3x52Fj6IAGuxFZZ
	 N+Zu2Ewofmra92uSXjmqHkyWrA2EnJJVleaEgpOvI1sCFvOVbmctPS8FjIhrfKI/PoOGT
	 SRWTGPtK405hvnzjMHJmJE9t+6Rj694q06oY7Eujw4xKtV646Jxb8K9EzAEZDhnvRjA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=FL+2mVVu;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1423606A326
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 10:06:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=FL+2mVVu
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3727C1F0089F;
	Sat,  7 Nov 2026 10:06:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794046014;
	bh=RIMJDE0yi/dmjiNKw7fSUW39wOcby5TLUoYzht5ygDY=;
	h=From:To:Cc:Subject:Date;
	b=FL+2mVVu5eyfpsiUAdcOAMbdW/6UC8jQKCfn7zLAH6FRoqek5GX0HntAxFBxJ2cgZ
	 yXHQGeHRKDFLdhGvQNYGx6JIG4FiXbGaklYrMdj+bmo5j2e9V2UzV4UgBxXIftmWIB
	 Z2eN7o26cqJ2iZTi+ujr2DiYx+aHYm7hnKyUTAs954d0h384oLDCUwGN+fBN9rNplZ
	 spJDuTmQqH1lKcY0pI9zHc+Fydx50PdBUNWHuCuyW5I84WUjtij3Vsl8ibO7UmU3dW
	 ljZL+mvrePBKz8OX9KsQLpy3gQH5gxyro37gxrxahrlqBRMvIa47+a0AGWCI1V7bO/
	 v60El5puGZnaw==
From: Sasha Levin <sashal@kernel.org>
To: sakari.ailus@linux.intel.com,
	dave.stevenson@raspberrypi.com,
	laurent.pinchart@ideasonboard.com
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] media: imx219: Account for rate_factor in control steps" failed to apply to 6.18-stable tree
Date: Sat,  7 Nov 2026 05:06:53 -0500
Message-ID: <20261107050653-failed-6.18-57043aef0a04@kernel.org>
X-Mailer: git-send-email 2.53.0
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The patch below does not apply to the 6.18-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.18.y
git checkout FETCH_HEAD
git cherry-pick -x 57043aef0a04bd96d97881422590e71c1e4c45b1
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261107050653-failed-6.18-57043aef0a04@kernel.org' --subject-prefix 'PATCH 6.18.y' 'HEAD^..'

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From 57043aef0a04bd96d97881422590e71c1e4c45b1 Mon Sep 17 00:00:00 2001
From: Sakari Ailus <sakari.ailus@linux.intel.com>
Date: Mon, 22 Jun 2026 14:16:45 +0300
Subject: [PATCH] media: imx219: Account for rate_factor in control steps

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
---
 drivers/media/i2c/imx219.c | 16 +++++++---------
 1 file changed, 7 insertions(+), 9 deletions(-)

diff --git a/drivers/media/i2c/imx219.c b/drivers/media/i2c/imx219.c
index 5184523de8bed..b1f29037af742 100644
--- a/drivers/media/i2c/imx219.c
+++ b/drivers/media/i2c/imx219.c
@@ -340,13 +340,13 @@ static const struct imx219_mode supported_modes[] = {
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
 
@@ -473,8 +473,7 @@ static int imx219_set_ctrl(struct v4l2_ctrl *ctrl)
 		ret = __v4l2_ctrl_modify_range(imx219->exposure,
 					       imx219->exposure->minimum,
 					       exposure_max,
-					       imx219->exposure->step,
-					       exposure_def);
+					       rate_factor, exposure_def);
 		if (ret)
 			return ret;
 
@@ -902,7 +901,8 @@ static int imx219_set_pad_format(struct v4l2_subdev *sd,
 
 		/* Update limits and set FPS to default */
 		ret = __v4l2_ctrl_modify_range(imx219->vblank, IMX219_VBLANK_MIN,
-					       IMX219_FLL_MAX - mode->height, 1,
+					       IMX219_FLL_MAX - mode->height,
+					       rate_factor,
 					       mode->fll_def - mode->height);
 		if (ret)
 			return ret;
@@ -920,8 +920,7 @@ static int imx219_set_pad_format(struct v4l2_subdev *sd,
 		ret = __v4l2_ctrl_modify_range(imx219->exposure,
 					       imx219->exposure->minimum,
 					       exposure_max,
-					       imx219->exposure->step,
-					       exposure_def);
+					       rate_factor, exposure_def);
 		if (ret)
 			return ret;
 
@@ -946,8 +945,7 @@ static int imx219_set_pad_format(struct v4l2_subdev *sd,
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




