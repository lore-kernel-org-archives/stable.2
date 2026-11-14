Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794639276;
	b=EldC9E4q3M5gPHsGLgjtLq7fgszOWXOt+J5F+VXLErDF9NxkqZTTdqA0GWXgH3RtG3kP
	 BT8/YyXeDI/uE05uSjCQV22bpDltv5s3QHohxuqN40dQUAy8i+At54j/NAnHcAvza16+A
	 WVGdtKOw8DX0L3LqnvXcn6mxFpuMHXU6c4NogS4fbKW6owjCURuTSxtw/GWckeGdgT1dh
	 bKZB9BEEFukNPJ+p0/ukyYDT5byn/X9/MxYxPRwV2hz2M3gOZSL7dks/YbnT5SkdpfmTW
	 3WcuQis3JF8eoxK/HvXk8jgLRqO9lZiGUAqgYrCjmQ3vaNZF6dMivoyZb4m7kNpiPnw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794639276;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=KU2DGHJTqeFJpefLhYFgosKs8k0dlsxDE/9ISFruxTI=;
	b=IGsNKxh52vprh2IxWtviyqmxLGZkS26xMZ1vFMaIiX23HohzVQY2QPJr+VZpKEOMqgnh
	 SGpVb0Cf1wqOr5+ztXSnf4b1yASbWhX90O6J2tR1p8ig88y7VOd/9vU2lqJn24GycthER
	 91CfI9t50ZvBdVeqZErbwxbQSglbQoK7uth//XjbKvpaxNm5Mre5/+7czMzA4Lxfch2xD
	 08A7L9a+FQkiOup2FJxN7cQv8ODC9ueuVwF1BnSyaHTvAe1VwBARIFf72Xde/YeDRTsI8
	 vRFl87fuf/uLKtcNPmyhgVhH3U2oaAikmBPctc0Tyj6OcOA9x/ZpYrb97Hll89bwEDg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dAcpHQCR;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2646E606A327
	for <stable@vger.kernel.org>; Sat, 14 Nov 2026 06:54:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dAcpHQCR
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 39A401F000C6;
	Sat, 14 Nov 2026 06:54:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794639276;
	bh=KU2DGHJTqeFJpefLhYFgosKs8k0dlsxDE/9ISFruxTI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=dAcpHQCR1FoC0RkP8N7TVLgGZNqZL5q/1MWoEYsTswlk0BBXNKFQVoe/zPUmIJAHU
	 eV14CCZvWaVnoXIcw9DcY+EMnXKh7B7hEQbvfsQsukIPSWryHJAi74qa5wbzsOHgXk
	 09zsnQohhOlktZLSVLbrCHo4bkYtN6rLHKgUM3avKhpS2aflAWQlXKQLI7y/ArnpMX
	 v/lcIvTqrQ23Qojv0/0bsJKQhoH4wzDNRfQyFiyJJf4QQpQPlTr9Ft++lnu8WyupuO
	 xkY9g8nAENGamlXvohGoZZCyixPWQT9iCmGOtgXQNnpOzCI1Z0GnCtLAQ4eSqZWqUZ
	 wvrIY4ooWmsTw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Joseph Qi <joseph.qi@linux.alibaba.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Heming Zhao <heming.zhao@suse.com>,
	Mark Fasheh <mark@fasheh.com>,
	Joel Becker <jlbec@evilplan.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y 2/2] ocfs2: do not read the entry array of an empty xattr bucket
Date: Sat, 14 Nov 2026 01:54:32 -0500
Message-ID: <20261114065240.3232541-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261114065240.3232541-1-sashal@kernel.org>
References: <20261109202227-failed-5.15-e8de099f2958@kernel.org>
 <20261114065240.3232541-1-sashal@kernel.org>
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

From: Joseph Qi <joseph.qi@linux.alibaba.com>

[ Upstream commit e8de099f2958c84aa23186c5481e69f7ffd39355 ]

ocfs2_check_xattr_bucket_collision() decides whether splitting a bucket
can make room by comparing the hash being inserted against the first and
the last entry.  xh_count comes off disk and is never checked, and a
bucket is allowed to hold no entries: ocfs2_xa_remove_entry() keeps the
last slot when it removes the only one, so that an empty bucket still
carries the hash it is keyed by.  xh_count then reads back as 0 while
xh_entries[0] is still meaningful, and the second comparison indexes
xh_entries[-1].

That is outside the __counted_by_le(xh_count) bounds of xh_entries[] and
lands on the header.  An entry is 16 bytes and xe_name_hash is its first
field, so the value read is xh_count | xh_free_start << 16.  It stays
inside the block, but the answer is arbitrary, and for an empty bucket
it says there is no collision, so a new bucket gets added on the
strength of it.

An empty bucket holds no entries to collide with.  Return before reading
the array.

One way to reach the test with an empty bucket is a set that removes the
bucket's only entry during cleanup and then fails for space again, since
it is that second -ENOSPC which calls this.  Growing a value past
OCFS2_XATTR_INLINE_SIZE is the easy route: the cluster allocation fails,
the "!orig_clusters" arm of ocfs2_xa_cleanup_value_truncate() removes
the entry, and although the "growing" caller does set ctxt->set_abort,
only ocfs2_xattr_block_set() and __ocfs2_xattr_set_handle() look at it,
so ocfs2_xattr_set_entry_index_block() goes straight on to the collision
check.

This sits on commit a9ea8b397864 ("ocfs2: use the stored hash when
checking xattr bucket collision"), which gave the collision check its two
argument form and is marked for 6.2 and later.  The read fixed here is
present in the three argument version too, but a tree without that
commit needs the hunk adapted by hand.

Link: https://lore.kernel.org/20261024151012.1059683-5-joseph.qi@linux.alibaba.com
Fixes: 012255961c9e ("ocfs2: Enable xattr set in index btree")
Signed-off-by: Joseph Qi <joseph.qi@linux.alibaba.com>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Cc: Heming Zhao <heming.zhao@suse.com>
Cc: Mark Fasheh <mark@fasheh.com>
Cc: Joel Becker <jlbec@evilplan.org>
Cc: <stable@vger.kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/ocfs2/xattr.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/fs/ocfs2/xattr.c b/fs/ocfs2/xattr.c
index fca9ed94ca17a..49b1b4e072ce3 100644
--- a/fs/ocfs2/xattr.c
+++ b/fs/ocfs2/xattr.c
@@ -5609,11 +5609,20 @@ static int ocfs2_check_xattr_bucket_collision(struct ocfs2_xattr_bucket *bucket,
 					      u32 name_hash)
 {
 	struct ocfs2_xattr_header *xh = bucket_xh(bucket);
+	u16 count = le16_to_cpu(xh->xh_count);
+
+	/*
+	 * An empty bucket keeps the hash of the entry that was removed in
+	 * xh_entries[0] so that it can still be found, but it holds no
+	 * entries to collide with.
+	 */
+	if (!count)
+		return 0;
 
 	if (name_hash != le32_to_cpu(xh->xh_entries[0].xe_name_hash))
 		return 0;
 
-	if (xh->xh_entries[le16_to_cpu(xh->xh_count) - 1].xe_name_hash ==
+	if (xh->xh_entries[count - 1].xe_name_hash ==
 	    xh->xh_entries[0].xe_name_hash) {
 		mlog(ML_ERROR, "Too much hash collision in xattr bucket %llu, "
 		     "hash = %u\n",
-- 
2.53.0

