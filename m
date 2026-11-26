Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795668977;
	b=S4ON+yoBaCyi7nx5uVm6eX0xwCjZXLoYRiYxscwUy6CfuUv3p607ZIFwJwRNy3Cp6qxj
	 rHVvgAdLx+m1FL6OV/rsw4qCeFl3x5pfRusddkp1y1yaVk4Kip0/4aQz/ozyIMjmmSedG
	 7oQQCPEaGI5oAvfzS0RSfoELbdIxF0NEK846ac+jzUUwVLBk7ocIT82rPH8/5i/2oRsh1
	 9VdO40vz+6HteIo7iMLgnb1WeOeXdlZhzj4C8W+Hbvln96rn+tlUd091oBHZGcWu6bZ2L
	 nMt2QIcv82Sq2n8QWQlj0zMEg5f8uXt1xRm0Zj3rq6zzDiY0N/9ttSeIKtnqIsLsNng==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795668977;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=FMBMWnZ8P/gkem0qUIw7royXb4EoETr1Zhd2TIl3o4s=;
	b=a6dPcurGaG6qy89g8tLFJhvjpkWsulMJiPVzpA8wOljEPeQPekvqNWU+JcjvmWKsAUyi
	 7tXTaFJUEgvnU0+ZLCvp9tLIPl8d0tMezV8mQ7TrH0hvVAf2Ihv3Qf0xPBFuYSP3O7pdf
	 0+PxzQkDivkVSPUcuU2s7rXdBGRQdJ41oXkKHS+/jyrNK6QlK2nS/IynEsiz/k+DiIYNV
	 EfNSuUoM2vDuW3sHDYTfWDx2RZTB50bhoO/9V1MSuSpoxt6lFFBEIHUahy2kshuu1/E7c
	 8+2vRtTkji76sOOqr9s7dDrGXFw1vFWlrKNeRK8/tjnydQMzSbDItQcPCveZFTHyRlA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=KJP8mixb;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35CA2606A31C
	for <stable@vger.kernel.org>; Thu, 26 Nov 2026 04:56:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=KJP8mixb
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C97561F000C0;
	Thu, 26 Nov 2026 04:56:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795668976;
	bh=FMBMWnZ8P/gkem0qUIw7royXb4EoETr1Zhd2TIl3o4s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=KJP8mixbKoPamigwMYCo+qh/WIWeJVscRCJ42N/7EOOJ4VhejnEPF6/JhmXAsvBdJ
	 HJCwl9P9e6N8LdbWn+id66575Iq80NBgNfUb5DFXtxQ+6BXzImGmflERqrtD1duoFy
	 g0gEyXS5t7wQlFS1QbjQgzYGWyzDxi3gIfS810SeVPmkIjpvjj8d2Ms+wIuJtYG5nQ
	 TQrrczenbP3nNzpTIMYW7oNjv9ACplceQ4f61ZVI6hmtRA/f22UNv85nYRrgdUARAe
	 lBGMu3xaIpWewVk4KTxUzaGC4rpVwZIMX3d4fG811JdGVFFbSbjCvkAYuOAIiWKR7P
	 UfM6oGcMs+9Xw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Kirtikumar Anandrao Ramchandani <kirtiar15502@gmail.com>,
	syzbot+c8564fc0a96e3ecbe4d4@syzkaller.appspotmail.com,
	Mikulas Patocka <mpatocka@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18.y 2/2] dm cache: validate the discard block size before narrowing
Date: Wed, 25 Nov 2026 23:56:12 -0500
Message-ID: <20261126045549.2060110-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261126045549.2060110-1-sashal@kernel.org>
References: <2026112509-relish-capitol-9ef2@gregkh>
 <20261126045549.2060110-1-sashal@kernel.org>
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
index 207dcefbfb636..949bf669a8884 100644
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

