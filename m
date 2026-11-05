Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793839093;
	b=TW2kgKfKQ9JpUSLZWHgRwrsapCmgO2iG9dNkhCx4HODzj3wZIo5hxfimMzMayPhHOmze
	 8CvXHWsP5mKAnM/2wXQhCuAaxDySLLodFO3iBXUviks5N0ndzLGtcHHfoR7HmO/EfoB18
	 oZHbZBy0kCtsNkik+nLtRzZ4y4D1XWxrZTOStCqMGwdwFZaaigIDj57friZnaeXRUczMs
	 zCMVzKNmkrrUr9EflfUob9elACiP/ern5UDSrb7+ulhJuLqwHoWQE/51tXBKeP+BnQPb7
	 9nZQzWgfffM8y3Cnof7tM3cCdOqQAY0kEr2kgV9YMNJ0hUdeUPub+xXJ68PrJZVzFrg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793839093;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=hrAvguoF5hZGOcIOkWctsnR8n697FrD5ft7156fooRc=;
	b=CRGhJuJwevj7g2nL5+t9hMBEsaQO+DVQ5g7R0O546Mb6p0nPMtyK+n8GEq7xCSxypSfs
	 SVHy6xbRkF9rgOSSNUoIcmHtgNi4oy3zYubBT1oqmh/47ZfcfiFntaJt0D71xsZotwUzV
	 //ZO9DV8CQ8XHk6AEmoTm1bXErgweN8+bNymBHgBF9N8RRM0aQtjAR4m32Ah7sx70sHOT
	 j/nG5QZd148cPaZGz6AridJzcuKZFHUbYQ3sOulPMfLqZX2z/FgS6AYi0CO49Z/O9dQse
	 puc589RHKnXytNhsrgq1M48b0esOi+be9n3gzWf6w9TgJ8MYWfroT3v34sJafOjpQLg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="Kc6aW/Dh";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2584C606A329
	for <stable@vger.kernel.org>; Thu,  5 Nov 2026 00:38:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Kc6aW/Dh
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 461281F000C1;
	Thu,  5 Nov 2026 00:38:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793839092;
	bh=hrAvguoF5hZGOcIOkWctsnR8n697FrD5ft7156fooRc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Kc6aW/DhSFikjv2u4XVFjmp57/3Vs+jNaPOIkXXLKIBmPaq/ryWi4ju/GL1IZu+9M
	 ok1qG7lzgH2L7G67FreevCnL3TuF+Xp8008O1fUTyrpVJWd9z59auLfPp4ELpFLJji
	 BEIjNR6vjXaZvFMdnhI4SW2wa2gRNIDL3toaLQZMzo4wKzCN1r0FapKcyUY/xvG5Bu
	 JmAvAcav8pBGp0lFGZg99MfuqjfLZ/ducFZ8MEyjR39YpY5QfRd/5l0bw7goHCP1F3
	 YU3M+pxlQQNImAFSwvOTNQYuWZZMyHkbA9Qskxah4k611HKLZ141pj5VmwwYDLy2G1
	 oq+DcStEEU2+Q==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Danish Khateeb <danishkhateeb03@gmail.com>,
	Rodolfo Giometti <giometti@enneenne.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18.y] pps: generators: don't use the driver's info after unregister
Date: Wed,  4 Nov 2026 19:38:10 -0500
Message-ID: <20261105003742.1032816-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026110431-imminent-guts-a847@gregkh>
References: <2026110431-imminent-guts-a847@gregkh>
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

From: Danish Khateeb <danishkhateeb03@gmail.com>

[ Upstream commit 4e8063cae337cb7328e6856235cf4de5d165516e ]

A file that was opened before pps_gen_unregister_source() keeps
pps_gen, and with it the pointer to the driver's pps_gen_source_info.
PPS_GEN_SETENABLE and PPS_GEN_USESYSTEMCLOCK keep using that pointer
after the driver has gone:

 - pps_gen_tio allocates its info with devm_kzalloc(), so after an
   unbind both ioctls read freed memory, and SETENABLE calls the
   driver's enable() with its freed private data.

 - pps_gen-dummy does not set info->owner, so it can be unloaded while
   the file is open, and the ioctls then read the unloaded module's
   data and call its code.

TIO can't probe in a VM, as it needs ART. A test driver that registers
its info in devm memory like TIO does, unbound while /dev/pps-gen0 is
open, gives:

  BUG: KASAN: slab-use-after-free in pps_gen_cdev_ioctl+0x4c1/0x580
  Read of size 1 at addr ffff88800e647f38 by task ppsgen64/145
  ...
  Freed by task 146:
   kfree+0x25a/0x6d0
   release_nodes+0xd1/0x140
   devres_release_all+0x10e/0x1a0
   device_unbind_cleanup+0x71/0x250
   device_release_driver_internal+0x41b/0x570
   unbind_store+0xd9/0x100

