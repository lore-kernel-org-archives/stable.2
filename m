Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794272918;
	b=GLnIEAxHHyXIICujXZcGD6O5crWyXegkbsr+4aGBL2gxBkw0KNW6Thn5jkjYb58eLiEt
	 19rehQyLz0giDX25x2J1G8VOJOrGcRENJJ73qHklFtAvliHoMnUdNFSttN030WHzy7BvH
	 Xmq6n5C33oIv5NyrCdo9XknnBdJjwnXanhPl5P3CuLrZsj6NmBiA++XH2SFpMYA9PABOS
	 B2JA9NqU61mwmoCwejec6bRFRp12O4idw+uNtZEPoROA00GZCnf7eiT7wymIQE4zVtKEy
	 rFkT4Cf++yrOCiqXjUNleb/MHrpJkfLFHxcDK5YZjFn49rUVpNKBpldV8flNlVfSjbw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794272918;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=syjjzJ0tVaVGlBSBq58YcLeCazllcnPSnSrEvu8vAUU=;
	b=i0/hx5ljs3iyTjRiKPe5nc9675/pZIse7V5HoIiv7a/mMhq0HTNSUV3haQESZ2qL6UPU
	 4k1pKEBnFQNDv/VrmCYT5JYMmihQOPyg4RPb+c5na7vlq6PWxEVPvVobhUlfgRSyPFJ+G
	 LeQk8O5tZMZWtIfkv9WdjIUK+B8cKWLQPLC1ag/Z6V7EONPpa8a6MIW+OPkSVTHZ5g/Z1
	 P79oFjoiEYpgINx4nrkHcCFqGYfNv0vojl1DGIGQSoXdu3R5i/GSHJGz9CFonsYqv9Dv/
	 r9uCdAo9StZwhck0jbS1GTRnVdM6dipnSS5rPRqn4xHfChGJZKgqhvUHbihicnlkMGw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=lTRvQfwI;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D010606A32A
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 01:08:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=lTRvQfwI
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4722B1F0089F;
	Tue, 10 Nov 2026 01:08:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794272917;
	bh=syjjzJ0tVaVGlBSBq58YcLeCazllcnPSnSrEvu8vAUU=;
	h=From:To:Cc:Subject:Date;
	b=lTRvQfwIV/BsCI4v0W/lveuJxqRuzgvVaIVdUOe0D+DqJI9E3MSp9RsT11wK9OXB1
	 TBeUl42AI5PJ5dWKvc3fWjElLk4o5JHO3qkXnOnUg6ngZay3x3VKujbGJe0Tcb5/tv
	 IFxzrfQIRZU1tL6U0Wyhy9Kx7WCoeySS2FGQeQJS3DLV6Rslv+HaZ5TSYARKazcyeF
	 4AlYVq7cKNp0ZN02tWFYAaEpUQ121AsU6foMmKhq8nUJOkckUyaEll9sB+6qZkL7tL
	 0GGy/EEJvIhjf3cIAnLTCmrcy/f7sq01PQoMqlHkNgHYs5Ur1Gu3FHif78QGxp+2r8
	 BGhBC/QN9eIQQ==
From: Sasha Levin <sashal@kernel.org>
To: daejun7.park@samsung.com,
	hch@lst.de,
	cem@kernel.org
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] xfs: refuse a pNFS LAYOUTCOMMIT of a range without blocks" failed to apply to 6.12-stable tree
Date: Mon,  9 Nov 2026 20:08:36 -0500
Message-ID: <20261109200836-failed-6.12-bcf0b7f18ad1@kernel.org>
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

The patch below does not apply to the 6.12-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.12.y
git checkout FETCH_HEAD
git cherry-pick -x bcf0b7f18ad11e1d410e82ffef678705eff0a317
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261109200836-failed-6.12-bcf0b7f18ad1@kernel.org' --subject-prefix 'PATCH 6.12.y' 'HEAD^..'

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




