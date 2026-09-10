Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 298D923395C
	for <stable@vger.kernel.org>; Thu, 10 Sep 2026 01:00:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789002017; cv=none; b=Ibn3LWXddH9w0OgdHHauSVfRuDGZtCM9HAlcVi98sMVmy4Pj/tT50jewbrdVf8KfYYCsi4Y1BXs5VeownIKv1VxGsJ0NfPlWFS6BTsosYLzq0rO0NIDNZFcH0+Lyhsdm+qyQs5mmdCmhe42rKjk7wS6kT4f1yWo3RSq1OdgSHB8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789002017; c=relaxed/simple;
	bh=Mm7JSfbJ871/ffr8ZvfSUOEwbs1eJOKbC+q1hBPu81s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DteFDXOHKqqbnzMC7AneqzJCBqWhAEZ8cBghrTnNk5I6DsCIF5vljoB6iRbVzfj5B4NM26pElwlOENDTQJQia4Bfbl9F12EHI82Piz1OR4nUpqIioyAsBVUFkB4k1NnlRDbbWNB87vnu/ilxMNTW9Ha1MhM4UHlm3bwYBhkYwTI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EXxRUmYm; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EXxRUmYm"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 047BD1F000FF;
	Thu, 10 Sep 2026 01:00:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789002015;
	bh=kO43xNIaxIcVMJ4xUn/Y6JuDTUdJeBrpXZE4ddpOslI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=EXxRUmYmed7Ceea1OrOmqGRv84+RqLVuM4550n+l9s9h0TWnwh1Cqg9stNNxgDIuh
	 0xLBj4yGntdr7hNJDfpbPe+583DesOcRMswmzwbFd0G5ulCG/+MGxoEqHW6y9cFzfn
	 Y9uV3jr5JA9JhSZu4NaIIknT5S02EBu0Ou0VuQOcbO/EUu8Q1XUgPbXv6oFuEpu2wS
	 aZlm6C6bX8SRoyAQ9PoZrKQLXdGMs+qpZb05rtO9WEXR0aw6j1YHrK134fojIFmH66
	 OrJNT4r2847MmTOEPjMAFEI9H78ka4MCXZMoCmJUUnPgw/W54VWHXnOt8bfJK6oCJ8
	 qopzNiZMJ6v2g==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Bryam Vargas <hexlabsecurity@proton.me>,
	Mikulas Patocka <mpatocka@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18.y] dm-pcache: validate the persisted dirty_tail chain at load
Date: Wed,  9 Sep 2026 21:00:12 -0400
Message-ID: <20260910010012.3788038-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026090411-harsh-specks-0d82@gregkh>
References: <2026090411-harsh-specks-0d82@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Bryam Vargas <hexlabsecurity@proton.me>

[ Upstream commit 58d620ee9e01d4bdbceaf2ae1450d307a2a9d58b ]

The writeback worker follows the persisted dirty_tail chain, which is
decoded from the cache device independently of the key_tail chain that
cache_replay() walks and bounds. A crafted image, whose on-media fields are
authenticated only by a crc32c with a fixed seed, can aim dirty_tail at a
chain of last ksets that never terminates, so cache_writeback_fn() re-arms
itself with no delay forever.

Walk the dirty_tail chain once at load with the same hop cap cache_replay()
uses and fail the table load with -EIO if it does not reach an end within
n_segs hops.

Fixes: 1d57628ff95b ("dm-pcache: add persistent cache target in device-mapper")
Cc: stable@vger.kernel.org
Signed-off-by: Bryam Vargas <hexlabsecurity@proton.me>
Signed-off-by: Mikulas Patocka <mpatocka@redhat.com>
[ replaced the unavailable cache_seg_id_valid() helper with an equivalent bounds check against cache->cache_info.n_segs ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/md/dm-pcache/cache.c     |  7 ++++
 drivers/md/dm-pcache/cache.h     |  2 +
 drivers/md/dm-pcache/cache_key.c | 69 ++++++++++++++++++++++++++++++++
 3 files changed, 78 insertions(+)

diff --git a/drivers/md/dm-pcache/cache.c b/drivers/md/dm-pcache/cache.c
index 887157fde68da..8635fbf780aa0 100644
--- a/drivers/md/dm-pcache/cache.c
+++ b/drivers/md/dm-pcache/cache.c
@@ -197,6 +197,7 @@ static int cache_tail_init(struct pcache_cache *cache)
 {
 	struct dm_pcache *pcache = CACHE_TO_PCACHE(cache);
 	bool new_cache = !(cache->cache_info.flags & PCACHE_CACHE_FLAGS_INIT_DONE);
+	int ret;
 
 	if (new_cache) {
 		__set_bit(0, cache->seg_map);
@@ -213,6 +214,12 @@ static int cache_tail_init(struct pcache_cache *cache)
 			pcache_dev_err(pcache, "Corrupted key tail or dirty tail.\n");
 			return -EIO;
 		}
+
+		ret = cache_verify_dirty_tail(cache);
+		if (ret) {
+			pcache_dev_err(pcache, "dirty tail chain does not terminate (crafted cache image?)\n");
+			return ret;
+		}
 	}
 
 	return 0;
diff --git a/drivers/md/dm-pcache/cache.h b/drivers/md/dm-pcache/cache.h
index afc112b79496a..e38e8c720071c 100644
--- a/drivers/md/dm-pcache/cache.h
+++ b/drivers/md/dm-pcache/cache.h
@@ -651,6 +651,8 @@ static inline int cache_decode_dirty_tail(struct pcache_cache *cache)
 				&cache->dirty_tail_index);
 }
 
