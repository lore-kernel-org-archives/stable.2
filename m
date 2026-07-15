Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF5D043B4AE
	for <stable@vger.kernel.org>; Wed, 15 Jul 2026 10:13:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784110411; cv=none; b=sPLTqclRc1dnsHz6oFQMahzVcHJ3zGum+kwiO3qY+N3uDs++MK7+0jMYEJA4qOjVYJPSRk59lwek68QQt7jD/M6Gu8WVwvEYhjBtdfeioGThNOeVSY92RFFU8Dmf1wfAuTOCROFxJ8KUfb7RdMQgd+PfW+b6uCyPPr05a4etc1s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784110411; c=relaxed/simple;
	bh=bRVGbf3ORxZ38UHfDNPGRQH0F7aZYn0v47eEKEcxrlQ=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=g10vreW0TJ0G5SgO04/Zj5CKzkT/oMM64k9VEkvQMCAa09RGr2MfYzkF0Oih4ZQkuW4auQ9c/yJsKbvBBVNGYi7+wnaMU42En35O52+rmbX/kHf5DQ1jBbYza+b3cq/cTiXN5rZXzyJhFNB05Y59kfT2vBJjGXvUx0+KS2ISINo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=uxl9LweA; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="uxl9LweA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D24B91F000E9;
	Wed, 15 Jul 2026 10:13:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1784110409;
	bh=c8LXkTsgcuvEfZcEXa1lEnfpGwkt/OtcX/kAUmbUupc=;
	h=Subject:To:Cc:From:Date;
	b=uxl9LweAmGKuqZesZH7wIFLO6DR8OUkFy5aEzOx6bdc1ZSX1REWI2FoqiZ9Pcm/HJ
	 oQ8YpG7wlpjSTSNq/dqGieU9fqyENuOFww/b9G9OIbDuTpbYFiJpD5ivl8WD36I+Qx
	 /jWBQf2wDg6gkQilH2+3IVeSRQ5EUO2kfzQk52D8=
Subject: FAILED: patch "[PATCH] btrfs: fix incorrect buffered IO fallback for append direct" failed to apply to 5.15-stable tree
To: wqu@suse.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 15 Jul 2026 12:13:10 +0200
Message-ID: <2026071510-plexiglas-finishing-b299@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.15-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.15.y
git checkout FETCH_HEAD
git cherry-pick -x ff66fe6662330226b3f486014c375538d91c44aa
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026071510-plexiglas-finishing-b299@gregkh' --subject-prefix 'PATCH 5.15.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From ff66fe6662330226b3f486014c375538d91c44aa Mon Sep 17 00:00:00 2001
From: Qu Wenruo <wqu@suse.com>
Date: Thu, 4 Jun 2026 09:59:47 +0930
Subject: [PATCH] btrfs: fix incorrect buffered IO fallback for append direct
 writes

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

diff --git a/fs/btrfs/direct-io.c b/fs/btrfs/direct-io.c
index 88cb2e82a507..412309825d6f 100644
--- a/fs/btrfs/direct-io.c
+++ b/fs/btrfs/direct-io.c
@@ -15,10 +15,12 @@
 
 struct btrfs_dio_data {
 	ssize_t submitted;
+	loff_t old_isize;
 	struct extent_changeset *data_reserved;
 	struct btrfs_ordered_extent *ordered;
 	bool data_space_reserved;
 	bool nocow_done;
+	bool updated_isize;
 };
 
 struct btrfs_dio_private {
@@ -228,6 +230,7 @@ static int btrfs_get_blocks_direct_write(struct extent_map **map,
 	bool space_reserved = false;
 	u64 len = *lenp;
 	u64 prev_len;
+	loff_t old_isize;
 	int ret = 0;
 
 	/*
@@ -341,8 +344,14 @@ static int btrfs_get_blocks_direct_write(struct extent_map **map,
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
@@ -625,6 +634,38 @@ static int btrfs_dio_iomap_end(struct inode *inode, loff_t pos, loff_t length,
 		pos += submitted;
 		length -= submitted;
 		if (write) {
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
 			 * We have a short write, if there is any range
 			 * that is submitted properly, that part will have

