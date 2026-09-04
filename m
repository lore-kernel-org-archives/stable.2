Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D5214EA394
	for <stable@vger.kernel.org>; Fri,  4 Sep 2026 20:32:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788553932; cv=none; b=UxDAPfZfd3RxuwzNx29W3vXWRzixcsW+/RQO7DaK3ML8lIlCfB4f0HGDrc0oIcXQ7EyG3qQF2WwUMXben3ySMuOkyf2+2w1dxK1AktVbdoxgt9eC5DPhsPKLi+iLrNUh3waC03E/AA+KToyjYvaasCQfcL62ZIyPDpa/cFySFKM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788553932; c=relaxed/simple;
	bh=DzQsuW8MfS+GkYuj0xuBh+J/kyNdtgsxJLUaRQbJlW8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WbpBszntd5qgstuJGmib3X6VaLXoOeyAt5m4lrsU9+CzDM4VrjS/+tsZDvRtkT9PkCjGjEq3uCtkKjIHamvha/dTixhz6jikvrMhtba0eCw74yZHGpDSbVvnf/FiOJYW5F/+YrD2+5kHm3J4aFL4bnip9qtDMLP4DESEToLTRcY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=itgPqsJl; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="itgPqsJl"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 430F01F00AC4;
	Fri,  4 Sep 2026 20:32:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788553925;
	bh=xxHg4RdsOct2KGaqTZxn2TimW/QZNmuehTG9QVpeOsE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=itgPqsJlz25TdMjr+Lzbu71q7WwwJGXIWA+pPRZHe5A5CGXHesvAnwAZzxtgK4lb2
	 gES5sUMX2HOZEdzUPmz7/u8O/9N3xEqEGjUw1wxTfRRb1rpUwswiPQGqRpxSVAyDux
	 CHBNmTdhGSh+wZiaRjDRL/t7CQ0H6sVqOgLe1vG3yiaA7sIhCakY/IVM4udsjhtm6h
	 AiFrhQ1aQUYexmQwOrSHvwtanap4y5JrD2kFlLpNtEN01yopsNfsLsjx7dlW3H8j1J
	 eN9oyW9u+YfUFVPFEojR2jYUm0w0avggsYxxetuCIsOWCt2P3aNJ2kjmMb2kKN2Oua
	 E910n/Z8vuu1Q==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>,
	Minchan Kim <minchan@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y 1/4] zram: use zram_read_from_zspool() in writeback
Date: Fri,  4 Sep 2026 16:32:00 -0400
Message-ID: <20260904203203.1546745-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026090305-dimly-backboned-037d@gregkh>
References: <2026090305-dimly-backboned-037d@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Sergey Senozhatsky <senozhatsky@chromium.org>

[ Upstream commit b8d3ff7bb5111c6a88d5672469de445d9b46cf22 ]

We only can read pages from zspool in writeback, zram_read_page() is not
really right in that context not only because it's a more generic function
that handles ZRAM_WB pages, but also because it requires us to unlock slot
between slot flag check and actual page read.  Use zram_read_from_zspool()
instead and do slot flags check and page read under the same slot lock.

Link: https://lkml.kernel.org/r/20241218063513.297475-7-senozhatsky@chromium.org
Signed-off-by: Sergey Senozhatsky <senozhatsky@chromium.org>
Cc: Minchan Kim <minchan@kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Stable-dep-of: 894913e2d35c ("zram: fix out-of-bounds access in writeback_store()")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/block/zram/zram_drv.c | 136 ++++++++++++++++++----------------
 1 file changed, 71 insertions(+), 65 deletions(-)

diff --git a/drivers/block/zram/zram_drv.c b/drivers/block/zram/zram_drv.c
index 0c422e4179ad5..d547f2d251fd2 100644
--- a/drivers/block/zram/zram_drv.c
+++ b/drivers/block/zram/zram_drv.c
@@ -54,8 +54,8 @@ static size_t huge_class_size;
 static const struct block_device_operations zram_devops;
 
 static void zram_free_page(struct zram *zram, size_t index);
