Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.51
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795380813;
	b=RxaliTxD0xGXMA1xfm0bbJEcgaHIPLehY31904WeT2keaG8sttWO9SsOzO1gRQeVc/BB
	 XYJ+Qhjr0lofWGg9u3ZauOjsXynQ07DW86Bd4pS27uzKxxiy+Z6pXfv1M63ykiws1Vhu3
	 SUf72CHq0J9Um+7ajHw44n4yzra55H9WcysnqDx+aME78ozOHRkTGgWKBXIGJIjbdF6zA
	 AG1i1Y+s3v6UPe3NatED96hAs+VNjaHMRI7NDc6CgoNjMEIqyvNmBUvkZjWPISRC0I5kJ
	 cka+JwJR5LuuxcxGUlAOWfKXZWWfp8lDqQlt+kKvZzvIPZ0ZOAsj4cf89PFJUa7mB2w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795380813;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=jCkKjGFl/FESlc4vs2SRng6oOInHAgHTvIB3dJ89NUk=;
	b=4xSoGRGtqKAYGWIH+9v42LVVfSJUDBaENXuO2jabxX1GAWcnkMaJHPw8icmoEtMi5GSF
	 /j3jwcxbw02OA8uOjtDFFdD2r7dEIStOXuswyRci5RTOICJ1au0KSKrpUP9a0gBQ75WOv
	 hUKYDAgEZTa0JYkx0Fg8STzsCyjOdY6porxVykZjrX8ZGAqhgsgRGqaV1NxsWDeZDC4Fd
	 4A3H8CnLMNVUcvIMT2R0f6Q0B58H705UqPrkzv1Z1433IhoI4SLegbwCWBXX99N1O7/BP
	 x0r3jwlVZhHu/LpaWNe+PtN618sn9lOaPo98dlQfy7CJ0DznyD6GVo7jYan5wtaf+Yg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=R6GzwmoP;
	arc=none smtp.remote-ip=209.85.128.51
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC0D8606A31E
	for <stable@vger.kernel.org>; Sun, 22 Nov 2026 20:53:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AC0D8606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=R6GzwmoP
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-4b79502c27aso23287725e9.1
        for <stable@vger.kernel.org>; Sun, 22 Nov 2026 12:53:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795380811; x=1795985611; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=jCkKjGFl/FESlc4vs2SRng6oOInHAgHTvIB3dJ89NUk=;
        b=R6GzwmoPbZ8PGALr9DSfhHfc85bDo/sOdAuzBt0z+ZCv+J7FlYUabjiK4MCSj4gAaD
         0DXWS4MA7hLUC+Pd2c/9LzQNkyTTrnpawv/ct5UjVxUeR8NSGXDdNqVZvEVFRMdqw6Fg
         Ks3EGKtOFzOipgT1nxgyXfjFZXi3jXKjUjA8a6hFFaPHVyVzccaef6hjGvAclbzF5nTW
         KTajbyT7KBEWxRWIeT8mYe9tkAZSFyo/p4BF2QOARmSftJHE4YBccBJQ1yu/hvb48V5f
         BUGZsm0SrbOnIGAqAzWkoKQzhxBpG4qCjyyVepBcGciGA1ff5utkMVV6XVXu9l4z1xY5
         lSdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795380811; x=1795985611;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=jCkKjGFl/FESlc4vs2SRng6oOInHAgHTvIB3dJ89NUk=;
        b=KqI7AZwHGAoTn4zL2lGGtPzKuKXaVpPZyA00RIpUKANoCZESIILegS3ICn4KhL7jpz
         uotChf2/eO3MaRdM8s4v7Que2w5XL07UjctbznjZLjwzXnoWKPlzAAj/LMztRTaGlctY
         DR0ycggaxtSZI/sWBfMcY5inaOV1HToo3R+Kzl0F8zHv8l1kbnRsrIKpxidsYIUtaM7n
         iLhR282YcWQqSb0+cmERoaDHpun48ou67ImnUhKGtuj4xd4unxd0XbkTpUkD8wRT99ox
         xT5Qydr+RCJvu3+zerYFRbYMctLtXjCMoLV5FikV9f8qcBawgDY+4xSjchZuRWAixX0n
         Jt7w==
X-Forwarded-Encrypted: i=1; AL+hErFjser/ZUp4XM0P9+xglEu6RZqmxauNwBe19/gUnALFd2iSKgyQ9aZevCQVJxwSVCAIHh101bI=@vger.kernel.org
X-Gm-Message-State: APuU4Z9JxmbwCZKzc+TN05QweivrelVda7HOSzYNNKxX9NS4dJ42pyUv
	Y38uZvG1lSWraN0oWtt+rrKHvJegnuLBeIKwRh1v9oH7J8Ent0EGMM7M
