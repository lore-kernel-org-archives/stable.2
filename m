Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AF33EEC0
	for <stable@vger.kernel.org>; Sun, 28 Jun 2026 00:31:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782606674; cv=none; b=N0awrN15psLhm39EuRk58vIJPJh2l83y8DhIlnICkZ23VLNY0hVl/hCvJV+aph0/9hfxL8YWDSDZN4OF4pchy3Uxnj8kcWDG4GHmeHLBvFeoltEeindFWU+wtaczL27RDuSUyTJw5u93w/O2MsQoSTvEjd5wSZZoPoTgBWGaReo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782606674; c=relaxed/simple;
	bh=YCurl51Wd9up5XqC1lcIyo6fi0heIKeRJH9GNK+mSLg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=StasxqZUMbMBDvrYbnTiPJmMJApk4WZapPF4DQPCdIZ4s1Ip/R3KbeOu5Kid53opuWWwh3NOsYCnaNbGG/P1i5wtymR5VDMEGCG1z+6bY9ziSQ5BSK2mhTcTLGlheEq6bO5kmQyLiRERwvH48pG1cR6tci/LQhEWRaHOF5+2zrg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bw7N4Ktu; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bw7N4Ktu"
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-4927014c0deso7867385e9.2
        for <stable@vger.kernel.org>; Sat, 27 Jun 2026 17:31:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782606671; x=1783211471; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=KOz501n904lvdLTm47kCJmdYhlDM6NLfGSeUIVVTmrQ=;
        b=bw7N4KtumtpGsZZMwFPL7DAaM9HLBW5vDq/uZ+gWejrhf50XRyGgqiVYGWzHitCZDO
         0+YhGEU4jVqxzgdsUQl1+u7hPE4VJ5hH1UhAlcKO5ULzb2bK2fH0jiVoCA33vVRzaM4O
         Sodm4s3hSJhTImueqVYD0lkgGE66+ClwOkzIcSnLTwknTpYffmRnAyUGYyJyUzoMOszs
         MNxfqa+Gr4EP1uSeARwuGCo5l54f1P7yQIO3TJQX5jOVwqXKpOKV4IulE9Zo/6ZD+c5O
         u1AghjAR+ymLABBzKCRLy61VE7m+82cJZPNWf1NReiOdEC/oVb15/xhaEkd5BCOM1tcV
         t/HQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782606671; x=1783211471;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KOz501n904lvdLTm47kCJmdYhlDM6NLfGSeUIVVTmrQ=;
        b=ieKC4HA9GHGlEB7odIo7YxKArtcF8dbw+oMQd87KzSXzxGYO9iZEnfqOYA7xCbvm9k
         RyVmE5lYCW56Mi11JMTo0AWvw9l/aPFXeznFrZfgjvW0qTmCxdGPcOdF6ksopWpJOqCI
         tX9zCi9pX/0ejQp0KEnf1bNqKM9ishbYvBzXDTdbAjWZ4vJAD8Ppv2MfxZzGtpPjNLdQ
         SA8Be2Wfz+zmInpP4LTKgw4xAZVfiBELFkf/a3lOqYkloJF9RJRRtmpjsnZD611Cn28W
         IDkLtjy3dTFR2HTAWDnSyTr3f4ztapJjnBvjxZ/A13W7BFzvVaK0oPKmFZEjuTp5O2Dw
         u7/w==
X-Forwarded-Encrypted: i=1; AFNElJ+nivIRAJ2Kwl1uMCv+b76ojtbS5SJvj9c/T/01icA8qNSxvY/SPpkYkluz4W0atxMdxCms7as=@vger.kernel.org
X-Gm-Message-State: AOJu0YyZqr2hNX4covQkdegdRC9683gm9G9jvjEIarmUyu3p89blZdV0
	2kxILa+aGLVvw8wZFqKG0+AjEzBNh1gJbQL/mzDURiKCfkh3PbBncBC6
X-Gm-Gg: AfdE7ckYW/iURP0cSiLQqGGUVdkGqCy0e5YgWmwLbO/ov69+ztUYp9r0nzntVovzLis
	szUUx4PpsivU77UHc/c7Ha2jZJGSAboqU5rJMxTMcLQtg84Y5rug6rCZ9TiWFSAsh+gRhqcz/4f
	4+BdQgNiQinAW0LNYUcJIemlzn1FsFJ4Rf2ZyRWhabD+ekGs3Jiq8QyJL8JJ1bohvrpwgrMEcHU
	ddN7s+GxDF4u+1o469ur25SwURU7pOYwqKy7iTKJv3d9dnwelSbf3j7uSxoX1BrbGHf0uUvnwj6
	y8J77tpubPInLjC0FYe8RfTxtsx/++yCb9cka1KfzqcQee4I2e/8/9oEV92OQWy+9TUyN+VaUYB
	zLE+5+Wzp3zA+bG7wUNK0Z/4trqBxHShfSVXLMjm/PxgeHXYyraBK3swjI1r7aH46+Va0kuyBPs
	vLwEWrWENwZdHSWUfSVLvtlCqz0Q==
X-Received: by 2002:a05:600c:6b70:b0:490:b06a:649e with SMTP id 5b1f17b1804b1-49266893253mr130977045e9.25.1782606671052;
        Sat, 27 Jun 2026 17:31:11 -0700 (PDT)
