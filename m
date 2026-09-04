Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BCC751E442
	for <stable@vger.kernel.org>; Fri,  4 Sep 2026 18:49:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788547795; cv=none; b=sOuJqqLXjK15yeqo6b3HkVJHktRUGp3V4CiQXV80IDoPr723tfxAkJBo8eM89TAALJM9nhdfOIz4QL30EdAwN+0YFsC9NaR/XLO1R3w6PM4Dn6uG6gP1vNcDAA5LVsLhHqGUsGzcGTXaRmmSSnK/pVpEDOXuE/FOXiNQOI9OkAs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788547795; c=relaxed/simple;
	bh=KgQ8nb3vLEkL1Gfuycv0bVUSl9ST/BiFKONeO6NeB9Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fnUV3DfpHI1USfr9ihJb0j76hOaxPYNXa//JOwYUBjx2RpwnmwtPp+tYKnK7TL6+oUpR0oy5wP3PkwrNt8FYDIN+Wp1gD2U5iCa8r7bTA8yi5il9JwVB4hvVbbE1CJtGUc7b6uWlouLmvXUUi6BweKmC5f8ZiMKLS0U2bKPgUSo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=c1whiz60; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="c1whiz60"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 287111F00A3F;
	Fri,  4 Sep 2026 18:49:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788547793;
	bh=H1gkgqGXWvC1T41xs7znk4p+F+OjQwlb4WPygZhhrwI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=c1whiz60g5OCi45Ax6vN+DJd6f65j+EvnOYtOon5hXDBSuyzFMEb/9OTAU40VJdRF
	 TleC1ghOC8t7mRqMxRvHcVJUjh8vSI2NFjV8ZjsGu7HNGPb+s1FteCmghAdVOmW0+M
	 HM6KFOp5x6Xu7XdS31SZ+K5g/Oxe+muKfqfl0AoTo2Ix2F4KmlxZmuc0EBtDGiqyvv
	 R5RwKcscjGOx3o26oq6XOvpPSqkcUj79BS8prcHZuH0mCqmlV424RA1GoG5aGvPet3
	 U1/3Bx20EhKLVPvuLxI84QRIuCzB4AM1hXiQhh1p+vYhcXXdRscmGLmLR6o9xPL/Ry
	 N+ybXGFz5jYSg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: David Carlier <devnexen@gmail.com>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Minchan Kim <minchan@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 7.2.y 2/2] zram: fix slot lock bit position on big-endian 64-bit
Date: Fri,  4 Sep 2026 14:49:50 -0400
Message-ID: <20260904184950.1353771-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260904184950.1353771-1-sashal@kernel.org>
References: <2026090337-onshore-thermos-9127@gregkh>
 <20260904184950.1353771-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: David Carlier <devnexen@gmail.com>

[ Upstream commit a8b5875741d416703e19ad8eeac6fce8a12bd6e4 ]

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
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/block/zram/zram_drv.c |  6 +++---
 drivers/block/zram/zram_drv.h | 14 ++++++++++++++
 2 files changed, 17 insertions(+), 3 deletions(-)

diff --git a/drivers/block/zram/zram_drv.c b/drivers/block/zram/zram_drv.c
index 4223002d80b41..be8308c26fb06 100644
--- a/drivers/block/zram/zram_drv.c
+++ b/drivers/block/zram/zram_drv.c
@@ -81,7 +81,7 @@ static __must_check bool slot_trylock(struct zram *zram, u32 index)
 {
 	unsigned long *lock = &zram->table[index].__lock;
 
-	if (!test_and_set_bit_lock(ZRAM_ENTRY_LOCK, lock)) {
+	if (!test_and_set_bit_lock(ZRAM_ENTRY_LOCK_BIT, lock)) {
 		mutex_acquire(&zram->table_lock_map, 0, 1, _RET_IP_);
 		lock_acquired(&zram->table_lock_map, _RET_IP_);
 		return true;
@@ -95,7 +95,7 @@ static void slot_lock(struct zram *zram, u32 index)
 	unsigned long *lock = &zram->table[index].__lock;
 
 	mutex_acquire(&zram->table_lock_map, 0, 0, _RET_IP_);
-	wait_on_bit_lock(lock, ZRAM_ENTRY_LOCK, TASK_UNINTERRUPTIBLE);
+	wait_on_bit_lock(lock, ZRAM_ENTRY_LOCK_BIT, TASK_UNINTERRUPTIBLE);
 	lock_acquired(&zram->table_lock_map, _RET_IP_);
 }
 
@@ -104,7 +104,7 @@ static void slot_unlock(struct zram *zram, u32 index)
 	unsigned long *lock = &zram->table[index].__lock;
 
 	mutex_release(&zram->table_lock_map, _RET_IP_);
-	clear_and_wake_up_bit(ZRAM_ENTRY_LOCK, lock);
+	clear_and_wake_up_bit(ZRAM_ENTRY_LOCK_BIT, lock);
 }
 
 static inline bool init_done(struct zram *zram)
diff --git a/drivers/block/zram/zram_drv.h b/drivers/block/zram/zram_drv.h
index 8290dc6e23352..996bb99ea8bbf 100644
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
-- 
2.53.0

