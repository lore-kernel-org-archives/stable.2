Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794311432;
	b=R8sqMzgIlYStwoSWOaapRNenP65Z5Mcxh2tIBBs1NxJaRfFhEghgUkRidfLGcM0dbfnR
	 F2nztriBPz6xPC7WVNu9cpYi43GaISbcBD51E8gu+UnyLEivWDAJhAzrZglpBLun0mLxg
	 EZ9weK7QImJLntJ1atebZUjWS8WXmCXAmguFfIWvSZFe8kSijHrnOudJF1G3iVK70Ifxb
	 E/WrvC6ct3KN1zl6SL0IHgwOyFh7w4iQGKszxyrB+xKHV9w70Z+a8N1D9fh4uwONqYP76
	 8qQPP7JCnHHLjqzNbrp3GBM63GlrFP9dJPwjx/jELCQ61/i/4I3tK7j/Ihn4Lz+AeLQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794311432;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=uGSS/0Eqzr1A/mSFQlg2ydEkg7K0JLyGd5nPMNOR3MY=;
	b=jqScotKZQFcgb6BQ4yF7w3i6NNElrJ5ltYLEvkNKHiBgAilAqMeqTnYbX4xyqQopx65h
	 yDQbuGE9wQIRLZfqjZlK6tAWW2VBLdFehs+5o5v1YfwRix/h7THHY8XnWtRRGxjHh8IQg
	 vU4tJaJILwv0vPSiDuF/MQmDezP88EsF8e1zQhVwoyP1kvT+k/R462Pn5mZAW0Xfgx4b9
	 MDfpumblWCb4LOTGZnznqpg2HK4fweC7M625rNcaUyt+EMw6IJ1EJzLBcDNjshOGvFbpY
	 BKM2KDylrT99TbYaisKLwID0QGt1DKad6yhoXtqLc8WqMzif/PqIdjwMTCvduH2x2Nw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=cDWeaDUG;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBEE6606A331
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 11:50:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=cDWeaDUG
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8FF8D1F008A6;
	Tue, 10 Nov 2026 11:50:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794311431;
	bh=uGSS/0Eqzr1A/mSFQlg2ydEkg7K0JLyGd5nPMNOR3MY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=cDWeaDUGsyvdRRBaHgM0ueKZTeFsBydg8Tt+TMRFvBjEezO7MgFO+K8/yBagZO+yO
	 kQYUSUY9s7L6xMSZLXVvhMRrdfHkEHQ7mGp6wATVQi6gra/cgLqEly9uV1dBk0OvTE
	 S4g1P1RENZCMXqGweSGR6AnNpKx1rO/KCmDaASvVp30A7bBrPjf9fI2T4dHakd2j9N
	 x6BHCsa4oLpt5GVo2+uRlhkTagV/zO3su0qnKHUU7xr8+uAyImZFpPCiE903xMgEXc
	 EVSNTbqopN+cqxf6NpiHIFfHdy+IM9y109dRdykl+UyCHp6oraNcWpH43ciYRzrQas
	 WVs38W9kh5Qiw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sakari Ailus <sakari.ailus@linux.intel.com>,
	Dave Stevenson <dave.stevenson@raspberrypi.com>,
	Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18.y 2/3] media: imx219: Account rate_factor in setting upper exposure limit
Date: Tue, 10 Nov 2026 06:50:27 -0500
Message-ID: <20261110115020.612803-2-sashal@kernel.org>
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

[ Upstream commit db111b66f2db7f3f79d9359f4a9762e832d6fde9 ]

The rate_factor multiplier is used to multiply a few values in the
sensor's timing configuration and the exposure time is one of them. This
also needs to be taken into account in exposure time margin: multiply it
by rate_factor so that sensor's exposure time margin is respected.

Fixes: f513997119f4 ("media: i2c: imx219: Scale the pixel rate for analog binning")
Cc: stable@vger.kernel.org
Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>
Reviewed-by: Dave Stevenson <dave.stevenson@raspberrypi.com>
Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Stable-dep-of: 57043aef0a04 ("media: imx219: Account for rate_factor in control steps")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/media/i2c/imx219.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/media/i2c/imx219.c b/drivers/media/i2c/imx219.c
index 4160a482fdce3..87c4d8942135c 100644
--- a/drivers/media/i2c/imx219.c
+++ b/drivers/media/i2c/imx219.c
@@ -462,7 +462,8 @@ static int imx219_set_ctrl(struct v4l2_ctrl *ctrl)
 		int exposure_max, exposure_def;
 
 		/* Update max exposure while meeting expected vblanking */
-		exposure_max = format->height + ctrl->val - IMX219_EXPOSURE_OFFSET;
+		exposure_max = format->height + ctrl->val -
+			IMX219_EXPOSURE_OFFSET * rate_factor;
 		exposure_def = (exposure_max < IMX219_EXPOSURE_DEFAULT) ?
 				exposure_max : IMX219_EXPOSURE_DEFAULT;
 		ret = __v4l2_ctrl_modify_range(imx219->exposure,
@@ -895,6 +896,7 @@ static int imx219_set_pad_format(struct v4l2_subdev *sd,
 	crop->top = (IMX219_NATIVE_HEIGHT - crop->height) / 2;
 
 	if (fmt->which == V4L2_SUBDEV_FORMAT_ACTIVE) {
+		int rate_factor = imx219_get_rate_factor(state);
 		int exposure_max;
 		int exposure_def;
 		int hblank, llp_min;
@@ -913,7 +915,8 @@ static int imx219_set_pad_format(struct v4l2_subdev *sd,
 			return ret;
 
 		/* Update max exposure while meeting expected vblanking */
-		exposure_max = mode->fll_def - IMX219_EXPOSURE_OFFSET;
+		exposure_max = mode->fll_def -
+			IMX219_EXPOSURE_OFFSET * rate_factor;
 		exposure_def = (exposure_max < IMX219_EXPOSURE_DEFAULT) ?
 				exposure_max : IMX219_EXPOSURE_DEFAULT;
 		ret = __v4l2_ctrl_modify_range(imx219->exposure,
-- 
2.53.0