X-Gm-Gg: AZFdTZeqgYJpqFMiUSFczF+8lp7DbFXh1VjkOVgXHgx/Jjcz1VpOU6NUp9A2E1jyyHY
	xYciFfihwJCFJ70R1jpV8FWlYJ5e6xON3/qshbGGz0vRMzoww3KccKIW/54D/wDrDHL5IwVkD2h
	puKtTLJ46ZPH2leaicdHFkA9AoOYFVB4bFccnZh0OOxHVhWP8Gtzw8mky52ZFNuxihpcpagqsND
	mADlEcB6myRV1y87McCaNco6Vmd8XDYhtX3gLoIY8ecM4K+XmMNR8VwLJfqP6hRvC9Mjv3RGF6/
	nvnRPpxOwv6KQBfkA11+B66YI2/LyPRukcryU/caL6xvhDDaTeDxbSY/58603CPU8trC/AE5jze
	IevMHIuTKzaV2GqDpdkCmvNMAPiposu/FICgB9gn0hjSoC7TDdfUI7oOHjZ0ickWVrIiIelK0F1
	OBaKiLdA1khqXCBnPvE4+pq0z850ejjceJ77Z5MXR/xCK+qR7meDlP0xTCEwD+75nRIlMI738W0
	HszxfVk4M9PNhDaWcu64KBHQ98dhRSpG0Ll7rkfzIxdYVrS3jY0p9uH8S1842tfadYAslWWftzw
	PA01L+FGmLIJh4D6Y3F3T0yIHcIBC+oeU2T46mfG/8+Sv9ts44buEDXA
X-Received: by 2002:a05:600c:c8c:b0:4b7:6942:39bd with SMTP id 5b1f17b1804b1-4bb88820e06mr193076305e9.26.1795380810868;
        Sun, 22 Nov 2026 12:53:30 -0800 (PST)
Received: from DESKTOP-V28CTA4.localdomain ([103.125.177.105])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb85399e2esm338371075e9.7.2026.11.22.12.53.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Nov 2026 12:53:30 -0800 (PST)
From: Arbab Haider <arbabhaider649@gmail.com>
To: Mauro Carvalho Chehab <mchehab@kernel.org>
Cc: linux-media@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Arbab Haider <arbabhaider649@gmail.com>
Subject: [PATCH 2/2] media: em28xx: avoid dereferencing dev->intf after disconnect in em28xx_v4l2_close()
Date: Mon, 23 Nov 2026 01:50:29 +0500
Message-ID: <20261122205028.41222-4-arbabhaider649@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261122205028.41222-2-arbabhaider649@gmail.com>
References: <20261122205028.41222-2-arbabhaider649@gmail.com>
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

em28xx_v4l2_close() unconditionally evaluates
interface_to_usbdev(dev->intf) at function entry, before acquiring
dev->lock and checking dev->disconnected.

If the USB device was disconnected while /dev/video0 was still open,
struct usb_interface (dev->intf) has already been freed by
usb_disable_device() -> device_release(), so closing the file handle
triggers a KASAN slab-use-after-free:

  BUG: KASAN: slab-use-after-free in em28xx_v4l2_close+0x37c/0x3a0
  Read of size 8 at addr ffff888007245890 by task test_em28xx_uaf/71
  ...
  Freed by task 10:
   kfree+0x162/0x410
   device_release+0xca/0x250
   kobject_put+0x152/0x2f0
   usb_disable_device+0x324/0x570
   usb_disconnect+0x271/0x950

Move the interface_to_usbdev(dev->intf) lookup after the
dev->disconnected check under dev->lock, right before its only user
usb_set_interface().

Tested locally in QEMU (x86_64, KASAN+UBSAN) using dummy_hcd and
raw-gadget emulating an EM2820 device across open->disconnect->close,
repeated disconnect, dual-fd open->disconnect->close, and normal
open->close->disconnect scenarios (4/4 passed, 0 KASAN reports).

Cc: stable@vger.kernel.org
Signed-off-by: Arbab Haider <arbabhaider649@gmail.com>
---
 drivers/media/usb/em28xx/em28xx-video.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/media/usb/em28xx/em28xx-video.c b/drivers/media/usb/em28xx/em28xx-video.c
index 84424284d..854fcc897 100644
--- a/drivers/media/usb/em28xx/em28xx-video.c
+++ b/drivers/media/usb/em28xx/em28xx-video.c
@@ -2503,7 +2503,6 @@ static int em28xx_v4l2_close(struct file *filp)
 	struct video_device   *vdev = video_devdata(filp);
 	struct em28xx         *dev  = video_drvdata(filp);
 	struct em28xx_v4l2    *v4l2 = dev->v4l2;
-	struct usb_device *udev = interface_to_usbdev(dev->intf);
 	int              err;
 	bool last_user;
 
@@ -2512,6 +2511,8 @@ static int em28xx_v4l2_close(struct file *filp)
 	_vb2_fop_release(filp, vdev->queue->lock);
 
 	if (last_user) {
+		struct usb_device *udev;
+
 		/* No sense to try to write to the device */
 		if (dev->disconnected)
 			goto exit;
@@ -2525,6 +2526,7 @@ static int em28xx_v4l2_close(struct file *filp)
 		/* set alternate 0 */
 		dev->alt = 0;
 		em28xx_videodbg("setting alternate 0\n");
+		udev = interface_to_usbdev(dev->intf);
 		err = usb_set_interface(udev, 0, 0);
 		if (err < 0) {
 			dev_err(&dev->intf->dev,
-- 
2.53.0

