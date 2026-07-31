Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E382142A78B
	for <stable@vger.kernel.org>; Fri, 31 Jul 2026 14:22:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785507754; cv=none; b=Q+b9bWWT7upUvPr2ci/mw0rcVTFYsollBfdX3OP+RXH6644+jMpwqYgi3OGHZ2sJ3wyYrwikhxUhj573f0Nh1LHC8nyE2ICBst92zHsDV695I4XCLioCSyirRzEbSk2fpKJd0ZCgzZrus5jV2+gzM7F+opHn1oFJsG7E3Rgc1D4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785507754; c=relaxed/simple;
	bh=ll6FLQerJq3jLfjs/fN90YGo45O8imjtMDX2eTiTmhE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=eLKrybovm+r6+HvpiN3ezCin3GYbn57fJULV9Wj6Fqu9VslNP43rnBQjiNMlsdJlEFd7PaCMQWQh3wMLtiE1I0jXo9J847eKkz/Io9GDaUuunVdKhloDdIJ/hopdYsqeSEzDiFXDmjNTkYRtHFNcISudtEIYZJ1ZE1z7o87vIh8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FvF9E4Mp; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FvF9E4Mp"
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2cc8311c6ddso732055ad.0
        for <stable@vger.kernel.org>; Fri, 31 Jul 2026 07:22:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785507752; x=1786112552; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=cPoeW3jLES6wCr33SzwG3txLGpwaWgERLK4MD+MFZtU=;
        b=FvF9E4MpEzP1X8Np3czmCCjgB+eNVlhvCUrY4Ggp0hrLL3/alXRjLiBi9gpgsY3gBD
         yeNMoB1YRuyY4/14iOS2MItWjSbbP288nSutIu8amjb7cyECQ/tLIWM0ArdgkUWDg/B0
         O8xt5S2e1wvYZvT8lgAzAkDPttaiMFQtd6bFK1sPmmDe47zIavl/UodwU/CVHujx75E4
         g01Y8GIaD8LUskASPme/4VFKeaWwri2415FSv5v/VDk4GdaAud+GZo3OKmJmtPYSYwxb
         NzM8GHhGCz9n63/LpshZ/Lpp3mcJL+ir8xCyAU1c9YHYTJHXbVvB3tpA4Vr28yee1wil
         XZ9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785507752; x=1786112552;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=cPoeW3jLES6wCr33SzwG3txLGpwaWgERLK4MD+MFZtU=;
        b=Gnf1b8MmxBxPeMs45S5pUuzm+TG0O2yjM0CdwMCZINNDG9fz68UCYzWLOb0Y6cAKR6
         zHMkTg7HYVCHTAT/YEvjR+VJ7nV6KuBTXO5Xrs6qipboNPsBiaM3BAfSpJrWuqlFwVir
         7DZvJK2wBiQjU2JOTzy8KXPB/vrcfT2WA+z2fe3xM5LMBjihVEb0q+VUmRnTPWhXbiHc
         U6jOH5qQw/qlwr9J1pU37uvsrvfHvKKc6b82mKPwhHvWp4c06RoxhtGO/D7T8dzu9sZV
         SyOJnh1/jl2Z/PGQ/AJPmnnCFZ7aWN6hO54ArUIjjPKTgdIHR6xcrZwjkRjsl4OTohXR
         O6cA==
X-Forwarded-Encrypted: i=1; AHgh+RpUGFVTiyhrxIH8/ADGfqyRKZFMXEmbjjUJ0oxJj0Rz/8lIU0bRynlC8kW+5RInQONxd2W0iZk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx591MijOvyqK+Z0hlcf4G9+ODjT1EGRzSApkRnDMTMx4dbA1Zr
	MqQkQ/CKUZmH50h1ztUxo0PWA2K+vQRQd6opqWaW8BiG93SKQ19/QVSe
