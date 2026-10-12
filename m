Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2809548F84D
	for <stable@vger.kernel.org>; Mon, 12 Oct 2026 15:18:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791818315; cv=none; b=dM0sKUyci4LhWiNmMx3We2VEG99sbox8y2Jrh7w8EiHZSwKOl/1lTBu1AB4r77kdiL3k0QHRJu25Rsq5905qTDOp4IxZ7PHUhrbpirdSkUNJRBGB66GJWK6yltxvJJQILyTo77LABm6UhpTmoMYRxnKCTKoy1LtPjNuCa3Gw/bk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791818315; c=relaxed/simple;
	bh=r60teC3ctLAH0vu7SmgkUmTkEPTPB1+Rpb41cYdZq0U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=paDQwAJv+VJVnBdnsXXpwC0EwdvFLgHmXfwG/cgPYD861Lo8ZSK3afHK3tnXiHeiGI97kN7ZBUNdfLuc1+SyDf2m70cvGbDiiHp0b4IPuxciqGOBm0mmxhtd0nNkJv11dHR2ovYCw2wJmaxzgWtIL8UHK8Klww9nUzGBTGBiMkA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Die83MJW; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Die83MJW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C1DC81F0089D;
	Mon, 12 Oct 2026 15:18:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791818313;
	bh=gECs2GvSqtLcO34KG761V/cCjbo0ECyYz7HmOmUYfUw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Die83MJW3cAjoLLg3xroaYiaTL0HJmaZhZ7glyrTv/HaWwOCZbWo8p0cGYzlqPLta
	 WB77W/7ECAO8G70za3Q1w+nxG4ejDVo+t2gRSK90lUc7s3b5ZHEuAfiRJ1KQ6qdICz
	 BzNlMEEokrocMQq8JDaRUWHYSzGgzZOIkCLpmu/ZFY2/ElZNFR6NIZ49XGXcUpjYvk
	 L8DQRO8Y6tLo0mm9w13jZPk0EuAuflzs7e4+NyQw7bzL5KMnKbqEMeNdwrXgHKJcpk
	 oogcFDHA4rAfrKx6O57AyMbbH6+cUdaTsNkjQOTHzWbGDSCC25l7ug15Qgbn1ZbJwv
	 DQ+DSEcbV9T7A==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: "Darrick J. Wong" <djwong@kernel.org>,
	Norbert Szetei <norbert@doyensec.com>,
	Dave Chinner <dchinner@redhat.com>,
	Carlos Maiolino <cem@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y 2/2] xfs: fix exchange-range-to-eof file size exchange
Date: Mon, 12 Oct 2026 11:18:30 -0400
Message-ID: <20261012151823.785277-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261012151823.785277-1-sashal@kernel.org>
References: <2026101219-upheld-endowment-592e@gregkh>
 <20261012151823.785277-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Darrick J. Wong" <djwong@kernel.org>

[ Upstream commit 7dfb218c829c1acb626e0fe92c5fddb9a26a03e9 ]

Norbert Szetei posted a patch containing an incomplete description of a
bug in XFS_IOC_EXCHANGE_RANGE's TO_EOF flag.  The bug tricks
exchange-range into modifying a file so that it has shared blocks
starting beyond EOF, which is never allowed because files never have
written data beyond EOF, and you can only share written data blocks.
This is key to all the incorrect behavior that follows.

Eventually I got from Norbert a description of what's going wrong:

> Fair. Here it is with physical block numbers, 4k blocks. peer is the file
> that gets rewritten and file1 is the one that ends up with the flag
> cleared.
>
> Start, nothing shared:
>
>	peer size 4096   -> [100]
>	file1 size 12288 -> [200] [201] [202]
>	donor1 size 4096 -> [300]
>	donor2 size 4096 -> [400]
>
> 1. FICLONERANGE peer's block into file1's middle slot:
>
>	peer size 4096   -> [100]
>	file1 size 12288 -> [200] [100] [202] reflink flag set
>                             ^^^^^ both files own block 100
>
> 2. XFS_IOC_EXCHANGE_RANGE file1 against donor1, file1_offset 0,
> file2_offset 8192, length 0, TO_EOF. One block is exchanged, and the sizes
> are exchanged with it:
>
>	file1 size 4096   -> [200] [100] [300] reflink flag set
>                              ^^^^^^^^^^^ still owned, now past the size
>	donor1 size 12288 -> [202]
>
> file1 says it is one block long while it still owns three. Nothing was
> unmapped. file2_offset is block 2, so this exchange cannot clear a flag.
>
> 3. XFS_IOC_EXCHANGE_RANGE file1 against donor2, both offsets 0, length 4096.
> By i_disk_size this is two one-block files exchanging everything, so
> xmi_can_exchange_reflink_flags() agrees and the flag is cleared:
>
>	file1 size 4096   -> [400] [100] [300] reflink flag CLEARED
>	donor2 size 4096  -> [200]
>
> Block 100 is still shared with peer.
>
> 4. pwrite(file1, 4096, 4096), which is file1's second slot, block 100.
> xfs_is_cow_inode(file1) is false, so no CoW:
>
>	peer size 4096 -> [100] same block, new contents
>
> Block 100 is the only one that matters here. PoC below, it reads a file
> called peer in the current directory. The filesystem needs reflink and
> exchange-range, which mkfs.xfs 7.x turns on by default.

