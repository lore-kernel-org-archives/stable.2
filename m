Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D011847887A
	for <stable@vger.kernel.org>; Mon, 20 Jul 2026 18:08:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784570936; cv=none; b=L+Vrn4sPe9qmZ4YrsDHRo3Tk1+p7q/T27trtfJdi44hoBC4pxihLZUHZYeAtLeYQQaSMg3EfO1TRCVJGYkVoeQ4xwih6lFN3PpbwbpVofOWXxuSiW9pNVzuQA+IA9d5AagsJzXfJ0cDdG9DGlJn4ilO2qitgKTCIhh+2Et49K3A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784570936; c=relaxed/simple;
	bh=zSXa+pCkSk/Ionsos253Rt2f04Pu9dtgKdtKWBiOa4I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=R91cO+qlnYuMabTcljqOd7iDukVVNsv6SufE5yLE3c2MnR9FYLNqC1VoQhDKU6ItE1yhNVSd07gTH/lZsP0Awk5gPHUnqKxLTa7yb0srnZxcCCvu/0pT+c9wvTRwwlFzW2K8rNTjRj+RZnAsuYUpDPLWIrUqXVQ+NoPWkwSSZoY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aAgmImMF; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aAgmImMF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2ED661F000E9;
	Mon, 20 Jul 2026 18:08:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784570934;
	bh=UPbGKax7MfVpww0arV2yQH2KUgP4o6wXPSvz8dWa7fM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=aAgmImMFhRkTxHq9Soe8SxOrBlumI3uPc8nWWgj12Tzj+L/+Y4/wtodlW7hN++7e5
	 uBonOr8dPxJPQQaGYzp8DX6sdEsnaPqwhw4NKLvbM2KP0/q6lL7RDFpSLUFTv7aHlT
	 WOcNKSrYMkzqdG1vR/nTKAAF/09fwKdiIJ7xuedBkg5nr2eKb+2P/+TiKeItnSSNzQ
	 v4lWugpXMboQMz2nkN0aSF4hUAUA8agovMeAk2eytH2Yk4BWkkDEFzkYe06z19qTft
	 KaM8lL77mlr0qMaWqVtYQWRd1lqR4mM/pMNfLOy67KHVxFiMSbOWwtmEcnw+6CK5ui
	 6wpsoVMjd3Byw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Qu Wenruo <wqu@suse.com>,
	Boris Burkov <boris@bur.io>,
	David Sterba <dsterba@suse.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y] btrfs: fix false IO failure after falling back to buffered write
Date: Mon, 20 Jul 2026 14:08:52 -0400
Message-ID: <20260720180852.2923422-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026071553-happening-gusty-dbf1@gregkh>
References: <2026071553-happening-gusty-dbf1@gregkh>
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
 fs/btrfs/inode.c        | 33 +++++++++++++++++++++++++--------
 fs/btrfs/ordered-data.c | 12 ++++++++++++
 fs/btrfs/ordered-data.h |  2 ++
 3 files changed, 39 insertions(+), 8 deletions(-)

diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 577f7e2895b66a..758a1ce83cf749 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -7987,12 +7987,33 @@ static int btrfs_dio_iomap_end(struct inode *inode, loff_t pos, loff_t length,
 	if (submitted < length) {
 		pos += submitted;
 		length -= submitted;
-		if (write)
+		if (write) {
+			struct btrfs_ordered_extent *ordered;
+
+			/*
+			 * We have a short write, and the ordered extent is
+			 * not split at submission time on this tree, so it
+			 * may cover both the submitted range and the range
+			 * that was never submitted.
+			 *
+			 * Truncate the ordered extent to the part that was
+			 * submitted properly, so the never submitted range
+			 * is reclaimed without inserting a file extent item
+			 * for it and without marking it as an IO error.
+			 */
+			ordered = btrfs_lookup_ordered_extent(BTRFS_I(inode),
+							      pos);
+			if (ordered) {
+				btrfs_mark_ordered_extent_truncated(ordered,
+						pos - ordered->file_offset);
+				btrfs_put_ordered_extent(ordered);
+			}
 			btrfs_mark_ordered_io_finished(BTRFS_I(inode), NULL,
-						       pos, length, false);
-		else
+						       pos, length, true);
+		} else {
 			unlock_extent(&BTRFS_I(inode)->io_tree, pos,
 				      pos + length - 1, NULL);
+		}
 		ret = -ENOTBLK;
 	}
 
@@ -8516,11 +8537,7 @@ static void btrfs_invalidate_folio(struct folio *folio, size_t offset,
 					 EXTENT_LOCKED | EXTENT_DO_ACCOUNTING |
 					 EXTENT_DEFRAG, &cached_state);
 
-		spin_lock_irq(&inode->ordered_tree.lock);
-		set_bit(BTRFS_ORDERED_TRUNCATED, &ordered->flags);
-		ordered->truncated_len = min(ordered->truncated_len,
-					     cur - ordered->file_offset);
-		spin_unlock_irq(&inode->ordered_tree.lock);
+		btrfs_mark_ordered_extent_truncated(ordered, cur - ordered->file_offset);
 
 		/*
 		 * If the ordered extent has finished, we're safe to delete all
diff --git a/fs/btrfs/ordered-data.c b/fs/btrfs/ordered-data.c
index 69fd4f9d840b56..a9f44de06decf8 100644
--- a/fs/btrfs/ordered-data.c
+++ b/fs/btrfs/ordered-data.c
@@ -279,6 +279,18 @@ void btrfs_add_ordered_sum(struct btrfs_ordered_extent *entry,
 	spin_unlock_irq(&tree->lock);
 }
 
+void btrfs_mark_ordered_extent_truncated(struct btrfs_ordered_extent *ordered,
+					 u64 truncate_len)
+{
+	struct btrfs_inode *inode = BTRFS_I(ordered->inode);
+
+	ASSERT(truncate_len <= ordered->num_bytes);
+	spin_lock_irq(&inode->ordered_tree.lock);
+	set_bit(BTRFS_ORDERED_TRUNCATED, &ordered->flags);
+	ordered->truncated_len = min(ordered->truncated_len, truncate_len);
+	spin_unlock_irq(&inode->ordered_tree.lock);
+}
+
 static void finish_ordered_fn(struct btrfs_work *work)
 {
 	struct btrfs_ordered_extent *ordered_extent;
diff --git a/fs/btrfs/ordered-data.h b/fs/btrfs/ordered-data.h
index cc3ca4bb9bd542..9bb82aa5a2e462 100644
--- a/fs/btrfs/ordered-data.h
+++ b/fs/btrfs/ordered-data.h
@@ -209,6 +209,8 @@ void btrfs_lock_and_flush_ordered_range(struct btrfs_inode *inode, u64 start,
 bool btrfs_try_lock_ordered_range(struct btrfs_inode *inode, u64 start, u64 end);
 int btrfs_split_ordered_extent(struct btrfs_ordered_extent *ordered, u64 pre,
 			       u64 post);
+void btrfs_mark_ordered_extent_truncated(struct btrfs_ordered_extent *ordered,
+					 u64 truncate_len);
 int __init ordered_data_init(void);
 void __cold ordered_data_exit(void);
 
-- 
2.53.0

