Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF79B28690
	for <stable@vger.kernel.org>; Thu, 10 Sep 2026 01:00:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789002037; cv=none; b=hsKodXhMLo8FoQoMZVD1CeAdFm2G15895DpqufzEHZAp4ZmSygMThJN1eVZ8UTo6LeWSCPYDu0l3782L5KWDhfZujAOsGfMiEb4ZNN6uTU4iXmPYTDfzMi0CWdtUe8AyinaBtXvZZagIsoPyBDRBMTezKrduLVP5z1grkgz6TNs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789002037; c=relaxed/simple;
	bh=wj+Hgz6bd9YJxnrgsxqXLm8CUWahz55fZ4+oPSEB+hQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VPRzc88/qxRcH7fnIiZV08ZbQ9/k336iyZ8xWUVLYLL2EHzNCJXW7Pv9KwfqdPEIzC/kjQ0xASRHZ5uy1lYOr0O9Yaw3u6FRecmx4+huOFRS2jiAyxPh4kWfBBx97/mB7mwh+rOrvdGCqLq1hGHJOD6hxonzF4cOim7VrHdjkg4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aTxrKy3q; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aTxrKy3q"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E26101F00893;
	Thu, 10 Sep 2026 01:00:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789002035;
	bh=J7mdJzbPGj9mlUJ6ge52wtoq+iZRohAZ1PpPBC4u50o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=aTxrKy3qwb0rFFYZiypjwdbxIKNPvKvgxyenS/kP/laskWXQgsesCXTb+LZ3wPZ3z
	 Gg6zeEktEOAsyAKrBOD6gahoRZt/Qvp1rUEZQDTQMmbEeBxMwdv5w9FM2wdIadkA79
	 HVMOUF4nzGANre9pCM6wP3c4Y7Z4unA4Gt5WJmbuqFnVbYLljrIj7CHJw57aIm6uqI
	 OjmJWhqk2VZifUoaYvciAy5p1bKNorvhziq9ZULNjVYXv7N77qu0zcV74HG0Ev/JYn
	 hhYMx9guo2DFUFPLkOzQzpoPHKpflKRF81z9nSo8aTiU0S8DeWueW7saXzf73170Y8
	 gIMposDfG4WUw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Bryam Vargas <hexlabsecurity@proton.me>,
	Mikulas Patocka <mpatocka@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18.y] dm-pcache: reject a kset that overruns its segment
Date: Wed,  9 Sep 2026 21:00:31 -0400
Message-ID: <20260910010031.3788894-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026090426-rebirth-deflected-dbea@gregkh>
References: <2026090426-rebirth-deflected-dbea@gregkh>
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
index a3bb1f95afb90..c39e642f1feb9 100644
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