So yes, TO_EOF is screwing up the file size even if it's actually
exchanging the data block correctly.  The following is the intended
behavior of XFS_EXCHANGE_RANGE_TO_EOF, as described by its manpage:

"Ignore the length parameter.  All bytes in file1_fd from file1_offset
 to EOF are moved to file2_fd, and file2's size is set to
 (file2_offset+(file1_length-file1_offset)).  Meanwhile, all bytes in
 file2 from file2_offset to EOF are moved to file1 and file1's size is
 set to (file1_offset+(file2_length-file2_offset))."

In other words, if we only exchange a portion of the file data, then we
should only exchange the portion of the file size that relates to the
exchanged data.  Unfortunately, the code swaps the ondisk file size and
the incore file sizes, which is incorrect if the caller passes in a
nonzero offset.

Having confused the file sizes, the PoC uses a second exchange-range
call on what looks like a non-reflinked single-block file.  Because the
file size is set incorrectly, exchange-range thinks it's exchanging the
full contents of two files and clears the reflink flag on the broken
file.  That enables an extending write of the broken file to rewrite the
shared block that's just past EOF.  This has become known colloquially
as refluxfs.

Once the file sizes are set correctly, the second exchange-range no
longer thinks that it's doing a full-contents swap, so it won't clear
the reflink flag on either of its file arguments.

Norbert followed up to an earlier version of this patch with a second
complaint about us not handling the i_disk_size state correctly:

> The offsets are bounded against the incore i_size but subtracted from
> the ondisk i_disk_size, so a file that has not been written back gives
> xmi_isize1 = 0 + (0 - 12288).
>
> For instance, you can do:
>
> $ xfs_io -f -c "pwrite -q 0 4096" -c fsync file1
> $ xfs_io -f -c "pwrite -q 0 12288" \
>   -c "exchangerange -s 0 -d 12288 file1" dirty
> $ stat -c %s file1
> 0
> $ stat -c %i file1
> 131
> $ sudo xfs_io -r -c "bulkstat_single 131" . | grep bs_size
> bs_size = 18446744073709539328

That's wrong, and the new file size update logic depends on the ondisk
i_disk_size matching the incore i_size, so flush the pagecache as needed
to push it upwards.

Link: https://lore.kernel.org/linux-xfs/1E196589-DEBE-40AC-AFEA-D420DAAB067F@doyensec.com/
Reported-by: Norbert Szetei <norbert@doyensec.com>
Cc: stable@vger.kernel.org # v6.10
Fixes: 966ceafc7a4371 ("xfs: create deferred log items for file mapping exchanges")
Signed-off-by: Darrick J. Wong <djwong@kernel.org>
Reviewed-by: Dave Chinner <dchinner@redhat.com>
Signed-off-by: Carlos Maiolino <cem@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/xfs/libxfs/xfs_exchmaps.c | 13 +++++++--
 fs/xfs/xfs_exchrange.c       | 51 ++++++++++++++++++++++++++----------
 2 files changed, 48 insertions(+), 16 deletions(-)

