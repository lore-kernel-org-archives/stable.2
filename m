Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 702BE2F3C3E
	for <stable@vger.kernel.org>; Thu, 10 Sep 2026 00:18:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788999495; cv=none; b=D8FyN3sCJHwSAphx6KRCmMjlelc+vjYg/dox1mGwouEEk7Dt07RgkZkzSN0eKIkIDSACGElFRnnv0hfAUOLZIoJED3C2EJhl3P4UEkbomPxyMlR5sT8sTLVutAGJ/+8SWkvhaJRuEod1yO0GsREZPYqDcDp4echh5PhvdmlnjjM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788999495; c=relaxed/simple;
	bh=Nzf95sBUydpC3cREfcSvgIP7eT5RZlaH2+Fv9K8GiVE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UgLX0Bi8u8h0Tau+3u+oL4+nrw8Z2BcMxpjwPAHRgHc4DHb+Yy/6gjbZdIpFEIYPKqveuUeXiG7UCLf546e3BtU4eLK8vVo3iHLZa5D1ed2gQU02b/LJNhd5ISO27dZF1FtlYry+ooeTp5ZL6v5aYbyr4mnv3lpwYlAW1u+v6x4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WpRLwhs8; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WpRLwhs8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7E2531F000FF;
	Thu, 10 Sep 2026 00:18:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788999494;
	bh=JrDfk29Jli2hPJnl7VtGDtnCqdl23UzPVpYnDBABdrE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=WpRLwhs8zP2Kmiy9BYJMXOovzfbXYHDJb2+Y99XMvAMdqdPsrc4BhCgX4OUtcKjiV
	 s23r22oLNg+ObKPOl5X/ujpM8DPCl/lIluOEqS0TJHY+IhVgowzfF9ytPMLV04vyaC
	 JtrLsxpKGHFXPbvhbiyAsxboo0IVqs+nEQXo5QYmbGX6FhBuDF7SBBqfQnDUiOQEvX
	 1WxlyugJWLNFddxIZoRt6YRrgujSvKCOKKHvxAAabFGf3g8tMdKmZ4cPXzI4+Ro+DZ
	 8AICyBi+sock2MRUNQLdG2QqtFisCoIRYRhHi9CGVACbnuvXimVSYV+WJW3h1+nyYA
	 EPpTWCIDyKchA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Bryam Vargas <hexlabsecurity@proton.me>,
	Mikulas Patocka <mpatocka@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18.y] dm-pcache: validate seg_id fields from persistent memory
Date: Wed,  9 Sep 2026 20:18:11 -0400
Message-ID: <20260910001811.3749965-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026090437-wok-unstable-1b2e@gregkh>
References: <2026090437-wok-unstable-1b2e@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Bryam Vargas <hexlabsecurity@proton.me>

[ Upstream commit 90c990a68460d7b5720e5634cf650eccdf0f4098 ]

cache_pos_decode(), cache_key_decode() and the last-kset branches of
cache_replay(), the writeback worker and the GC worker take a cache
segment id from the cache device metadata and index cache->segments[]
with it without checking it against cache->n_segs. That metadata is only
CRC-protected with a fixed public seed, so whoever supplies the cache
device on a table load (CAP_SYS_ADMIN) controls the id; an out-of-range
value forms a wild pcache_cache_segment pointer that is dereferenced and
written through -- an out-of-bounds read and write driven by on-disk data.

Add cache_seg_id_valid() and reject an out-of-range id at each decode
site, failing the operation with -EIO instead of indexing past the array.
Bound the id against the initialized-segment count (cache_info.n_segs)
rather than the physical device total. A forged cache_info.n_segs below
seg_num otherwise leaves segments[cache_info.n_segs..seg_num) as zeroed
structs whose data pointer is NULL, so a forged id in that window would
still be dereferenced. A later patch guarantees cache_info.n_segs <=
seg_num, and a driver-created cache sets the two equal, so valid images
are unaffected.