X-Gm-Gg: AR+sD10Nbm+ytH98GWvK1Wbj9VKHkEtp9BLa0aJFA7xyZ88CbNx+UKV6EQ5sIt5PlXk
	iZ0x/PBvNuxnzw71FCPv2IR70cfuUH8snFZpFO/wt+SSBK70sqsQdFQIZ2E5/5705hYAp4YIAwf
	5xDM8SLCTS0+XWDCqmcVvso0f2CMCmSwcUOu39nE0UhgCLBSd9Df27hBJGQQFxa5ruH4ufsr7Gi
	9EHOEHNZtVXlKxWlMx/Kp+LBpxlgubv5Mm/SKlUR19xu5IVEtShL2Sz1C1gmwqecI7bGDSRZVBD
	DaktSTAFKhv6NNcVRfLvpiFXT7np1ZuCsGffCgcH7wbEvUfIVSPm/7tctO4jCCmYEEAbmvxQbG1
	Ae+sCRnH8F5JojZmkAZEKwPHnlk2v33CKnMEZ4mCTNmx/gKe3Gv7bC+AJDOH4gYwlO61euY4MJf
	IpKdGmTh3oHx8FutC/75nBe+uRE33YwsrmjzJiJr97sAiXYixR+Unfo2ld5u9r9BnfnQMvWOHKa
	3DROtUaUmOog8R14WFD94RmzQ4jvcCpWnSIn8QMx1KHEMSJXlonVCs=
X-Received: by 2002:a17:903:38c7:b0:2c9:8287:fd0d with SMTP id d9443c01a7336-2d052438c91mr2628485ad.3.1785507751833;
        Fri, 31 Jul 2026 07:22:31 -0700 (PDT)
Received: from localhost.localdomain (45.78.65.84.16clouds.com. [45.78.65.84])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3153dd4f0f0sm6470095eec.2.2026.07.31.07.22.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Jul 2026 07:22:30 -0700 (PDT)
From: Chengfeng Ye <nicoyip.dev@gmail.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	Richard Watts <rrw@kynesim.co.uk>
Cc: linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org,
	Chengfeng Ye <nicoyip.dev@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH] tty: serialize device registration and removal
Date: Fri, 31 Jul 2026 22:22:20 +0800
Message-ID: <20260731142220.3000214-1-nicoyip.dev@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

tty_cdev_add() stores a newly allocated cdev in driver->cdevs[index]
before initializing and registering it. tty_unregister_device() reads and
deletes the same pointer without serialization.

The race can proceed as follows:

  registration                     removal
  ------------                     -------
  driver->cdevs[index] = cdev
                                   cdev_del(driver->cdevs[index])
                                   kobject_put() frees cdev
  driver->cdevs[index]->ops = &tty_fops

The final write accesses freed memory. Concurrent registration can also
replace the slot while another caller is still using its cdev.

KASAN reported:

  BUG: KASAN: slab-use-after-free in tty_cdev_add+0x5c7/0x670
  Write of size 8 at addr ffff88810b298c48

  Call Trace:
   tty_cdev_add+0x5c7/0x670
   tty_register_device_attr+0x458/0x810
   gsm_activate_mux+0x105/0x2e0
   gsmld_ioctl+0x92f/0x14d0

  Allocated by task 111:
   cdev_alloc+0x99/0x130
   tty_cdev_add+0x93/0x670

  Freed by task 110:
   cdev_dynamic_release+0x38/0x50
   kobject_put+0x14d/0x280
   tty_unregister_device+0x1b7/0x3c0

Add a per-driver mutex and hold it across complete device registration and
removal. This prevents either transition from replacing or freeing a cdev
until the other has finished.

Fixes: a3a10ce3429e ("Avoid usb reset crashes by making tty_io cdevs truly dynamic")
Cc: stable@vger.kernel.org
Signed-off-by: Chengfeng Ye <nicoyip.dev@gmail.com>
---
 drivers/tty/tty_io.c       | 13 ++++++++++---
 include/linux/tty_driver.h |  3 +++
 2 files changed, 13 insertions(+), 3 deletions(-)

