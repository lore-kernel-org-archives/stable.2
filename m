Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA5CF3BB13D
	for <stable@vger.kernel.org>; Mon, 20 Jul 2026 20:19:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784578752; cv=none; b=pVP1Vw2eFVyXhC6IjrdlliQvFw6X0/YHlD78Yg5m5Py/EuC7/de3kc0gzp/fzS+UmJ8pikdc4ZN7qZRsnebSAgPsEBKDEWQQMywfziKNNl844hROIgx5UPemO9miqc3dO1SxvaPnrlqMqlWp0kuqjCF5koJvG1IWgkUh16W5TUc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784578752; c=relaxed/simple;
	bh=vhwFzdRMJJF9WzFdeoM59VKwYLiPnBySTrRh4t0Xtto=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=shoVc9e7AaSCAsTsynvsLSZLdaByYpvUxjq2KvawT9XSXneFF31mLLRQWXtZNaM/igEiRFcYOSkpakLAR5Sze3PMdQ9NI1D87/cu8CFz4rCmBxC5Su+iyFN56a7aGUHOhTKuhuY8gxyhyCHWtW3wKU4F1qCG3xaVeXJxtkhWwZg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lPm7u8nY; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lPm7u8nY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2ED221F00A3A;
	Mon, 20 Jul 2026 20:19:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784578750;
	bh=xve8Zniihxpy235f4Bg1Dnk7KF+2r2E5XSBU4R+CNHU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=lPm7u8nYAGoKyAgGDjDv+Nz7vexeogVa6Hj47xK8ld6SIOmYOjJZDA9UaNJY2e+1e
	 VnHKvjENE3M/qrt6qVg6Mjpb8RvnIVb8rCA0n00/nRLacM0TzeDhQjt4M6iyQzpvc6
	 qu7Tqlppn3mmxuQhb3x5lG+PNQmIdyAPxevKwejcrfY8aj2w0D3Fzwrf1mVvDZzy9C
	 Gh2wWBCtKOb5aDJbiXzs7A1BEgp/E9RWIHwrzRJSIApW1zVsw+X6f8ZO0jpYfDzjHT
	 1KdQftOFtQk+Rr4aB5CediPy3vAwPdQ+myGKkHK/phtbjk/mhJx4ffzJG6Hv2moeBe
	 HESznz3A2C6Hg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Qu Wenruo <wqu@suse.com>,
	Boris Burkov <boris@bur.io>,
	David Sterba <dsterba@suse.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y 2/2] btrfs: fix incorrect buffered IO fallback for append direct writes
Date: Mon, 20 Jul 2026 16:19:07 -0400
Message-ID: <20260720201907.3240613-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260720201907.3240613-1-sashal@kernel.org>
References: <2026071510-legend-handled-035f@gregkh>
 <20260720201907.3240613-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Qu Wenruo <wqu@suse.com>

[ Upstream commit ff66fe6662330226b3f486014c375538d91c44aa ]

