Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794273749;
	b=UKmt6MnZb6fLyyMfkIHa12ecZ39NqT2YvTCGxo7O8w9zcn6IY/Fa7esVfKqOvBcjZwoK
	 dMANdrnGGv0LbKSig0cUOsJdlHvtba6LaZlyHuYMXiZeGuTf8q8SiDwhj6KAFSVmV0WNy
	 K8N7Jaq+kirkMniPWs+5A0ya9bYTeGPlr1RzXymRCs60BzS+H+gJcveA/KNoEngG3NfKb
	 MZ+39sfBknTYZgUt8N4qbBeUhv8zkOqx/l3eR3VS5POu/OziFRliEachNcn6rd6q+jYU8
	 FMF2K+Fm0kCBM1HMo6nHMmNsdokY/9Gr4lhT57aCzw8T7igfzdbukDr8QjG/tJiuMzA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794273749;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=V4ezBGrk1hrfoV9WUspCA2cE0It/YKXLaVfdZunerhg=;
	b=1eFAWo2vGcJnY0SlScYBbWpE4zdsnYYvnv94UwtXFs67o7uPL6EnynxNiwXI3xgGrX4c
	 vGk62Zsf1BrKkYhLJRfFK7nSjqVjIDAYBx8zD9VfRofZbS8X/DKJ7g8DEQ9baOdzfKvfI
	 MIDxrwWnSoRTXjJtb9DzUKRu21oGVbLCsDfAxZ3z0gG1cD4iVDfSi8ODO7h6Saz/+utMb
	 EuZvQ0VkXTtAXtMCNkKx8PSzxPURhoKLDooQABKnRVmay9KVfst2mq5qsi7Un1bYLfV7X
	 uQGEVQgpXiUrxAQTiJBYq0VZoKOrVPysRadg3A9iVzYHAxYArpAhOOO+xZrFpTMQDNA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Y2vibDQR;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 534B760A262B
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 01:22:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Y2vibDQR
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7ABC81F0089F;
	Tue, 10 Nov 2026 01:22:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794273749;
	bh=V4ezBGrk1hrfoV9WUspCA2cE0It/YKXLaVfdZunerhg=;
	h=From:To:Cc:Subject:Date;
	b=Y2vibDQRPt2xMq5FaZyNr7AyW13eLZDkXJsMT+CsU1V66z2EvxJ6ontxPX6Xx09C3
	 2ulMfq4O73OkjB8lRWlyzPK19DPxiyGBrRbbFBOzVA9vXT5ueyU/ql4rWUmzs8Mxch
	 8aorpc5z/O10NIRftFqjFNFThpAv72G7ybM8FKwbjDZQ6dIUB+07dVq9FEAG+L89U0
	 cirydPrBVsxdmhVDCaEZqlVZBFWLku0Fyd6IiI7Ok8/SC6r3StF9IUq/TE7EKrcEor
	 stD/f7XJ5Cp+H/MMnCrD4Ph6WURhrgyffqgQELHwTgSdJzAYWoStPbGrOlaRyjD57y
	 24xO3hBysHWCQ==
From: Sasha Levin <sashal@kernel.org>
To: joseph.qi@linux.alibaba.com,
	akpm@linux-foundation.org,
	heming.zhao@suse.com,
	mark@fasheh.com,
	jlbec@evilplan.org
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] ocfs2: do not read the entry array of an empty xattr bucket" failed to apply to 5.15-stable tree
Date: Mon,  9 Nov 2026 20:22:27 -0500
Message-ID: <20261109202227-failed-5.15-e8de099f2958@kernel.org>
X-Mailer: git-send-email 2.53.0
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The patch below does not apply to the 5.15-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.15.y
git checkout FETCH_HEAD
git cherry-pick -x e8de099f2958c84aa23186c5481e69f7ffd39355
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261109202227-failed-5.15-e8de099f2958@kernel.org' --subject-prefix 'PATCH 5.15.y' 'HEAD^..'

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From e8de099f2958c84aa23186c5481e69f7ffd39355 Mon Sep 17 00:00:00 2001
From: Joseph Qi <joseph.qi@linux.alibaba.com>
Date: Sat, 24 Oct 2026 23:10:10 +0800
Subject: [PATCH] ocfs2: do not read the entry array of an empty xattr bucket

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
---
 fs/ocfs2/xattr.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/fs/ocfs2/xattr.c b/fs/ocfs2/xattr.c
index 2c069029cef73..3a16b4a36d9ae 100644
--- a/fs/ocfs2/xattr.c
+++ b/fs/ocfs2/xattr.c
@@ -6061,11 +6061,20 @@ static int ocfs2_check_xattr_bucket_collision(struct ocfs2_xattr_bucket *bucket,
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




