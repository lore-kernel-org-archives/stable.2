Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE38C2DF719
	for <stable@vger.kernel.org>; Sun, 28 Jun 2026 09:33:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782639212; cv=none; b=eXFs2FhOrKjtcsmU2VgPi25zLPi4RDvm0iH07pBt0CGOVHYgIZQv+6By7EK9C6JQj05XYNB12SWO3TDCGHw2eUdIkCxnkFmCJe8X9mgwLutqM/YcbtlAyOG4f1u85VTOvZciKDh1RuK1WnLARM3nJl7E8u1AQQC97L8vg5/OyMQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782639212; c=relaxed/simple;
	bh=DJTHZvl6S11OOfAQB6lqm5ikN8o5iBUg99YfgfnT5U4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=tMBNFOK1ERnnO5X+WtbG6Mlh/m3hzwa6kdtBAZYTUEQJADxEMA61WtGFAX14lsnvERQYIyhQY/ORgjvmh+M8A6QgGL5jszjvnEvJAZkeXdlENpORgkKQYrkgLuecM9IhoCyCH6hTSkQeP2PPHmMSec7LrVt6M4zbUyFdU+SFIo4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=oQquA0RP; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oQquA0RP"
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-493a287b8c1so4214495e9.0
        for <stable@vger.kernel.org>; Sun, 28 Jun 2026 02:33:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782639209; x=1783244009; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=TFWzc7Dr8BMNziQC19/fthox8mYezwUWhmmBeBzJP4M=;
        b=oQquA0RP0lsFOz19uEGAteLaWKqrTQ1mr9j7/7B6iMjf85lJUOHPGrDBMWIflgCmHF
         FEUnyJEDnr+Bk34YxqYj7u3CV1X/ZV1TyYGogm54P8/wZUJhArzJecDItwEkPYuYvBhK
         1LB544qAgmSqThiXB+WRR4xjb/fbkDn6/3y34Cm01lQq6fo8rtGD4PP7VYJlq2hULcud
         nEIcX5tUz48WVuYfnOJlbb+4dU23uxEit5iiXTVK449uvbwhFVbua8V0JuGxRvmMZsOi
         12OQqt5hLF9FHZKKmHisUNiFjQUIM8ZooWRz0miybxsh5tIuoG9tRD9RKXVWJLaN5uDl
         QfpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782639209; x=1783244009;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TFWzc7Dr8BMNziQC19/fthox8mYezwUWhmmBeBzJP4M=;
        b=Thc4KmY1gXHAFJg1cSG2UKLK1zInHilfaJiE9HSHXiZwC3JG84ihBeT8Rsj+6xxv8U
         Vjtr6iU51o2eAZKsMeFTUX0lN+95jXD5GoBwZ+s9V4e0s8hO8lzTf0JCbuRTH78lfD9k
         Z0oS+Rhl7IB+Ek79j69axi7Sqq44DsRcFx0ny3b/594IvkFvSdcgcFSJGDmRbUoygeFP
         6H+bHAoNCVdfEG6UbFOabrsCVp4/Ck0uskZ6ZV2ylnrvA0IIhEQf8Usait/vTMT8NbWv
         DFlFpOuOmnrUDP6QGy7lDekh/qLhC9sC2vVHpNRA1udLPAK8q3YjtVHcA1q/X/nMkRMN
         cKVw==
X-Forwarded-Encrypted: i=1; AFNElJ8dC/aIVA/hGqKKf3ZiOCh2Lke0SzkeIrqCR8zi//7rMPmOpN06mm71zLz5Up22AOO9mI6RPZQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyEKvUIX963ffHJ5+b61i3xz0cbeCCQzizN04TG+lOq+UH+v8uT
	P/hn7i2MI8I3GGt/tnQmTU8Njaat2GhC/AnAGHLKiftPfMHhz+DzHAiz
X-Gm-Gg: AfdE7cna5QvwOkmkEjHuqw+dxpfgUJ4JvFMXH9gqeRPuv6EwEDfSp5+itMzv0mkfCSR
	u9rKDtmT5TohJACIHdpHeI3ONfk9FMpl4tH4U2f+nx/6VzK0ddaYgJ6DHun+E0XE3ygCA497En8
	TjQCur6kgcNGE3NK/34wRDoxzMMGMWjnVYRW+Zeob4cV9KSnc/06bwTXt7nWlevyvfxzCA8hCTv
	9LCtHDmWeJ4WvQBgnsHqiuuOtSaD+7EmNn5NWk4jSz7sI3SKBVBIacR7Vf+u+A7aK4whyEv03T5
	PzTTwlOy+NxRTcuVdxd8IVOT/SxacHWzeD5KpdFZa4bz2Tt3gHV89YM6KK4P8lcXdAuaSS7QyA6
	7ramuysE1W6C+bP3bQYvRTbo7j6cooVxrouaq1TnU4fBKOZzmSUiovW37QhuKmgP7d/cXFemwRP
	bbqV2KZ2A20hMMZpAKwZbjIraNTw==
X-Received: by 2002:a05:600c:1d1b:b0:492:4caa:e2f4 with SMTP id 5b1f17b1804b1-492668ad885mr198132705e9.36.1782639209171;
        Sun, 28 Jun 2026 02:33:29 -0700 (PDT)
Received: from Dev-Null-MSI ([2a0d:3344:52ac:a808:98a4:4381:be45:536f])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-46c2279bc77sm37461059f8f.32.2026.06.28.02.33.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Jun 2026 02:33:28 -0700 (PDT)
From: Yousef Alhouseen <alhouseenyousef@gmail.com>
To: Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>
Cc: linux-input@vger.kernel.org,
	linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	syzbot+563191a4939ddbfe73d4@syzkaller.appspotmail.com,
	Yousef Alhouseen <alhouseenyousef@gmail.com>
