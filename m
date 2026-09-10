Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDD354BFE85
	for <stable@vger.kernel.org>; Thu, 10 Sep 2026 00:18:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788999512; cv=none; b=ID4iHOheEQir+jNcWx5joZBBGJZQRWf4dru9zGsnz0pTd6Q/+egHFTHgtPGC3qwo+TabpStMLeP3pKry4vMa/n4KEtf91OWseNNcvXrh6/xZJLoVcFvHHXH/cFqAviTA8lrMqx5Ncib0MWEmWnuWEtEMGXFX9IQ5V3o3yjkcChE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788999512; c=relaxed/simple;
	bh=3+jIJtG7BYd+0SvsoqCAnrKdFI17SELEyh5CkOQAYRc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lrOZ7kKzAkl7sFsggu1+lbW34As7i12zQzcZ7JNEDd4Z0/HqaE1oA7iRS2O7WGhSxK7+Cj09vr5Bl8JBjv6+wnAguEkJJ+RuhXKHahIL2Sydo0eaQW/84haD3hkp+qGyqVCc5GpohYclNP7b/fS1AgD40rtlt5233iyYEnBZNIs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Cj0clxie; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Cj0clxie"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 387191F000FF;
	Thu, 10 Sep 2026 00:18:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788999511;
	bh=83lD1EgYsRUL7oirZAB1UPSawPrU96bHPyK0LKP4UCg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Cj0clxie+2jWFL6VVZBWg9RRgpI7RR91M1wan3CbWNk3obXT7P0ezrO5TXkP4vrg/
	 YaB6wKCDSXDT2hhF9c3tt6iP4+DoG6aoyFvozUVsrAJMyz0MLd0HgWqSlKIog5/zIT
	 DYV2uZQt8EuocanGDqcfLu/Wt4xZEGV1hW9+2ykceynrXCwe2LfarXZotj65H6RtSs
	 IXwNh8JJ6K3OzOMJTbFGXp2GfkJ7Xs+z+UfSWFhu+5M5/+S9P0PoVr59sQNIztNUTh
	 6yr4HWI1tVgpghF2vx/QpO6zEjpMOyvFF1EhICZtvzW5FKQLg57/47ZVmUsDwS2I+k
	 WFY9vEptRbmMQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Bryam Vargas <hexlabsecurity@proton.me>,
	Mikulas Patocka <mpatocka@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 7.2.y] dm-pcache: bound the logical key offset from persistent memory
Date: Wed,  9 Sep 2026 20:18:29 -0400
Message-ID: <20260910001829.3751733-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026090433-ebony-snore-69ef@gregkh>
References: <2026090433-ebony-snore-69ef@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Bryam Vargas <hexlabsecurity@proton.me>

[ Upstream commit 97fc4b53dbe4a983fdf093243067fa6a64562307 ]

cache_key_decode() takes a key's logical off from the cache device and
later indexes req_key_tree->subtrees[] by it in get_subtree(). An off
past the device forms a subtree pointer outside the array, which
rb_insert() writes through during replay.

Reject a key of zero length, or whose off+len (computed in 64 bits)
exceeds the device size, before it is used.

Fixes: 1d57628ff95b ("dm-pcache: add persistent cache target in device-mapper")
Cc: stable@vger.kernel.org
Signed-off-by: Bryam Vargas <hexlabsecurity@proton.me>
Signed-off-by: Mikulas Patocka <mpatocka@redhat.com>
[ adjusted context to account for the missing cache_seg_id_valid() check. ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/md/dm-pcache/cache_key.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/md/dm-pcache/cache_key.c b/drivers/md/dm-pcache/cache_key.c
index 51dd1ccf4e2fd..c98005d16fd6b 100644
--- a/drivers/md/dm-pcache/cache_key.c
+++ b/drivers/md/dm-pcache/cache_key.c
@@ -90,10 +90,19 @@ int cache_key_decode(struct pcache_cache *cache,
 			struct pcache_cache_key *key)
 {
 	struct dm_pcache *pcache = CACHE_TO_PCACHE(cache);
+	u64 dev_bytes = (u64)cache->dev_size << SECTOR_SHIFT;
 
 	key->off = key_onmedia->off;
 	key->len = key_onmedia->len;
 
+	if (key_onmedia->len == 0 ||
+	    key_onmedia->len > dev_bytes ||
+	    key_onmedia->off > dev_bytes - key_onmedia->len) {
+		pcache_dev_err(pcache, "key off %llu + len %u exceeds device size\n",
+				key_onmedia->off, key_onmedia->len);
+		return -EIO;
+	}
+
 	key->cache_pos.cache_seg = &cache->segments[key_onmedia->cache_seg_id];
 	key->cache_pos.seg_off = key_onmedia->cache_seg_off;
 
-- 
2.53.0

