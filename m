Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A4D051C331
	for <stable@vger.kernel.org>; Fri,  4 Sep 2026 18:49:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788547795; cv=none; b=LAe5OHLhF0V/QmpLAKIcvhgiyRoMxjlnPv6nwuCrzIjRwwaaRwDrXDq0/U4XXUtbcYfVrwExXjskBK95ZKnZs6q+jYlwG3vWaOaOrUPG0uVNe1OZMBa4xgM55bCFyZtzBn2SzHNKgjK/kKs9TWGUOgFDzEtfz0Uh419V2QRN7Ws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788547795; c=relaxed/simple;
	bh=EBNg/Gg0MmpJ0ZsWFicZ7v8yzWxApFVcWDKHIrGbFsU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JweHxU+5+sUJrJUpbzuZQDTJgwYs2qyYpeByfVKR9kGflKEgpCgSN/xcmLhucv0C3yNp8E5trcU3Au7+ysFn948JrenEsUXOcUh/7ZsPYU5i0RT9raptZEkyLBZZPyjvcE7sBAcXGEAsP7byCZTsjkk6j+DKdmq3/hyJ1n929Rw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=W9bYvEVm; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="W9bYvEVm"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 16D0B1F00A3D;
	Fri,  4 Sep 2026 18:49:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788547792;
	bh=zfZBSXb90vl+AkWB64pA4J3YN0CD3lEkIsj5oLMjkYs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=W9bYvEVmEL9JBniKXGW9hKc/HC2/xbUyOh2NfhObb4q3QO1/VAhuYy8eNGIy/IeRN
	 Zozsuiz/303AhtR+l9tn0CChRer8uztcoV2/qM8ohfNoGkcF+O67dz+w8YDJU90TOE
	 ydo1fWBHLEnc5+30QBClxZbfezOx5CMzBSlAJ3rm5IDH74wHw7CqPg4/loAiHfI0MS
	 pOlK2uQO1CB6J06IGIPreDMwmAZqhOOLyYj65I4Fc5pH+s+vHtT9eWGShhvPiMjdt7
	 +ITMEHPveCDjas4UbB4Car4w7CXcPdtgzxN0S3tJxyBAFhvpxyOUTDSqQPyiFK+f3o
	 /+oSvaqd5W/8g==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Jens Axboe <axboe@kernel.dk>,
	Minchan Kim <minchan@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 7.2.y 1/2] zram: move lockmap to be per-zram instead per table
Date: Fri,  4 Sep 2026 14:49:49 -0400
Message-ID: <20260904184950.1353771-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026090337-onshore-thermos-9127@gregkh>
References: <2026090337-onshore-thermos-9127@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>

[ Upstream commit dbb7ba9c7fa81a48ed2a108ad684cf3655f3ae4b ]

Patch series "zram: lockmap tweaks".

This patch (of 2):

