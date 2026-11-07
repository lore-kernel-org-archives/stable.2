Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794046017;
	b=IQpQkoI128/cnqFCCAh8yw+WOFcMZWEer7fqkna/LMr+T84U8MdN/Gzm5/YykZvlbNtI
	 RSx7gzp7CD4ktZqUrhxQwkbrK3UT/sQTl2IVX7IqNcNIIOTzW2OYkmkohWS8NwPwt/15t
	 AS/gdH+j0PMwpIGEp2fpkaMsAVP7wMMzDBF9Pj6Tno8+cqez2cQ1uFrNWxaAyGb6bGkeN
	 TrH3W4ShN1KwZOASX7VBPag9ugfzWdd6k0n2kMoynbdqKcwXw+U41wRyx/hmolIITmSlw
	 GYoLfz53eRYf+o1EzXlhygiUU0Fc0cog9OgtMURfkCDx+18YBIreDErbHpkSbJkCBew==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794046017;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=MQrgdbriL+Z4JJvBqmLUY2u5PE9cy7kafSWJgnm+WTA=;
	b=SoB8geTJZSpcfYSFadJwHlIZJfdLJG1AELLEWAEiz4WVrKWM/fvumdzFK3nYTnJaVhhZ
	 LQD60e21AD6CtC10Ijz5lz2cTcSLOl22CEVl50b6FPSlaS59GXWDeLJvpqLx1C5KXvPTn
	 awEu+DBGXAuZvUgcCj98OXZVFeN8UriJoPpwqYnqz5i5oebwCZvPBGoWXcVmkCaleasE7
	 SPeJBMafhqFcs3JXwDjDNflgf48dtpxQDfUKLtCXGh0RFh9Rh1R7jF9meKPj9n8eGH0Uk
	 TzFg+jyTk3wx0zh52A1Udn/++GPF4SdeawbKpTQE2tsQGXm/i9LH3CDGM/5AJvn2yXA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=iCanZumS;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D9FD606A326
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 10:06:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=iCanZumS
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 770B91F0089F;
	Sat,  7 Nov 2026 10:06:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794046017;
	bh=MQrgdbriL+Z4JJvBqmLUY2u5PE9cy7kafSWJgnm+WTA=;
	h=From:To:Cc:Subject:Date;
	b=iCanZumSLqQGn6+1irMZ6ez+1DO9LbFV8BCaXinPtv2azaMRXW91exHGjems5PBR7
	 9jV1ACaQ6HexoWTkf03PuKV2BvcuuLk72+o5Kzz6R3iUB4+MDAMpmlqTq68I6eUY4d
	 7Rxc6933s/XahejMzV2Ic3igxU+5DS8DEmJxke2o6dEBD4nAnX8RzgRqkw8JepkFwq
	 OmfMAaDwiL3PeqLSMdjQi/1W++2wXrEKzwVS1ODpY43Db8Yo4azKUa0LzeK+ydj73G
	 CTQDBgoFDSNJm6Yb1aqku8srZN/9QpgsxIoXexnnyjAR9WscTl/z1laB9cCfbz9Xu8
	 vse4ChYat3Uvg==
From: Sasha Levin <sashal@kernel.org>
To: sakari.ailus@linux.intel.com,
	dave.stevenson@raspberrypi.com,
	laurent.pinchart@ideasonboard.com
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] media: imx219: Account rate_factor in setting upper exposure limit" failed to apply to 6.18-stable tree
Date: Sat,  7 Nov 2026 05:06:55 -0500
Message-ID: <20261107050655-failed-6.18-db111b66f2db@kernel.org>
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
git cherry-pick -x db111b66f2db7f3f79d9359f4a9762e832d6fde9
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261107050655-failed-6.18-db111b66f2db@kernel.org' --subject-prefix 'PATCH 6.18.y' 'HEAD^..'

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From db111b66f2db7f3f79d9359f4a9762e832d6fde9 Mon Sep 17 00:00:00 2001
From: Sakari Ailus <sakari.ailus@linux.intel.com>
Date: Mon, 20 Apr 2026 20:31:49 +0300
Subject: [PATCH] media: imx219: Account rate_factor in setting upper exposure
 limit

The rate_factor multiplier is used to multiply a few values in the
sensor's timing configuration and the exposure time is one of them. This
also needs to be taken into account in exposure time margin: multiply it
by rate_factor so that sensor's exposure time margin is respected.

Fixes: f513997119f4 ("media: i2c: imx219: Scale the pixel rate for analog binning")
Cc: stable@vger.kernel.org
Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>
Reviewed-by: Dave Stevenson <dave.stevenson@raspberrypi.com>
Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
---
 drivers/media/i2c/imx219.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/media/i2c/imx219.c b/drivers/media/i2c/imx219.c
index 9571f3622d2d4..5184523de8bed 100644
--- a/drivers/media/i2c/imx219.c
+++ b/drivers/media/i2c/imx219.c
@@ -466,7 +466,8 @@ static int imx219_set_ctrl(struct v4l2_ctrl *ctrl)
 		int exposure_max, exposure_def;
 
 		/* Update max exposure while meeting expected vblanking */
-		exposure_max = format->height + ctrl->val - IMX219_EXPOSURE_OFFSET;
+		exposure_max = format->height + ctrl->val -
+			IMX219_EXPOSURE_OFFSET * rate_factor;
 		exposure_def = (exposure_max < IMX219_EXPOSURE_DEFAULT) ?
 				exposure_max : IMX219_EXPOSURE_DEFAULT;
 		ret = __v4l2_ctrl_modify_range(imx219->exposure,
@@ -893,6 +894,7 @@ static int imx219_set_pad_format(struct v4l2_subdev *sd,
 	crop->top = (IMX219_NATIVE_HEIGHT - crop->height) / 2;
 
 	if (fmt->which == V4L2_SUBDEV_FORMAT_ACTIVE) {
+		int rate_factor = imx219_get_rate_factor(state);
 		int exposure_max;
 		int exposure_def;
 		int llp_min;
@@ -911,7 +913,8 @@ static int imx219_set_pad_format(struct v4l2_subdev *sd,
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




