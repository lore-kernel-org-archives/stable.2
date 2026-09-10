Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C055F4BFE85
	for <stable@vger.kernel.org>; Thu, 10 Sep 2026 00:18:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788999507; cv=none; b=OUeAI4PwBy6dGwlwJ4zSVSeKwW+6zY/sIwR2H8bhnkNtY0uCPAcVvHYsNxplKIbDGBHKRtAjWt1WpfcNnVW8gv5lr/aUdZCEL6hv69xOnbXwSckcVdciTkk0t0tRC8xbiiUXfFsx3ASDbJ9VMFLn6IwzyMburQwumbkedl46Wfc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788999507; c=relaxed/simple;
	bh=yM32WMVruhVgp9IPDQZpNRNUx3+BOghMpW77R+DQQCw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WTZULToJdqERjRyY51fG9YMg0Dpb00PG/rMGLx7Uz8lsrNmi+Za1QENIl2f29c90f6GXDs9tJU0QVjgZ8tWnSvNHCxQmKAYLjMRITkJLsqeCO154VOkCSvDhTbvJ7B0vhiYZlHtUfGlqFcfMORVjHI8oWEB9zII+TgLgpIVsG0c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Mx0dffhA; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Mx0dffhA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E3A901F000FF;
	Thu, 10 Sep 2026 00:18:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788999505;
	bh=NN3Qrd2U8Q8OgtDAjas5NPkaOUYfkHRw5cjgpIm1c1Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Mx0dffhA7XPF3d9qLY5ANALSXcK2UQ7zKK02rfgJgJDfYyxGkOeKtHWGUMNWCCrY+
	 lqfZdAvcd9mKOVe3SJpd80zpbKMPKlRKFj5UNdhmXeFnFPVcgBQKnfL36wEoF62LUV
	 NjTZlYCvRqUMiaqUqZn+gDnJ6BBhYTB6Qzvx4kufkqGjUYIHyjPNhoReayVvgA1dMt
	 FK9YybOHFD+0dw/nk+wvFShIKq5L/uPV0//BNbAieyhDiCoDysRGyk418zWO0pyKcD
	 GGIgonqRn0XYEFIQ+wb5wfBeYadhI2dD8cpVglc7qClGbs01VqQjCgu5Y3WeJIQO3J
	 jFqclEDeuu84Q==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Bryam Vargas <hexlabsecurity@proton.me>,
	Mikulas Patocka <mpatocka@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 7.2.y] dm-pcache: validate the persisted dirty_tail chain at load
Date: Wed,  9 Sep 2026 20:18:23 -0400
Message-ID: <20260910001823.3751221-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026090410-haven-virus-13f7@gregkh>
References: <2026090410-haven-virus-13f7@gregkh>
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
index e68dacb69459c..e05be58f73e6a 100644
--- a/drivers/md/dm-pcache/cache.c
+++ b/drivers/md/dm-pcache/cache.c
@@ -198,6 +198,7 @@ static int cache_tail_init(struct pcache_cache *cache)
 {
 	struct dm_pcache *pcache = CACHE_TO_PCACHE(cache);
 	bool new_cache = !(cache->cache_info.flags & PCACHE_CACHE_FLAGS_INIT_DONE);
+	int ret;
 
 	if (new_cache) {
 		__set_bit(0, cache->seg_map);
@@ -214,6 +215,12 @@ static int cache_tail_init(struct pcache_cache *cache)
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
index 51dd1ccf4e2fd..cb728bceaeed7 100644
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