[BUG]
With the previous bug of short direct writes fixed, test case
generic/362 (*) still fails with the following error with nodatasum
mount option:

 generic/362  0s ... - output mismatch (see /home/adam/xfstests/results//generic/362.out.bad)
 - output mismatch (see /home/adam/xfstests/results//generic/362.out.bad)
    --- tests/generic/362.out	2024-08-24 15:31:37.200000000 +0930
    +++ /home/adam/xfstests/results//generic/362.out.bad	2026-05-27 10:13:09.072485767 +0930
    @@ -1,2 +1,3 @@
     QA output created by 362
    +Wrong file size after first write, got 8192 expected 4096
     Silence is golden
    ...

*: If the test case has been executed before with default data checksum,
the failure will not reproduce. Need the following fix to make it
reliably reproducible:
https://lore.kernel.org/linux-btrfs/20260528111659.87113-1-wqu@suse.com/

[CAUSE]
Inside btrfs_dio_iomap_begin() for a direct write, we increase the isize
if it's beyond the current isize.

But if the direct io finished short, we do not revert the isize to the
previous value nor to the short write end.

Then if we need to fall back to buffered writes, and the write has
IOCB_APPEND flag, then the buffered write will be positioned at the
incorrect isize.

The call chain looks like this:

 btrfs_direct_write(pos=0, length=4K)
 |- __iomap_dio_rw()
 |  |- iomap_iter()
 |  |  |- btrfs_dio_iomap_begin()
 |  |     |- btrfs_get_blocks_direct_write()
 |  |        |- i_size_write()
 |  |           Which updates the isize to the write end (4K).
 |  |
 |  |- iomap_dio_iter()
 |  |  Failed with -EFAULT on the first page.
 |  |
 |  |- iomap_iter()
 |  |  |- btrfs_dio_iomap_end()
 |  |     Detects a short write, return -ENOTBLK
 |  |- if (ret == -ENOTBLK) { ret = 0;}
 |     Which resets the return value.
 |
 |- ret = iomap_dio_complet()
 |  Which returns 0.
 |
 |- btrfs_buffered_write(iocb, from);
    |- generic_write_checks()
       |- iocb->ki_pos = i_size_read()
          Which is still the new size (4K), other than the original
	  isize 0.

[FIX]
Introduce the following btrfs_dio_data members:

- old_isize

- updated_isize
  If the direct write has enlarged the isize.

Then if we got a short write, and btrfs_dio_data::updated_isize is set,
revert to the correct isize based on old_isize and current file
position.

And here we call i_size_write() without holding an extent lock, which is
a very special case that we're safe to do:

 - Only a single writer can be enlarging isize
   Enlarging isize will take the exclusive inode lock.

 - Buffered readers need to wait for the OE we're holding
   Buffered readers will lock extent and wait for OE of the folio range.
   Sometimes we can skip the OE wait, but since all page cache is
   invalidated, the OE wait can not be skipped.

But I do not think this is the most elegant solution, nor covers all
cases. E.g. if the bio is submitted but IO failed, we are unable to do
the revert.

I believe the more elegant one would be extend the EXTENT_DIO_LOCKED
lifespan for direct writes, so that we can update the isize when a
write beyond EOF finished successfully.

However that change is too huge for a small bug fix.
So only implement the minimal partial fix for now.

[REASON FOR NO FIXES TAG]
The bug is again very old, before commit f85781fb505e ("btrfs: switch to
iomap for direct IO") we are already increasing isize without a
proper rollback for short writes.

Thus only a CC to stable.

CC: stable@vger.kernel.org # 5.15+
Reviewed-by: Boris Burkov <boris@bur.io>
Signed-off-by: Qu Wenruo <wqu@suse.com>
Signed-off-by: David Sterba <dsterba@suse.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/btrfs/inode.c | 43 ++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 42 insertions(+), 1 deletion(-)

diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 758a1ce83cf749..45b4ca6f281adc 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -63,9 +63,11 @@ struct btrfs_iget_args {
 
 struct btrfs_dio_data {
 	ssize_t submitted;
+	loff_t old_isize;
 	struct extent_changeset *data_reserved;
 	bool data_space_reserved;
 	bool nocow_done;
+	bool updated_isize;
 };
 
 struct btrfs_dio_private {
@@ -7591,6 +7593,7 @@ static int btrfs_get_blocks_direct_write(struct extent_map **map,
 	bool space_reserved = false;
 	u64 len = *lenp;
 	u64 prev_len;
+	loff_t old_isize;
 	int ret = 0;
 
 	/*
@@ -7706,8 +7709,14 @@ static int btrfs_get_blocks_direct_write(struct extent_map **map,
 	 * Need to update the i_size under the extent lock so buffered
 	 * readers will get the updated i_size when we unlock.
 	 */
-	if (start + len > i_size_read(inode))
+	old_isize = i_size_read(inode);
+	if (start + len > old_isize) {
+		if (!dio_data->updated_isize) {
+			dio_data->old_isize = old_isize;
+			dio_data->updated_isize = true;
+		}
 		i_size_write(inode, start + len);
+	}
 out:
 	if (ret && space_reserved) {
 		btrfs_delalloc_release_extents(BTRFS_I(inode), len);
@@ -7990,6 +7999,38 @@ static int btrfs_dio_iomap_end(struct inode *inode, loff_t pos, loff_t length,
 		if (write) {
 			struct btrfs_ordered_extent *ordered;
 
+			/*
+			 * Got a short write and have updated the isize, need to
+			 * revert the isize change.
+			 *
+			 * Normally we need to update isize with extent lock hold,
+			 * but we're safe due to the following factors:
+			 *
+			 * - Only a single writer can be enlarging isize
+			 *   Enlarging isize will take the exclusive inode lock.
+			 *
+			 * - Buffered readers need to wait for the OE we're holding
+			 *   Buffered readers will lock extent and wait for OE
+			 *   of the folio range, and since page cache is invalidated
+			 *   the OE wait can not be skipped.
+			 *
+			 * So here we are safe to revert the isize before
+			 * finishing the OE, and no reader of the remaining range
+			 * can see the enlarged size.
+			 *
+			 * TODO: Extend the DIO_LOCKED lifespan for direct writes,
+			 * and only enlarge isize after a successful write.
+			 */
+			if (dio_data->updated_isize) {
+				u64 new_isize;
+
+				if (submitted == 0)
+					new_isize = dio_data->old_isize;
+				else
+					new_isize = max(dio_data->old_isize, pos);
+				i_size_write(inode, new_isize);
+				dio_data->updated_isize = false;
+			}
 			/*
 			 * We have a short write, and the ordered extent is
 			 * not split at submission time on this tree, so it
-- 
2.53.0

