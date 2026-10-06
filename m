Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C13033BB9EB
	for <stable@vger.kernel.org>; Tue,  6 Oct 2026 20:42:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791319329; cv=none; b=RwHxE17Buxgn3ZiWqkpnapJOy5hT0J/wjQNzQ/jqQFVbWj+yTGngRPs9WTqmBgDP6EVMrT/Fi/VN8alx6z/vcmAPMsTVcHiwTYMX6B4CMx1JBjq+BLuV1zRtll8OGLVyYertPlFaAgoELUKJUy5eqjE0W3QodPRX83nyiasXIGc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791319329; c=relaxed/simple;
	bh=ae1+jQ+9/ez5KK1iccrevpE3Y/v2hJ7/j3WMLTOnlbY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=CWIlvVZwRyUQ1Uy7FUjtwCfD7QiM5wrBVrL+ekfjyd04jS2fE//IMx2y6FbvPKLEZJ69Y5QWT4bwXaAF1G2yVjLm4Yj8pDSJd1wL/AifYetLnAo8ggHrQy8kwRa5pC0kVExMiU+A7Dfk1Fi675rQBdHVdLMy0oz0PmPcMkEejIg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=tEqCtlE1; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tEqCtlE1"
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-49ff680331aso34122215e9.3
        for <stable@vger.kernel.org>; Tue, 06 Oct 2026 13:42:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791319325; x=1791924125; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=aA2FYIjUqF5r/91lBwDXxKR+/AAiwQXpqeT47CJCmVU=;
        b=tEqCtlE1wY+xXwcUz+mdroP02tEUob5DA9En/YN4u0CTMyxui813m4YDW8W7enHfWv
         hYZ+Qc2YrK5pofPdvz0di3Rwcx5KnUu+p25MaYdMqskyOoJonKIbLYmngyFOLRmcy94g
         8GSYzDr5FPPD9/F27QY5jWmVg0XKxhNv+aToLtYymuTTApI2SQ5uzy6C1GzL68Cp1naQ
         2wV8fW9zIALO1zKAFCGQp4oEsVB2f15FH+nJZGC2GKm+pNzcyLEeH3zbQWZzYKhfS+UP
         hBWIqqcslaJ7azNkkP8nEINgiJzQxEssZ5d5lOr4h8NBM4fWY3nrVrCaBUme/ckP3QJx
         BBkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791319325; x=1791924125;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=aA2FYIjUqF5r/91lBwDXxKR+/AAiwQXpqeT47CJCmVU=;
        b=PXhRxBrNlcBxpyNoj3xvxFPgYqhJrcRtVbQSrq7yCjrk1EYXRdB88WY+/K2MioCEEU
         U0fAhLSUXnR+MCi68bW8C0LT5Fanz7EObJ9XXd53GjvjJ398wZL0kLNCnbV+6qRpZU0S
         ZqbQEU2sTtPIvAMaa8GTJ1+fo3pNrLlw5V6M50IoYXyWwh0MCJJWT4jXgH3cvhVh7YrY
         EHAg+WoZP4YXe3dinXBeHnp59Ohl90QUvYTQGdNf4DlZYMAhuExIrwOgPrUrlPH9FTpP
         h9fy0U53Ytqqt67lt5Gt/XYzYajiF3zLSqTs2v+Qm9G+tpwV2WoVai2q6TA1I/I2KqRO
         ePTw==
X-Forwarded-Encrypted: i=1; AKwUvBzsYh31ViazVf4k4aM9w/7/WG2XhK9DpCV9seI0S0Bla+J/a//3MTf0nDD0jULNHckMpdQwjJY=@vger.kernel.org
X-Gm-Message-State: AFuF++nILwrQZ+KaikzrcaFVyXF1lFmYKotJYvbVdzNlfY3f3H6C8AFn
	AhZxbd4bX+xVrqhyIhbAcMPbymKMAZbHczU7epyHHu4MIAfPje+4/WuM
