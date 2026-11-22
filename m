Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.43
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795374068;
	b=Qvc/BGMibOE7jDBsZ5Pe4j9WirLy64BbjQKj5ppP3Q49k20gt+zLcX8r+fBzHxL/uQah
	 QsZFVy7o4/BgKynnIkg+fk5NLV8VvwtT9ebt6m7aaYsKbzWX1jJUxSaKNrnx8KHRHcdfa
	 W4ZKDqeWGmAH+cPkLJ3NKh0lf18mL6NXgolqRvYLtvjXrgltPmUqXiqadyN19hItVt8Zy
	 /CYNvJb1upg07+oR/dN61Us7+wT3oAyFpzjF3amI/yWxGhLWS9Vsi8VE4hA+3gcVYKqIo
	 BBgVtDwPDdkbTuB75XIrBPFQcI/Qz7FJcAsrA4Yg2HV+8wVKz22u0G+rK/zWTFz+2vA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795374068;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=psP2uIlkimEYW+kQJSgqbVunRYZcoC3y/JABKKHgk3g=;
	b=OHfnYQChz5vPgfqwhuqD4ISLpPAqoEF9Enf7VzDcGaUv0OOFSTHZ4V4TtW/i+/bRjQpH
	 qEugGdtSDDJozYrV6XxqrX701TyCpIFMVwhXaSG4DWW3JjRquMrW3peCHZ3Eu+L/Kflwi
	 AJx0dU92mGZ9UfUa6S0/HFQLMgDmnuL5oAXSQwP0aKeoqwpIFZ7BAA2qD6oGavflHA5ke
	 64zdrJbm+dZe1FbATdxreI98W3Jf2c5/pvmMrQ/seTMGT5E8HVWNWkVwcLJqzvb0NE/Np
	 K+OU9MefHr1AEPV7b9WgSVarUzoCbahHIOb+XQec1/OrorxaJ8p4qsWJ4xd6n191bcw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=d7AO7oiM;
	arc=none smtp.remote-ip=209.85.128.43
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CF18606A682
	for <stable@vger.kernel.org>; Sun, 22 Nov 2026 19:01:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5CF18606A682
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=d7AO7oiM
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-4bb55cda775so15710455e9.0
        for <stable@vger.kernel.org>; Sun, 22 Nov 2026 11:01:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795374067; x=1795978867; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=psP2uIlkimEYW+kQJSgqbVunRYZcoC3y/JABKKHgk3g=;
        b=d7AO7oiMDNVsFh0LM4DDKaTKjlPQXm/32TtE6F0SynaZGe7KrFwsGdFSW+iOtkrCj0
         Di0w3iZEbeIjuIueiDIsB/9NIDyUk86Kwvz5K+7WfCtRouCSFbM3YBPrvDSmmBaKseVm
         LQC7JLblIZ8LUVFyKjVA7otkeG1kO7+f3RlI1uAgDoxG8FSwCcKCqngDMaoCx+UX3Jl9
         d3pHBf0bEjA9RLOJNPrs5YFHpCVdyR6Pj1cHBPdUCzOGc5nUEM+jqMF3pXh1uIVW1kF4
         G+jB0bUaWK48X/PmGHmpNQZ+8Mtay6QfZBz30QVPtVdlRuWD8ij96D2OgqTVgQ50pLLq
         YE9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795374067; x=1795978867;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=psP2uIlkimEYW+kQJSgqbVunRYZcoC3y/JABKKHgk3g=;
        b=UD/nSnrr8C1N8xaFJ2cN/GXkXN/aE/sBhTLjfJZD7dquBQj75wRy0RYn7Sy6YsKrEW
         JO+MMnC+UpWujXQMHcpEDPEK4N0gx3jx8YCCfLtLKwccbM1joelf6MyEb4vNIaJNU44X
         Ek1BM2Ymg2wx7vjmWwH28ELpQrWdyGXCeoK3u5LNuNT7okpUItS+VunjA/utV/Htjifg
         1cI5T57LwHR9A0P5nvESHlo42OSvApHhzvKJKVQTuOXXqFqnEwT7nAcrhWHR5vxtyI0s
         ldAU1t5bKqLEuLxXmiTjjhjtPrFUxpXnD4ybKGcoXwZOmgeqSUw/zlgSKxx7jGXVVyga
         VUTA==