Subject: [PATCH] HID: hiddev: keep state alive through disconnect unlock
Date: Sun, 28 Jun 2026 11:32:45 +0200
Message-ID: <20260628093245.42065-1-alhouseenyousef@gmail.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

hiddev_disconnect() drops existancelock before freeing the hiddev state,
but a waiting final file release can run as soon as the mutex becomes
available. On PREEMPT_RT, that waiter may free hiddev while the disconnect
thread is still executing the mutex slow-unlock path, causing a
use-after-free in the mutex implementation.

Give the connection and each open file an explicit reference. Drop each
reference only after its existancelock critical section has completed, so
the state cannot be freed from the other unlock path.

Fixes: 079034073faf ("HID: hiddev cleanup -- handle all error conditions properly")
Reported-by: syzbot+563191a4939ddbfe73d4@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=563191a4939ddbfe73d4
Cc: stable@vger.kernel.org
Signed-off-by: Yousef Alhouseen <alhouseenyousef@gmail.com>
---
 drivers/hid/usbhid/hiddev.c | 37 +++++++++++++++++++------------------
 include/linux/hiddev.h      |  2 ++
 2 files changed, 21 insertions(+), 18 deletions(-)

diff --git a/drivers/hid/usbhid/hiddev.c b/drivers/hid/usbhid/hiddev.c
index 6378801b22c6..21396481995b 100644
--- a/drivers/hid/usbhid/hiddev.c
+++ b/drivers/hid/usbhid/hiddev.c
@@ -46,6 +46,12 @@ struct hiddev_list {
 	struct mutex thread_lock;
 };
 
+static void hiddev_put(struct hiddev *hiddev)
+{
+	if (refcount_dec_and_test(&hiddev->refcount))
+		kfree(hiddev);
+}
+
 /*
  * Find a report, given the report's type and ID.  The ID can be specified
  * indirectly by REPORT_ID_FIRST (which returns the first report of the given
@@ -216,26 +222,21 @@ static int hiddev_fasync(int fd, struct file *file, int on)
 static int hiddev_release(struct inode * inode, struct file * file)
 {
 	struct hiddev_list *list = file->private_data;
+	struct hiddev *hiddev = list->hiddev;
 	unsigned long flags;
 
-	spin_lock_irqsave(&list->hiddev->list_lock, flags);
+	spin_lock_irqsave(&hiddev->list_lock, flags);
 	list_del(&list->node);
-	spin_unlock_irqrestore(&list->hiddev->list_lock, flags);
+	spin_unlock_irqrestore(&hiddev->list_lock, flags);
 
-	mutex_lock(&list->hiddev->existancelock);
-	if (!--list->hiddev->open) {
-		if (list->hiddev->exist) {
-			hid_hw_close(list->hiddev->hid);
-			hid_hw_power(list->hiddev->hid, PM_HINT_NORMAL);
-		} else {
-			mutex_unlock(&list->hiddev->existancelock);
-			kfree(list->hiddev);
-			vfree(list);
-			return 0;
-		}
+	mutex_lock(&hiddev->existancelock);
+	if (!--hiddev->open && hiddev->exist) {
+		hid_hw_close(hiddev->hid);
+		hid_hw_power(hiddev->hid, PM_HINT_NORMAL);
 	}
 
-	mutex_unlock(&list->hiddev->existancelock);
+	mutex_unlock(&hiddev->existancelock);
+	hiddev_put(hiddev);
 	vfree(list);
 
 	return 0;
@@ -270,6 +271,7 @@ static int __hiddev_open(struct hiddev *hiddev, struct file *file)
 	spin_unlock_irq(&hiddev->list_lock);
 
 	file->private_data = list;
+	refcount_inc(&hiddev->refcount);
 
 	return 0;
 
@@ -897,6 +899,7 @@ int hiddev_connect(struct hid_device *hid, unsigned int force)
 	INIT_LIST_HEAD(&hiddev->list);
 	spin_lock_init(&hiddev->list_lock);
 	mutex_init(&hiddev->existancelock);
+	refcount_set(&hiddev->refcount, 1);
 	hid->hiddev = hiddev;
 	hiddev->hid = hid;
 	hiddev->exist = 1;
@@ -937,9 +940,7 @@ void hiddev_disconnect(struct hid_device *hid)
 	if (hiddev->open) {
 		hid_hw_close(hiddev->hid);
 		wake_up_interruptible(&hiddev->wait);
-		mutex_unlock(&hiddev->existancelock);
-	} else {
-		mutex_unlock(&hiddev->existancelock);
-		kfree(hiddev);
 	}
+	mutex_unlock(&hiddev->existancelock);
+	hiddev_put(hiddev);
 }
diff --git a/include/linux/hiddev.h b/include/linux/hiddev.h
index 2164c03d2c72..8e9f8a33e359 100644
--- a/include/linux/hiddev.h
+++ b/include/linux/hiddev.h
@@ -13,6 +13,7 @@
 #ifndef _HIDDEV_H
 #define _HIDDEV_H
 
+#include <linux/refcount.h>
 #include <uapi/linux/hiddev.h>
 
 
@@ -24,6 +25,7 @@ struct hiddev {
 	int minor;
 	int exist;
 	int open;
+	refcount_t refcount;
 	struct mutex existancelock;
 	wait_queue_head_t wait;
 	struct hid_device *hid;
-- 
2.54.0

