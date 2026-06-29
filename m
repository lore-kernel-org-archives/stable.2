Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72E1AF507
	for <stable@vger.kernel.org>; Mon, 29 Jun 2026 15:30:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782747030; cv=none; b=tN7KCoqQUNamLwdDhErD8JzOBd/0IymHbEeTzJ4YpE1CcGg/XS/Gw5u4ANU1EU6aLB6a0RSIc13CAZw3zdIkcAPqUKsraaRbUWa7duLlAM3mWiaYDhe7zTXHx1VPCeozZDhpyuLQI388iZfcjriY3IvXWqYcY5uGV86khZeGkww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782747030; c=relaxed/simple;
	bh=ZblhU4T4gUC+SFMGo/LcEaT9saHx77/RW0RYQsX5ve8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=LetR1nYnZaH+pg41KIvx/2kadyPpFS4XGojXrBjCeKPgIRtZikCJdOFNMrO8muAjbkVLb1fvdPpQe61AXOzOF8cZyJUZdUfsS08Og8FEeycLamOjwYIOxFmSFkSZQygHrLnsRZtdoYsAT0uT9rJtb02SkWWwdcuFuL0IYZrU26w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RyJp/X6B; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RyJp/X6B"
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-493a54b80a5so23596895e9.2
        for <stable@vger.kernel.org>; Mon, 29 Jun 2026 08:30:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782747027; x=1783351827; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=zbaI5Q/eJ17Mm9qyxMZzWRHjz2c8M5UHrnu/UKsWJac=;
        b=RyJp/X6BpAqL/e/jvgXiwsSFMv31ZMrQY5LiA/0Ie/+4lt754QJ9pGnTCji0xBm6hk
         iABAah7OEugVkehECWJCimxLI8WYNlZ+sfhI6vZddDMCaPA6QEYhkjVIwo7hWojpl0xR
         mf9yAf/sttNdVV7wrv1u8WbLJAEQuYevqIlxq2846aa+feeNU297w410Gib53FDkb7+I
         HcRKhKk5MRAQ6koHOGLaZUSEAzLr+C5aCxwLMqBh0E/muNNd0c+jA0akMH2IRfoodk8g
         vjk/YGUzwDQgPPeADqs7sRBHcE7QlFOqRxc59eCFV7KQRWjqvxfr+GxlLrznp/96P+w3
         2dig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782747027; x=1783351827;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zbaI5Q/eJ17Mm9qyxMZzWRHjz2c8M5UHrnu/UKsWJac=;
        b=NPkLdfUzk53FKVG2RrY/Wmeiexe+ZR5XUSM5wzqakaA+PGGTsIOk1FfouMb5yyPuyn
         YrKFxD6PufXQHogHgYJd2nle1ysYeFXVZwOVCrPw+Jn3X1HL5isrolmzrGr9jpl5C0rO
         7WNFpVhIVODAVfIaIz6iRg79Q3AbvSzcasbLu2O1MGjTnnJGUoKPBdBOw1K3/ikRyxyW
         VmRRwsw/2WqreDE6hpQlrzT4x3f06Tqm5PJYtb2UNbsVSLg4HdX1sI+ink06R799/Vq/
         ltSL1aytjFUCx2/oQhs/0Ysgx8PZfnHs/zW7FrXF2AQs5C/+yJ3Obd6MxwSIvOKbN3Zp
         UxTw==
X-Forwarded-Encrypted: i=1; AFNElJ9buo+QKguIOV7Z+sAsF8IgVSOfkrstR+K1LnuWG8YTcJun3Wf3Z5F6juINitnSxaIjgVi3UsE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxAoghH1x07TjxEKKLVYi9CYIKV5I9/rYCNAWUV7jn45Boybzkn
	SxZ8P7PiT2jIhHELGyI0Q8/GMdzS+IODisBUC4zl18v9tosqJD7W9U07
X-Gm-Gg: AfdE7ckXZvU+M8IyG1pH3XluSa1koaYqMC+OZcr1iTtYJqD8w3vwUkEY7XhVfAgeOqc
	0+DWtCs8VfIAChQrY828JwJsUrtMsL1jkGHWlT4+pMCqDam+0a2X2rpptjWpx4UK3uhoMK8QIkI
	3mkcuA4JRysRWu0biR2Ca2XVb5OzjRCP2Hfs67NlaqJPH0N7x+XY1y+PGVp8kRR71Nbvu4L1hIv
	4qwHkP6LqBFNeKYUCWk3bs4CiW5693xbzW1MEiCvJ9ayaEWbsPx66Kuyf0nedVtNTpYn5+yGPbK
	weg2wi1nxj4xdwzDW2T3OQTYtY+tIqmtCgBYsIsHt2eoG3XlUQ+HaDQiiMavWn2pQi0FphxazJm
	GKm5JdKevUoLliW7XTetqtQdLHLuMVhucV8Ix9Eh6sU+7QeuyjplecbZPl0dT/nnqeXfshk7K1v
	uhqC6wz2Y1tPNVURmVfAeNNrpv0w==
X-Received: by 2002:a05:600c:1912:b0:490:e281:287d with SMTP id 5b1f17b1804b1-493b827f8f7mr2867575e9.1.1782747025567;
        Mon, 29 Jun 2026 08:30:25 -0700 (PDT)
Received: from Dev-Null-MSI ([2a0d:3344:52ac:a808:98a4:4381:be45:536f])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-473563c2df7sm12414085f8f.24.2026.06.29.08.30.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jun 2026 08:30:24 -0700 (PDT)
From: Yousef Alhouseen <alhouseenyousef@gmail.com>
To: Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>
Cc: linux-input@vger.kernel.org,
	linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	syzbot+563191a4939ddbfe73d4@syzkaller.appspotmail.com,
	Yousef Alhouseen <alhouseenyousef@gmail.com>
Subject: [PATCH v2] HID: hiddev: keep state alive through disconnect unlock
Date: Mon, 29 Jun 2026 17:29:47 +0200
Message-ID: <20260629152947.13821-1-alhouseenyousef@gmail.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

mutex_unlock() clears the mutex owner before taking its wait lock. A
thread spinning in the final hiddev file release can acquire
existancelock after hiddev_disconnect() clears the owner, then free
hiddev before the disconnecting thread reaches the mutex wait lock. This
causes a use-after-free in the mutex slow unlock path.

Give the connection and each open file an explicit reference. Drop each
reference only after its existancelock critical section has completed,
so neither unlock path can free the mutex while the other is still using
it.

Fixes: 079034073faf ("HID: hiddev cleanup -- handle all error conditions properly")
Reported-by: syzbot+563191a4939ddbfe73d4@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=563191a4939ddbfe73d4
Cc: stable@vger.kernel.org
Signed-off-by: Yousef Alhouseen <alhouseenyousef@gmail.com>
---
Changes in v2:
- Explain the mutex owner-clear/spinning-contender race in the commit log.
- No code changes.

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
