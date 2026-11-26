Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795670089;
	b=zNMN0Qe+a+nxWW2gffM7d0a/nELV5cRYWEMBM0Fi9so3FNM4HaxQe5uOd67vrJa1WTDr
	 9sL2Tzzpu7Qb/DDsbbqK1wVjar4BxaNCDqaSsSsv4LOiM9QtrXVobX25mhlXDjlu+fJlD
	 gpp0htA3Bu7Mh5ZJ7ki259vMC9L5apr6kLGwqtNuK6zHxj4VNXjmR5MA/e1ME1NowlnMa
	 KdUm2KJv/iMMYeemdnedzolmLBZQI5OiSNXc26muKBirBX3DuGlN5E2ixZxr9mZ93kIB6
	 sP5AEoVzofdvqu0qQGZ/ztsk0Ee7u2d0XwpzSsyb4LQQqRtHO+NqNi4TVdezstkRJqA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795670089;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=yje1LiJ59bRgj8AhcxGARN+Qk3J+M08JuYX0UUNGG4Q=;
	b=nK82H0C0UAWVux5otA+piT9yTzhNaEJg1VINUNKmRFFQEdVnZ10yFFxXwXW4yOeC0RsN
	 pboxRS8kf9CIp8uJEgPcAUgZ4264ZVgYM6jFCnWRZ9SM0QuiSmRCyma7rS2ulA0dpr+iX
	 Mj5B9GsKvPaUu+HCENTrttn508RIiQyhqYqvFJAJRpLWGfcxbiJaikNnd7Jqajil8Kb+X
	 oV7UItJZS6KnroQHL3Bd9JUbfeA0AdmLM+5vASFitSjbsmiJimb3rXqstLIv1CH0IYt85
	 HC6fOe8IdImTk3IOtV5q2/wykR9XHhmleyhVqETAMJxdY+wl7rdmMNf0ExKNhRwYtLw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=OJarIRgX;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA9D8606A330
	for <stable@vger.kernel.org>; Thu, 26 Nov 2026 05:14:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=OJarIRgX
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A3B6B1F01562;
	Thu, 26 Nov 2026 05:14:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795670089;
	bh=yje1LiJ59bRgj8AhcxGARN+Qk3J+M08JuYX0UUNGG4Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=OJarIRgXPItpJf1rPMMD+Dx71KyLTVLJYW7+QUpLRwbielJTMfs4jE/tInaQMcMtA
	 jmuPcdVDBm4lth0HRRDZZ6yuHI/f+qHIyrv0Er9wvUEY54pf7+ka2kuuOXC48bnONv
	 qILGTU0Ud0NqrVb6oUkmuOfIf+CjtLRMmZhuX7UIOPNn9WQ4otl2lEI30i9DY9QpuD
	 hCix5mpvQSpkyT6fnJP2AVdJEzcT//LFTGXJpeP5AJFAs4aaHNdzhMZymnwP5FSLbn
	 GHnRqJ5KeWDLjQuUMtC+FzJB17RLG2WVuJNbfXA1y+UL+fgpZr5990tgYXVM+m0z91
	 nWqX+A++M/LGA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Kirtikumar Anandrao Ramchandani <kirtiar15502@gmail.com>,
	syzbot+c8564fc0a96e3ecbe4d4@syzkaller.appspotmail.com,
	Mikulas Patocka <mpatocka@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y] dm cache: validate the discard block size before narrowing
Date: Thu, 26 Nov 2026 00:14:47 -0500
Message-ID: <20261126051432.2135467-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026112511-raft-shadily-48b2@gregkh>
References: <2026112511-raft-shadily-48b2@gregkh>
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
[ sashal: adjusted include context: the math64.h include is added after a different neighboring include, and the upstream-commit reference line was added. ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/md/dm-cache-target.c | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/drivers/md/dm-cache-target.c b/drivers/md/dm-cache-target.c
index b4c7ed26e3de9..ded5b65249891 100644
--- a/drivers/md/dm-cache-target.c
+++ b/drivers/md/dm-cache-target.c
@@ -13,6 +13,7 @@
 #include <linux/dm-kcopyd.h>
 #include <linux/jiffies.h>
 #include <linux/init.h>
+#include <linux/math64.h>
 #include <linux/mempool.h>
 #include <linux/module.h>
 #include <linux/rwsem.h>
@@ -2422,9 +2423,7 @@ static int create_cache_policy(struct cache *cache, struct cache_args *ca,
 static bool too_many_discard_blocks(sector_t discard_block_size,
 				    sector_t origin_size)
 {
-	(void) sector_div(origin_size, discard_block_size);
-
-	return origin_size > MAX_DISCARD_BLOCKS;
+	return div64_u64(origin_size, discard_block_size) > MAX_DISCARD_BLOCKS;
 }
 
 static sector_t calculate_discard_block_size(sector_t cache_block_size,
@@ -2461,6 +2460,7 @@ static int cache_create(struct cache_args *ca, struct cache **result)
 	struct cache *cache;
 	struct dm_target *ti = ca->ti;
 	dm_block_t origin_blocks;
+	sector_t discard_block_size;
 	struct dm_cache_metadata *cmd;
 	bool may_format = ca->features.mode == CM_WRITE;
 
@@ -2559,9 +2559,15 @@ static int cache_create(struct cache_args *ca, struct cache **result)
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