X-Gm-Gg: AYBFou1G3G8JTUCufUeh8C83mtePLOB5F1L69Pulkm+R3eLq/0v5q1fkImU26T7Xcds
	JXNjWUnkcq+GNqtOloOqqcamhNQCkYzbvPkbRm3n3Ix111ZOEKqtfxQRvgsYAzy/8JsRWiYWajx
	DSoH3206NeOn6Q6YxUzOdNgB2aDQz8sTEMExLqCRAiqkLYQoC7P747on/6UJPbmWkCx4ARWhTn1
	Oj9OYWnKPycCHVXAv3GLzlrZduAO0OLHFkSXyFdbjB5K1bkqFtaqYnVmuaPp2H/QGAsZAUFjSdz
	7PCbVQLyb+Re7+ebi36TJ0cUA90VszRJZHlj8HU5csVVqgYBStWh7joeHUYZIOIzzpxYLKlzqSB
	DM5vXhtcAMZr8l0eeie+jZN28/E+hd229QMQWUI0bWE9ANFKN45MIjmmXWU3lc4AMqte/ew3AVZ
	zgJEKQjINMRGa2lLzab1g0xBpbpxqfBMvazcFu7Yl4FlndIpTjlue/xmynZUT/7esR1c9PF8jmS
	Tpt3WTjRNDz1+nW9HTeJ8EGJ7OMwcnPmMgFSXCvTmW9Php+toucGooJclKZ8url2/Y=
X-Received: by 2002:a05:600c:8b8b:b0:4a0:251f:dabd with SMTP id 5b1f17b1804b1-4a18064cd98mr384095e9.16.1791319324673;
        Tue, 06 Oct 2026 13:42:04 -0700 (PDT)
Received: from Raghu007.. (sgyl-44-b2-v4wan-174108-cust110.vm6.cable.virginm.net. [80.1.81.111])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a1787e7792sm93473055e9.0.2026.10.06.13.42.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Oct 2026 13:42:04 -0700 (PDT)
From: Palla Raghunath <raghunathpalla.0209@gmail.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-usb@vger.kernel.org,
	Neill Kapron <nkapron@google.com>,
	=?UTF-8?q?Micha=C5=82=20Nazarewicz?= <mina86@mina86.com>,
	Shuah Khan <shuah@kernel.org>,
	Brigham Campbell <me@brighamcampbell.com>,
	linux-kernel-mentees@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	raghunathpalla.0209@gmail.com,
	stable@vger.kernel.org,
	syzbot+6227549bd2c8a1ec8ba0@syzkaller.appspotmail.com
Subject: [PATCH] usb: gadget: f_fs: fix use-after-free of ffs_dev in ffs_free_inst()
Date: Tue,  6 Oct 2026 21:42:02 +0100
Message-Id: <20261006204202.59604-1-raghunathpalla.0209@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When a function instance is removed through configfs, ffs_free_inst()
first calls ffs_release_dev(), which takes ffs_dev_lock, detaches the
dev from its mount and drops the lock again. Only then does it retake
the lock and free the dev with _ffs_free_dev().

Between those two steps the dev is still on the ffs_devices list. If
someone mounts functionfs with the same instance name right then,
ffs_acquire_dev() finds the dev, marks it mounted and points the new
ffs_data at it. The dev is freed a moment later, and when that mount
is torn down, ffs_closed() writes to freed memory. syzbot hit this:

  BUG: KASAN: slab-use-after-free in ffs_closed drivers/usb/gadget/function/f_fs.c:4427 [inline]
  BUG: KASAN: slab-use-after-free in ffs_data_clear+0x543/0x5b0 drivers/usb/gadget/function/f_fs.c:2305
  Write of size 1 at addr ffff8880237b1e4a by task syz-executor/11910
  Call Trace:
   ffs_closed drivers/usb/gadget/function/f_fs.c:4427 [inline]
   ffs_data_clear+0x543/0x5b0 drivers/usb/gadget/function/f_fs.c:2305
   ffs_data_reset drivers/usb/gadget/function/f_fs.c:2336 [inline]
   ffs_fs_kill_sb+0x84/0x370 drivers/usb/gadget/function/f_fs.c:2180
   deactivate_locked_super+0xbe/0x110 fs/super.c:586
   cleanup_mnt+0x3d3/0x460 fs/namespace.c:1329
  ...
  Freed by task 17408:
   kfree+0x1c5/0x650 mm/slub.c:6923
   _ffs_free_dev drivers/usb/gadget/function/f_fs.c:4336 [inline]
   ffs_free_inst+0x233/0x2c0 drivers/usb/gadget/function/f_fs.c:4152
   usb_put_function_instance+0x95/0xc0 drivers/usb/gadget/functions.c:77
   config_item_release+0x13a/0x2d0 fs/configfs/item.c:137
   configfs_rmdir+0x885/0x950 fs/configfs/dir.c:1580

