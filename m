Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.45
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795687708;
	b=KATurwxrjgzFsg7YhPOW7IpYVE6I6T8SoDOHjNm+5ruUs2uVfail3VUo0LcQljq8ayVU
	 Qn0dZpY1dboufIVtSGpZLCMrgs7zTBl6AuX53q7ijPQBCHWhNBZbmmhnSAfgtwD7sX5W5
	 7444ZzkL1KK/fWo2QgbHS/aj5XxADLW97jPjdcfqyQSlbM44uKW4RAdZVdnuIsuE6O+KN
	 5l0ADyh5CGVsibHvSi5L9R5q/E9KPdzHFzC6l79sVoduXnGglKQLVm8E2KM2wmiyXJ0bH
	 Od80PKyoa9qnKVeF+xbnsvohjyBIFTOfLAu6/0B2rUkuz/iQSwOkEjBTuie5YsDdBwQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795687708;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=yhJLheRK2k8iW0h1BrUFUeUwi944GYqdiiaue7ukRoM=;
	b=H7YTVisd4Tq6osONOXXbhw1N2qIn5/eHCJNtRUwLB82EoJB6FoQHQuom1d9uQa1KdU6M
	 t2rBEXasnM4TTpiiyxUNhv2lRsq88q4NzMPjEQgPSf22myaAqJ1+SkYwCa8Ykddh2YzSc
	 29qHDTfjH1moNrCvYAoycwaEJPJRVWHAQh/gdH+7oXBz6v2U5a/hwOpCOVwiG8EzxzN/N
	 TxAD8SGJy8eRDJMPM81zUk7HPmCucmnvEops87oF5Z+IiG//ZeQvqKOs5EquCnDEOSfqR
	 iZWo3CVyyah3Ir4FRcMjyUaSsh0b/asf2LpjxrFeOmkLR1+eqhG02nnC/c5Y2T9eglw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=zmgTBLo2;
	arc=none smtp.remote-ip=209.85.128.45
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D16EE606A336
	for <stable@vger.kernel.org>; Thu, 26 Nov 2026 10:08:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D16EE606A336
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=zmgTBLo2
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-4bb70074ab2so72451855e9.0
        for <stable@vger.kernel.org>; Thu, 26 Nov 2026 02:08:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795687706; x=1796292506; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=yhJLheRK2k8iW0h1BrUFUeUwi944GYqdiiaue7ukRoM=;
        b=zmgTBLo27luXCYwakoBn1tfqpIuR9XRYiH9hY97k2rY8emO8toHDfYZY+poj9cEtzN
         hlTWo05Wqnl9HaB94VSrynltCn8bZMciKwMxdHw/x1s3+MOupcVx5SluLOcUbCT5x2Lp
         k8SAgaUMrI7vFCBw9/Je04NioiV62CJ9hmq2TmQxNkURZUl+LnGHLOS2IruzdawKfklp
         sNaDUbnNAbxssrV0wf+GqDlijXrymPnOfdqV+hLEyvuwL2JGbh9X7AIdvRe8GYxDO0au
         xLF2/UcHQQ6IOvXN4O3Cv9kNIAaYQxgFjkm9HDzrd4JYpdq06cg+Fg94pO3y1SnSoO0N
         vhMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795687706; x=1796292506;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=yhJLheRK2k8iW0h1BrUFUeUwi944GYqdiiaue7ukRoM=;
        b=auwwMshaciZLfHBV30FtwiwlJbxgtW/n7c89wLUrhhFyZlDBHGciyEA8K1LVPwN3P7
         ofpt0kcrPt2JM5IQmcGzRbJOUYw4Tjm6KSUaa7bVox0DqqnOplTYhxD+u8sCJcsqTBBd
         8t7kJxRxL7fTLHOksDT4ICp/hlylX5PiWuVHAIpP+yHQhtSomoG+b5SJw5SPBi9TMpbG
         WIGnGCIekA3wLtbxtKvRAVJ3RZN+G5/4LWfSUTspGckI85oDcG6ZiB9B31Q+KFC1cYjw
         sMtJ6ymbkIn+bw6ee1XEgVW9ldhXMi7ZyknrEaTRpmpHljNF5OjAK9koaxUvjK8NRBdm
         VWsg==
X-Forwarded-Encrypted: i=1; AL+hErHScDS+onpcYaQBkUROATiIMe/6lqZCZcAyflBaE8KZyrAu1a0k9X9Pa7GcUqViDxe6KAX8TDU=@vger.kernel.org
X-Gm-Message-State: APuU4Z81bw8LGWCVNI0nYQ69BmF1oueUbw74qqVliydEdUefaxl9JGSi
	eOZ5US0i3FBWroXxU9wV5LHHlm3HPJYIXxBSc+Ra/piVAM3NRjw4kRHQ
