Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05E07425868
	for <stable@vger.kernel.org>; Mon, 20 Jul 2026 15:56:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784563001; cv=none; b=aMK1n5K4Qk3UCYY3CswGrkX5qQpNG68qBNPqzC4IwySqK2Mh6QU4QDzZoP/lvCgSxgSgbLq6tuVIeGDUAsHJmFfNT+ZIf8HBq65kYH5BLfIeTgVpa6vKmXNTBgBgIJn3ar0rhq+0ZZ+eXvBFAA8pczpI2nO7nWRpxcsYM3lheAs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784563001; c=relaxed/simple;
	bh=tpL4Jy1GsxJNTANk9GP9WJFqm65jbpnV+aCpm7VulcQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SLvY7I4rnrv22FsaPYxIwKb+ufve8s7y7bMhofv+SJaSi0J4HuKydrmWEx66IghQO5Fb4/zRVeqOt03VGaY7V3MUrah3MgsvdCEKWSc392e9FfU0lLPcr/7HXvX8nfJ7yPHF6UPhDLh2je2QZ1np37zX9OZ1WryjYZ0jnOBZWQU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nQ8+Baht; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nQ8+Baht"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5BEF31F00A3D;
	Mon, 20 Jul 2026 15:56:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784562999;
	bh=JpA0omac3BW6r/UQRiXt/biCbytUpAQHui1Q3h2zffw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=nQ8+Baht4x2fgEU/czRgEn+zQO6dX2+lQvqWuv9/37tN9pg8/PWYqVDExCHoDGKmn
	 soieqPbgrdUBF4bX8bDL7VXEJ6F+AfBeKjkOzv/D2xYd1iDxocb2CmKHgHQbOB0lnt
	 4O+qfQ3RzEAXTM9WJK6nAx7a+G73dvQNZZ2b7cFXJbQXIGEZeMniQ9yy0hyop8YfOk
	 GDmwdtzLMx/pPpSanFk/4WAeCaVqPD3lrWN+TOKCK4/1p/W1DjAdtKuRhxSEWGO8Nz
	 FyY2qSkvZGYdlexAEhvU7K9dKbYHiW/9KWcAV5mK60l2+aorSg0/eB2b/krCPs4r7q
	 BR+tV922OnBYw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Qu Wenruo <wqu@suse.com>,
	Boris Burkov <boris@bur.io>,
	David Sterba <dsterba@suse.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y 4/4] btrfs: fix false IO failure after falling back to buffered write
Date: Mon, 20 Jul 2026 11:56:35 -0400
Message-ID: <20260720155635.2425597-4-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260720155635.2425597-1-sashal@kernel.org>
References: <2026071553-kite-shadow-2c30@gregkh>
 <20260720155635.2425597-1-sashal@kernel.org>
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
 fs/btrfs/direct-io.c    | 17 ++++++++++++++---
 fs/btrfs/inode.c        |  6 +-----
 fs/btrfs/ordered-data.c | 12 ++++++++++++
 fs/btrfs/ordered-data.h |  2 ++
 4 files changed, 29 insertions(+), 8 deletions(-)

diff --git a/fs/btrfs/direct-io.c b/fs/btrfs/direct-io.c
index fae5e005da45a5..ccdfc6b67038a3 100644
--- a/fs/btrfs/direct-io.c
+++ b/fs/btrfs/direct-io.c
@@ -623,12 +623,23 @@ static int btrfs_dio_iomap_end(struct inode *inode, loff_t pos, loff_t length,
 	if (submitted < length) {
 		pos += submitted;
 		length -= submitted;
-		if (write)
+		if (write) {
+			/*
+			 * We have a short write, if there is any range
+			 * that is submitted properly, that part will have
+			 * its own OE split from the original one.
+			 *
+			 * So for the OE at dio_data->ordered, it's the part
+			 * that is not submitted, and should be marked
+			 * as fully truncated.
+			 */
+			btrfs_mark_ordered_extent_truncated(dio_data->ordered, 0);
 			btrfs_finish_ordered_extent(dio_data->ordered,
-						    pos, length, false);
-		else
+						    pos, length, true);
+		} else {
 			unlock_dio_extent(&BTRFS_I(inode)->io_tree, pos,
 					  pos + length - 1, NULL);
+		}
 		ret = -ENOTBLK;
 	}
 	if (write) {
diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 3f5312b1823afb..8bbb054c38fe78 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -7532,11 +7532,7 @@ static void btrfs_invalidate_folio(struct folio *folio, size_t offset,
 					 EXTENT_LOCKED | EXTENT_DO_ACCOUNTING |
 					 EXTENT_DEFRAG, &cached_state);
 
-		spin_lock_irq(&inode->ordered_tree_lock);
-		set_bit(BTRFS_ORDERED_TRUNCATED, &ordered->flags);
-		ordered->truncated_len = min(ordered->truncated_len,
-					     cur - ordered->file_offset);
-		spin_unlock_irq(&inode->ordered_tree_lock);
+		btrfs_mark_ordered_extent_truncated(ordered, cur - ordered->file_offset);
 
 		/*
 		 * If the ordered extent has finished, we're safe to delete all
diff --git a/fs/btrfs/ordered-data.c b/fs/btrfs/ordered-data.c
index c7901fb167db79..692f03803da9eb 100644
--- a/fs/btrfs/ordered-data.c
+++ b/fs/btrfs/ordered-data.c
@@ -329,6 +329,18 @@ void btrfs_mark_ordered_extent_error(struct btrfs_ordered_extent *ordered)
 		mapping_set_error(ordered->inode->vfs_inode.i_mapping, -EIO);
 }
 
+void btrfs_mark_ordered_extent_truncated(struct btrfs_ordered_extent *ordered,
+					 u64 truncate_len)
+{
+	struct btrfs_inode *inode = ordered->inode;
+
+	ASSERT(truncate_len <= ordered->num_bytes);
+	spin_lock_irq(&inode->ordered_tree_lock);
+	set_bit(BTRFS_ORDERED_TRUNCATED, &ordered->flags);
+	ordered->truncated_len = min(ordered->truncated_len, truncate_len);
+	spin_unlock_irq(&inode->ordered_tree_lock);
+}
+
 static void finish_ordered_fn(struct btrfs_work *work)
 {
 	struct btrfs_ordered_extent *ordered_extent;
diff --git a/fs/btrfs/ordered-data.h b/fs/btrfs/ordered-data.h
index cbfac6044dfb6a..a1a9f8d46e10e2 100644
--- a/fs/btrfs/ordered-data.h
+++ b/fs/btrfs/ordered-data.h
@@ -213,6 +213,8 @@ bool btrfs_try_lock_ordered_range(struct btrfs_inode *inode, u64 start, u64 end,
 struct btrfs_ordered_extent *btrfs_split_ordered_extent(
 			struct btrfs_ordered_extent *ordered, u64 len);
 void btrfs_mark_ordered_extent_error(struct btrfs_ordered_extent *ordered);
+void btrfs_mark_ordered_extent_truncated(struct btrfs_ordered_extent *ordered,
+					 u64 truncate_len);
 int __init ordered_data_init(void);
 void __cold ordered_data_exit(void);
 
-- 
2.53.0

