Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795606371;
	b=jjogYSr9fTbz3FCwLpPdJU3Fh+rF17SjB5hhcPR57zMk45JZ1ficl78pA8o+MPOW3wBd
	 EanP5H6p2mLHvG3TySrKNwfaTxu+dp8BlCKzCxnoxJlRKkuWo27jBVKDgky4Y2LBrHFMl
	 9fBu3jqXCpPRA4fvBqfM8o5osLI3efcWMg9jF7wdk/GfWIl4nkIJffHb8fTgpwCcPLm9m
	 DvX5DMdjeicfxZxF/5E46/xUVIBxs7rzlYGCpGGoHxT2fIG+4vY2xeXvabricVfybgFvb
	 YPXjmS3owcRxy5u/7jqm5yG9O2SmMnvStBFX3bCiAvAA/VbJ2Lay5WMhxwNqzVR6bPg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795606371;
	h=Received:DKIM-Signature:Subject:To:Cc:From:Date:Message-ID:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=1sjF0ET4xnKt0e9vrfatV0immXjiSq2axiH1/76TVjc=;
	b=jJHoP6vG1qgwrYrBr4sQm0j06AAUmTE9u+3z025qeRJdoA+FGu8foubfRcKbuwQSaxHR
	 q8jAA49wI6vBdMA50Cjp4tuMQjz9X6C92wqNOiOfgUHZ/eI07mI7zTOJDQsM7GvCoJ/6y
	 AK9MXIG9NVtAX8P2FD+p/0zLau8+f0vdrNi4ANZ5cNaJaBVFimQJgldU7fufzN9IRkY7L
	 t9y9HJg8zK0swc8i+iLmeFv0Qy//KwadcbMmqms948cS72gn/hOWRRbopuHmMDmxC9jW7
	 3XFroblC1oi1HJeMptiyRoDatCtMfYI6MtMetfydStJSqnGH7Ls3enKQsCS2VD73CGQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=DbuUm9a+;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89491606A335
	for <stable@vger.kernel.org>; Wed, 25 Nov 2026 11:32:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=DbuUm9a+
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CA8CA1F000CF;
	Wed, 25 Nov 2026 11:32:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1795606371;
	bh=1sjF0ET4xnKt0e9vrfatV0immXjiSq2axiH1/76TVjc=;
	h=Subject:To:Cc:From:Date;
	b=DbuUm9a+lZHUwR6SEZWLoeiXBPrVFiaIG5uukICCza/agedmjf5NYoJ0Hn3f39Rwy
	 MDCiJu3gd9QQ8ld45fyNdyEguYTZy6jFWQRJVi6PntmDN4ND020OxhhxTaeY9hHV3V
	 lE+JBL92qp4kB0bRVC6KAWheFsIb23CGZgCb4Wxo=
Subject: FAILED: patch "[PATCH] dm cache: validate the discard block size before narrowing" failed to apply to 6.12-stable tree
To: kirtiar15502@gmail.com,mpatocka@redhat.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 25 Nov 2026 12:19:10 +0100
Message-ID: <2026112510-mama-skintight-d6f5@gregkh>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.12-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.12.y
git checkout FETCH_HEAD
git cherry-pick -x df8daa4d916c88ef7888c738e0eb3b6f11714a6f
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026112510-mama-skintight-d6f5@gregkh' --subject-prefix 'PATCH 6.12.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From df8daa4d916c88ef7888c738e0eb3b6f11714a6f Mon Sep 17 00:00:00 2001
From: Kirtikumar Anandrao Ramchandani <kirtiar15502@gmail.com>
Date: Thu, 5 Nov 2026 20:48:07 +0100
Subject: [PATCH] dm cache: validate the discard block size before narrowing

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

diff --git a/drivers/md/dm-cache-target.c b/drivers/md/dm-cache-target.c
index b562bf59124c..809184371629 100644
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
@@ -2383,9 +2384,7 @@ static int create_cache_policy(struct cache *cache, struct cache_args *ca,
 static bool too_many_discard_blocks(sector_t discard_block_size,
 				    sector_t origin_size)
 {
-	(void) sector_div(origin_size, discard_block_size);
-
-	return origin_size > MAX_DISCARD_BLOCKS;
+	return div64_u64(origin_size, discard_block_size) > MAX_DISCARD_BLOCKS;
 }
 
 static sector_t calculate_discard_block_size(sector_t cache_block_size,
@@ -2422,6 +2421,7 @@ static int cache_create(struct cache_args *ca, struct cache **result)
 	struct cache *cache;
 	struct dm_target *ti = ca->ti;
 	dm_block_t origin_blocks;
+	sector_t discard_block_size;
 	struct dm_cache_metadata *cmd;
 	bool may_format = ca->features.mode == CM_WRITE;
 
@@ -2521,9 +2521,15 @@ static int cache_create(struct cache_args *ca, struct cache **result)
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

