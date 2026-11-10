Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794274051;
	b=iXYQzKb8d9ULovQ59/L4AUT4Zfjo+5DPlz0fu3K/IVCqWY1SFKUoIrHqgBbIl8igmaeM
	 0WwFWqu7xDXniE3KQz99tuP8VNQkLpMSs+ieFBvXxiF6YNHOePOR8qXxBwdzpAW0dqCub
	 9yBpWWq/dO+NFNYFb31IwfsknYlkziJu6sAJF9ZZTmv9GFDyL0QeKIkluG4aQy/jzhwZl
	 aH+q3Fkwi+7GFQxOJ3dZudg2Q+uZtLw3gBm1+VSfJwF1sVrfGMsxFw2FMYzNWJC5xumSB
	 hlbfqOasQYuwOusEXuIHdlVK4WSWNq6AN6dEUeNIMia7QyYVvrfVV9vOF9BPENobwpQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794274051;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=RrAmC0IfmzkT3pCfytkgsQD8vi0H+jKkoVkj8lkIxQg=;
	b=3+t5nbA3EKTp8ozrvoVZ0TAN9tahuwmadZBOvQGHK5mKJ5+KxP85562gL7yIYUxZRLb/
	 hL+VcsHdRwKAfQYSZMleWyv4EJtPpNsKnswAmfalPyafVOKi111gEDiSkbVDHMMaxT5oC
	 jAxhmb1QEWq1ykjJHs1wqmuofMX1+6cxR4mgLWF8dPGyQk4MLKU8ignUaH9rqdCDsG6bz
	 tFXepzzDanfBkvO0YJBhfWgh34m7p+FQItzsCej1Z1sHzx3xMoTiGuVD5C6yOV1TE9Dmf
	 dFff7wgGgX5yibULfP3q8xadSkITq/LjmaqDMD78TifW5pqtqXpEwuuFeSeUWqp4nwg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Ue7BKa2s;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DEB3606A321
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 01:27:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Ue7BKa2s
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8DA0E1F0089F;
	Tue, 10 Nov 2026 01:27:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794274051;
	bh=RrAmC0IfmzkT3pCfytkgsQD8vi0H+jKkoVkj8lkIxQg=;
	h=From:To:Cc:Subject:Date;
	b=Ue7BKa2szc4Ji86olX0humWOl4bpCcMCgHyDNQ84zTZyk6lXiz+U6PLF7M23DJLd/
	 vTzD8W0sonm7Qy0EpIckxnDHoz0/HZAON3p/iITIz8fGC/8kbFsbqZEvNfiMGmM7yW
	 X3XLCiDC9i2wI1at/tOE09yYeJaKbCEZ4QK6OvOHNPf7AoSp8eTq/o7zUdxWmicklM
	 7DeTWNFuXRzo4LNWnQI+uEkhihz4pPWuqyj2ju5RJWbUv2RHvt92bzr/SFdvvvS482
	 GszHugVegoJHCccXmIDwJqjvVLFZae7mxzqNG/HoUTHFkoE8DYdyniC9i8e/FR6slb
	 6QzYMzShJfTmw==
From: Sasha Levin <sashal@kernel.org>
To: daejun7.park@samsung.com,
	hch@lst.de,
	cem@kernel.org
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] xfs: refuse a pNFS LAYOUTCOMMIT of a range without blocks" failed to apply to 5.10-stable tree
Date: Mon,  9 Nov 2026 20:27:29 -0500
Message-ID: <20261109202729-failed-5.10-bcf0b7f18ad1@kernel.org>
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

The patch below does not apply to the 5.10-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.10.y
git checkout FETCH_HEAD
git cherry-pick -x bcf0b7f18ad11e1d410e82ffef678705eff0a317
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261109202729-failed-5.10-bcf0b7f18ad1@kernel.org' --subject-prefix 'PATCH 5.10.y' 'HEAD^..'

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From bcf0b7f18ad11e1d410e82ffef678705eff0a317 Mon Sep 17 00:00:00 2001
From: Daejun Park <daejun7.park@samsung.com>
Date: Thu, 29 Oct 2026 11:23:00 +0900
Subject: [PATCH] xfs: refuse a pNFS LAYOUTCOMMIT of a range without blocks

A client can commit a hole in a LAYOUTCOMMIT, because nfsd does not
check the extents against its layouts. xfs_iomap_write_unwritten() then
allocates written blocks there. A large hole overruns the block
reservation and shuts XFS down. A small one exposes stale data.

Refuse such a range with -EIO, using XFS_BMAPI_CONVERT_ONLY.

Link: https://lore.kernel.org/r/20261014130834.GB15773@lst.de
Fixes: 527851124d10 ("xfs: implement pNFS export operations")
Cc: stable@vger.kernel.org
Signed-off-by: Daejun Park <daejun7.park@samsung.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Carlos Maiolino <cem@kernel.org>
---
 fs/xfs/xfs_file.c  |  2 +-
 fs/xfs/xfs_ioend.c |  2 +-
 fs/xfs/xfs_iomap.c | 20 +++++++++++++++++---
 fs/xfs/xfs_iomap.h |  3 ++-
 fs/xfs/xfs_pnfs.c  |  9 ++++++++-
 5 files changed, 29 insertions(+), 7 deletions(-)