diff --git a/fs/xfs/libxfs/xfs_exchmaps.c b/fs/xfs/libxfs/xfs_exchmaps.c
index 6a9a73fc5fd90..d900aff4fbea6 100644
--- a/fs/xfs/libxfs/xfs_exchmaps.c
+++ b/fs/xfs/libxfs/xfs_exchmaps.c
@@ -929,6 +929,7 @@ xfs_exchmaps_init_intent(
 	const struct xfs_exchmaps_req	*req)
 {
 	struct xfs_exchmaps_intent	*xmi;
+	struct xfs_mount		*mp = req->ip1->i_mount;
 
 	xmi = kmem_cache_zalloc(xfs_exchmaps_intent_cache,
 			GFP_NOFS | __GFP_NOFAIL);
@@ -946,10 +947,18 @@ xfs_exchmaps_init_intent(
 		return xmi;
 	}
 
+	/*
+	 * If the caller wanted, set each file's size to that file's exchange
+	 * offset + length exchanged from the other file because the ranges in
+	 * each file might be different lengths.
+	 */
 	if (req->flags & XFS_EXCHMAPS_SET_SIZES) {
+		loff_t	off1 = XFS_FSB_TO_B(mp, xmi->xmi_startoff1);
+		loff_t	off2 = XFS_FSB_TO_B(mp, xmi->xmi_startoff2);
+
 		xmi->xmi_flags |= XFS_EXCHMAPS_SET_SIZES;
-		xmi->xmi_isize1 = req->ip2->i_disk_size;
-		xmi->xmi_isize2 = req->ip1->i_disk_size;
+		xmi->xmi_isize1 = off1 + (req->ip2->i_disk_size - off2);
+		xmi->xmi_isize2 = off2 + (req->ip1->i_disk_size - off1);
 	}
 
 	if (S_ISDIR(VFS_I(xmi->xmi_ip2)->i_mode) ||
diff --git a/fs/xfs/xfs_exchrange.c b/fs/xfs/xfs_exchrange.c
index f54ed30b76e40..449090cbb1698 100644
--- a/fs/xfs/xfs_exchrange.c
+++ b/fs/xfs/xfs_exchrange.c
@@ -287,17 +287,20 @@ xfs_exchrange_mappings(
 		goto out_unlock;
 
 	/*
-	 * If the caller wanted us to exchange the contents of two complete
-	 * files of unequal length, exchange the incore sizes now.  This should
-	 * be safe because we flushed both files' page caches, exchanged all
-	 * the mappings, and updated the ondisk sizes.
+	 * If the caller wanted, set each file's size to that file's exchange
+	 * offset + length exchanged from the other file because the ranges in
+	 * each file might be different lengths.  This should be safe because
+	 * we flushed both files' page caches, exchanged all the mappings, and
+	 * updated the ondisk sizes.
 	 */
 	if (fxr->flags & XFS_EXCHANGE_RANGE_TO_EOF) {
-		loff_t	temp;
+		loff_t	old_ip1_size = i_size_read(VFS_I(ip1));
+		loff_t	old_ip2_size = i_size_read(VFS_I(ip2));
 
-		temp = i_size_read(VFS_I(ip2));
-		i_size_write(VFS_I(ip2), i_size_read(VFS_I(ip1)));
-		i_size_write(VFS_I(ip1), temp);
+		i_size_write(VFS_I(ip2), fxr->file2_offset +
+				(old_ip1_size - fxr->file1_offset));
+		i_size_write(VFS_I(ip1), fxr->file1_offset +
+				(old_ip2_size - fxr->file2_offset));
 	}
 
 out_unlock:
@@ -442,6 +445,30 @@ xfs_exchange_range_checks(
 	return blen == fxr->length ? 0 : -EINVAL;
 }
 
+/* Flush all relevant dirty pagecache near the range to be exchanged. */
+static inline int
+xfs_exchange_range_flush(
+	struct xfs_inode		*ip,
+	const struct xfs_exchrange	*fxr,
+	loff_t				offset)
+{
+	/*
+	 * If TO_EOF is set, the ondisk file size update logic depends on the
+	 * ondisk file size matching the incore file size.  Flush everything.
+	 */
+	if (fxr->flags & XFS_EXCHANGE_RANGE_TO_EOF)
+		return filemap_write_and_wait(VFS_I(ip)->i_mapping);
+
+	/*
+	 * Because we're updating the ondisk mappings, flush all dirty data
+	 * between the ondisk size and the exchange offset to reduce the chance
+	 * of zeroed file contents in that gap after a crash.
+	 */
+	return filemap_write_and_wait_range(VFS_I(ip)->i_mapping,
+			min(offset, ip->i_disk_size),
+			offset + fxr->length - 1);
+}
+
 /*
  * Check that the two inodes are eligible for range exchanges, the ranges make
  * sense, and then flush all dirty data.  Caller must ensure that the inodes
@@ -467,15 +494,11 @@ xfs_exchange_range_prep(
 	if (!same_inode)
 		inode_dio_wait(inode2);
 
-	error = filemap_write_and_wait_range(inode1->i_mapping,
-			fxr->file1_offset,
-			fxr->file1_offset + fxr->length - 1);
+	error = xfs_exchange_range_flush(XFS_I(inode1), fxr, fxr->file1_offset);
 	if (error)
 		return error;
 
-	error = filemap_write_and_wait_range(inode2->i_mapping,
-			fxr->file2_offset,
-			fxr->file2_offset + fxr->length - 1);
+	error = xfs_exchange_range_flush(XFS_I(inode2), fxr, fxr->file2_offset);
 	if (error)
 		return error;
 
-- 
2.53.0