The zram object contains an array zram_table_entry.  Each one has a `lock'
variable and each has a matching struct lockdep_map.  This mimics a struct
mutex.

It uses always the same key for all lockdep_map instances.  This makes it
look like the same lock to lockdep.  Therefore it could be reduced to have
one lockdep_map per struct zram.

Use only one struct lockdep_map per struct zram.

Link: https://lore.kernel.org/20260714141300.3945672-1-bigeasy@linutronix.de
Link: https://lore.kernel.org/20260714141300.3945672-2-bigeasy@linutronix.de
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Reviewed-by: Sergey Senozhatsky <senozhatsky@chromium.org>
Tested-by: Sergey Senozhatsky <senozhatsky@chromium.org>
Cc: Jens Axboe <axboe@kernel.dk>
Cc: Minchan Kim <minchan@kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Stable-dep-of: a8b5875741d4 ("zram: fix slot lock bit position on big-endian 64-bit")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/block/zram/zram_drv.c | 21 +++++++++------------
 drivers/block/zram/zram_drv.h |  2 +-
 2 files changed, 10 insertions(+), 13 deletions(-)

diff --git a/drivers/block/zram/zram_drv.c b/drivers/block/zram/zram_drv.c
index ace65c586072b..4223002d80b41 100644
--- a/drivers/block/zram/zram_drv.c
+++ b/drivers/block/zram/zram_drv.c
@@ -57,14 +57,12 @@ static size_t huge_class_size;
 static const struct block_device_operations zram_devops;
 
 static void slot_free(struct zram *zram, u32 index);
-#define slot_dep_map(zram, index) (&(zram)->table[(index)].dep_map)
 
-static void slot_lock_init(struct zram *zram, u32 index)
+static void slot_lock_init(struct zram *zram)
 {
 	static struct lock_class_key __key;
 
-	lockdep_init_map(slot_dep_map(zram, index), "zram->table[index].lock",
-			 &__key, 0);
+	lockdep_init_map(&zram->table_lock_map, "zram->table[index].lock", &__key, 0);
 }
 
 /*
@@ -84,8 +82,8 @@ static __must_check bool slot_trylock(struct zram *zram, u32 index)
 	unsigned long *lock = &zram->table[index].__lock;
 
 	if (!test_and_set_bit_lock(ZRAM_ENTRY_LOCK, lock)) {
-		mutex_acquire(slot_dep_map(zram, index), 0, 1, _RET_IP_);
-		lock_acquired(slot_dep_map(zram, index), _RET_IP_);
+		mutex_acquire(&zram->table_lock_map, 0, 1, _RET_IP_);
+		lock_acquired(&zram->table_lock_map, _RET_IP_);
 		return true;
 	}
 
@@ -96,16 +94,16 @@ static void slot_lock(struct zram *zram, u32 index)
 {
 	unsigned long *lock = &zram->table[index].__lock;
 
-	mutex_acquire(slot_dep_map(zram, index), 0, 0, _RET_IP_);
+	mutex_acquire(&zram->table_lock_map, 0, 0, _RET_IP_);
 	wait_on_bit_lock(lock, ZRAM_ENTRY_LOCK, TASK_UNINTERRUPTIBLE);
-	lock_acquired(slot_dep_map(zram, index), _RET_IP_);
+	lock_acquired(&zram->table_lock_map, _RET_IP_);
 }
 
 static void slot_unlock(struct zram *zram, u32 index)
 {
 	unsigned long *lock = &zram->table[index].__lock;
 
-	mutex_release(slot_dep_map(zram, index), _RET_IP_);
+	mutex_release(&zram->table_lock_map, _RET_IP_);
 	clear_and_wake_up_bit(ZRAM_ENTRY_LOCK, lock);
 }
 
@@ -1984,7 +1982,7 @@ static void zram_meta_free(struct zram *zram, u64 disksize)
 
 static bool zram_meta_alloc(struct zram *zram, u64 disksize)
 {
-	size_t num_pages, index;
+	size_t num_pages;
 
 	num_pages = disksize >> PAGE_SHIFT;
 	zram->table = vzalloc(array_size(num_pages, sizeof(*zram->table)));
@@ -2001,8 +1999,7 @@ static bool zram_meta_alloc(struct zram *zram, u64 disksize)
 	if (!huge_class_size)
 		huge_class_size = zs_huge_class_size(zram->mem_pool);
 
-	for (index = 0; index < num_pages; index++)
-		slot_lock_init(zram, index);
+	slot_lock_init(zram);
 
 	return true;
 }
diff --git a/drivers/block/zram/zram_drv.h b/drivers/block/zram/zram_drv.h
index 08d1774c15db6..8290dc6e23352 100644
--- a/drivers/block/zram/zram_drv.h
+++ b/drivers/block/zram/zram_drv.h
@@ -74,7 +74,6 @@ struct zram_table_entry {
 #endif
 		} attr;
 	};
-	struct lockdep_map dep_map;
 };
 
 struct zram_stats {
@@ -107,6 +106,7 @@ struct zram_stats {
 
 struct zram {
 	struct zram_table_entry *table;
+	struct lockdep_map table_lock_map;
 	struct zs_pool *mem_pool;
 	struct zcomp *comps[ZRAM_MAX_COMPS];
 	struct zcomp_params params[ZRAM_MAX_COMPS];
-- 
2.53.0

