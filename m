Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E38372F3C3E
	for <stable@vger.kernel.org>; Thu, 10 Sep 2026 01:00:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789002034; cv=none; b=mWu58ik/kxGFkwVQPLgAkJCeRF4qAELIGcyttSH+PdL+Lqgt4wiN6vWV9O0/HT9IutexC+agRiPlskFW2duCT1y3lGbc5FsRQ/VlLUtBm+/JlGTPdxPgDAp0Ovz0TUmj/tPqlVplgGtSzIDcNAr8nhv+Yn1QxF41p5cT6QZPibo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789002034; c=relaxed/simple;
	bh=RUkuGpKV7Vx2xcosagoqyAB6lnwvfn9vEFgn/8VglvU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kAhlIF0WJcgkhnGit/RhaRIPhDyDm30ueDGP9/NOp506QRIP0vbTRgPv274DaO6prpwjLh8xYDgebCQAQ1ok5+S7+mImfOkv/Hbh6HmmuqFT21zcHQAzAaRsPlbSS1jba4F7VLCFdHkSWZBJ19qG36gkjlkgyVDJMc4sK3idmII=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XvW+LRkm; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XvW+LRkm"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 415B71F000FF;
	Thu, 10 Sep 2026 01:00:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789002032;
	bh=Texw+b76z24+aw2SBrvESrpX2GUrADF1oPhi+vZF0hM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=XvW+LRkm6o+btfhOcIo+H82fhb1vsA2vPNm0AMwwntW6JPgNSj+hViy0Fn8ISfvgQ
	 bX9d5dtqMYS7J06124NIkVEPJLdSWNQJrmp48+ok3U/gkQ6sV6L6Ce2wxrVJKvZow9
	 HEI5WGp9Oh3hHF8SVM18GAqX1/3GlZEywA18uSb2W0scHFiJchGNWuz8Sne29MBzsF
	 lI933Tqh3puNZHwtYQaQgjLphpNbnx9aBSYI24bwQ9e5vcaT+gu/KgrBqDsKZn8yc+
	 Y+D8FmkGMhZP7+MbcbTEB0H5+ygPItMFr9RzfuXAoK/3l68YCSDaSF5XpPunczzBLX
	 Y1ae6HnOIlxDg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Bryam Vargas <hexlabsecurity@proton.me>,
	Mikulas Patocka <mpatocka@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18.y] dm-pcache: bound the logical key offset from persistent memory
Date: Wed,  9 Sep 2026 21:00:29 -0400
Message-ID: <20260910010029.3788785-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026090433-clothing-lyricist-8896@gregkh>
References: <2026090433-clothing-lyricist-8896@gregkh>
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
index a3bb1f95afb90..e21ca33c731da 100644
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

