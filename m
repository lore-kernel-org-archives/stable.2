Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795669263;
	b=1HH+bcpSGD44/GEZOKq8rSfZUHQqsxp8OMF+wCrTsdPO4529ClUynESM4J9GCf0ti+q5
	 zuPa/WH1q+oZH0Aw7ff+MOoM0WLzzqkFrAKEoU1serED4YpA9KOn733crOAexFKqTdObE
	 vpC1J4Sseq9dsCs4xKA9BBScw58HoVNVQMNbH6heOm0eEALML7JmImVRDmFwYl4YYhHIP
	 xKUExmptq0OblWS9YCN7LALiukvv0K4P3syWWdaOaUC2bRwgqSvwc9sT8sFu4bXIu+8OY
	 UpEtlhhENBKH3zNI7rIQNTYm+RBdzY/4ziKPmA8OBeoOm4CH9de5kyDgforhCiyCdUw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795669263;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=RT3Dq4NG8OAgccQjjJzXTqR6xYmCJoFfJTtZ+Fxfuc4=;
	b=I0IzWyL+EbDCZsiQLoGc+w3mWn6eRQTv0vxzokn7gonDbIxF04wUF6ORGw88pH2+qy3V
	 8gxPZP0mH5B6hHn4EmSQ6kxyfB1zsugKKloQEG2fnmGOx/FBdbJbkhTFhKDt/GH2ejcbF
	 xR+8RK8kT+r39R+coyQhqqjMJbmPnnCBKG05PRqRFqfCjtc88RvhLImAKVA22wwndeI2Z
	 ib0XbbqzUWEvT+hXIx6KnpHmCnRjtEW5aR9eVKDyOA8eM1W5kFBvP8+DIyi7wZ8jdB5FN
	 pORUwQqPBlMD/Bpo0euAnDSBHoj50e/5pcY4mJ/ytzZtx9JwKIFYdGqUwBAq6VGkEWQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=KOiRh5DP;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4B70606A31C
	for <stable@vger.kernel.org>; Thu, 26 Nov 2026 05:01:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=KOiRh5DP
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 09C781F000CA;
	Thu, 26 Nov 2026 05:01:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795669263;
	bh=RT3Dq4NG8OAgccQjjJzXTqR6xYmCJoFfJTtZ+Fxfuc4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=KOiRh5DP7LLXmk5zfvpdgKXPMdIUadpqL4BmlroaLvKsbtKviSM1SwS5qsZt5Bx/m
	 cM9cag9aPrux/Vm/XERh972X4wRyT90E/Czyc5WXqEhjFcQHhXwi+qhduDlUqi6dGg
	 zMr9Q47hmQbHArWOxsETIN7DaSqedYB45eB84A/7mV3LDCCKDrkX18P8dLy9awSkKN
	 kaPiZSX8baFYV4R1CRL7wFuHtOfNcujviY4gKhJiIEND6wgRFLx4F4RaASs51X03WH
	 Tq/S5E++wKE5dg6KRk27qeg0wyoc+itnXoIR5vT00f8vFMqe4MZehBAI6cEsATKGb9
	 UbjLMPThzfDsQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Kirtikumar Anandrao Ramchandani <kirtiar15502@gmail.com>,
	syzbot+c8564fc0a96e3ecbe4d4@syzkaller.appspotmail.com,
	Mikulas Patocka <mpatocka@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y 2/2] dm cache: validate the discard block size before narrowing
Date: Thu, 26 Nov 2026 00:01:00 -0500
Message-ID: <20261126050045.2080405-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261126050045.2080405-1-sashal@kernel.org>
References: <2026112510-mama-skintight-d6f5@gregkh>
 <20261126050045.2080405-1-sashal@kernel.org>
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
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/md/dm-cache-target.c | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/drivers/md/dm-cache-target.c b/drivers/md/dm-cache-target.c
index 6dc177c51f8f0..13479c6b4cc36 100644
--- a/drivers/md/dm-cache-target.c
+++ b/drivers/md/dm-cache-target.c
@@ -17,6 +17,7 @@
 #include <linux/jiffies.h>
 #include <linux/init.h>
 #include <linux/kstrtox.h>
+#include <linux/math64.h>
 #include <linux/mempool.h>
 #include <linux/module.h>
 #include <linux/rwsem.h>
@@ -2390,9 +2391,7 @@ static int create_cache_policy(struct cache *cache, struct cache_args *ca,
 static bool too_many_discard_blocks(sector_t discard_block_size,
 				    sector_t origin_size)
 {
-	(void) sector_div(origin_size, discard_block_size);
-
-	return origin_size > MAX_DISCARD_BLOCKS;
+	return div64_u64(origin_size, discard_block_size) > MAX_DISCARD_BLOCKS;
 }
 
 static sector_t calculate_discard_block_size(sector_t cache_block_size,
@@ -2429,6 +2428,7 @@ static int cache_create(struct cache_args *ca, struct cache **result)
 	struct cache *cache;
 	struct dm_target *ti = ca->ti;
 	dm_block_t origin_blocks;
+	sector_t discard_block_size;
 	struct dm_cache_metadata *cmd;
 	bool may_format = ca->features.mode == CM_WRITE;
 
@@ -2528,9 +2528,15 @@ static int cache_create(struct cache_args *ca, struct cache **result)
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