diff --git a/fs/xfs/xfs_file.c b/fs/xfs/xfs_file.c
index 1eab6dbb4c5f1..d2a2124bff547 100644
--- a/fs/xfs/xfs_file.c
+++ b/fs/xfs/xfs_file.c
@@ -666,7 +666,7 @@ xfs_dio_write_end_io(
 	 * they are converted.
 	 */
 	if (flags & IOMAP_DIO_UNWRITTEN) {
-		error = xfs_iomap_write_unwritten(ip, offset, size, true);
+		error = xfs_iomap_write_unwritten(ip, offset, size, true, 0);
 		goto out;
 	}
 
diff --git a/fs/xfs/xfs_ioend.c b/fs/xfs/xfs_ioend.c
index 48becc3bf6088..7f4a4a95afe50 100644
--- a/fs/xfs/xfs_ioend.c
+++ b/fs/xfs/xfs_ioend.c
@@ -237,7 +237,7 @@ xfs_end_ioend_write(
 	if (ioend->io_flags & IOMAP_IOEND_SHARED)
 		error = xfs_reflink_end_cow(ip, offset, size);
 	else if (ioend->io_flags & IOMAP_IOEND_UNWRITTEN)
-		error = xfs_iomap_write_unwritten(ip, offset, size, false);
+		error = xfs_iomap_write_unwritten(ip, offset, size, false, 0);
 
 	if (!error &&
 	    !(ioend->io_flags & IOMAP_IOEND_DIRECT) &&
diff --git a/fs/xfs/xfs_iomap.c b/fs/xfs/xfs_iomap.c
index 329c745e31204..99d48081c5ac3 100644
--- a/fs/xfs/xfs_iomap.c
+++ b/fs/xfs/xfs_iomap.c
@@ -614,7 +614,8 @@ xfs_iomap_write_unwritten(
 	xfs_inode_t	*ip,
 	xfs_off_t	offset,
 	xfs_off_t	count,
-	bool		update_isize)
+	bool		update_isize,
+	uint32_t	bmapi_flags)
 {
 	xfs_mount_t	*mp = ip->i_mount;
 	xfs_fileoff_t	offset_fsb;
@@ -676,8 +677,21 @@ xfs_iomap_write_unwritten(
 		 */
 		nimaps = 1;
 		error = xfs_bmapi_write(tp, ip, offset_fsb, count_fsb,
-					XFS_BMAPI_CONVERT, resblks, &imap,
-					&nimaps);
+					XFS_BMAPI_CONVERT | bmapi_flags,
+					resblks, &imap, &nimaps);
+		if (error == -ENOSR && (bmapi_flags & XFS_BMAPI_CONVERT_ONLY)) {
+			/*
+			 * Nothing was mapped: the rest of the range starts
+			 * with a hole or a delalloc extent. Nothing was
+			 * changed either, but xfs_iext_count_extend() may
+			 * have logged the inode, and cancelling a dirty
+			 * transaction shuts the filesystem down. Commit it,
+			 * as xfs_alloc_file_space() does on -ENOSR.
+			 */
+			error = xfs_trans_commit(tp);
+			xfs_iunlock(ip, XFS_ILOCK_EXCL);
+			return error ? error : -EIO;
+		}
 		if (error)
 			goto error_on_bmapi_transaction;
 
diff --git a/fs/xfs/xfs_iomap.h b/fs/xfs/xfs_iomap.h
index f2520a9b3a13e..8fc0c6fc8bea5 100644
--- a/fs/xfs/xfs_iomap.h
+++ b/fs/xfs/xfs_iomap.h
@@ -15,7 +15,8 @@ struct xfs_zone_alloc_ctx;
 int xfs_iomap_write_direct(struct xfs_inode *ip, xfs_fileoff_t offset_fsb,
 		xfs_fileoff_t count_fsb, unsigned int flags,
 		struct xfs_bmbt_irec *imap, u64 *sequence);
-int xfs_iomap_write_unwritten(struct xfs_inode *, xfs_off_t, xfs_off_t, bool);
+int xfs_iomap_write_unwritten(struct xfs_inode *ip, xfs_off_t offset,
+		xfs_off_t count, bool update_isize, uint32_t bmapi_flags);
 xfs_fileoff_t xfs_iomap_eof_align_last_fsb(struct xfs_inode *ip,
 		xfs_fileoff_t end_fsb);
 
diff --git a/fs/xfs/xfs_pnfs.c b/fs/xfs/xfs_pnfs.c
index a9f0b472f3076..7ff83274a5135 100644
--- a/fs/xfs/xfs_pnfs.c
+++ b/fs/xfs/xfs_pnfs.c
@@ -344,7 +344,14 @@ xfs_fs_commit_blocks(
 					(end - 1) >> PAGE_SHIFT);
 		WARN_ON_ONCE(error);
 
-		error = xfs_iomap_write_unwritten(ip, start, length, false);
+		/*
+		 * A client may only write to blocks that a layout handed out,
+		 * and xfs_fs_map_blocks() allocates blocks for any hole in a
+		 * write layout, so refuse to allocate blocks for a hole or a
+		 * delalloc extent in the committed range.
+		 */
+		error = xfs_iomap_write_unwritten(ip, start, length, false,
+				XFS_BMAPI_CONVERT_ONLY);
 		if (error)
 			goto out_drop_iolock;
 	}
-- 
2.53.0