X-Forwarded-Encrypted: i=1; AL+hErEmgHkEf8dBgClGIWS4716Ol8+cWaz83U9Iq26fTJOHIaZ8WPqOdxDvY3smtnrV0KR6jCDPSbQ=@vger.kernel.org
X-Gm-Message-State: APuU4Z+NkQqD6N4w3/q9N77G8VW5poFGoTKCW1uevOmlyeEkNUZFJkhh
	/CwEoZWJPId58jO2X3tDHfpRdYC6ZpkSkxyb1N2EsZYD8/hqer6MqJkV
X-Gm-Gg: AZFdTZewg9hxIjuvynSw6P5Ph/Cq1fizW5tshS4heGvXprI2vxHxUqJ5v7al5pAJ15B
	Mm6eckfeYbB28RmiAVacMhlDN1c/9YAXsbtZH7ReYOFkP3Y7ARJ4jePgaxz+xLT924N6EBkLzQB
	EE/XtpiGHoFLZlzTgODcJi5sPzR5Ng0o1qhrZCH0LHzSYAyGSNvxfkMHnUhdSanqZayt3AjZ5wU
	XJ+8hdPRZXRuROI9HB1KiPtlrfVMgvSftYcSFpCoaWMMlnAAzvhSPQX3NKpWmSXb7yFXNwldtZ+
	PwX2eRprzXjNKdfyNL5DxPE+Qsc2BZIv8LlnzqFdbwJhN6dp6MAdrNtoM0ext5/Fo2ZO90STKPE
	noYmfik+VFShRKTDpFSxHG82qCchEcca+9iE3CNzktWf/UkotqU33p+HIBBMdGVBS9oIustE43F
	ALTau0yELfB2t1+Lj9Lr0twDoUPWmPqWJu28PvbV9RDMT/Yu8kAUkcdgknqUbbS1J18oK10S2vT
	GD3d3Ukmk/NbYQQj5YhJchH0obLVJWjTX4mf18HSipd+OQHU+NrJ9tbZ/CJTZS4WIaqM52qlrKK
	1TvZnLSlek1rfDbYKTGu+U2q1WCCWwr9c3pU2mQdlUt5LIpjux9mGsTA
X-Received: by 2002:a05:600c:3547:b0:4a1:c27d:e1a8 with SMTP id 5b1f17b1804b1-4bb8880b88fmr189495385e9.10.1795374066559;
        Sun, 22 Nov 2026 11:01:06 -0800 (PST)
Received: from DESKTOP-V28CTA4.localdomain ([103.125.177.105])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb884865a2sm283389045e9.3.2026.11.22.11.01.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Nov 2026 11:01:06 -0800 (PST)
From: Arbab Haider <arbabhaider649@gmail.com>
To: Mauro Carvalho Chehab <mchehab@kernel.org>,
	Hans Verkuil <hverkuil+cisco@kernel.org>
Cc: linux-media@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	syzbot+fb0d2df09b56117605fc@syzkaller.appspotmail.com,
	stable@vger.kernel.org,
	Arbab Haider <arbabhaider649@gmail.com>
Subject: [PATCH] media: em28xx: clear dev->v4l2 on init failure and fini to avoid double put
Date: Mon, 23 Nov 2026 00:00:09 +0500
Message-ID: <20261122190008.21278-2-arbabhaider649@gmail.com>
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

Commit 288254383674 ("media: em28xx: use v4l2_device release callback")
switched em28xx_v4l2 teardown to v4l2_device reference counting, where
dev->v4l2 is only cleared inside em28xx_free_v4l2() once the refcount
reaches zero.

If em28xx_v4l2_init() fails after video_register_device() (for example,
when v4l2_mc_create_media_graph() returns -EINVAL) while userspace has
opened the video node, the unregister_dev error path calls
v4l2_device_put(&v4l2->v4l2_dev) to drop the initial reference, but
em28xx_free_v4l2() does not run yet because the open file handle still
holds a reference, leaving dev->v4l2 non-NULL.

When the USB device is subsequently disconnected, em28xx_v4l2_fini()
sees dev->v4l2 != NULL and calls v4l2_device_put(&v4l2->v4l2_dev) a
second time for the initial reference, freeing struct em28xx_v4l2 while
the video device node is still referenced and causing a
slab-use-after-free in media_device_unregister() /
__media_entity_remove_links().

Fix this by:
- Calling v4l2_device_disconnect() and clearing dev->v4l2 = NULL under
  dev->lock in em28xx_v4l2_init()'s unregister_dev path before dropping
  the initial v4l2_device reference.
- Checking and clearing dev->v4l2 under dev->lock in em28xx_v4l2_fini()
  so the initial reference is dropped at most once.
