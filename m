Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795669946;
	b=ZV334HCrsT4aEFYnHlDEbSGJ9uCWk52dit/6R1RLmsZWi+YjaQPt1vO500l1Au2vUyxz
	 CHVygjRPFzYwosvHjMbe3cfpqUnLX6rFmmqbgTYp07PJ+a3d52/ThXlfkJORh9GFCq6Ji
	 Nt4Z1MLj6D+PasGQfyo0L/Jupv8gEYFwyZtQZgsDxH5w2AYcU5n6Gt8uIrwgaHquoDXFY
	 fLfyy5IY0dJo9VBYAgOcRwCWMrerkheSRHoylwSetb3rIKYT2PS+wkF1BuDgezkP/K+OV
	 1LRBC2pGFvjhS5Yac7TeEadVKhu6OlaU5Z6Xmy2LAJq2n7l5j//MMgCi1IrpA6oV/DQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795669946;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=DB+TLxSGv1InLhR6Z3lF+bw2OUQ722GThfsePcRb6tk=;
	b=AxHvt4SNAdFkG7zmyXVBG8uvkdLTJPAuu1U3ENx/hYYFb/eUp2830ve9/Pni9t738Uha
	 JEm0VJowhwcvfpOFIkLmOSja9EJ5zZfSMQuo7ivC9pHKnz0CoLrIqhDqA5s1U3kbATW+e
	 eQ1Y/18hYoFLjevGFp78OnnEWNStMr+Ka2TI7MHcmgeBF359D2Ao7Q1ZkuTSA45M94pAz
	 B0eGxQhoMOzEl6X9d9mRUGscYJpr4K0jTS+ZG85g228yqzndS5+8BUA18honn2PXzLNc+
	 p1m6vXPq2r+VTPd02BZoPRq5R8s8si1LiA3LXzb/LHOgedXAH+/asUHTs2BtUZfpiqQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=XwwphrLL;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1773606A33B
	for <stable@vger.kernel.org>; Thu, 26 Nov 2026 05:12:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=XwwphrLL
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B25231F000EF;
	Thu, 26 Nov 2026 05:12:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795669945;
	bh=DB+TLxSGv1InLhR6Z3lF+bw2OUQ722GThfsePcRb6tk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=XwwphrLLd22ee7Fy+EHbaPtrbKNMwjUX6Wc1T4c7mX7CH8LsWPoZezxuUf9GagVy6
	 J26wyRwaznS9MApdeXq/JZPsV51LUnyKMSmCKLCiVh4O4ypolSBtVSxV1JiPMBN5oL
	 XJW8FEk8mdGHEzY9g7k6zsN6FiT/lGECBxFx46rBRxoAHCE52QvEF12n3FN+i+tgnl
	 A5OIB8eNNPfrp6hHQKkONqg1rzr14h2bUnQ5AdvnuebBbGbEzO3YElibEM66cRQgJu
	 e/Qb355H8kNwFU3tY7+3Hhht0XliCJtNpXbyaU2Z6rxpEBkh/N/N6/XNhxnmRtJYH+
	 msERQxw1SAQ0w==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Kirtikumar Anandrao Ramchandani <kirtiar15502@gmail.com>,
	syzbot+c8564fc0a96e3ecbe4d4@syzkaller.appspotmail.com,
	Mikulas Patocka <mpatocka@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y] dm cache: validate the discard block size before narrowing
Date: Thu, 26 Nov 2026 00:12:23 -0500
Message-ID: <20261126051207.2128898-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026112511-thee-bucket-8691@gregkh>
References: <2026112511-thee-bucket-8691@gregkh>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Kirtikumar Anandrao Ramchandani <kirtiar15502@gmail.com>

[ Upstream commit df8daa4d916c88ef7888c738e0eb3b6f11714a6f ]

The discard block size doubles until the origin fits within the discard
bitset limit. too_many_discard_blocks() passes this sector_t size to
sector_div(), whose divisor is only 32 bits. Once the size exceeds that
range, the division uses a truncated divisor, which can become zero.

Use a 64-bit divisor when checking the block count. The selected size is
stored in a u32, so reject sizes that cannot be represented before the
assignment and before calculating the bitset size. This prevents a
truncated zero size from reaching dm_sector_div_up().

An earlier proposal checks whether the mapped length exceeds the origin
device. This fix also covers an origin device whose valid size requires a
discard block size beyond the field's range.

Reported-by: syzbot+c8564fc0a96e3ecbe4d4@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=c8564fc0a96e3ecbe4d4
Cc: stable@vger.kernel.org
Fixes: 08b184514f65 ("dm cache: revert 'prevent corruption caused by discard_block_size > cache_block_size'")
Signed-off-by: Kirtikumar Anandrao Ramchandani <kirtiar15502@gmail.com>
Signed-off-by: Mikulas Patocka <mpatocka@redhat.com>
[ sashal: adjusted the include context because linux/kstrtox.h is absent here, so the math64.h include is added after linux/dm-kcopyd.h and linux/jiffies.h/linux/init.h instead ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/md/dm-cache-target.c | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/drivers/md/dm-cache-target.c b/drivers/md/dm-cache-target.c
index ea1843bb70b3b..13b0d21d62ff7 100644
--- a/drivers/md/dm-cache-target.c
+++ b/drivers/md/dm-cache-target.c
@@ -14,6 +14,7 @@
 #include <linux/dm-kcopyd.h>
 #include <linux/jiffies.h>
 #include <linux/init.h>
+#include <linux/math64.h>
 #include <linux/mempool.h>
 #include <linux/module.h>
 #include <linux/rwsem.h>
@@ -2352,9 +2353,7 @@ static int create_cache_policy(struct cache *cache, struct cache_args *ca,
 static bool too_many_discard_blocks(sector_t discard_block_size,
 				    sector_t origin_size)
 {
-	(void) sector_div(origin_size, discard_block_size);
-
-	return origin_size > MAX_DISCARD_BLOCKS;
+	return div64_u64(origin_size, discard_block_size) > MAX_DISCARD_BLOCKS;
 }
 
 static sector_t calculate_discard_block_size(sector_t cache_block_size,
@@ -2391,6 +2390,7 @@ static int cache_create(struct cache_args *ca, struct cache **result)
 	struct cache *cache;
 	struct dm_target *ti = ca->ti;
 	dm_block_t origin_blocks;
+	sector_t discard_block_size;
 	struct dm_cache_metadata *cmd;
 	bool may_format = ca->features.mode == CM_WRITE;
 
@@ -2489,9 +2489,15 @@ static int cache_create(struct cache_args *ca, struct cache **result)
 	}
 	clear_bitset(cache->dirty_bitset, from_cblock(cache->cache_size));
 
-	cache->discard_block_size =
+	discard_block_size =
 		calculate_discard_block_size(cache->sectors_per_block,
 					     cache->origin_sectors);
+	if (discard_block_size > U32_MAX) {
+		*error = "Discard block size exceeds 32 bits";
+		r = -EOVERFLOW;
+		goto bad;
+	}
+	cache->discard_block_size = discard_block_size;
 	cache->discard_nr_blocks = to_dblock(dm_sector_div_up(cache->origin_sectors,
 							      cache->discard_block_size));
 	cache->discard_bitset = alloc_bitset(from_dblock(cache->discard_nr_blocks));
-- 
2.53.0

