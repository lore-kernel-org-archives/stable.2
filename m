Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795669549;
	b=yH4Na0x+TnitFiQ3maoqjE0IVWwnlz0tSj2D/GZNgXS4OEjBen/aR3lk2oJNVc+x2ctL
	 pcze6o5NvtulNH8GzszM2e0la4f+RPj5JCwMwYIg4Ysya1bpzRxPwPXUjGlzmcSJdYDp1
	 ZUsef1GRKVlR7VqEvVRazVSlbY59EF2IMT03aMzNUR3/nOuGtYcG+5QeeuTIjxlsKkB3I
	 oc6Nuw1UPkUSTiiYRLHHVchiFgV8yl2aGYvA8cuFSKIUKDu6zulX8WxnetBY/zWYVUbIc
	 GUNLYNqDQoQCTRXQWNR9sUnzPCLpuk8ulC41TiyHooPiWUExz8xSOj67SsNPvlkhwIw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795669549;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=x8dbAoZSkg+EajqZkqIm6PORMnA2yfEze5aiARIaEBM=;
	b=DIUCThN78kDeQA7HCsR/HXlwktB9YjB5pC4ydhHXLOUExgvR+w1jO6tPxNBiZmm7Z1l/
	 z1MgHDC+V03syOsCGZppYWZu5KTq7YBeZk9sXbdnREsVn5m1w88MmtCL7wVWuPQBOVLmm
	 lLbj9WzhPWyLS2aIYCIgqHJEYRz0BqxK18c+3JQFeOqROpC4FwNo3yvUH7sdoNCG4sMos
	 XX6aW61OCf3XoePMGw/6saGL669Ded/EPdSkHSfQeQXnjg43NYh+hldKrPuwZ+YsZ8Rpn
	 N7JbcRQENwqOHBAjjtKO7vfEGgoU15i2zRp4mZ+WsjqsqyVi+aKI3bA9a9qYdh8hkLQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="N6UGAVa/";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0580C606A31E
	for <stable@vger.kernel.org>; Thu, 26 Nov 2026 05:05:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=N6UGAVa/
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 48A091F000C4;
	Thu, 26 Nov 2026 05:05:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795669548;
	bh=x8dbAoZSkg+EajqZkqIm6PORMnA2yfEze5aiARIaEBM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=N6UGAVa/8Y54sCwjgEwpu+9ZffziP0niRHgS8Axvb/7s+sYbE4SWi5XnvGy+qL6D4
	 vM3RMlwPYnFilzt6pK63Cmte6bgU3Pfbuh8kTlqI36uGTM0obL3sxhsZwqBlp30p+t
	 9iqOFcK38ur8SFidHJxz+V80FiIOwVoIFI3yJo9gERyzPRQ3YmWPIQ3BhlsVaoeifN
	 sPV0WmW2/P8oCZJS7P8ghK43qAhrsTUIk8imO1BOHyCxDUHzkahmrk5L2aXcTXmpba
	 ySEmWAhHCVw/VgSoRrGtyazY73Js2pHOBhyo0KLKJXwDkH9QdDM5pW+MgOTvKRg18H
	 Piia4XmK35UxQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Kirtikumar Anandrao Ramchandani <kirtiar15502@gmail.com>,
	syzbot+c8564fc0a96e3ecbe4d4@syzkaller.appspotmail.com,
	Mikulas Patocka <mpatocka@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y] dm cache: validate the discard block size before narrowing
Date: Thu, 26 Nov 2026 00:05:46 -0500
Message-ID: <20261126050529.2095647-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026112510-cesspool-letdown-737d@gregkh>
References: <2026112510-cesspool-letdown-737d@gregkh>
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
[ sashal: Adjusted the include context: added only #include <linux/math64.h> between init.h and mempool.h, since kstrtox.h isn't present in this tree. ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/md/dm-cache-target.c | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/drivers/md/dm-cache-target.c b/drivers/md/dm-cache-target.c
index 79b4eec0ce8de..8b4e64b36a6e0 100644
--- a/drivers/md/dm-cache-target.c
+++ b/drivers/md/dm-cache-target.c
@@ -16,6 +16,7 @@
 #include <linux/dm-kcopyd.h>
 #include <linux/jiffies.h>
 #include <linux/init.h>
+#include <linux/math64.h>
 #include <linux/mempool.h>
 #include <linux/module.h>
 #include <linux/rwsem.h>
@@ -2393,9 +2394,7 @@ static int create_cache_policy(struct cache *cache, struct cache_args *ca,
 static bool too_many_discard_blocks(sector_t discard_block_size,
 				    sector_t origin_size)
 {
-	(void) sector_div(origin_size, discard_block_size);
-
-	return origin_size > MAX_DISCARD_BLOCKS;
+	return div64_u64(origin_size, discard_block_size) > MAX_DISCARD_BLOCKS;
 }
 
 static sector_t calculate_discard_block_size(sector_t cache_block_size,
@@ -2432,6 +2431,7 @@ static int cache_create(struct cache_args *ca, struct cache **result)
 	struct cache *cache;
 	struct dm_target *ti = ca->ti;
 	dm_block_t origin_blocks;
+	sector_t discard_block_size;
 	struct dm_cache_metadata *cmd;
 	bool may_format = ca->features.mode == CM_WRITE;
 
@@ -2531,9 +2531,15 @@ static int cache_create(struct cache_args *ca, struct cache **result)
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

