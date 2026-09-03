Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DECB4AA1EE
	for <stable@vger.kernel.org>; Thu,  3 Sep 2026 13:06:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788440822; cv=none; b=biTlHY2a1/kEa7mukleFFKOyL1s8e3C02i9GhYXUZzmg3E6iF0igtLQdJb/Jhdwp2uIChq936gXyLbO9wp5nEdqK2qwvn/Ev2/BrZkbxFUTHMPExZZFkDIIBpXdAr7+2dC+2E823ULgna+acH5FQ9EWD8kpQA89TcaIOSt0qfng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788440822; c=relaxed/simple;
	bh=LPyhXOjCtDbRNZOOkhSU0QLSGWnrETyUOKKMMkjwcI4=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=l55QavKbfXsppU6bE0X0cvgYZk97Ns+uQPpdMwvBAocjWoEn1kqXy8AaUblGGe8hbzOMm7hSSBJfZrGjAW0FsCu4RylJiwnMUJYqu9QyJbAhj+pFe/D/HFlIYlJSnxs5rHl6oQA+yazAzWHxjCbNa6O+PiiTMADQdI8cDFBPbZ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=zDmlI18h; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="zDmlI18h"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 920EE1F00A3F;
	Thu,  3 Sep 2026 13:06:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1788440816;
	bh=1xpMO83OlC8YOzX6Ngpfq4XOOE+Wzhqa65GaU+m4tio=;
	h=Subject:To:Cc:From:Date;
	b=zDmlI18hNh8Lg6wAgPi0oPQdVfUFScMdg7ph1hgYp/uQFHzAhTr1N8U2Lo43g5jbe
	 jwLYPEbxzv8qjEBx0edWSxc4Kjn3Hnal0OvRhx4LT/8WuDuivWYIoqd8zxSJAusXDr
	 WG7elVCBHD+OSMYaIhndYIL1c5rmV4xkYbWB4/N0=
Subject: FAILED: patch "[PATCH] zram: fix slot lock bit position on big-endian 64-bit" failed to apply to 7.2-stable tree
To: devnexen@gmail.com,akpm@linux-foundation.org,minchan@kernel.org,senozhatsky@chromium.org,stable@vger.kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Thu, 03 Sep 2026 15:01:37 +0200
Message-ID: <2026090337-onshore-thermos-9127@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 7.2-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-7.2.y
git checkout FETCH_HEAD
git cherry-pick -x a8b5875741d416703e19ad8eeac6fce8a12bd6e4
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026090337-onshore-thermos-9127@gregkh' --subject-prefix 'PATCH 7.2.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From a8b5875741d416703e19ad8eeac6fce8a12bd6e4 Mon Sep 17 00:00:00 2001
From: David Carlier <devnexen@gmail.com>
Date: Mon, 10 Aug 2026 21:22:37 +0100
Subject: [PATCH] zram: fix slot lock bit position on big-endian 64-bit

The slot lock is a bit operation on the whole __lock word, which flags and
ac_time alias as two u32s.  On little-endian the lock bit lands in the
position ZRAM_ENTRY_LOCK reserves in flags, so the aliasing works out.  On
64-bit big-endian it lands in ac_time instead: with
ZRAM_TRACK_ENTRY_ACTIME enabled, storing the access time from
mark_slot_accessed() or slot_free() wipes out the held lock bit, letting
another CPU take the same slot lock; an access time value with that bit
set makes the slot look locked forever.

Shift the lock bit into the flags half of the word on big-endian 64-bit.

Link: https://lore.kernel.org/20260810202241.2436603-1-devnexen@gmail.com
Fixes: 2e8ff2f51dde ("zram: use u32 for entry ac_time tracking")
Signed-off-by: David Carlier <devnexen@gmail.com>
Reviewed-by: Sergey Senozhatsky <senozhatsky@chromium.org>
Cc: Minchan Kim <minchan@kernel.org>
Cc: <stable@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>

diff --git a/drivers/block/zram/zram_drv.c b/drivers/block/zram/zram_drv.c
index d09fdca49cbd..a9b3bb1d3bef 100644
--- a/drivers/block/zram/zram_drv.c
+++ b/drivers/block/zram/zram_drv.c
@@ -74,7 +74,7 @@ static __must_check bool slot_trylock(struct zram *zram, unsigned long index)
 {
 	unsigned long *lock = &zram->table[index].__lock;
 
-	if (!test_and_set_bit_lock(ZRAM_ENTRY_LOCK, lock)) {
+	if (!test_and_set_bit_lock(ZRAM_ENTRY_LOCK_BIT, lock)) {
 		mutex_acquire(&zram->table_lock_map, 0, 1, _RET_IP_);
 		lock_acquired(&zram->table_lock_map, _RET_IP_);
 		return true;
@@ -88,7 +88,7 @@ static void slot_lock(struct zram *zram, unsigned long index)
 	unsigned long *lock = &zram->table[index].__lock;
 
 	mutex_acquire(&zram->table_lock_map, 0, 0, _RET_IP_);
-	wait_on_bit_lock(lock, ZRAM_ENTRY_LOCK, TASK_UNINTERRUPTIBLE);
+	wait_on_bit_lock(lock, ZRAM_ENTRY_LOCK_BIT, TASK_UNINTERRUPTIBLE);
 	lock_acquired(&zram->table_lock_map, _RET_IP_);
 }
 
@@ -97,7 +97,7 @@ static void slot_unlock(struct zram *zram, unsigned long index)
 	unsigned long *lock = &zram->table[index].__lock;
 
 	mutex_release(&zram->table_lock_map, _RET_IP_);
-	clear_and_wake_up_bit(ZRAM_ENTRY_LOCK, lock);
+	clear_and_wake_up_bit(ZRAM_ENTRY_LOCK_BIT, lock);
 }
 
 static inline bool init_done(struct zram *zram)
diff --git a/drivers/block/zram/zram_drv.h b/drivers/block/zram/zram_drv.h
index 4fddc582f3b8..7a55d751417e 100644
--- a/drivers/block/zram/zram_drv.h
+++ b/drivers/block/zram/zram_drv.h
@@ -15,6 +15,7 @@
 #ifndef _ZRAM_DRV_H_
 #define _ZRAM_DRV_H_
 
+#include <asm/byteorder.h>
 #include <linux/rwsem.h>
 #include <linux/zsmalloc.h>
 
@@ -57,6 +58,19 @@ enum zram_pageflags {
 	__NR_ZRAM_PAGEFLAGS,
 };
 
+/*
+ * The slot lock is a bit-wait lock on the whole __lock word, while
+ * flags and ac_time alias that word as two u32s.  The lock bit must
+ * land in the slot that ZRAM_ENTRY_LOCK reserves in attr.flags; on
+ * 64-bit big-endian the flags word maps to the upper half of __lock,
+ * so the bit position has to be shifted up.
+ */
+#if defined(CONFIG_64BIT) && defined(__BIG_ENDIAN)
+#define ZRAM_ENTRY_LOCK_BIT  (ZRAM_ENTRY_LOCK + 32)
+#else
+#define ZRAM_ENTRY_LOCK_BIT  ZRAM_ENTRY_LOCK
+#endif
+
 /*
  * Allocated for each disk page.  We use bit-lock (ZRAM_ENTRY_LOCK bit
  * of flags) to save memory.  There can be plenty of entries and standard

