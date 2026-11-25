Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795606374;
	b=tQpNeg8WC+Krnxg8lzQaMy9VIxK4meyIInhOSVQ2eI1PjAjuGpH27MyPtMlzJsDThVPZ
	 Suhg7Y5wutIfIvigF0RM+GjtAIbFy4sug3x52J0uxwbHqcI0IO83/5CzYkVZJWCaLMreR
	 RrciU+myfdfFmuEIiw4kahUMNeWUipXcvTzl20eFGm2Js6M01Dc0Q1lRjaT60GfMRN1Df
	 3UuwHoNfuUvA9VzMVcd5apcYs2WHgaRjbXDhUBDls7fxskyUo4q2nr1zGevs7hADpM/98
	 qOvh3lE4RFuC3N2cF8ilQTNc8o48CW8MHgNFCJjp0xRzvyPgtIHWxB7xCH0ZfHtBPkA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795606374;
	h=Received:DKIM-Signature:Subject:To:Cc:From:Date:Message-ID:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=1RwLV8YV/IiSPknRKM5+oFnuIvfOAjfEoQKzu92j0f0=;
	b=FLiYDF2iAUewUGlpGboRJs1xDA6jR8g3JsD6QaQze1mZZ+l0arx+6xdj/4QeTaTPNc07
	 03X2Vu0NLry9nhhehN5JzruAT2tn2slSK6xZYRYhWHxBeI0jSEM/+FSkYwTiJh4xSG2Ai
	 5Dqrm7eYmqyTY8iHsdNeZxWnTXGu3ilmLTiYFSe8KVr/Fkv19F+ftsXi7c8i1hui+MHqI
	 XuJgOFsKsmEx6k4+PsM4ZJxOrqcS2iCEZcLpOBKxmlzu76fT2C+C+lHPe9L7lROkqoGEo
	 EhauDeqAgkrRLUu+hSyqfCFR6wC12qzrsNLaLBOdyaoWjILJyMplQiRnlE0rxkd5glg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=zfKgFgPc;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DC39606A32C
	for <stable@vger.kernel.org>; Wed, 25 Nov 2026 11:32:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=zfKgFgPc
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DFFB31F000CA;
	Wed, 25 Nov 2026 11:32:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1795606374;
	bh=1RwLV8YV/IiSPknRKM5+oFnuIvfOAjfEoQKzu92j0f0=;
	h=Subject:To:Cc:From:Date;
	b=zfKgFgPc9EefMn2TyvmgmIRZ2AAI/qqvRgo3rHIVm0aI7lwjRnrUlKBuDC340xd2f
	 FlKvWnl9Flk+pfqp2+GHUx2qmJ1rJ8OoxeRa/UPYy0Ja/UAjrIS3gtiScfw9sy4Rk6
	 mMs5YZfipMsr1ohWK+KUlzCfHc3qLeGU8mwIUJpw=
Subject: FAILED: patch "[PATCH] dm cache: validate the discard block size before narrowing" failed to apply to 5.10-stable tree
To: kirtiar15502@gmail.com,mpatocka@redhat.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 25 Nov 2026 12:19:11 +0100
Message-ID: <2026112511-raft-shadily-48b2@gregkh>
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


The patch below does not apply to the 5.10-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.10.y
git checkout FETCH_HEAD
git cherry-pick -x df8daa4d916c88ef7888c738e0eb3b6f11714a6f
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026112511-raft-shadily-48b2@gregkh' --subject-prefix 'PATCH 5.10.y' 'HEAD^..'

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