Fix it by doing the release and the free while holding the lock once.
To allow that, move the body of ffs_release_dev() into a new
_ffs_release_dev() that expects the lock to be held already, and keep
ffs_release_dev() as a wrapper for ffs_data_put(). A racing mount now
either gets the dev before ffs_free_inst() runs, in which case the
release clears its pointer, or doesn't find the dev at all.

I was able to reproduce this in QEMU with a small program that keeps
creating and removing an ffs function directory in configfs while a
second thread mounts and unmounts functionfs with the same name. On an
unpatched kernel it hit the same KASAN report within about ten
minutes. With this patch applied, the same program ran for 30 minutes
without any problem.

Fixes: ecfbd7b9054b ("usb: gadget: f_fs: Fix setting of device and driver data cross-references")
Cc: stable@vger.kernel.org
Reported-by: syzbot+6227549bd2c8a1ec8ba0@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=6227549bd2c8a1ec8ba0
Signed-off-by: Palla Raghunath <raghunathpalla.0209@gmail.com>
---
 drivers/usb/gadget/function/f_fs.c | 15 +++++++++++----
 1 file changed, 11 insertions(+), 4 deletions(-)

diff --git a/drivers/usb/gadget/function/f_fs.c b/drivers/usb/gadget/function/f_fs.c
index c64a268e98a4..f8ea9a980605 100644
--- a/drivers/usb/gadget/function/f_fs.c
+++ b/drivers/usb/gadget/function/f_fs.c
@@ -288,6 +288,7 @@ static struct ffs_dev *_ffs_find_dev(const char *name);
 static struct ffs_dev *_ffs_alloc_dev(void);
 static void _ffs_free_dev(struct ffs_dev *dev);
 static int ffs_acquire_dev(const char *dev_name, struct ffs_data *ffs_data);
+static void _ffs_release_dev(struct ffs_dev *ffs_dev);
 static void ffs_release_dev(struct ffs_dev *ffs_dev);
 static int ffs_ready(struct ffs_data *ffs);
 static void ffs_closed(struct ffs_data *ffs);
@@ -4147,8 +4148,8 @@ static void ffs_free_inst(struct usb_function_instance *f)
 	struct f_fs_opts *opts;
 
 	opts = to_f_fs_opts(f);
-	ffs_release_dev(opts->dev);
 	ffs_dev_lock();
+	_ffs_release_dev(opts->dev);
 	_ffs_free_dev(opts->dev);
 	ffs_dev_unlock();
 	kfree(opts);
@@ -4363,10 +4364,11 @@ static int ffs_acquire_dev(const char *dev_name, struct ffs_data *ffs_data)
 	return ret;
 }
 
-static void ffs_release_dev(struct ffs_dev *ffs_dev)
+/*
+ * Same as ffs_release_dev(), for callers that already hold ffs_dev_lock.
+ */
+static void _ffs_release_dev(struct ffs_dev *ffs_dev)
 {
-	ffs_dev_lock();
-
 	if (ffs_dev && ffs_dev->mounted) {
 		ffs_dev->mounted = false;
 		if (ffs_dev->ffs_data) {
@@ -4377,7 +4379,12 @@ static void ffs_release_dev(struct ffs_dev *ffs_dev)
 		if (ffs_dev->ffs_release_dev_callback)
 			ffs_dev->ffs_release_dev_callback(ffs_dev);
 	}
+}
 
+static void ffs_release_dev(struct ffs_dev *ffs_dev)
+{
+	ffs_dev_lock();
+	_ffs_release_dev(ffs_dev);
 	ffs_dev_unlock();
 }
 
-- 
2.34.1