Received: from Dev-Null-MSI ([2a0d:3344:52ac:a808:98a4:4381:be45:536f])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49268f7670bsm192987435e9.0.2026.06.27.17.31.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 27 Jun 2026 17:31:09 -0700 (PDT)
From: Yousef Alhouseen <alhouseenyousef@gmail.com>
To: Mauro Carvalho Chehab <mchehab@kernel.org>
Cc: linux-media@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Hans Verkuil <hverkuil-cisco@xs4all.nl>,
	Abhishek Kumar <abhishek_sts8@yahoo.com>,
	stable@vger.kernel.org,
	syzbot+39ff299961a7c07f00f0@syzkaller.appspotmail.com,
	Yousef Alhouseen <alhouseenyousef@gmail.com>
Subject: [PATCH] media: em28xx: keep device state alive for registered video nodes
Date: Sun, 28 Jun 2026 02:31:03 +0200
Message-ID: <20260628003103.24832-1-alhouseenyousef@gmail.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The V4L2 core takes a video_device reference before invoking the
driver open callback. That reference does not protect em28xx state
because all three video_device objects are embedded in em28xx_v4l2 and
use video_device_release_empty().

If initialization fails after registering a node, the error path can
unregister it and drop the last em28xx_v4l2 reference while a concurrent
open has passed the core registration check. The open callback then
dereferences the freed video_device in video_drvdata(), as observed by
KASAN. A disconnect has the same lifetime gap.

Give each successfully registered video node references to both the
enclosing V4L2 state and the parent em28xx device. Release those
references from the video_device release callback, after the core has
drained pending opens and existing file references.

Fixes: ef74a0b9ff56 ("[media] em28xx: move video_device structs from struct em28xx to struct v4l2")
Reported-by: syzbot+39ff299961a7c07f00f0@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=39ff299961a7c07f00f0
Cc: stable@vger.kernel.org
Signed-off-by: Yousef Alhouseen <alhouseenyousef@gmail.com>
---
 drivers/media/usb/em28xx/em28xx-video.c | 35 +++++++++++++++++++++++--
 1 file changed, 33 insertions(+), 2 deletions(-)

diff --git a/drivers/media/usb/em28xx/em28xx-video.c b/drivers/media/usb/em28xx/em28xx-video.c
index da0422c65e5f..4274a9bcb432 100644
--- a/drivers/media/usb/em28xx/em28xx-video.c
+++ b/drivers/media/usb/em28xx/em28xx-video.c
@@ -2289,6 +2289,31 @@ static void em28xx_free_v4l2(struct kref *ref)
 	kfree(v4l2);
 }
 
+static void em28xx_vdev_release(struct video_device *vdev)
+{
+	struct em28xx_v4l2 *v4l2;
+	struct em28xx *dev;
+
+	switch (vdev->vfl_type) {
+	case VFL_TYPE_VIDEO:
+		v4l2 = container_of(vdev, struct em28xx_v4l2, vdev);
+		break;
+	case VFL_TYPE_VBI:
+		v4l2 = container_of(vdev, struct em28xx_v4l2, vbi_dev);
+		break;
+	case VFL_TYPE_RADIO:
+		v4l2 = container_of(vdev, struct em28xx_v4l2, radio_dev);
+		break;
+	default:
+		WARN_ON_ONCE(1);
+		return;
+	}
+
+	dev = v4l2->dev;
+	kref_put(&v4l2->ref, em28xx_free_v4l2);
+	kref_put(&dev->ref, em28xx_free_device);
+}
+
 /*
  * em28xx_v4l2_open()
  * inits the device and starts isoc transfer
@@ -2554,7 +2579,7 @@ static const struct v4l2_ioctl_ops video_ioctl_ops = {
 static const struct video_device em28xx_video_template = {
 	.fops		= &em28xx_v4l_fops,
 	.ioctl_ops	= &video_ioctl_ops,
-	.release	= video_device_release_empty,
+	.release	= em28xx_vdev_release,
 	.tvnorms	= V4L2_STD_ALL,
 };
 
@@ -2583,7 +2608,7 @@ static const struct v4l2_ioctl_ops radio_ioctl_ops = {
 static struct video_device em28xx_radio_template = {
 	.fops		= &radio_fops,
 	.ioctl_ops	= &radio_ioctl_ops,
-	.release	= video_device_release_empty,
+	.release	= em28xx_vdev_release,
 };
 
 /* I2C possible address to saa7115, tvp5150, msp3400, tvaudio */
@@ -2965,6 +2990,8 @@ static int em28xx_v4l2_init(struct em28xx *dev)
 			"unable to register video device (error=%i).\n", ret);
 		goto unregister_dev;
 	}
+	kref_get(&v4l2->ref);
+	kref_get(&dev->ref);
 
 	/* Allocate and fill vbi video_device struct */
 	if (em28xx_vbi_supported(dev) == 1) {
@@ -2999,6 +3026,8 @@ static int em28xx_v4l2_init(struct em28xx *dev)
 				"unable to register vbi device\n");
 			goto unregister_dev;
 		}
+		kref_get(&v4l2->ref);
+		kref_get(&dev->ref);
 	}
 
 	if (em28xx_boards[dev->model].radio.type == EM28XX_RADIO) {
@@ -3012,6 +3041,8 @@ static int em28xx_v4l2_init(struct em28xx *dev)
 				"can't register radio device\n");
 			goto unregister_dev;
 		}
+		kref_get(&v4l2->ref);
+		kref_get(&dev->ref);
 		dev_info(&dev->intf->dev,
 			 "Registered radio device as %s\n",
 			 video_device_node_name(&v4l2->radio_dev));
-- 
2.54.0

