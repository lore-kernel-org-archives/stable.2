Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B992C3BD653
	for <stable@vger.kernel.org>; Fri,  4 Sep 2026 18:35:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788546927; cv=none; b=jfJHoDNAfaVyzbWGgnt0afZIkXZQNxY8V4wBBTV5G+pzCixt7X0G7BO+VOwRSF8sRf6bl6Ghi6qDRb5HGAL8MPnRC++NPeLSMMwrHcue4rYSWiubFBgbMpoGrP65csj8+FoAMHlUyC0NHVdERgxgz78tD5Y76XIOwQkSj1AWO/w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788546927; c=relaxed/simple;
	bh=xbR7kBGJRT0+0S7tU6WK1GoJbN/aAYjqhUdsP5akMDA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=E0dzApmIC4+u+uDyo+zRNgck8E7ea4q079UXIfyBWMUh5LlcENFewvWmzwqK8loDejnAkeSycjeVnd0tWqY0FG2buKeI0IFZsBLJMu2P5vCRF6JovOJ42WowIiMwRBJpcqBPRuPFMgrb27n5zZri36hVoSpQsKNYQOtmFPIDRuo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VUUVzJUn; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VUUVzJUn"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 04F681F00AC4;
	Fri,  4 Sep 2026 18:35:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788546918;
	bh=n6TiBXcmwG8xwHsx1ZydMqn7ebVXsbd+QznOPNVdn5E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=VUUVzJUnx1B+qKessP8VdvxQ6DYtInJ7UABGIc08xKg7Cr0ZJkwnamu4q/HxQCg0/
	 wjmIkrra7HTlYF7wK2FkLqgYhYjXHoLHoiS4u48vvut1bqY7CFfBJgNE4Q8SiTrjSk
	 GaxDI55xXvSy/sp1s+mC/hDHgvMFGB8EHUDADFrYxYqUtqEQCwq7IBox7ccvmB1uCN
	 gzGZ59fsWstV2xRpxcl8Ihw5TX+M5r9PxVkyncurYWMAyHphd8ABsXOX9q5xcJILtO
	 4m3yN724NatOL88S70/UFX48kx5RNBfFpDz23U2yrXhmPO3WpPXSLYFVzImpQO3EsG
	 Uyc0tcPh+X3bg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>,
	Minchan Kim <minchan@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y 1/3] zram: remove entry element member
Date: Fri,  4 Sep 2026 14:35:14 -0400
Message-ID: <20260904183516.1323937-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026090305-desolate-sports-060e@gregkh>
References: <2026090305-desolate-sports-060e@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Sergey Senozhatsky <senozhatsky@chromium.org>

[ Upstream commit b4444a849f1827c04df81a6f1ef26ddb6f072a94 ]

Element is in the same anon union as handle and hence holds the same
value, which makes code below sort of confusing

    handle = zram_get_handle()
    if (!handle)
	element = zram_get_element()

Element doesn't really simplify the code, let's just remove it.  We
already re-purpose handle to store the block id a written back page.

Link: https://lkml.kernel.org/r/20241218063513.297475-3-senozhatsky@chromium.org
Signed-off-by: Sergey Senozhatsky <senozhatsky@chromium.org>
Cc: Minchan Kim <minchan@kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Stable-dep-of: 894913e2d35c ("zram: fix out-of-bounds access in writeback_store()")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/block/zram/zram_drv.c | 23 +++++------------------
 drivers/block/zram/zram_drv.h |  5 +----
 2 files changed, 6 insertions(+), 22 deletions(-)

diff --git a/drivers/block/zram/zram_drv.c b/drivers/block/zram/zram_drv.c
index cf3c789945b41..afd1eb7a8fffb 100644
--- a/drivers/block/zram/zram_drv.c
+++ b/drivers/block/zram/zram_drv.c
@@ -112,17 +112,6 @@ static void zram_clear_flag(struct zram *zram, u32 index,
 	zram->table[index].flags &= ~BIT(flag);
 }
 
-static inline void zram_set_element(struct zram *zram, u32 index,
-			unsigned long element)
-{
-	zram->table[index].element = element;
-}
-
-static unsigned long zram_get_element(struct zram *zram, u32 index)
-{
-	return zram->table[index].element;
-}
-
 static size_t zram_get_obj_size(struct zram *zram, u32 index)
 {
 	return zram->table[index].flags & (BIT(ZRAM_FLAG_SHIFT) - 1);
@@ -762,7 +751,7 @@ static ssize_t writeback_store(struct device *dev,
 		zram_free_page(zram, index);
 		zram_clear_flag(zram, index, ZRAM_UNDER_WB);
 		zram_set_flag(zram, index, ZRAM_WB);
-		zram_set_element(zram, index, blk_idx);
+		zram_set_handle(zram, index, blk_idx);
 		blk_idx = 0;
 		atomic64_inc(&zram->stats.pages_stored);
 		spin_lock(&zram->wb_limit_lock);
@@ -1388,7 +1377,7 @@ static void zram_free_page(struct zram *zram, size_t index)
 
 	if (zram_test_flag(zram, index, ZRAM_WB)) {
 		zram_clear_flag(zram, index, ZRAM_WB);
-		free_block_bdev(zram, zram_get_element(zram, index));
+		free_block_bdev(zram, zram_get_handle(zram, index));
 		goto out;
 	}
 
@@ -1434,12 +1423,10 @@ static int zram_read_from_zspool(struct zram *zram, struct page *page,
 
 	handle = zram_get_handle(zram, index);
 	if (!handle || zram_test_flag(zram, index, ZRAM_SAME)) {
-		unsigned long value;
 		void *mem;
 
-		value = handle ? zram_get_element(zram, index) : 0;
 		mem = kmap_local_page(page);
-		zram_fill_page(mem, PAGE_SIZE, value);
+		zram_fill_page(mem, PAGE_SIZE, handle);
 		kunmap_local(mem);
 		return 0;
 	}
@@ -1485,7 +1472,7 @@ static int zram_read_page(struct zram *zram, struct page *page, u32 index,
 		 */
 		zram_slot_unlock(zram, index);
 
-		ret = read_from_bdev(zram, page, zram_get_element(zram, index),
+		ret = read_from_bdev(zram, page, zram_get_handle(zram, index),
 				     parent);
 	}
 
@@ -1637,7 +1624,7 @@ static int zram_write_page(struct zram *zram, struct page *page, u32 index)
 
 	if (flags) {
 		zram_set_flag(zram, index, flags);
-		zram_set_element(zram, index, element);
+		zram_set_handle(zram, index, element);
 	}  else {
 		zram_set_handle(zram, index, handle);
 		zram_set_obj_size(zram, index, comp_len);
diff --git a/drivers/block/zram/zram_drv.h b/drivers/block/zram/zram_drv.h
index 8acf9d2ee42b8..6ff5606c159cd 100644
--- a/drivers/block/zram/zram_drv.h
+++ b/drivers/block/zram/zram_drv.h
@@ -62,10 +62,7 @@ enum zram_pageflags {
 
 /* Allocated for each disk page */
 struct zram_table_entry {
-	union {
-		unsigned long handle;
-		unsigned long element;
-	};
+	unsigned long handle;
 	unsigned int flags;
 	spinlock_t lock;
 #ifdef CONFIG_ZRAM_TRACK_ENTRY_ACTIME
-- 
2.53.0