diff --git a/drivers/tty/tty_io.c b/drivers/tty/tty_io.c
index 6b283fd03ff8..926a9b586c7d 100644
--- a/drivers/tty/tty_io.c
+++ b/drivers/tty/tty_io.c
@@ -3185,7 +3185,8 @@ static int tty_cdev_add(struct tty_driver *driver, dev_t dev,
  * that bit is not set, this function should not be called by a tty
  * driver.
  *
- * Locking: ??
+ * Locking: device registration and removal are serialized by
+ * @driver->device_mutex.
  *
  * Return: A pointer to the struct device for this tty device (or
  * ERR_PTR(-EFOO) on error).
@@ -3217,7 +3218,8 @@ static void tty_device_create_release(struct device *dev)
  * tty driver's flags have the %TTY_DRIVER_DYNAMIC_DEV bit set. If that bit is
  * not set, this function should not be called by a tty driver.
  *
- * Locking: ??
+ * Locking: device registration and removal are serialized by
+ * @driver->device_mutex.
  *
  * Return: A pointer to the struct device for this tty device (or
  * ERR_PTR(-EFOO) on error).
@@ -3257,6 +3259,7 @@ struct device *tty_register_device_attr(struct tty_driver *driver,
 	dev_set_drvdata(dev, drvdata);
 
 	dev_set_uevent_suppress(dev, 1);
+	guard(mutex)(&driver->device_mutex);
 
 	retval = device_register(dev);
 	if (retval)
@@ -3300,10 +3303,13 @@ EXPORT_SYMBOL_GPL(tty_register_device_attr);
  * If a tty device is registered with a call to tty_register_device() then
  * this function must be called when the tty device is gone.
  *
- * Locking: ??
+ * Locking: device registration and removal are serialized by
+ * @driver->device_mutex.
  */
 void tty_unregister_device(struct tty_driver *driver, unsigned index)
 {
+	guard(mutex)(&driver->device_mutex);
+
 	device_destroy(&tty_class, MKDEV(driver->major, driver->minor_start) + index);
 	if (!(driver->flags & TTY_DRIVER_DYNAMIC_ALLOC)) {
 		cdev_del(driver->cdevs[index]);
@@ -3338,6 +3344,7 @@ struct tty_driver *__tty_alloc_driver(unsigned int lines, struct module *owner,
 		return ERR_PTR(-ENOMEM);
 
 	kref_init(&driver->kref);
+	mutex_init(&driver->device_mutex);
 	driver->num = lines;
 	driver->owner = owner;
 	driver->flags = flags;
diff --git a/include/linux/tty_driver.h b/include/linux/tty_driver.h
index 1f2896e56e77..bf8c9d8ec698 100644
--- a/include/linux/tty_driver.h
+++ b/include/linux/tty_driver.h
@@ -7,6 +7,7 @@
 #include <linux/kref.h>
 #include <linux/list.h>
 #include <linux/cdev.h>
+#include <linux/mutex.h>
 #include <linux/uaccess.h>
 #include <linux/termios.h>
 #include <linux/seq_file.h>
@@ -497,6 +498,7 @@ struct tty_operations {
  * @kref: reference counting. Reaching zero frees all the internals and the
  *	  driver.
  * @cdevs: allocated/registered character /dev devices
+ * @device_mutex: serializes device registration and removal
  * @owner: modules owning this driver. Used drivers cannot be rmmod'ed.
  *	   Automatically set by tty_alloc_driver().
  * @driver_name: name of the driver used in /proc/tty
@@ -532,6 +534,7 @@ struct tty_operations {
 struct tty_driver {
 	struct kref kref;
 	struct cdev **cdevs;
+	struct mutex device_mutex;
 	struct module	*owner;
 	const char	*driver_name;
 	const char	*name;
-- 
2.43.0