Fixes: 1d57628ff95b ("dm-pcache: add persistent cache target in device-mapper")
Cc: stable@vger.kernel.org
Signed-off-by: Bryam Vargas <hexlabsecurity@proton.me>
Signed-off-by: Mikulas Patocka <mpatocka@redhat.com>
[ adjusted cache_replay() context to preserve the existing hop-limit check before segment-ID validation ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/md/dm-pcache/cache.c           |  4 ++++
 drivers/md/dm-pcache/cache.h           | 15 +++++++++++++++
 drivers/md/dm-pcache/cache_gc.c        | 16 ++++++++++++++--
 drivers/md/dm-pcache/cache_key.c       | 11 +++++++++++
 drivers/md/dm-pcache/cache_writeback.c | 23 +++++++++++++++++++----
 5 files changed, 63 insertions(+), 6 deletions(-)

diff --git a/drivers/md/dm-pcache/cache.c b/drivers/md/dm-pcache/cache.c
index 887157fde68da..502acf2451779 100644
--- a/drivers/md/dm-pcache/cache.c
+++ b/drivers/md/dm-pcache/cache.c
@@ -118,6 +118,9 @@ int cache_pos_decode(struct pcache_cache *cache,
 	if (!latest_addr)
 		return -EIO;
 
+	if (!cache_seg_id_valid(cache, latest.cache_seg_id))
+		return -EIO;
+
 	pos->cache_seg = &cache->segments[latest.cache_seg_id];
 
 	if (latest.seg_off >= pos->cache_seg->segment.data_size)
@@ -158,6 +161,7 @@ static int cache_init(struct dm_pcache *pcache)
 	cache->cache_dev = &pcache->cache_dev;
 	cache->n_segs = cache_dev->seg_num;
 	atomic_set(&cache->gc_errors, 0);
+	atomic_set(&cache->writeback_errors, 0);
 	spin_lock_init(&cache->seg_map_lock);
 	spin_lock_init(&cache->key_head_lock);
 
diff --git a/drivers/md/dm-pcache/cache.h b/drivers/md/dm-pcache/cache.h
index afc112b79496a..d9e3e09f18e32 100644
--- a/drivers/md/dm-pcache/cache.h
+++ b/drivers/md/dm-pcache/cache.h
@@ -180,6 +180,7 @@ struct pcache_cache {
 		u32 advance;
 		int ret;
 	} writeback_ctx;
+	atomic_t		writeback_errors;
 
 	char gc_kset_onmedia_buf[PCACHE_KSET_ONMEDIA_SIZE_MAX];
 	struct delayed_work	gc_work;
@@ -420,6 +421,20 @@ static inline bool cache_seg_is_ctrl_seg(u32 cache_seg_id)
 	return (cache_seg_id == 0);
 }
 
+/**
+ * cache_seg_id_valid - Validate a cache segment id read from the cache device.
+ * @cache: Pointer to the pcache_cache structure.
+ * @cache_seg_id: Segment id decoded from on-media metadata.
+ *
+ * On-media segment ids are only protected by a CRC, which an attacker who can
+ * format the cache device computes over their chosen value. Reject any id that
+ * would index cache->segments[] out of bounds before it is dereferenced.
+ */
+static inline bool cache_seg_id_valid(struct pcache_cache *cache, u32 cache_seg_id)
+{
+	return cache_seg_id < cache->cache_info.n_segs;
+}
+
 /**
  * cache_key_cutfront - Cuts a specified length from the front of a cache key.
  * @key: Pointer to pcache_cache_key structure.
diff --git a/drivers/md/dm-pcache/cache_gc.c b/drivers/md/dm-pcache/cache_gc.c
index 3088cfef951bc..a167892be7cef 100644
--- a/drivers/md/dm-pcache/cache_gc.c
+++ b/drivers/md/dm-pcache/cache_gc.c
@@ -74,11 +74,17 @@ static bool need_gc(struct pcache_cache *cache, struct pcache_cache_pos *dirty_t
  * @cache: Pointer to the pcache_cache structure.
  * @kset_onmedia: Pointer to the kset_onmedia structure for the last kset.
  */
-static void last_kset_gc(struct pcache_cache *cache, struct pcache_cache_kset_onmedia *kset_onmedia)
+static int last_kset_gc(struct pcache_cache *cache, struct pcache_cache_kset_onmedia *kset_onmedia)
 {
 	struct dm_pcache *pcache = CACHE_TO_PCACHE(cache);
 	struct pcache_cache_segment *cur_seg, *next_seg;
 
+	if (!cache_seg_id_valid(cache, kset_onmedia->next_cache_seg_id)) {
+		pcache_dev_err(pcache, "invalid next_cache_seg_id %u in gc (n_segs %u)\n",
+				kset_onmedia->next_cache_seg_id, cache->n_segs);
+		return -EIO;
+	}
+
 	cur_seg = cache->key_tail.cache_seg;
 
 	next_seg = &cache->segments[kset_onmedia->next_cache_seg_id];
@@ -94,6 +100,8 @@ static void last_kset_gc(struct pcache_cache *cache, struct pcache_cache_kset_on
 	spin_lock(&cache->seg_map_lock);
 	__clear_bit(cur_seg->cache_seg_id, cache->seg_map);
 	spin_unlock(&cache->seg_map_lock);
+
+	return 0;
 }
 
 void pcache_cache_gc_fn(struct work_struct *work)
@@ -130,7 +138,11 @@ void pcache_cache_gc_fn(struct work_struct *work)
 			if (dirty_tail.cache_seg == key_tail.cache_seg)
 				break;
 
-			last_kset_gc(cache, kset_onmedia);
+			ret = last_kset_gc(cache, kset_onmedia);
+			if (ret) {
+				atomic_inc(&cache->gc_errors);
+				return;
+			}
 			continue;
 		}
 
diff --git a/drivers/md/dm-pcache/cache_key.c b/drivers/md/dm-pcache/cache_key.c
index a3bb1f95afb90..47338a4df36fc 100644
--- a/drivers/md/dm-pcache/cache_key.c
+++ b/drivers/md/dm-pcache/cache_key.c
@@ -94,6 +94,12 @@ int cache_key_decode(struct pcache_cache *cache,
 	key->off = key_onmedia->off;
 	key->len = key_onmedia->len;
 
+	if (!cache_seg_id_valid(cache, key_onmedia->cache_seg_id)) {
+		pcache_dev_err(pcache, "invalid cache_seg_id %u in cache key (n_segs %u)\n",
+				key_onmedia->cache_seg_id, cache->n_segs);
+		return -EIO;
+	}
+
 	key->cache_pos.cache_seg = &cache->segments[key_onmedia->cache_seg_id];
 	key->cache_pos.seg_off = key_onmedia->cache_seg_off;
 
@@ -801,6 +807,11 @@ int cache_replay(struct pcache_cache *cache)
 				goto out;
 			}
 
+			if (!cache_seg_id_valid(cache, kset_onmedia->next_cache_seg_id)) {
+				ret = -EIO;
+				goto out;
+			}
+
 			next_seg = &cache->segments[kset_onmedia->next_cache_seg_id];
 
 			pos->cache_seg = next_seg;
diff --git a/drivers/md/dm-pcache/cache_writeback.c b/drivers/md/dm-pcache/cache_writeback.c
index 3df8687e2382f..c34db79fcefb4 100644
--- a/drivers/md/dm-pcache/cache_writeback.c
+++ b/drivers/md/dm-pcache/cache_writeback.c
@@ -196,12 +196,18 @@ static int cache_kset_insert_tree(struct pcache_cache *cache, struct pcache_cach
 	return ret;
 }
 
-static void last_kset_writeback(struct pcache_cache *cache,
+static int last_kset_writeback(struct pcache_cache *cache,
 		struct pcache_cache_kset_onmedia *last_kset_onmedia)
 {
 	struct dm_pcache *pcache = CACHE_TO_PCACHE(cache);
 	struct pcache_cache_segment *next_seg;
 
+	if (!cache_seg_id_valid(cache, last_kset_onmedia->next_cache_seg_id)) {
+		pcache_dev_err(pcache, "invalid next_cache_seg_id %u in writeback (n_segs %u)\n",
+				last_kset_onmedia->next_cache_seg_id, cache->n_segs);
+		return -EIO;
+	}
+
 	pcache_dev_debug(pcache, "last kset, next: %u\n", last_kset_onmedia->next_cache_seg_id);
 
 	next_seg = &cache->segments[last_kset_onmedia->next_cache_seg_id];
@@ -211,6 +217,8 @@ static void last_kset_writeback(struct pcache_cache *cache,
 	cache->dirty_tail.seg_off = 0;
 	cache_encode_dirty_tail(cache);
 	mutex_unlock(&cache->dirty_tail_lock);
+
+	return 0;
 }
 
 void cache_writeback_fn(struct work_struct *work)
@@ -229,6 +237,9 @@ void cache_writeback_fn(struct work_struct *work)
 	if (pcache_is_stopping(pcache))
 		goto unlock;
 
+	if (atomic_read(&cache->writeback_errors))
+		goto unlock;
+
 	kset_onmedia = (struct pcache_cache_kset_onmedia *)cache->wb_kset_onmedia_buf;
 
 	mutex_lock(&cache->dirty_tail_lock);
@@ -241,15 +252,19 @@ void cache_writeback_fn(struct work_struct *work)
 	}
 
 	if (kset_onmedia->flags & PCACHE_KSET_FLAGS_LAST) {
-		last_kset_writeback(cache, kset_onmedia);
+		ret = last_kset_writeback(cache, kset_onmedia);
+		if (ret) {
+			atomic_inc(&cache->writeback_errors);
+			goto unlock;
+		}
 		delay = 0;
 		goto queue_work;
 	}
 
 	ret = cache_kset_insert_tree(cache, kset_onmedia);
 	if (ret) {
-		delay = PCACHE_CACHE_WRITEBACK_INTERVAL;
-		goto queue_work;
+		atomic_inc(&cache->writeback_errors);
+		goto unlock;
 	}
 
 	cache_wb_tree_writeback(cache, get_kset_onmedia_size(kset_onmedia));
-- 
2.53.0