and unloading pps_gen-dummy while its file is open oopses:

  BUG: unable to handle page fault for address: ffffffffa0203040
  Oops: Oops: 0000 [#1] SMP KASAN NOPTI
  RIP: 0010:pps_gen_cdev_ioctl+0x372/0x580

Protect info in the ioctl handler with a mutex, and clear it under the
mutex on unregister, so that unregister waits for the ioctls using it
and later ones fail with -ENODEV. PPS_KC_BIND does the same for a
removed PPS device since commit 3649f9a6b897 ("pps: don't allow
PPS_KC_BIND on removed devices"). The sysfs attributes need nothing
new: they are removed, and their callbacks drained, before info is
cleared.

Fixes: 86b525bed275 ("drivers pps: add PPS generators support")
Cc: stable@vger.kernel.org
Assisted-by: LLM
Signed-off-by: Danish Khateeb <danishkhateeb03@gmail.com>
Acked-by: Rodolfo Giometti <giometti@enneenne.com>
Link: https://patch.msgid.link/20260929124937.51114-3-danishkhateeb03@gmail.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/pps/generators/pps_gen.c | 31 ++++++++++++++++++++++++++-----
 include/linux/pps_gen_kernel.h   |  2 ++
 2 files changed, 28 insertions(+), 5 deletions(-)

diff --git a/drivers/pps/generators/pps_gen.c b/drivers/pps/generators/pps_gen.c
index 69a470fa164d6..630a8804d63e7 100644
--- a/drivers/pps/generators/pps_gen.c
+++ b/drivers/pps/generators/pps_gen.c
@@ -69,17 +69,28 @@ static long pps_gen_cdev_ioctl(struct file *file,
 		if (ret)
 			return -EFAULT;
 
-		ret = pps_gen->info->enable(pps_gen, status);
-		if (ret)
-			return ret;
-		pps_gen->enabled = status;
+		scoped_guard(mutex, &pps_gen->info_lock) {
+			if (!pps_gen->info)
+				return -ENODEV;
+
+			ret = pps_gen->info->enable(pps_gen, status);
+			if (ret)
+				return ret;
+			pps_gen->enabled = status;
+		}
 
 		break;
 
 	case PPS_GEN_USESYSTEMCLOCK:
 		dev_dbg(&pps_gen->dev, "PPS_GEN_USESYSTEMCLOCK\n");
 
-		ret = put_user(pps_gen->info->use_system_clock, uiuarg);
+		scoped_guard(mutex, &pps_gen->info_lock) {
+			if (!pps_gen->info)
+				return -ENODEV;
+			status = pps_gen->info->use_system_clock;
+		}
+
+		ret = put_user(status, uiuarg);
 		if (ret)
 			return -EFAULT;
 
@@ -212,6 +223,15 @@ static void pps_gen_unregister_cdev(struct pps_gen_device *pps_gen)
 {
 	pr_debug("unregistering pps-gen%d\n", pps_gen->id);
 	cdev_device_del(&pps_gen->cdev, &pps_gen->dev);
+
+	/*
+	 * An open file keeps pps_gen around, but the driver may free info as
+	 * soon as we return. The sysfs files are gone now, so wait for the
+	 * ioctls using info and make later ones fail.
+	 */
+	scoped_guard(mutex, &pps_gen->info_lock)
+		pps_gen->info = NULL;
+
 	put_device(&pps_gen->dev);
 }
 
@@ -243,6 +263,7 @@ struct pps_gen_device *pps_gen_register_source(const struct pps_gen_source_info
 	pps_gen->info = info;
 	pps_gen->enabled = false;
 
+	mutex_init(&pps_gen->info_lock);
 	init_waitqueue_head(&pps_gen->queue);
 	spin_lock_init(&pps_gen->lock);
 
diff --git a/include/linux/pps_gen_kernel.h b/include/linux/pps_gen_kernel.h
index f26f6aac000dc..c4d22b1af1186 100644
--- a/include/linux/pps_gen_kernel.h
+++ b/include/linux/pps_gen_kernel.h
@@ -11,6 +11,7 @@
 #include <linux/pps_gen.h>
 #include <linux/cdev.h>
 #include <linux/device.h>
+#include <linux/mutex.h>
 
 /*
  * Global defines
@@ -44,6 +45,7 @@ struct pps_gen_source_info {
 /* The main struct */
 struct pps_gen_device {
 	const struct pps_gen_source_info *info;	/* PSS generator info */
+	struct mutex info_lock;			/* protects info */
 	bool enabled;				/* PSS generator status */
 
 	unsigned int event;
-- 
2.53.0