-static int zram_read_page(struct zram *zram, struct page *page, u32 index,
-			  struct bio *parent);
+static int zram_read_from_zspool(struct zram *zram, struct page *page,
+				 u32 index);
 
 static int zram_slot_trylock(struct zram *zram, u32 index)
 {
@@ -623,19 +623,42 @@ static void read_from_bdev_async(struct zram *zram, struct page *page,
 #define IDLE_WRITEBACK			(1<<1)
 #define INCOMPRESSIBLE_WRITEBACK	(1<<2)
 
+/* Map newer writeback setup context to the 6.6 page allocation. */
+#define zram_pp_ctl page
+#define pp_ctl page
+#define init_pp_ctl() alloc_page(GFP_KERNEL)
+
 static ssize_t writeback_store(struct device *dev,
-		struct device_attribute *attr, const char *buf, size_t len)
+			       struct device_attribute *attr,
+			       const char *buf, size_t len)
 {
 	struct zram *zram = dev_to_zram(dev);
-	unsigned long nr_pages = zram->disksize >> PAGE_SHIFT;
-	unsigned long index = 0;
+	u64 nr_pages = zram->disksize >> PAGE_SHIFT;
+	unsigned long lo = 0, hi = nr_pages;
+	struct zram_pp_ctl *pp_ctl = NULL;
+	ssize_t ret = len;
+	int err, mode = 0;
 	struct bio bio;
 	struct bio_vec bio_vec;
-	struct page *page;
-	ssize_t ret = len;
-	int mode, err;
 	unsigned long blk_idx = 0;
 
+	guard(rwsem_write)(&zram->init_lock);
+	if (!init_done(zram))
+		return -EINVAL;
+
+	if (!zram->backing_dev)
+		return -ENODEV;
+
+	nr_pages = zram->disksize >> PAGE_SHIFT;
+	hi = nr_pages;
+
+	pp_ctl = init_pp_ctl();
+	if (!pp_ctl)
+		return -ENOMEM;
+#undef init_pp_ctl
+#undef pp_ctl
+#undef zram_pp_ctl
+
 	if (sysfs_streq(buf, "idle"))
 		mode = IDLE_WRITEBACK;
 	else if (sysfs_streq(buf, "huge"))
@@ -645,35 +668,22 @@ static ssize_t writeback_store(struct device *dev,
 	else if (sysfs_streq(buf, "incompressible"))
 		mode = INCOMPRESSIBLE_WRITEBACK;
 	else {
-		if (strncmp(buf, PAGE_WB_SIG, sizeof(PAGE_WB_SIG) - 1))
-			return -EINVAL;
+		if (strncmp(buf, PAGE_WB_SIG, sizeof(PAGE_WB_SIG) - 1)) {
+			ret = -EINVAL;
+			goto release_init_lock;
+		}
 
-		if (kstrtol(buf + sizeof(PAGE_WB_SIG) - 1, 10, &index) ||
-				index >= nr_pages)
-			return -EINVAL;
+		if (kstrtoul(buf + sizeof(PAGE_WB_SIG) - 1, 10, &lo) ||
+		    lo >= nr_pages) {
+			ret = -EINVAL;
+			goto release_init_lock;
+		}
 
-		nr_pages = 1;
+		hi = lo + 1;
 		mode = PAGE_WRITEBACK;
 	}
 
-	down_read(&zram->init_lock);
-	if (!init_done(zram)) {
-		ret = -EINVAL;
-		goto release_init_lock;
-	}
-
-	if (!zram->backing_dev) {
-		ret = -ENODEV;
-		goto release_init_lock;
-	}
-
-	page = alloc_page(GFP_KERNEL);
-	if (!page) {
-		ret = -ENOMEM;
-		goto release_init_lock;
-	}
-
-	for (; nr_pages != 0; index++, nr_pages--) {
+	for (; lo < hi; lo++) {
 		spin_lock(&zram->wb_limit_lock);
 		if (zram->wb_limit_enable && !zram->bd_wb_limit) {
 			spin_unlock(&zram->wb_limit_lock);
@@ -690,40 +700,38 @@ static ssize_t writeback_store(struct device *dev,
 			}
 		}
 
-		zram_slot_lock(zram, index);
-		if (!zram_allocated(zram, index))
+		zram_slot_lock(zram, lo);
+		if (!zram_allocated(zram, lo))
 			goto next;
 
-		if (zram_test_flag(zram, index, ZRAM_WB) ||
-				zram_test_flag(zram, index, ZRAM_SAME) ||
-				zram_test_flag(zram, index, ZRAM_UNDER_WB))
+		if (zram_test_flag(zram, lo, ZRAM_WB) ||
+				zram_test_flag(zram, lo, ZRAM_SAME) ||
+				zram_test_flag(zram, lo, ZRAM_UNDER_WB))
 			goto next;
 
 		if (mode & IDLE_WRITEBACK &&
-		    !zram_test_flag(zram, index, ZRAM_IDLE))
+		    !zram_test_flag(zram, lo, ZRAM_IDLE))
 			goto next;
 		if (mode & HUGE_WRITEBACK &&
-		    !zram_test_flag(zram, index, ZRAM_HUGE))
+		    !zram_test_flag(zram, lo, ZRAM_HUGE))
 			goto next;
 		if (mode & INCOMPRESSIBLE_WRITEBACK &&
-		    !zram_test_flag(zram, index, ZRAM_INCOMPRESSIBLE))
+		    !zram_test_flag(zram, lo, ZRAM_INCOMPRESSIBLE))
 			goto next;
 
 		/*
 		 * Clearing ZRAM_UNDER_WB is duty of caller.
 		 * IOW, zram_free_page never clear it.
 		 */
-		zram_set_flag(zram, index, ZRAM_UNDER_WB);
+		zram_set_flag(zram, lo, ZRAM_UNDER_WB);
 		/* Need for hugepage writeback racing */
-		zram_set_flag(zram, index, ZRAM_IDLE);
-		zram_slot_unlock(zram, index);
-		if (zram_read_page(zram, page, index, NULL)) {
-			zram_slot_lock(zram, index);
-			zram_clear_flag(zram, index, ZRAM_UNDER_WB);
-			zram_clear_flag(zram, index, ZRAM_IDLE);
-			zram_slot_unlock(zram, index);
-			continue;
+		zram_set_flag(zram, lo, ZRAM_IDLE);
+		if (zram_read_from_zspool(zram, page, lo)) {
+			zram_clear_flag(zram, lo, ZRAM_UNDER_WB);
+			zram_clear_flag(zram, lo, ZRAM_IDLE);
+			goto next;
 		}
+		zram_slot_unlock(zram, lo);
 
 		bio_init(&bio, zram->bdev, &bio_vec, 1,
 			 REQ_OP_WRITE | REQ_SYNC);
@@ -736,10 +744,10 @@ static ssize_t writeback_store(struct device *dev,
 		 */
 		err = submit_bio_wait(&bio);
 		if (err) {
-			zram_slot_lock(zram, index);
-			zram_clear_flag(zram, index, ZRAM_UNDER_WB);
-			zram_clear_flag(zram, index, ZRAM_IDLE);
-			zram_slot_unlock(zram, index);
+			zram_slot_lock(zram, lo);
+			zram_clear_flag(zram, lo, ZRAM_UNDER_WB);
+			zram_clear_flag(zram, lo, ZRAM_IDLE);
+			zram_slot_unlock(zram, lo);
 			/*
 			 * BIO errors are not fatal, we continue and simply
 			 * attempt to writeback the remaining objects (pages).
@@ -762,18 +770,18 @@ static ssize_t writeback_store(struct device *dev,
 		 * mark ZRAM_IDLE once it found the slot was ZRAM_UNDER_WB.
 		 * Thus, we could close the race by checking ZRAM_IDLE bit.
 		 */
-		zram_slot_lock(zram, index);
-		if (!zram_allocated(zram, index) ||
-			  !zram_test_flag(zram, index, ZRAM_IDLE)) {
-			zram_clear_flag(zram, index, ZRAM_UNDER_WB);
-			zram_clear_flag(zram, index, ZRAM_IDLE);
+		zram_slot_lock(zram, lo);
+		if (!zram_allocated(zram, lo) ||
+			  !zram_test_flag(zram, lo, ZRAM_IDLE)) {
+			zram_clear_flag(zram, lo, ZRAM_UNDER_WB);
+			zram_clear_flag(zram, lo, ZRAM_IDLE);
 			goto next;
 		}
 
-		zram_free_page(zram, index);
-		zram_clear_flag(zram, index, ZRAM_UNDER_WB);
-		zram_set_flag(zram, index, ZRAM_WB);
-		zram_set_element(zram, index, blk_idx);
+		zram_free_page(zram, lo);
+		zram_clear_flag(zram, lo, ZRAM_UNDER_WB);
+		zram_set_flag(zram, lo, ZRAM_WB);
+		zram_set_element(zram, lo, blk_idx);
 		blk_idx = 0;
 		atomic64_inc(&zram->stats.pages_stored);
 		spin_lock(&zram->wb_limit_lock);
@@ -781,15 +789,13 @@ static ssize_t writeback_store(struct device *dev,
 			zram->bd_wb_limit -=  1UL << (PAGE_SHIFT - 12);
 		spin_unlock(&zram->wb_limit_lock);
 next:
-		zram_slot_unlock(zram, index);
+		zram_slot_unlock(zram, lo);
 	}
 
 	if (blk_idx)
 		free_block_bdev(zram, blk_idx);
 	__free_page(page);
 release_init_lock:
-	up_read(&zram->init_lock);
-
 	return ret;
 }
 
-- 
2.53.0

