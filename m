Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795669773;
	b=QA4kBGmWT6mOiZ/lafaR6tjUFOEX2WAl3ClUv8Qe4933kHnQuYARW1b/zsYlhgktWn1e
	 qaTjQmOfFuhwCl32PfjxWh8wk4kD1l54Ecd4dHUDlUP89fNbIayiEKX28yk7Ncq+gzukr
	 3PCfc6B/QcvlioIZ1w9BvAbUEDTxBG2XIq1gv6XOItdvWyVxnwhDARLD0d19LH8QMhkAi
	 7xJA21ba8IHbfhOvmylGb3Oz8W5BIaNG7vUhQf0i1LFxzXfS3rmWP7TUEINWEiboQqRdt
	 L7zVQ+rxlYHH+pgcZQs8o8aPMdU+O4wyDsqNDSJEc8NNTwrF+I7O99g7AFYg/cAxyTQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795669773;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=lSqVwXvj52yALqt74Jq/T4t2G1wSU1e3b7vmb5FK1EU=;
	b=MU2fxFo9sAXRTMfFs3wKX63FzfOTkCtSYWccpx8yeqMYbjgDnMmHHOh97+zlT5flEXnA
	 HEywE/G0qB2aDWMnjP2O/YHZLNSzrepB5Jr02T6xM8Cm4QPHTNKH60qOYL/6GM5EAS7al
	 lPrWj5Psd+6SJVkae/7Sa9yhG7cSlTtgwPM0IdkcPqVDhbau17qls4L1C2t3Q07G2u6Uq
	 Acx4zpN/vDZfYZlQbHQwWa9ot3eZHZf/Rs9KwvXQrWmtvH4rTPvzqeeImLJdllcSdQmCf
	 ENaZ42YfwFJAQsYoSCFzYHmRRMuqFzPN9vPOd0R4bJeVC7ZVasuojtsFy+Iq3TTSF0Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=KSAOPjEc;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A68F606A31C
	for <stable@vger.kernel.org>; Thu, 26 Nov 2026 05:09:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=KSAOPjEc
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 81AF01F000D4;
	Thu, 26 Nov 2026 05:09:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795669772;
	bh=lSqVwXvj52yALqt74Jq/T4t2G1wSU1e3b7vmb5FK1EU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=KSAOPjEc92u63ied6mrJsRIJjYlZSdC/koFj6ggtPr1bHsQjQ/9Nd0F86k4E/IQtt
	 EHsRkvtOFRLtdkz3BUn1VCUxKZuBGyVlIPjUlDTovURImJIraLUovdtT2YucNpTcYD
	 1OIIodag+LB9EETZ3ZD+uwWdg9x5Wuch3EpiKxGsvPz0FFR/KEyGuU4xLzlPTuIwyb
	 6WO9d8AkIBM72K+7e9qGAeZK+4GY85Mui+rumYyn+tD7+xSm0e9ZT4E9hoZz/K+Gbb
	 aBsTfetrsdspUVnHp1orzh6rYDiqnm1yP7w0zmd4nqjVeOuwMYqVzptsphzyP9lG7S
	 H7quKpkzbJwGA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Kirtikumar Anandrao Ramchandani <kirtiar15502@gmail.com>,
	syzbot+c8564fc0a96e3ecbe4d4@syzkaller.appspotmail.com,
	Mikulas Patocka <mpatocka@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y 3/3] dm cache: validate the discard block size before narrowing
Date: Thu, 26 Nov 2026 00:09:27 -0500
Message-ID: <20261126050921.2111286-3-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261126050921.2111286-1-sashal@kernel.org>
References: <2026112510-mandatory-improve-2cc3@gregkh>
 <20261126050921.2111286-1-sashal@kernel.org>
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
index d304e62fe2cc2..7d7bd25e27517 100644
--- a/drivers/md/dm-cache-target.c
+++ b/drivers/md/dm-cache-target.c
@@ -15,6 +15,7 @@
 #include <linux/jiffies.h>
 #include <linux/init.h>
 #include <linux/kstrtox.h>
+#include <linux/math64.h>
 #include <linux/mempool.h>
 #include <linux/module.h>
 #include <linux/rwsem.h>
@@ -2392,9 +2393,7 @@ static int create_cache_policy(struct cache *cache, struct cache_args *ca,
 static bool too_many_discard_blocks(sector_t discard_block_size,
 				    sector_t origin_size)
 {
-	(void) sector_div(origin_size, discard_block_size);
-
-	return origin_size > MAX_DISCARD_BLOCKS;
+	return div64_u64(origin_size, discard_block_size) > MAX_DISCARD_BLOCKS;
 }
 
 static sector_t calculate_discard_block_size(sector_t cache_block_size,
@@ -2431,6 +2430,7 @@ static int cache_create(struct cache_args *ca, struct cache **result)
 	struct cache *cache;
 	struct dm_target *ti = ca->ti;
 	dm_block_t origin_blocks;
+	sector_t discard_block_size;
 	struct dm_cache_metadata *cmd;
 	bool may_format = ca->features.mode == CM_WRITE;
 
@@ -2530,9 +2530,15 @@ static int cache_create(struct cache_args *ca, struct cache **result)
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

