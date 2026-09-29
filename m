Received: from mail-oo2-f42.google.com (mail-oo2-f42.google.com [74.125.231.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1C403ACF06
	for <stable@vger.kernel.org>; Tue, 29 Sep 2026 02:22:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.231.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790648548; cv=none; b=gdR4MCTvuHbW3yYOmdootot5+k2f2UQkAPfeVJx80ChcGCoddbLt5SsP/TypB3SFc4pX5scGNL7nOl4sEIrBfB/v3oYKKOHY/uyQmwrNLi0gb2mKlnJwQUEaSsW3Ygz0mH24lEOA4+zQBR1aLr8fcFd8OEYqBpCUkrA8cnvivW4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790648548; c=relaxed/simple;
	bh=4ISF6jBUzuFMOlOkasRP/H1VwejMBsAIaKXWOTE4qM8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BvH9w0hBBMe/kmsr8ANa5L/XbwIlXp7K/a/ERCcvCzPIkWDuqAgG9EZ9O6SCfOzBZiKV3IJgpxc0cRVW/z2FqmcgZYckRptHGlFxgrBaNITXcFeniyCQLrPV8bGEidHnTNVyMibuEcHBSZM9v2TdlCF/VKe+WaKHeHNsFrjFMGY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=sWZxdUxV; arc=none smtp.client-ip=74.125.231.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sWZxdUxV"
Received: by mail-oo2-f42.google.com with SMTP id 006d021491bc7-6d797cfdd1fso712161eaf.0
        for <stable@vger.kernel.org>; Mon, 28 Sep 2026 19:22:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790648545; x=1791253345; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=MvEVVHaL/fx0Jmvu8S0ME41C0yUaeIVIsmEstAo+u5U=;
        b=sWZxdUxV0UC8bFPL/r1Rn/KxVmuAQ8tH7nieO8Tg10topZOkG+4NWwuOUVwMLGfNyr
         lY0jF99HoIbXzLbt3oVslGtYLzfqLIlMUljvbVoskJjzdFTihCHrchp5MZxGdP7AJs0T
         Pg6Dj2bff1yOD+yqPPlca5tY3bwKMRZQnaU1jrnbJVPwmVo8DS8/SvchaQsmAoqrZI7s
         FfLkoDdoe8tHHtA1pzBusLo89rgN0DeDYChbInw1Zp7oufhdqWSNXA3XR+6qskxNwLk/
         dxVcXG0d2rTktUkzzsNlPw3r7nIyTEv1miEst68PJmakIwU/gfHz3d8K4VR+VMOfrm3b
         Gnhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790648545; x=1791253345;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=MvEVVHaL/fx0Jmvu8S0ME41C0yUaeIVIsmEstAo+u5U=;
        b=AxewyFdf4AJhFx9Zarkz12Yi05gdvwtBHezkQ9K6B9gYAHZUXQKZPNaoLxtSIocgfw
         lKD/SBd2/9tHExDE7npk7YLxoM/6osWhCnRM8Dzmnk8jZpgWTzNOHJujm1MgZpgNa2XJ
         HxBTb8ru01I971h1PW56gd/N4foCsOFuBJn8ys6NgCr9lgeH2T7Uo2DOrwos/j7mT2X6
         LPArkBz1uHT/6zbMY29iEve9cdA14+xX8ARv6x4w619j8vb5j6guMwh8S5/TB77U2If9
         XLwt0tNz/uvA5SeebnTo9PDyn8GxG1bnEKJEUMpsXWdrV1cXvjoukrSOM9cIizXpHaxi
         B3tQ==
X-Forwarded-Encrypted: i=1; AKwUvByTVfM627hOVcZ1ES5kpKGW/c5JvwtnfU663k+8iPcli0WVsT6iiLiTshT2R2ME8/ohyJyeoH8=@vger.kernel.org
X-Gm-Message-State: AFuF++nwpNO0FEvujtK888nS7ETwgoPhBgEUUuShxUruYgiGoCjGi+Xc
	NPP/gySaMU38IKuGIBXVJ53kOoUeHI9aulueKQFpK2obQaHOERbx285dF9gNbQ==
X-Gm-Gg: AYBFou37M18va4kxwzSFw1N2XV27rTUfP+CNdxpiY3ciaAykB2P8+QBcjZH3QTQbjoP
	aS9+Dv0pitK/kz5WK8LPDurX8xrWof2VMOHxLYYDqWkrdsK5RyPPX0nFf/s9fnkjG1CT4v13+ab
	CNkdgvodKaEhnA9qWXqm298j0zR/rIpwVIQepeelstl365ZSibPsVEOFrxsPojplRgjIspPc6A8
	X34TMFzngjryMOqpSTVgRrjqg3IukSxOrf/sPFBIX3MqEVpXh/lebjpEVGkFz9S+oMrtaYeoRPl
	sQmtlI9d/80wrX3MzFjQ7wx0grJN8uctHKMQhxz1mdsWnDyf1/+O8UMuBte2folkU4FS3a1q/hZ
	w5JcbiBaAKaQR0Fpg60/ytLcK/7X//3ONh2fyr9/VPiv7yZ73L7VUsItxTPqh269ckYHfu4Wtr6
	FUk0Lk9m7P16Xp5187ch+hjUoyBniOyKWdIo5BguhJOuuxsD34or+bNxQ4fk5NiyKgZMUy0Px/b
	rcMtFpzm7fZrB+mejcOuwKpUSv2FNmRH2SOePi5
X-Received: by 2002:a05:6820:c8c:b0:6d8:fa81:61ec with SMTP id 006d021491bc7-6d8fa8175dcmr4423691eaf.22.1790648545511;
        Mon, 28 Sep 2026 19:22:25 -0700 (PDT)
Received: from archlinux.lan ([136.34.156.120])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-6d883395632sm6753798eaf.12.2026.09.28.19.22.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Sep 2026 19:22:24 -0700 (PDT)
From: Danish Khateeb <danishkhateeb03@gmail.com>
To: Rodolfo Giometti <giometti@enneenne.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Calvin Owens <calvin@wbinvd.org>,
	Yibo Tan <lhfff@tju.edu.cn>,
	linux-kernel@vger.kernel.org,
	Danish Khateeb <danishkhateeb03@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH 1/2] pps: generators: fix use-after-free when closing a removed device
Date: Mon, 28 Sep 2026 21:22:18 -0500
Message-ID: <20260929022219.212024-2-danishkhateeb03@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260929022219.212024-1-danishkhateeb03@gmail.com>
References: <20260929022219.212024-1-danishkhateeb03@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The cdev of a PPS generator is embedded in struct pps_gen_device, but
nothing ties the lifetime of that structure to the cdev: pps_gen is
freed by the release function of its device, and an open file holds a
device reference only until pps_gen_cdev_release() drops it.

When the generator is unregistered while /dev/pps-genN is open, that
put_device() drops the last reference and frees pps_gen, and __fput()
then calls cdev_put() on the freed cdev:

  BUG: KASAN: slab-use-after-free in cdev_put+0x53/0x60
  Read of size 8 at addr ffff88801383e138 by task ppsgen64/149
  Call Trace:
   cdev_put+0x53/0x60
   __fput+0x745/0xad0
   fput_close_sync+0xd9/0x1b0
   __x64_sys_close+0x86/0xf0
  ...
  Freed by task 149:
   kfree+0x25a/0x6d0
   device_release+0xca/0x3c0
   kobject_put+0x169/0x320
   pps_gen_cdev_release+0x51/0x80
   __fput+0x36a/0xad0

pps.c had the same bug, fixed in commit c79a39dc8d06 ("pps: Fix a
use-after-free").

Fix it the usual way: embed the struct device in pps_gen_device and
register both with cdev_device_add(). This makes the device the parent
of the cdev, so the cdev holds a device reference until the last file
is closed.

Fixes: 86b525bed275 ("drivers pps: add PPS generators support")
Cc: stable@vger.kernel.org
Assisted-by: LLM
Signed-off-by: Danish Khateeb <danishkhateeb03@gmail.com>
---

Notes:
    Tested in QEMU (virtme-ng, x86_64, KASAN with kasan_multi_shot, lockdep)
    on v7.3-rc5. pps_gen_tio needs ART and can't probe in a VM, so the test
    uses a small platform driver that registers its generator the way TIO
    does. Unbinding it while /dev/pps-gen0 is open gives the cdev_put()
    report above; with this patch it is gone.
    
    The new registration error paths were run too, under KASAN and kmemleak:
    a 17th generator (-ENOSPC), and failslab fail-nth over each allocation
    of a bind (dev_set_name(), cdev_add(), device_add()). No reports and no
    leaks.

 drivers/pps/generators/pps_gen.c | 63 ++++++++++++++++----------------
 include/linux/pps_gen_kernel.h   |  2 +-
 2 files changed, 32 insertions(+), 33 deletions(-)

diff --git a/drivers/pps/generators/pps_gen.c b/drivers/pps/generators/pps_gen.c
index 5e207c75e340..059f4fe6c9b4 100644
--- a/drivers/pps/generators/pps_gen.c
+++ b/drivers/pps/generators/pps_gen.c
@@ -63,7 +63,7 @@ static long pps_gen_cdev_ioctl(struct file *file,
 
 	switch (cmd) {
 	case PPS_GEN_SETENABLE:
-		dev_dbg(pps_gen->dev, "PPS_GEN_SETENABLE\n");
+		dev_dbg(&pps_gen->dev, "PPS_GEN_SETENABLE\n");
 
 		ret = get_user(status, uiuarg);
 		if (ret)
@@ -77,7 +77,7 @@ static long pps_gen_cdev_ioctl(struct file *file,
 		break;
 
 	case PPS_GEN_USESYSTEMCLOCK:
-		dev_dbg(pps_gen->dev, "PPS_GEN_USESYSTEMCLOCK\n");
+		dev_dbg(&pps_gen->dev, "PPS_GEN_USESYSTEMCLOCK\n");
 
 		ret = put_user(pps_gen->info->use_system_clock, uiuarg);
 		if (ret)
@@ -89,12 +89,12 @@ static long pps_gen_cdev_ioctl(struct file *file,
 		struct pps_gen_event info;
 		unsigned int ev = pps_gen->last_ev;
 
-		dev_dbg(pps_gen->dev, "PPS_GEN_FETCHEVENT\n");
+		dev_dbg(&pps_gen->dev, "PPS_GEN_FETCHEVENT\n");
 
 		ret = wait_event_interruptible(pps_gen->queue,
 				ev != pps_gen->last_ev);
 		if (ret == -ERESTARTSYS) {
-			dev_dbg(pps_gen->dev, "pending signal caught\n");
+			dev_dbg(&pps_gen->dev, "pending signal caught\n");
 			return -EINTR;
 		}
 
@@ -121,7 +121,7 @@ static int pps_gen_cdev_open(struct inode *inode, struct file *file)
 	struct pps_gen_device *pps_gen = container_of(inode->i_cdev,
 				struct pps_gen_device, cdev);
 
-	get_device(pps_gen->dev);
+	get_device(&pps_gen->dev);
 	file->private_data = pps_gen;
 	return 0;
 }
@@ -130,7 +130,7 @@ static int pps_gen_cdev_release(struct inode *inode, struct file *file)
 {
 	struct pps_gen_device *pps_gen = file->private_data;
 
-	put_device(pps_gen->dev);
+	put_device(&pps_gen->dev);
 	return 0;
 }
 
@@ -151,19 +151,15 @@ static void pps_gen_device_destruct(struct device *dev)
 {
 	struct pps_gen_device *pps_gen = dev_get_drvdata(dev);
 
-	cdev_del(&pps_gen->cdev);
-
 	pr_debug("deallocating pps-gen%d\n", pps_gen->id);
 	ida_free(&pps_gen_ida, pps_gen->id);
 
-	kfree(dev);
 	kfree(pps_gen);
 }
 
 static int pps_gen_register_cdev(struct pps_gen_device *pps_gen)
 {
 	int err;
-	dev_t devt;
 
 	err = ida_alloc_max(&pps_gen_ida, PPS_GEN_MAX_SOURCES - 1, GFP_KERNEL);
 	if (err < 0) {
@@ -171,46 +167,52 @@ static int pps_gen_register_cdev(struct pps_gen_device *pps_gen)
 			pr_err("too many PPS sources in the system\n");
 			err = -EBUSY;
 		}
+		kfree(pps_gen);
 		return err;
 	}
 	pps_gen->id = err;
 
-	devt = MKDEV(MAJOR(pps_gen_devt), pps_gen->id);
+	/*
+	 * From here on pps_gen belongs to its device and is freed by
+	 * pps_gen_device_destruct(). The cdev holds a reference to the
+	 * device, so pps_gen stays around until the last file is closed.
+	 */
+	device_initialize(&pps_gen->dev);
+	pps_gen->dev.class = &pps_gen_class;
+	pps_gen->dev.parent = pps_gen->info->parent;
+	pps_gen->dev.devt = MKDEV(MAJOR(pps_gen_devt), pps_gen->id);
+	pps_gen->dev.release = pps_gen_device_destruct;
+	dev_set_drvdata(&pps_gen->dev, pps_gen);
 
 	cdev_init(&pps_gen->cdev, &pps_gen_cdev_fops);
 	pps_gen->cdev.owner = pps_gen->info->owner;
 
-	err = cdev_add(&pps_gen->cdev, devt, 1);
+	err = dev_set_name(&pps_gen->dev, "pps-gen%d", pps_gen->id);
+	if (err)
+		goto put_dev;
+
+	err = cdev_device_add(&pps_gen->cdev, &pps_gen->dev);
 	if (err) {
 		pr_err("failed to add char device %d:%d\n",
 				MAJOR(pps_gen_devt), pps_gen->id);
-		goto free_ida;
+		goto put_dev;
 	}
-	pps_gen->dev = device_create(&pps_gen_class, pps_gen->info->parent, devt,
-				     pps_gen, "pps-gen%d", pps_gen->id);
-	if (IS_ERR(pps_gen->dev)) {
-		err = PTR_ERR(pps_gen->dev);
-		goto del_cdev;
-	}
-	pps_gen->dev->release = pps_gen_device_destruct;
-	dev_set_drvdata(pps_gen->dev, pps_gen);
 
 	pr_debug("generator got cdev (%d:%d)\n",
 			MAJOR(pps_gen_devt), pps_gen->id);
 
 	return 0;
 
-del_cdev:
-	cdev_del(&pps_gen->cdev);
-free_ida:
-	ida_free(&pps_gen_ida, pps_gen->id);
+put_dev:
+	put_device(&pps_gen->dev);
 	return err;
 }
 
 static void pps_gen_unregister_cdev(struct pps_gen_device *pps_gen)
 {
 	pr_debug("unregistering pps-gen%d\n", pps_gen->id);
-	device_destroy(&pps_gen_class, pps_gen->dev->devt);
+	cdev_device_del(&pps_gen->cdev, &pps_gen->dev);
+	put_device(&pps_gen->dev);
 }
 
 /*
@@ -244,18 +246,15 @@ struct pps_gen_device *pps_gen_register_source(const struct pps_gen_source_info
 	init_waitqueue_head(&pps_gen->queue);
 	spin_lock_init(&pps_gen->lock);
 
-	/* Create the char device */
+	/* Create the char device, this frees pps_gen on failure */
 	err = pps_gen_register_cdev(pps_gen);
 	if (err < 0) {
 		pr_err(" unable to create char device\n");
-		goto kfree_pps_gen;
+		goto pps_gen_register_source_exit;
 	}
 
 	return pps_gen;
 
-kfree_pps_gen:
-	kfree(pps_gen);
-
 pps_gen_register_source_exit:
 	pr_err("unable to register generator\n");
 
@@ -289,7 +288,7 @@ void pps_gen_event(struct pps_gen_device *pps_gen,
 {
 	unsigned long flags;
 
-	dev_dbg(pps_gen->dev, "PPS generator event %u\n", event);
+	dev_dbg(&pps_gen->dev, "PPS generator event %u\n", event);
 
 	spin_lock_irqsave(&pps_gen->lock, flags);
 
diff --git a/include/linux/pps_gen_kernel.h b/include/linux/pps_gen_kernel.h
index 6214c8aa2e02..f26f6aac000d 100644
--- a/include/linux/pps_gen_kernel.h
+++ b/include/linux/pps_gen_kernel.h
@@ -54,7 +54,7 @@ struct pps_gen_device {
 
 	unsigned int id;			/* PPS generator unique ID */
 	struct cdev cdev;
-	struct device *dev;
+	struct device dev;
 	struct fasync_struct *async_queue;	/* fasync method */
 	spinlock_t lock;
 };
-- 
2.55.0