X-Gm-Gg: AZFdTZeL/h4iZWG8sWEUl4kDlkhPCaRbfSOfBUcB78A0RE2N7qWnzuBxmDJK+fLXF6Z
	1kL2aJc5gJ5Sph0A0aKgP2/t36bkR5AZYNSKXCk0f1E/STGNSr2mqXETh9OdP2Y2A2fIgb2CPZy
	C1LJNLbX8vgZam/ow60jnRTjlOCgBzWRk6rKDO+ahVJYBeTSg/wvGJyrdizDw0p+DYoKJ5lv2gv
	5fmADvzQ9EUpAvT7YI4kp1sIdaMTzpLmEkCxH6ME3fAxVYpqwRMUGfCpwgTv1fBSEdMVAVOer9U
	gXmp9KnntHUv+8lCXKVYO8QUm0OcvUIV1d/HPowVZiQISWD16njn422C2VqxVE545JdIU6Htk7H
	i93vlfm2gPqY4/o81RkBofFl1drs23RbYwXV5Ncw8gIq4CZayLOfcoTv+uSQVxC53DvtmWYsydK
	oTEnLTc+za00ccg+eqZDGCdSFHDI3DG6BNon5Gi4NYHajtZCr10bkJ+JJ4ner+HVqhh38uLDGE8
	vILwMwn400CAvmeifMSN5qExnfXY+T8O8hl4i0guXU/1wO26KdZaf7yCojaLM/Mo+vB9bO8JLJG
	uWfVoY9T4CAfgqs4FFR3PjR+c5BDxHRrzXFQSBa+9Mvpm878vAieGecScoAN9g2DwVJxF9FAFU9
	V
X-Received: by 2002:a05:600c:e549:10b0:4bb:a60a:fc8 with SMTP id 5b1f17b1804b1-4bba60a11d2mr59103625e9.35.1795687706012;
        Thu, 26 Nov 2026 02:08:26 -0800 (PST)
Received: from DESKTOP-V28CTA4.localdomain ([37.111.157.27])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb853b2437sm830600705e9.13.2026.11.26.02.08.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Nov 2026 02:08:25 -0800 (PST)
From: Arbab Haider <arbabhaider649@gmail.com>
To: linux-media@vger.kernel.org
Cc: mchehab@kernel.org,
	linux-kernel@vger.kernel.org,
	Arbab Haider <arbabhaider649@gmail.com>,
	Hans Verkuil <hverkuil@kernel.org>,
	stable@vger.kernel.org
Subject: [PATCH v3] media: em28xx: defer media device cleanup until final device release
Date: Thu, 26 Nov 2026 15:08:07 +0500
Message-ID: <20261126100807.356864-1-arbabhaider649@gmail.com>
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
Content-Transfer-Encoding: 8bit

em28xx_unregister_media_device() clears v4l2_dev.mdev and frees the
media device during disconnect. The driver holds dev->lock, but
v4l2_release() checks whether the device supports media requests before
calling the driver's release callback, which takes that lock. A
concurrent close can still dereference the media device after it has
been freed.

Unregister the media device on disconnect and defer cleanup and freeing
it to em28xx_free_device(). The V4L2 instance holds an em28xx device
reference until the last V4L2 device reference is dropped, which keeps
v4l2_dev.mdev valid throughout V4L2 release. Keep immediate cleanup in
the probe error path, before any V4L2 nodes have been registered.

Fixes: 37ecc7b1278f ("[media] em28xx: add media controller support")
Cc: stable@vger.kernel.org
Signed-off-by: Arbab Haider <arbabhaider649@gmail.com>
---
Changes in v3:
- Rebase onto media-committers/next and replace its disconnect-time
  mdev pointer clear with a lifetime guarantee for V4L2 users.
- Send the cleanup fix on its own, following acceptance of v2 patch 2.

Changes in v2:
- Add the Fixes tag as requested by Media CI.

Validation
- Built drivers/media/usb/em28xx/ on x86_64 with MEDIA_CONTROLLER,
  KASAN and UBSAN enabled.
- Booted QEMU x86_64 with MEDIA_CONTROLLER, KASAN and UBSAN and passed
  three em28xx and em28xx-v4l module load/unload cycles. This smoke test
  ran without an attached em28xx device.

Codex assisted with the rebase, source review, commit message and build.

 drivers/media/usb/em28xx/em28xx-cards.c | 14 +++++++++++---
 1 file changed, 11 insertions(+), 3 deletions(-)

diff --git a/drivers/media/usb/em28xx/em28xx-cards.c b/drivers/media/usb/em28xx/em28xx-cards.c
index f4b6dcf597..cf0312fc46 100644
--- a/drivers/media/usb/em28xx/em28xx-cards.c
+++ b/drivers/media/usb/em28xx/em28xx-cards.c
@@ -3773,11 +3773,16 @@ static int em28xx_media_device_init(struct em28xx *dev,
 static void em28xx_unregister_media_device(struct em28xx *dev)
 {
 #ifdef CONFIG_MEDIA_CONTROLLER
-	if (dev->media_dev) {
+	if (dev->media_dev)
 		media_device_unregister(dev->media_dev);
+#endif
+}
+
+static void em28xx_cleanup_media_device(struct em28xx *dev)
+{
+#ifdef CONFIG_MEDIA_CONTROLLER
+	if (dev->media_dev) {
 		media_device_cleanup(dev->media_dev);
-		if (dev->v4l2)
-			dev->v4l2->v4l2_dev.mdev = NULL;
 		kfree(dev->media_dev);
 		dev->media_dev = NULL;
 	}
@@ -3828,6 +3833,8 @@ void em28xx_free_device(struct kref *ref)
 	if (!dev->disconnected)
 		em28xx_release_resources(dev);
 
+	em28xx_cleanup_media_device(dev);
+
 	if (dev->ts == PRIMARY_TS)
 		kfree(dev->alt_max_pkt_size_isoc);
 
@@ -4000,6 +4007,7 @@ static int em28xx_init_dev(struct em28xx *dev, struct usb_device *udev,
 	em28xx_i2c_unregister(dev, 0);
 err_deinit_media:
 	em28xx_unregister_media_device(dev);
+	em28xx_cleanup_media_device(dev);
 	return retval;
 }
 

base-commit: b4e3c4b6a36fd76f57bf3e48638f68ddecc54ba4
-- 
2.53.0

