Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B691D395AEB
	for <stable@vger.kernel.org>; Mon, 20 Jul 2026 20:19:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784578772; cv=none; b=XRL/QnOyt55wSuY5MErG3KMAFNVyMCAh3dLZEmEbEdHgCOoJ7kN82wSSj7QdScKLJAz08Pu8XY/jq7a/bf14O630L3F0BdYnohz8Cj2lDdCTtxS5ovghU2uKkNcLy3VVGrffqLvBE/QR7aqbvG+EYgxneYMC7x/OHTyLSWFlE/g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784578772; c=relaxed/simple;
	bh=+PNOeefwxTrAm6pZAr5Sq6708mYRphjGd6wrFoHaq04=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IWrTAUnp/ayACn9MRocP/5VXZDvMDroQFgnGqNvtQYfFTqqhnG6nBRZyn+t2nKZujs+wyZ6m7yV7uMIRxbp9gs5kxgnjzgRNE0v48hBSqZT0dOPqaW8265qk5/fc9Wczii1kHzfgcJyVR2BeVjNwtbhxagQeYoe1t6VNjBc5rik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nMFvxswZ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nMFvxswZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D50DC1F000E9;
	Mon, 20 Jul 2026 20:19:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784578770;
	bh=HCOrrmSvsm9gYc8MDNNG24qkGtboNA7h6dHvddQkayM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=nMFvxswZM6jPWwXIv8SkqdzW6D5qgKRPw9JVT3IyFAYmZbw4D9FztUpez9BXZnMQf
	 q9/p39v/4KerJ0q4Pykm2UEOfeRnW2kr02ZXJMm0pulGfUrb2mQNxbP6NTVBgEmhIY
	 NIlagagbHB5un7joO6DpSiHeNQ+9yr3Y0+2M+pHIiqOEi1Z9iFgGs3EhRMNgd1pKz9
	 /hXrqmkk1/x6DB3JTbCGc8Rwhdi/dEFlhMXWrkLBY0bDfNo0qBOlb6WtqTj+NZI+nV
	 FaxUT33TJO7M4eZQvswWNdBjIpH2s1MYWXMGkBj0MOKa3DS5m1uBkfM1gy+pslP7Dz
	 keho6zQme5HPQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Qu Wenruo <wqu@suse.com>,
	Boris Burkov <boris@bur.io>,
	David Sterba <dsterba@suse.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y] btrfs: fix false IO failure after falling back to buffered write
Date: Mon, 20 Jul 2026 16:19:28 -0400
Message-ID: <20260720201928.3242739-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026071554-dealer-linseed-4119@gregkh>
References: <2026071554-dealer-linseed-4119@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Qu Wenruo <wqu@suse.com>

[ Upstream commit 66ff4d366e7eb4d31813d2acabf3af512ce03aa5 ]

