Received: from fhigh-a2-smtp.messagingengine.com (fhigh-a2-smtp.messagingengine.com [103.168.172.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F0A5360EE5;
	Wed, 30 Sep 2026 02:01:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790733679; cv=none; b=XsRTVShN7tCR42hJXbKbbhJkLsoDtwC1IdRt69YuhRXIBdeNCPr62IHaG/uv6pEE/9Sgtxm57S0NbNRjIB44FBN58kDQvCmESKmLjG3PVH25VERi5zTE4bbDMIG24FBX6RnRaor1wkF5doiDKqUCEMw9J26KIzk1wobzpyrCqT0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790733679; c=relaxed/simple;
	bh=6Pty6e/BsuARxstt0uljApujK3Ir0Y0DM1bCKScy6rU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=GsNs0X4H6CQDwXGfBKEMA5EiglPbpp10uOBQLKA4WgzFh5jQeyjAO7al9BQUBgx1FYImIhYoHQ2TFq8e4MqW0qqx8NUb5KPRyObdPmyAiIxb24WkV/dFsnJ8N9lW8xepuuPTilph00kjVhmtEM2whI+AXlCauZOKJQlDz8iTn3w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=kode54.net; spf=pass smtp.mailfrom=kode54.net; dkim=pass (2048-bit key) header.d=kode54.net header.i=@kode54.net header.b=b7+GjVH8; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=QfkNs7tN; arc=none smtp.client-ip=103.168.172.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=kode54.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kode54.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kode54.net header.i=@kode54.net header.b="b7+GjVH8";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="QfkNs7tN"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 3E14C1400327;
	Tue, 29 Sep 2026 22:01:16 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Tue, 29 Sep 2026 22:01:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kode54.net; h=cc
	:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to; s=fm1; t=1790733676; x=1790820076; bh=Ly1y7IF0HFIJnT198Bnkw
	vjYBp3S6axzsFhDj3HrqYg=; b=b7+GjVH8jDqsOJb07dLPqpckl5muwt5JQ5jj9
	ChheHJCM+JPSUesXBSvqkhAaTEW6a65PEXGl9r+h5KfizEegZNUBtimNGF++nmzs
	yn01i+DDLBme36oRQJsvfr35g3Ti5lvV28JqhX18wXGaVQl/l3mrQKP/Du0vNX9e
	vhpSllUOaa+C/VmgjzhvUpGw/Zl9eNP7gKb+2SZvWvYHplDgYXHrf9wPlJ6BTKWg
	hIMPJX8f0R4i/a3ogwCu6HPy9RUtMgooc+mDTURmZYbDFRGKHwkUoFmr5R8ksC7C
	ZwiTNxMRV0ste3SgrJHaIxADexO/ekKccqUg5HcsypKjN99ag==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1790733676; x=1790820076; bh=Ly1y7IF0HFIJnT198BnkwvjYBp3S6axzsFh
	Dj3HrqYg=; b=QfkNs7tNOw7vLOA2lNNeq7manuCMoUHx6QYDhhzhwX5BMGWW2aH
	CSqJDHP423jMVwgVBY3iy4Sf2ZmCgHive5mKw2tpjtVpQ70SRIS+jl4LV7fs0wVm
	PkvlyL2Tw2+0cyKIXiOAcR9c99/IYCgor+6tH+sKD1pF2wV/alGKMvNFynElfVol
	xrZcD5zMkyzkFId7+fGCyRjfelHRgHDLF2jPDELW4eewRA1MVmy/0gYI8uIu/vkq
	t3pC1Or28t0ovCr3OsWdjt5IBb18bX/7jQB/MvBJhAVMgfgXtfJcAzGs+p+5i9DC
	X8pcy8e3s7J22sQ+mKdxuOKcyH4Qz/5ogaQ==
X-ME-Sender: <xms:a228aruYAANBIZ_nTejCL87INVWs0jD0n0KkUet4Jm5ivk9fxHVP6w>
    <xme:a228anYoDVab2hiCzassLdKASxVRK3m_eMfhkVk3sqI_PDQKirMeZ8O5tPuPPDbsX
    JnG1X02EvZDnpiA45MlnUe7z1e1J26gu2wPcrckiYbDuGn20aiRMQs>
X-ME-Received: <xmr:a228aty0xCR-Hfkp5qkpFLFEPK7PlhR5QydNOdwMztM_0ipyxkQ7JXmqEknbXo9VomNz0jtuAoluY7gr1ZEZtAo>
X-ME-Proxy-Cause: dmFkZTEPMcW4vJDRdzUnK4djoVSsdnnwRjLFCruDVjPsainYLB3oKAY+Ex2CsDtt1nZMBo
    26hA70uBS+4BCKyGravu0b+omsVL7olxrH2bXo3Yq4HauTMapEuzjlxhVWJcRVPjwXuxY3
    Efb2SbE88HdXj3HYDi1+RTPwKr2u68xwBhhBGfvFk+TUG9VBMUldyuu1/e8xYuy2tBEAiK
    zgxNU7y5s/o51HBmnBhk6G7SAHNVNRImGUU0FXy/zvvqdDB2b3Uf5ZGHMnOGcoZwQq4Qv2
    opeg/GAk7/S8/wJIIeomnOA64/yxeGleGp4K2t1Fp9k+hvvc0mCY+sVQHTq3FAv3tTb3Iq
    4BkFENAYsD8h9CllKFwYuIujipg6GmKBNyns9iW5mJ7DF+zh/65FtAYXLZKnw6vin8mHKF
    qHvG4WdmGjnv46Lxkj7PUG2mzik/+poWG0HhRidWKKHP3GpwrbsZtYxZeKZP7XW+11kQJv
    imi7+HlQcKlazV8MDTBdcMgKeSMiQbD8QK4xI0j/+Dk+h/OodZTMOBm/AYLObYrFx/0fNI
    M0i/nOkmvtMUhMYNaDEPN3guS28p+kchTchSaeILx4ItD2uZmNQIrtTOrhYEK73Y+Y93h7
    XaSC3DZ5MhGPoQVkgQLexAbtbsHzmhW99xSHJDhizml/L1wSy7apTWAyZeQg
X-ME-Proxy: <xmx:a228avit3OORqY-347gSy4GgAr7ceZlBw6Qf1LlNAIjwkwGeU3iedw>
    <xmx:a228apm-JqXDB4j7-W7eEXjPJxD9xImJJAzFXN-_iBCd6UiU4MyuBQ>
    <xmx:a228algLeBKv6zUrk5wBHjkORrB0O9uUGv8Y4kWzeh9vdkiajSLXvA>
    <xmx:a228at24IsT-BfZxoa18BY3LuR9d7NTEgDPtHzZ5xvypwOZK58cXSQ>
    <xmx:bG28atDyTFSEw43bC4wdIccUpgL1tHMjJjvGuHONsjDJQMykGR3D7l-P>
Feedback-ID: i9ec6488d:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 29 Sep 2026 22:01:14 -0400 (EDT)
From: Christopher Snowhill <chris@kode54.net>
To: "Mauro Carvalho Chehab" <mchehab@kernel.org>
Cc: Christopher Snowhill <chris@kode54.net>,
	linux-media@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	"Bradford Love" <brad@nextdimension.cc>,
	stable@vger.kernel.org
Subject: [PATCH] media: em28xx: fix inverted tuner capability check for VBI device
Date: Tue, 29 Sep 2026 19:00:06 -0700
Message-ID: <20260930020010.85250-2-chris@kode54.net>
X-Mailer: git-send-email 2.56.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Commit 8e53399c63c3 ("media: em28xx: Add support for Empia em2828X
bridge") changed the condition for setting V4L2_CAP_TUNER on the VBI
device from "dev->tuner_type != TUNER_ABSENT" to a check of the video
device's capabilities, but inverted it: the VBI node now advertises a
tuner only when the video node does not have one.

On boards without a tuner (e.g. the MyGica iGrabber, card=105) the VBI
device's device_caps therefore contain V4L2_CAP_TUNER, while the shared
vidioc_querycap() correctly omits it from cap->capabilities. This trips
the sanity check in v4l_querycap() whenever the VBI node is queried,
for example by udev's v4l_id on every hotplug:

  WARNING: drivers/media/v4l2-core/v4l2-ioctl.c:1119 at v4l_querycap+0xff/0x110 [videodev]
  (cap->capabilities & (vfd->device_caps | V4L2_CAP_DEVICE_CAPS)) != (vfd->device_caps | V4L2_CAP_DEVICE_CAPS)

It also leaves the tuner ioctls enabled on the VBI node of tuner-less
boards and disables them on boards that do have a tuner.

Restore the intended logic so the VBI device has V4L2_CAP_TUNER exactly
when the video device does.

Fixes: 8e53399c63c3 ("media: em28xx: Add support for Empia em2828X bridge")
Assisted-by: LLM
Signed-off-by: Christopher Snowhill <chris@kode54.net>
Cc: stable@vger.kernel.org
---
 drivers/media/usb/em28xx/em28xx-video.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/media/usb/em28xx/em28xx-video.c b/drivers/media/usb/em28xx/em28xx-video.c
index c418add65bb5..cdf1dc692b08 100644
--- a/drivers/media/usb/em28xx/em28xx-video.c
+++ b/drivers/media/usb/em28xx/em28xx-video.c
@@ -3001,7 +3001,7 @@ static int em28xx_v4l2_init(struct em28xx *dev)
 		v4l2->vbi_dev.queue->lock = &v4l2->vb_vbi_queue_lock;
 		v4l2->vbi_dev.device_caps = V4L2_CAP_STREAMING |
 			V4L2_CAP_READWRITE | V4L2_CAP_VBI_CAPTURE;
-		if ((v4l2->vdev.device_caps & V4L2_CAP_TUNER) == 0)
+		if (v4l2->vdev.device_caps & V4L2_CAP_TUNER)
 			v4l2->vbi_dev.device_caps |= V4L2_CAP_TUNER;
 
 		/* disable inapplicable ioctls */
-- 
2.55.0

