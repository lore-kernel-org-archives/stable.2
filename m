Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.42
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795386241;
	b=JKEIzI2cfZcXcwgGABJgy+UjYC9hmwHWVcE5CCubbDi3mxwzfMrfcZDPZBDjqURVBTNo
	 +DU+Yxk6P5WTJa34XE9zr4RYVcqjMBRMO97niJjrNn0x8No452fpT15AEL6/Z6ZFnp6eK
	 ecsRaYcVyWphHUKzcPsaOykf8HlMD7An+rdIMwbWDTtkzg7YvzKWCFP42X8WR1mXU28X7
	 h7GtuTlMC/Wip6VctE7cMfrV0Alpk2heUqcn2VBxltdDpWYHZaSx8lfZAyVjogUcWHBsL
	 6U1+V7nh9D4LFBw9XMzsIF/N1ovEo8RWibLlqmXds2dkASH15C35sZWRM96szXwiOiQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795386241;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=KapwmbLEAkf33u/pzzWw2QZ8gktGhjW3ZtX3tKdugF0=;
	b=WZYCXHeTpyhQo37rvGz1W9vGzA6RNgvKydZ3zhKEn+VW+LuhCgi26fKpCteMxO/hdUQG
	 eLQAwcJVJDVb8pcNs9PBbei6RKbpvQkISFAHGSlONxjgNoHR4MYnu3hZ+IlN2d5jgeSws
	 vyVZv2LFSwavQAQXMkMpjzVmqS08EiCwsn7Fu7oIJ11kka8NbPx5QZ/dJxx2NDq7FGEbJ
	 R+NDxaWkTETHKD/jiO0BwRZDKizeUM92Fpmt8X4/Or99k5vl56cdJcbSrKuFfPRrHzLSA
	 TW/nczkCtFb1ApMUD5Tw8yet+KKXkI6gwSLgNFQXPfcLNoCCb27lavtmoyWDnevXINQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="i2R/yJDp";
	arc=none smtp.remote-ip=209.85.221.42
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84C40606A31E
	for <stable@vger.kernel.org>; Sun, 22 Nov 2026 22:24:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 84C40606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=i2R/yJDp
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-49a92144733so1252536f8f.0
        for <stable@vger.kernel.org>; Sun, 22 Nov 2026 14:24:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795386240; x=1795991040; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=KapwmbLEAkf33u/pzzWw2QZ8gktGhjW3ZtX3tKdugF0=;
        b=i2R/yJDpimHrS7eYZJtZGDiAVywPsyyCOvmfEFaBp62uI/AGioNG75yqZfkLhniRZe
         XveDSojPkBIOpjRK2be4jGyKusAB0nSulLHu+9ppxXnIqkS5IHJFFmVC+mDYLFpcwq9a
         Lz1Nc+emXSnUwLJLdNApyezog9ScRwCy/qU1ifQmte3tQRYD55fax28kl24H3LllvGg3
         CWDnPf+uCk41JyIqu+qyNyqWMxGoD9txa2fLNbcizqYDpzX+frx3Pbyl3nbuq0qs1OVJ
         VyUMHoRarnfkT73FlKZ7EHPHmr6GW2veNf/nACQTJ+Mc9J8tQQjm8iCGVEmDTE6vZoK0
         uBXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795386240; x=1795991040;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=KapwmbLEAkf33u/pzzWw2QZ8gktGhjW3ZtX3tKdugF0=;
        b=KVMmzbVH3hU9qnVSLDyj9x2ErF2G+3O9bCs0GYdX39fifM5IFId0zp2fEgXWbJj6qR
         p5DmecLMYkvT56v5QxZ1mK8pORqNOnBUOXULT3TgYzi3fjaAJlqxdJM0QSj4Dzd0n1WO
         4aJsNsNvRT9UTCOjlr1z0XpReRavmnJFEjDc3wI0mMhLE9BgcTwlRHGnRpMb87adngqJ
         YGuUBxBJSBE7AE2ZiSNzQlXc0QUyHuk3+WjcB9KpLq6c2ENdNLltMZ3qBB6RuViIzwPU
         tBxhoCsUzHmU+mLYK/ECcRGYxRU0N3Acv32DQ8k81I5qsu4fJ3ghfDkpb6Tt93f9QhOc
         deQw==
