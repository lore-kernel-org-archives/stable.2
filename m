Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B959637F8D7
	for <stable@vger.kernel.org>; Mon, 12 Oct 2026 14:33:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791815592; cv=none; b=cP94gIXQwxhKKrSWuXCsUuN74p2qc6nmGENSbEj9Hy7bU0tnf00ImrqOQkm8V+E3yxVVBkbfyn6ofIfbsDKlhLbTeqfeD78rYHFYe9oLYAKA/60EHvnx2NtYnUSUoKbN8DwFDK9R8V8KWo+OYchTufukBDyvu1wbEfFsP99658E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791815592; c=relaxed/simple;
	bh=Co6DVC2s76gFRRZmnD8qX25UV5/20+R44T8NrIIwbOQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lnCox6PunzMZr4aCEjCkL76VjbvG10ZUP+0WaAoW6x+Ixx4yy1m54mo8Kqx+ouD4ThaZt73Oh9ucFyQym1/LKoqNwRgbxG3jsliher56jCYB7U0WtKc1vONf76du65NfIaxS5OyNgsJP7ynS/jUSGRy3Kr8EW+bbbo/tF4veVxM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dhQo/VWg; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dhQo/VWg"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 04D8A1F0089B;
	Mon, 12 Oct 2026 14:33:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791815590;
	bh=t6Ohb2F0YTQweXAY5alow9osMUqkQSmro0tT9V2E7vU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=dhQo/VWgp5L1VvB8UvttMToTvV3lpXKz3XQ+E+fPqEwGRPGtzKBYyWH3I1LT3Ltjc
	 jAF/vTysyIIDWxq+bocV9S0raXFpcckmZbhG1U43AwUhX4zefpX1n2qq9oDRWjAv6M
	 /I+mQO/AvuwZbe5+qVEMGwTR1ScdIuv2zIaJgg6iUe9Yl2Bjv20/s25xjEC+ZgJHYY
	 i6zsUBXdY+p9w3ba06uqimCmuzzGoPHD1l1vsRjkZtaXv2pmiV9lNnlWG+cryqxZnb
	 pm+HZQeZG4fuJ6aRlACvoRxonIsFDrMVnuWfgWDV1oq6Ht5Z9xZtYigYo3tUxukgVV
	 EnGk+NdwCmgDA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: "Darrick J. Wong" <djwong@kernel.org>,
	Norbert Szetei <norbert@doyensec.com>,
	Dave Chinner <dchinner@redhat.com>,
	Carlos Maiolino <cem@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18.y] xfs: fix exchange-range-to-eof file size exchange
Date: Mon, 12 Oct 2026 10:33:08 -0400
Message-ID: <20261012143244.7057-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026101217-request-humming-58e8@gregkh>
References: <2026101217-request-humming-58e8@gregkh>
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
[ sashal: retained the rs variable alongside the new mp declaration for existing reflink-flag handling. ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/xfs/libxfs/xfs_exchmaps.c | 13 +++++++++--
 fs/xfs/xfs_exchrange.c       | 45 +++++++++++++++++++++++++-----------
 2 files changed, 42 insertions(+), 16 deletions(-)

diff --git a/fs/xfs/libxfs/xfs_exchmaps.c b/fs/xfs/libxfs/xfs_exchmaps.c
index 0cabbef65547e..2692f3b035d3d 100644
--- a/fs/xfs/libxfs/xfs_exchmaps.c
+++ b/fs/xfs/libxfs/xfs_exchmaps.c
@@ -997,6 +997,7 @@ xfs_exchmaps_init_intent(
 	const struct xfs_exchmaps_req	*req)
 {
 	struct xfs_exchmaps_intent	*xmi;
+	struct xfs_mount		*mp = req->ip1->i_mount;
 	unsigned int			rs = 0;
 
 	xmi = kmem_cache_zalloc(xfs_exchmaps_intent_cache,
@@ -1015,10 +1016,18 @@ xfs_exchmaps_init_intent(
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
 
 	/* Record the state of each inode's reflink flag before the op. */
diff --git a/fs/xfs/xfs_exchrange.c b/fs/xfs/xfs_exchrange.c
index 04da020f35778..fd127d88ac859 100644
--- a/fs/xfs/xfs_exchrange.c
+++ b/fs/xfs/xfs_exchrange.c
@@ -290,17 +290,20 @@ xfs_exchrange_mappings(
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
@@ -470,15 +473,29 @@ xfs_exchange_range_prep(
 	if (!same_inode)
 		inode_dio_wait(inode2);
 
-	error = filemap_write_and_wait_range(inode1->i_mapping,
-			fxr->file1_offset,
-			fxr->file1_offset + fxr->length - 1);
+	/*
+	 * If TO_EOF is set, the ondisk file size update logic depends on the
+	 * ondisk file size matching the incore file size.  Flush everything.
+	 *
+	 * Otherwise, flush all dirty data between the ondisk size and the
+	 * exchange offset to reduce the chance of zeroed file contents in
+	 * that gap after a crash.
+	 */
+	if (fxr->flags & XFS_EXCHANGE_RANGE_TO_EOF)
+		error = filemap_write_and_wait(inode1->i_mapping);
+	else
+		error = filemap_write_and_wait_range(inode1->i_mapping,
+				min(fxr->file1_offset, XFS_I(inode1)->i_disk_size),
+				fxr->file1_offset + fxr->length - 1);
 	if (error)
 		return error;
 
-	error = filemap_write_and_wait_range(inode2->i_mapping,
-			fxr->file2_offset,
-			fxr->file2_offset + fxr->length - 1);
+	if (fxr->flags & XFS_EXCHANGE_RANGE_TO_EOF)
+		error = filemap_write_and_wait(inode2->i_mapping);
+	else
+		error = filemap_write_and_wait_range(inode2->i_mapping,
+				min(fxr->file2_offset, XFS_I(inode2)->i_disk_size),
+				fxr->file2_offset + fxr->length - 1);
 	if (error)
 		return error;
 
-- 
2.53.0