[BUG]
The test case generic/362 will fail with "nodatasum" mount option (*):

 MOUNT_OPTIONS -- -o nodatasum /dev/mapper/test-scratch1 /mnt/scratch

 generic/362  0s ... - output mismatch (see /home/adam/xfstests/results//generic/362.out.bad)
    --- tests/generic/362.out	2024-08-24 15:31:37.200000000 +0930
    +++ /home/adam/xfstests/results//generic/362.out.bad	2026-05-27 10:21:17.574771567 +0930
    @@ -1,2 +1,3 @@
     QA output created by 362
    +First write failed: Input/output error
     Silence is golden
    ...

*: If the test case has been executed before with default data checksum,
the failure will not reproduce. Need the following fix to make it
reliably reproducible:
https://lore.kernel.org/linux-btrfs/20260528111659.87113-1-wqu@suse.com/

[CAUSE]
Inside __iomap_dio_rw(), the -EFAULT/-ENOTBLK error is not directly returned.
Thus we never got an error pointer from __iomap_dio_rw().

The call chain looks like this:

 btrfs_direct_write()
 |- btrfs_dio_write()
 |-  __iomap_dio_rw()
 |  |- iomap_iter()
 |  |  |- btrfs_dio_iomap_begin()
 |  |     Now an ordered extent is allocated for the 4K write.
 |  |
 |  |- iomi.status = iomap_dio_iter()
 |  |  Where iomap_dio_iter() returned -EFAULT.
 |  |
 |  |- ret = iomap_iter()
 |  |  |- btrfs_dio_iomap_end()
 |  |  |  |- btrfs_finish_ordered_extent(uptodate = false)
 |  |  |  |  |- can_finish_ordered_extent()
 |  |  |  |     |- btrfs_mark_ordered_extent_error()
 |  |  |  |        |- mapping_set_error()
 |  |  |  |           Now the address space is marked error.
 |  |  |  | return -ENOTBLK
 |  |  |- return -ENOTBLK
 |  |- if (ret == -ENOTBLK) { ret = 0; }
 |     Now the return value is reset to 0.
 |     Thus no error pointer will be returned.
 |
 |- ret = iomap_dio_complete()
 |  Since no byte is submitted, @ret is 0.
 |
 |- Fallback to buffered IO
 |  And the buffered write finished without error
 |
 |- filemap_fdatawait_range()
    |- filemap_check_errors()
       The previous error is recorded, thus an error is returned

However the buffered write is properly submitted and finished, the error
is from the btrfs_finish_ordered_extent() call with @uptodate = false.

[FIX]
When a short dio write happened, any range that is submitted will have
btrfs_extract_ordered_extent() to be called, thus the submitted range
will always have an OE just covering the submitted range.

The remaining OE range is never submitted, thus they should be treated
as truncated, not an error. So that we can properly reclaim and not
insert an unnecessary file extent item, without marking the mapping as
error.

Extract a helper, btrfs_mark_ordered_extent_truncated(), and utilize
that helper to mark the direct IO ordered extent as truncated, so it
won't cause failure for the later buffered fallback.

[REASON FOR NO FIXES TAG]
The bug itself is pretty old, at commit f85781fb505e ("btrfs: switch to
iomap for direct IO") we're already passing @uptodate=false finishing
the OE.
But at that time OE with IOERR won't call mapping_set_error(), so it's
not exposed.
Later commit d61bec08b904 ("btrfs: mark ordered extent and inode with
error if we fail to finish") finally exposed the bug, but that commit
is doing a correct job, not the root cause.

Anyway the bug is very old, dating back to 5.1x days, thus only CC to
stable.

CC: stable@vger.kernel.org # 5.15+
Reviewed-by: Boris Burkov <boris@bur.io>
Signed-off-by: Qu Wenruo <wqu@suse.com>
Signed-off-by: David Sterba <dsterba@suse.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/btrfs/inode.c        | 34 ++++++++++++++++++++++++++--------
 fs/btrfs/ordered-data.c | 13 +++++++++++++
 fs/btrfs/ordered-data.h |  2 ++
 3 files changed, 41 insertions(+), 8 deletions(-)

diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 62cf96fa12f239..6b08ee4aa4edba 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -8207,12 +8207,34 @@ static int btrfs_dio_iomap_end(struct inode *inode, loff_t pos, loff_t length,
 	if (submitted < length) {
 		pos += submitted;
 		length -= submitted;
-		if (write)
+		if (write) {
+			struct btrfs_ordered_extent *ordered;
+
+			/*
+			 * We have a short write. Any range that was properly
+			 * submitted will be finished through the bio
+			 * completion path with an uptodate status matching
+			 * the bio status.
+			 *
+			 * The remaining range was never submitted, so mark
+			 * it as truncated and finish it without an error, so
+			 * the extent is reclaimed without inserting a file
+			 * extent item for it and without marking the mapping
+			 * as failed, which would make a later buffered write
+			 * fallback fail with a false -EIO.
+			 */
+			ordered = btrfs_lookup_ordered_extent(BTRFS_I(inode),
+							      pos);
+			ASSERT(ordered);
+			btrfs_mark_ordered_extent_truncated(ordered,
+					pos - ordered->file_offset);
+			btrfs_put_ordered_extent(ordered);
 			__endio_write_update_ordered(BTRFS_I(inode), pos,
-					length, false);
-		else
+					length, true);
+		} else {
 			unlock_extent(&BTRFS_I(inode)->io_tree, pos,
 				      pos + length - 1);
+		}
 		ret = -ENOTBLK;
 	}
 
@@ -8839,11 +8861,7 @@ static void btrfs_invalidatepage(struct page *page, unsigned int offset,
 					 EXTENT_LOCKED | EXTENT_DO_ACCOUNTING |
 					 EXTENT_DEFRAG, 1, 0, &cached_state);
 
-		spin_lock_irq(&inode->ordered_tree.lock);
-		set_bit(BTRFS_ORDERED_TRUNCATED, &ordered->flags);
-		ordered->truncated_len = min(ordered->truncated_len,
-					     cur - ordered->file_offset);
-		spin_unlock_irq(&inode->ordered_tree.lock);
+		btrfs_mark_ordered_extent_truncated(ordered, cur - ordered->file_offset);
 
 		if (btrfs_dec_test_ordered_pending(inode, &ordered,
 						   cur, range_end + 1 - cur)) {
diff --git a/fs/btrfs/ordered-data.c b/fs/btrfs/ordered-data.c
index 6b51fd2ec5ac53..32c9afee334889 100644
--- a/fs/btrfs/ordered-data.c
+++ b/fs/btrfs/ordered-data.c
@@ -298,6 +298,19 @@ void btrfs_add_ordered_sum(struct btrfs_ordered_extent *entry,
 	spin_unlock_irq(&tree->lock);
 }
 
+void btrfs_mark_ordered_extent_truncated(struct btrfs_ordered_extent *ordered,
+					 u64 truncate_len)
+{
+	struct btrfs_ordered_inode_tree *tree;
+
+	tree = &BTRFS_I(ordered->inode)->ordered_tree;
+	ASSERT(truncate_len <= ordered->num_bytes);
+	spin_lock_irq(&tree->lock);
+	set_bit(BTRFS_ORDERED_TRUNCATED, &ordered->flags);
+	ordered->truncated_len = min(ordered->truncated_len, truncate_len);
+	spin_unlock_irq(&tree->lock);
+}
+
 /*
  * Mark all ordered extents io inside the specified range finished.
  *
diff --git a/fs/btrfs/ordered-data.h b/fs/btrfs/ordered-data.h
index 4194e960ff6177..ba6a4d6a5a6637 100644
--- a/fs/btrfs/ordered-data.h
+++ b/fs/btrfs/ordered-data.h
@@ -212,6 +212,8 @@ void btrfs_lock_and_flush_ordered_range(struct btrfs_inode *inode, u64 start,
 					struct extent_state **cached_state);
 int btrfs_split_ordered_extent(struct btrfs_ordered_extent *ordered, u64 pre,
 			       u64 post);
+void btrfs_mark_ordered_extent_truncated(struct btrfs_ordered_extent *ordered,
+					 u64 truncate_len);
 int __init ordered_data_init(void);
 void __cold ordered_data_exit(void);
 
-- 
2.53.0