- Reading dev->v4l2 under dev->lock and checking for !v4l2 in
  em28xx_v4l2_close() so a close racing with teardown cannot dereference
  a NULL pointer.

Tested locally in QEMU (x86_64, KASAN+UBSAN) using dummy_hcd and
raw-gadget emulating an EM2820 device with failed media graph creation
and concurrent /dev/video0 open/disconnect.

Reported-by: syzbot+fb0d2df09b56117605fc@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=fb0d2df09b56117605fc
Fixes: 288254383674 ("media: em28xx: use v4l2_device release callback")
Cc: stable@vger.kernel.org
Signed-off-by: Arbab Haider <arbabhaider649@gmail.com>
---
 drivers/media/usb/em28xx/em28xx-video.c | 23 ++++++++++++++++-------
 1 file changed, 16 insertions(+), 7 deletions(-)

diff --git a/drivers/media/usb/em28xx/em28xx-video.c b/drivers/media/usb/em28xx/em28xx-video.c
index 84424284d..50998aa1c 100644
--- a/drivers/media/usb/em28xx/em28xx-video.c
+++ b/drivers/media/usb/em28xx/em28xx-video.c
@@ -2333,7 +2333,6 @@ static void em28xx_free_v4l2(struct v4l2_device *v4l2_dev)
 
 	v4l2_ctrl_handler_free(&v4l2->ctrl_handler);
 	v4l2_device_unregister(v4l2_dev);
-	dev->v4l2 = NULL;
 	kfree(v4l2);
 	kref_put(&dev->ref, em28xx_free_device);
 }
@@ -2414,7 +2413,7 @@ static int em28xx_v4l2_open(struct file *filp)
  */
 static int em28xx_v4l2_fini(struct em28xx *dev)
 {
-	struct em28xx_v4l2 *v4l2 = dev->v4l2;
+	struct em28xx_v4l2 *v4l2;
 
 	if (dev->is_audio_only) {
 		/* Shouldn't initialize IR for this interface */
@@ -2426,13 +2425,16 @@ static int em28xx_v4l2_fini(struct em28xx *dev)
 		return 0;
 	}
 
-	if (!v4l2)
+	mutex_lock(&dev->lock);
+
+	v4l2 = dev->v4l2;
+	if (!v4l2) {
+		mutex_unlock(&dev->lock);
 		return 0;
+	}
 
 	dev_info(&dev->intf->dev, "Closing video extension\n");
 
-	mutex_lock(&dev->lock);
-
 	v4l2_device_disconnect(&v4l2->v4l2_dev);
 
 	em28xx_uninit_usb_xfer(dev, EM28XX_ANALOG_MODE);
@@ -2455,6 +2457,8 @@ static int em28xx_v4l2_fini(struct em28xx *dev)
 		vb2_video_unregister_device(&v4l2->vdev);
 	}
 
+	dev->v4l2 = NULL;
+
 	mutex_unlock(&dev->lock);
 
 	/*
@@ -2502,18 +2506,19 @@ static int em28xx_v4l2_close(struct file *filp)
 {
 	struct video_device   *vdev = video_devdata(filp);
 	struct em28xx         *dev  = video_drvdata(filp);
-	struct em28xx_v4l2    *v4l2 = dev->v4l2;
+	struct em28xx_v4l2    *v4l2;
 	struct usb_device *udev = interface_to_usbdev(dev->intf);
 	int              err;
 	bool last_user;
 
 	mutex_lock(&dev->lock);
+	v4l2 = dev->v4l2;
 	last_user = v4l2_fh_is_singular_file(filp);
 	_vb2_fop_release(filp, vdev->queue->lock);
 
 	if (last_user) {
 		/* No sense to try to write to the device */
-		if (dev->disconnected)
+		if (dev->disconnected || !v4l2)
 			goto exit;
 
 		/* Save some power by putting tuner to sleep */
@@ -3110,6 +3115,8 @@ static int em28xx_v4l2_init(struct em28xx *dev)
 	return 0;
 
 unregister_dev:
+	v4l2_device_disconnect(&v4l2->v4l2_dev);
+
 	if (video_is_registered(&v4l2->radio_dev)) {
 		dev_info(&dev->intf->dev,
 			 "V4L2 device %s deregistered\n",
@@ -3129,6 +3136,8 @@ static int em28xx_v4l2_init(struct em28xx *dev)
 		vb2_video_unregister_device(&v4l2->vdev);
 	}
 
+	dev->v4l2 = NULL;
+
 	mutex_unlock(&dev->lock);
 
 	/*
-- 
2.53.0

