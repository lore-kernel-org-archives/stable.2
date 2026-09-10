Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74B2226299
	for <stable@vger.kernel.org>; Thu, 10 Sep 2026 00:18:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788999517; cv=none; b=inJOCHUWNuzh5cMNWX7rgeXpDpSh0pwYvZIohgqwgbjYKdiKm0h/wMuhMkYFkH8Jqz5gTteFMShwrirOPdmaRE00mk17/j/dWyH4lZLkUg5D8bUdpCWfaQGkEnNqGdzfKlsOfc/GpVfE+Jtor9NsLMLsAi/sdwtiegKCee09RuM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788999517; c=relaxed/simple;
	bh=BeE9E+zKMRKVMj3Fm9upoLJ8WIm2Sa8L8sIUg/1Gtzs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qEWu2Vd0YyJ75Tur8VEC5xg9S+2A+sPYCxgz0f8D55Nt34fFK3kt9AV58lGGhHxOcvrcvWplJ/ybR79YdcvNOXjy0ZtvWE98ZHnPNMv5Cs+x7UGQAIWdAuvG9J8NzTtgU/O7D+OxK0S5ntBlXzkpdxlPXbsyyk2JYM6TLRNw8Tw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=c0tc4BL1; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="c0tc4BL1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D85E91F000FF;
	Thu, 10 Sep 2026 00:18:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788999516;
	bh=JMizTXWxJOwgLBg8jLHNbE3OOzmkFnSc61fpXFXK0Co=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=c0tc4BL1bRiYujMyeAVYXM+JP7wpGeYJD5hhpcjJyd5Cg3yRDtfAbruR88UYBQmzX
	 /lf6dv+d4RnyWSVM1e2WNAm3Eg0daBsoisOEfiS+X3AOau1f23wI5pFbnBnqbP1+9z
	 xTETjX4WcWF1/FCfsRXCaXDz0U90OA+fg4QUmHUWYObzB0CZVfKdGHW3zaHT5uYWA7
	 IjD1X9v7KXdmswTcyxMbRzTdBCZeE5LmYelAek+4LjIDg9RMkLRXUMhEy/L4wb3RaT
	 AH7OuPxtwSA0As7X5RQ7xNXqcM0+yk0YEbwwAj2GXYRx2vcOypYB15FyY96gED+cXa
	 N68B2xz109s9Q==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Bryam Vargas <hexlabsecurity@proton.me>,
	Mikulas Patocka <mpatocka@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 7.2.y] dm-pcache: reject a kset that overruns its segment
Date: Wed,  9 Sep 2026 20:18:34 -0400
Message-ID: <20260910001834.3752050-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026090425-mutiny-unsent-560b@gregkh>
References: <2026090425-mutiny-unsent-560b@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Bryam Vargas <hexlabsecurity@proton.me>

[ Upstream commit 7ac1f10f987a2ffae4aecf0e2ceca8f552b665cb ]

cache_replay(), the writeback worker and the GC worker read a kset of
get_kset_onmedia_size() bytes and advance the position by it. A forged
key_num makes that size exceed the segment's remaining space, so the
advance walks past the segment and trips the cache_pos_advance() BUG_ON.

Reject a kset whose on-media size exceeds cache_seg_remain() before use.

Fixes: 1d57628ff95b ("dm-pcache: add persistent cache target in device-mapper")
Cc: stable@vger.kernel.org
Signed-off-by: Bryam Vargas <hexlabsecurity@proton.me>
Signed-off-by: Mikulas Patocka <mpatocka@redhat.com>
[ backported missing writeback_errors support from the upstream dependency. ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/md/dm-pcache/cache.h           | 1 +
 drivers/md/dm-pcache/cache_gc.c        | 5 +++++
 drivers/md/dm-pcache/cache_key.c       | 5 +++++
 drivers/md/dm-pcache/cache_writeback.c | 8 ++++++++
 4 files changed, 19 insertions(+)

diff --git a/drivers/md/dm-pcache/cache.h b/drivers/md/dm-pcache/cache.h
index afc112b79496a..93c1e699a3944 100644
--- a/drivers/md/dm-pcache/cache.h
+++ b/drivers/md/dm-pcache/cache.h
@@ -180,6 +180,7 @@ struct pcache_cache {
 		u32 advance;
 		int ret;
 	} writeback_ctx;
+	atomic_t		writeback_errors;
 
 	char gc_kset_onmedia_buf[PCACHE_KSET_ONMEDIA_SIZE_MAX];
 	struct delayed_work	gc_work;
diff --git a/drivers/md/dm-pcache/cache_gc.c b/drivers/md/dm-pcache/cache_gc.c
index 3088cfef951bc..99999a92c4e67 100644
--- a/drivers/md/dm-pcache/cache_gc.c
+++ b/drivers/md/dm-pcache/cache_gc.c
@@ -134,6 +134,11 @@ void pcache_cache_gc_fn(struct work_struct *work)
 			continue;
 		}
 
+		if (get_kset_onmedia_size(kset_onmedia) > cache_seg_remain(&key_tail)) {
+			atomic_inc(&cache->gc_errors);
+			return;
+		}
+
 		for (i = 0; i < kset_onmedia->key_num; i++) {
 			struct pcache_cache_key key_tmp = { 0 };
 
diff --git a/drivers/md/dm-pcache/cache_key.c b/drivers/md/dm-pcache/cache_key.c
index 51dd1ccf4e2fd..93933651d2c96 100644
--- a/drivers/md/dm-pcache/cache_key.c
+++ b/drivers/md/dm-pcache/cache_key.c
@@ -811,6 +811,11 @@ int cache_replay(struct pcache_cache *cache)
 		}
 
 		/* Replay the kset and check for errors. */
+		if (get_kset_onmedia_size(kset_onmedia) > cache_seg_remain(pos)) {
+			ret = -EIO;
+			goto out;
+		}
+
 		ret = kset_replay(cache, kset_onmedia);
 		if (ret)
 			goto out;
diff --git a/drivers/md/dm-pcache/cache_writeback.c b/drivers/md/dm-pcache/cache_writeback.c
index 3df8687e2382f..656e4d0489121 100644
--- a/drivers/md/dm-pcache/cache_writeback.c
+++ b/drivers/md/dm-pcache/cache_writeback.c
@@ -229,6 +229,9 @@ void cache_writeback_fn(struct work_struct *work)
 	if (pcache_is_stopping(pcache))
 		goto unlock;
 
+	if (atomic_read(&cache->writeback_errors))
+		goto unlock;
+
 	kset_onmedia = (struct pcache_cache_kset_onmedia *)cache->wb_kset_onmedia_buf;
 
 	mutex_lock(&cache->dirty_tail_lock);
@@ -246,6 +249,11 @@ void cache_writeback_fn(struct work_struct *work)
 		goto queue_work;
 	}
 
+	if (get_kset_onmedia_size(kset_onmedia) > cache_seg_remain(&dirty_tail)) {
+		atomic_inc(&cache->writeback_errors);
+		goto unlock;
+	}
+
 	ret = cache_kset_insert_tree(cache, kset_onmedia);
 	if (ret) {
 		delay = PCACHE_CACHE_WRITEBACK_INTERVAL;
-- 
2.53.0