+int cache_verify_dirty_tail(struct pcache_cache *cache);
+
 int pcache_cache_init(void);
 void pcache_cache_exit(void);
 #endif /* _PCACHE_CACHE_H */
diff --git a/drivers/md/dm-pcache/cache_key.c b/drivers/md/dm-pcache/cache_key.c
index a3bb1f95afb90..b4e79f9a42ee5 100644
--- a/drivers/md/dm-pcache/cache_key.c
+++ b/drivers/md/dm-pcache/cache_key.c
@@ -832,6 +832,75 @@ int cache_replay(struct pcache_cache *cache)
 	return ret;
 }
 
+/*
+ * cache_verify_dirty_tail - reject a persisted dirty_tail whose last-kset
+ * chain does not terminate.
+ *
+ * dirty_tail is decoded independently of the key_tail chain cache_replay()
+ * walks, so replay's hop cap does not cover it. A crafted chain that loops
+ * back on itself makes the writeback worker re-arm forever; walk it once here
+ * with the same cap and fail the load if it does not end within n_segs hops.
+ */
+int cache_verify_dirty_tail(struct pcache_cache *cache)
+{
+	struct pcache_cache_pos pos;
+	struct pcache_cache_kset_onmedia *kset_onmedia;
+	u32 to_copy, last_hops = 0, count = 0;
+	int ret = 0;
+
+	kset_onmedia = kzalloc(PCACHE_KSET_ONMEDIA_SIZE_MAX, GFP_KERNEL);
+	if (!kset_onmedia)
+		return -ENOMEM;
+
+	cache_pos_copy(&pos, &cache->dirty_tail);
+
+	while (true) {
+		to_copy = min(PCACHE_KSET_ONMEDIA_SIZE_MAX, cache_seg_remain(&pos));
+		ret = copy_mc_to_kernel(kset_onmedia, cache_pos_addr(&pos), to_copy);
+		if (ret) {
+			ret = -EIO;
+			goto out;
+		}
+
+		/* A missing, short or corrupt kset is the normal end of the chain. */
+		if (!kset_onmedia_valid(kset_onmedia) ||
+		    kset_onmedia->crc != cache_kset_crc(kset_onmedia)) {
+			ret = 0;
+			goto out;
+		}
+
+		if (kset_onmedia->flags & PCACHE_KSET_FLAGS_LAST) {
+			if (kset_onmedia->next_cache_seg_id >= cache->cache_info.n_segs) {
+				ret = -EIO;
+				goto out;
+			}
+
+			if (++last_hops > cache->n_segs) {
+				ret = -EIO;
+				goto out;
+			}
+
+			pos.cache_seg = &cache->segments[kset_onmedia->next_cache_seg_id];
+			pos.seg_off = 0;
+			continue;
+		}
+
+		if (get_kset_onmedia_size(kset_onmedia) > cache_seg_remain(&pos)) {
+			ret = -EIO;
+			goto out;
+		}
+
+		cache_pos_advance(&pos, get_kset_onmedia_size(kset_onmedia));
+		if (++count > 512) {
+			cond_resched();
+			count = 0;
+		}
+	}
+out:
+	kfree(kset_onmedia);
+	return ret;
+}
+
 int cache_tree_init(struct pcache_cache *cache, struct pcache_cache_tree *cache_tree, u32 n_subtrees)
 {
 	int ret;
-- 
2.53.0