X-Forwarded-Encrypted: i=1; AL+hErFSvThN/37jaAcY4I9v/sP/vOy4vqUwiKga31Nl5e+SDV/BSD4Ctc2z04Leq7qZPXXGw8Ym8fA=@vger.kernel.org
X-Gm-Message-State: APuU4Z/xdvXmjYUj0uCIp9hH2ytpj9OGh0dButEg7fG3q7ll/wGFiR9P
	yxEml7TPqvn6MQpSTcuJYYCuH6ejzX94OpYhHxUOY/e81RfejXeT8XG0
X-Gm-Gg: AZFdTZcYjjERqEqHOyTkIqVpfvVH3zknO3b3AMyYQvMWr2bIdsZTtPkhJVa2yalEJIk
	X4Az5ikmpAF4PaFQomQQ2qqwmukopuEL/jgAAZoNVHxrSUK2dEkHeBEgA7HBi5q4lC5/kPbeROx
	+29s37CLtCryf5FyG+TWwZ2twzXUz/+wqEkEmkZof6UoKjhFmdOOlOXxBpVhkGgbUYpJ9UMu0cD
	fqCugtPjxCQC+iAeccqubTsm7kVbFUVe5eU8+7+bgfgu+MSN629z/2uLiLTKjHqkyq8xr/KyT/m
	9mlyGkl9R+MBh3x20NAgMDUnUkarh9CYKx2Z3vLATaKhFq/GuXht6uBf8JrMwozZr2xvL/5sPy2
	jPIQ6MOvy7iPUgAmDrsEvXT8BfrSA4HmT4NYYetDIEplxHfpe/CKCnwDyty2C0GuZRrHKmTDMaw
	w5qrNUJ+TwSJ7s5c0LQE0suceh9nQ6gwunM/qmRe/Wf/Rcr8xfeTXiQ2rTCfad1A+iGT7r7A/de
	/QxyvOB8yKQllZC81yA7Tcj+U4mi/09kY4brTq5Ej10snuyFoVgeWTwPXVMO8h0aq2Hby5D6Slr
	AuXXxMmyzaySrdbsxMkLPTCRRMd6b1ce/BktZEwuY1XDEiUWHTORk0a+U3iq7FlHo4RmgTQTkT0
	/fg==
X-Received: by 2002:a05:6000:2085:b0:49c:192f:cf20 with SMTP id ffacd0b85a97d-4abacfea524mr18694027f8f.6.1795386239712;
        Sun, 22 Nov 2026 14:23:59 -0800 (PST)
Received: from DESKTOP-V28CTA4.localdomain ([103.125.177.105])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4ab6c248b75sm18912122f8f.54.2026.11.22.14.23.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Nov 2026 14:23:58 -0800 (PST)
From: Arbab Haider <arbabhaider649@gmail.com>
To: Mauro Carvalho Chehab <mchehab@kernel.org>
Cc: linux-media@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Arbab Haider <arbabhaider649@gmail.com>
Subject: [PATCH v2 2/2] media: em28xx: avoid dereferencing dev->intf after disconnect in em28xx_v4l2_close()
Date: Mon, 23 Nov 2026 03:23:26 +0500
Message-ID: <20261122222325.41868-3-arbabhaider649@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261122222325.41868-2-arbabhaider649@gmail.com>
References: <20261122222325.41868-2-arbabhaider649@gmail.com>
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
open->close->disconnect scenarios (8/8 passed, 0 KASAN reports).

Fixes: c6d48134cb26 ("[media] em28xx: don't store usb_device at struct em28xx")
Cc: stable@vger.kernel.org
Signed-off-by: Arbab Haider <arbabhaider649@gmail.com>
---
Changes in v2:
- Add Fixes: tag as requested by Media CI.

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

