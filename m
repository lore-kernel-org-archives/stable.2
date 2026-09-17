Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFE4C4D7D46
	for <stable@vger.kernel.org>; Thu, 17 Sep 2026 15:17:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789658281; cv=none; b=c7VgRTXCteBgRai3hRh+/8AEHlorm5I6UMhUImHTg/jWZWI2E0DFGpLdLkHq3xfPCCoHqdwJhKXO/gIWQk35lPs8VeR/RPL8ZvBMQcQWN3jFozGlwHZQezOZaFKQUFLOAfwIYuKI4CjgwmT3BxXuCDxIWJ5KpLwM3pOWw5BYZUw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789658281; c=relaxed/simple;
	bh=/3qJEMIYywEsfDTY52O7pPWNupNfKPwhNvTlt+MrulM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Nf8X0s6JoWOYXRV4Ibx/bqhlIupMehA4YSdIooh3s5wAz4Iwz5ld/vlVBUGuEerGOIp7cO4Sh/vc6AWH3/GQ50B68rdSIOpE+gamez7D8HhRMPqRLRjoxHg+33nkCR9kobpISQZFEoiqhch57Hj6NSjpXYJ/u2p60Zmnid2mBkg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oqqpnOUV; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oqqpnOUV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2155A1F008A7;
	Thu, 17 Sep 2026 15:17:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789658248;
	bh=EsklgGfy2LmjQ9g1c4KTCDtMKdDt9yzm6C564Qqd/Ug=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=oqqpnOUVnzUj2+UOsVYYCT+YME4+7rXuzkh7SSGt1pvL0dQWGe9yXfhqCRU+Xf1eN
	 vf9cG+w52SsJhRwShu8E0gKcrGakhW0BSpoiEtHvyvOq1oZG2Eh5usf3zlvmLhp8Yx
	 9GPCQAIOzFdqTYsmPYk/oeDpZb8lEKGCdOL5hPibj/7DH64s2zw9LYKvTgNnt6nhvm
	 r5II2TsESZwYY4M9S9N8KGWq7rgxVNuEqrAwVd1JXk3TlWPxYGU2OWfbCpBPOh9hw4
	 wEuiH/ThYWxfw5+bSEabroUV1xEZpNXlSzTh24e8jZqhG154r8AGphn4BMSdSYqvRA
	 nDr3gnBW+TLbQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Christoph Hellwig <hch@lst.de>,
	Carlos Maiolino <cmaiolino@redhat.com>,
	"Darrick J. Wong" <djwong@kernel.org>,
	Carlos Maiolino <cem@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18.y 4/9] xfs: add a XFS_INO_TO_FSB helper
Date: Thu, 17 Sep 2026 11:17:18 -0400
Message-ID: <20260917151724.693663-4-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260917151724.693663-1-sashal@kernel.org>
References: <2026091651-freedom-anger-bd4d@gregkh>
 <20260917151724.693663-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Christoph Hellwig <hch@lst.de>

[ Upstream commit f8b7c9a8b0a9e43b054981d134b426d9464264f6 ]

Add a shortcut for the common XFS_INO_TO_FSB(mp, ip->i_ino) pattern.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Carlos Maiolino <cmaiolino@redhat.com>
Reviewed-by: "Darrick J. Wong" <djwong@kernel.org>
Signed-off-by: Carlos Maiolino <cem@kernel.org>
Stable-dep-of: 865b751e7503 ("xfs: don't stash removename operations with unknown ftype")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/xfs/libxfs/xfs_bmap.c   | 8 +++-----
 fs/xfs/libxfs/xfs_btree.c  | 6 ++----
 fs/xfs/libxfs/xfs_format.h | 2 ++
 fs/xfs/scrub/cow_repair.c  | 3 +--
 fs/xfs/scrub/newbt.c       | 6 ++----
 fs/xfs/scrub/trace.c       | 2 +-
 6 files changed, 11 insertions(+), 16 deletions(-)

diff --git a/fs/xfs/libxfs/xfs_bmap.c b/fs/xfs/libxfs/xfs_bmap.c
index 53ef4b7e504d6..73e618d656e25 100644
--- a/fs/xfs/libxfs/xfs_bmap.c
+++ b/fs/xfs/libxfs/xfs_bmap.c
@@ -681,8 +681,7 @@ xfs_bmap_extents_to_btree(
 	args.minlen = args.maxlen = args.prod = 1;
 	args.wasdel = wasdel;
 	*logflagsp = 0;
-	error = xfs_alloc_vextent_start_ag(&args,
-				XFS_INO_TO_FSB(mp, ip->i_ino));
+	error = xfs_alloc_vextent_start_ag(&args, XFS_INODE_TO_FSB(ip));
 	if (error)
 		goto out_root_realloc;
 
@@ -828,8 +827,7 @@ xfs_bmap_local_to_extents(
 	 */
 	args.total = total;
 	args.minlen = args.maxlen = args.prod = 1;
-	error = xfs_alloc_vextent_start_ag(&args,
-			XFS_INO_TO_FSB(args.mp, ip->i_ino));
+	error = xfs_alloc_vextent_start_ag(&args, XFS_INODE_TO_FSB(ip));
 	if (error)
 		goto done;
 
@@ -3590,7 +3588,7 @@ xfs_bmap_btalloc_best_length(
 	xfs_extlen_t		blen = 0;
 	int			error;
 
-	ap->blkno = XFS_INO_TO_FSB(args->mp, ap->ip->i_ino);
+	ap->blkno = XFS_INODE_TO_FSB(ap->ip);
 	if (!xfs_bmap_adjacent(ap))
 		ap->eof = false;
 
diff --git a/fs/xfs/libxfs/xfs_btree.c b/fs/xfs/libxfs/xfs_btree.c
index dbe9df8c33004..1b2166ac327a1 100644
--- a/fs/xfs/libxfs/xfs_btree.c
+++ b/fs/xfs/libxfs/xfs_btree.c
@@ -3243,8 +3243,7 @@ xfs_btree_new_iroot(
 	if (level > 0)
 		aptr = *xfs_btree_ptr_addr(cur, 1, block);
 	else
-		aptr.l = cpu_to_be64(XFS_INO_TO_FSB(cur->bc_mp,
-				cur->bc_ino.ip->i_ino));
+		aptr.l = cpu_to_be64(XFS_INODE_TO_FSB(cur->bc_ino.ip));
 
 	/* Allocate the new block. If we can't do it, we're toast. Give up. */
 	error = xfs_btree_alloc_block(cur, &aptr, &nptr, stat);
@@ -5609,8 +5608,7 @@ xfs_btree_alloc_metafile_block(
 	ASSERT(xfs_is_metadir_inode(ip));
 
 	xfs_rmap_ino_bmbt_owner(&args.oinfo, ip->i_ino, cur->bc_ino.whichfork);
-	error = xfs_alloc_vextent_start_ag(&args,
-			XFS_INO_TO_FSB(cur->bc_mp, ip->i_ino));
+	error = xfs_alloc_vextent_start_ag(&args, XFS_INODE_TO_FSB(ip));
 	if (error)
 		return error;
 	if (args.fsbno == NULLFSBLOCK) {
diff --git a/fs/xfs/libxfs/xfs_format.h b/fs/xfs/libxfs/xfs_format.h
index f812c6782492c..9886af0507e3a 100644
--- a/fs/xfs/libxfs/xfs_format.h
+++ b/fs/xfs/libxfs/xfs_format.h
@@ -1289,6 +1289,8 @@ static inline bool xfs_dinode_is_metadir(const struct xfs_dinode *dip)
 	((int)(i) & XFS_INO_MASK(XFS_INO_OFFSET_BITS(mp)))
 #define	XFS_INO_TO_FSB(mp,i)		\
 	XFS_AGB_TO_FSB(mp, XFS_INO_TO_AGNO(mp,i), XFS_INO_TO_AGBNO(mp,i))
+#define	XFS_INODE_TO_FSB(ip)		\
+	XFS_INO_TO_FSB((ip)->i_mount, (ip)->i_ino)
 #define	XFS_AGINO_TO_INO(mp,a,i)	\
 	(((xfs_ino_t)(a) << XFS_INO_AGINO_BITS(mp)) | (i))
 #define	XFS_AGINO_TO_AGBNO(mp,i)	((i) >> XFS_INO_OFFSET_BITS(mp))
diff --git a/fs/xfs/scrub/cow_repair.c b/fs/xfs/scrub/cow_repair.c
index 87627ab8943c1..6d0672ab54033 100644
--- a/fs/xfs/scrub/cow_repair.c
+++ b/fs/xfs/scrub/cow_repair.c
@@ -413,8 +413,7 @@ xrep_cow_alloc(
 	if (error)
 		return error;
 
-	error = xfs_alloc_vextent_start_ag(&args,
-			XFS_INO_TO_FSB(sc->mp, sc->ip->i_ino));
+	error = xfs_alloc_vextent_start_ag(&args, XFS_INODE_TO_FSB(sc->ip));
 	if (error)
 		return error;
 	if (args.fsbno == NULLFSBLOCK)
diff --git a/fs/xfs/scrub/newbt.c b/fs/xfs/scrub/newbt.c
index 951ae8b71566c..40e10ba4db371 100644
--- a/fs/xfs/scrub/newbt.c
+++ b/fs/xfs/scrub/newbt.c
@@ -123,8 +123,7 @@ xrep_newbt_init_inode(
 	if (!ifp)
 		return -ENOMEM;
 
-	xrep_newbt_init_ag(xnr, sc, oinfo,
-			XFS_INO_TO_FSB(sc->mp, sc->ip->i_ino),
+	xrep_newbt_init_ag(xnr, sc, oinfo, XFS_INODE_TO_FSB(sc->ip),
 			XFS_AG_RESV_NONE);
 	xnr->ifake.if_fork = ifp;
 	xnr->ifake.if_fork_size = xfs_inode_fork_size(sc->ip, whichfork);
@@ -160,8 +159,7 @@ xrep_newbt_init_metadir_inode(
 	 * as if they were regular file blocks.  This exposes us to a higher
 	 * risk of the repair being cancelled due to ENOSPC.
 	 */
-	xrep_newbt_init_ag(xnr, sc, &oinfo,
-			XFS_INO_TO_FSB(sc->mp, sc->ip->i_ino),
+	xrep_newbt_init_ag(xnr, sc, &oinfo, XFS_INODE_TO_FSB(sc->ip),
 			XFS_AG_RESV_NONE);
 	xnr->ifake.if_fork = ifp;
 	xnr->ifake.if_fork_size = xfs_inode_fork_size(sc->ip, XFS_DATA_FORK);
diff --git a/fs/xfs/scrub/trace.c b/fs/xfs/scrub/trace.c
index 987313a52e640..4a2cd335f2ebf 100644
--- a/fs/xfs/scrub/trace.c
+++ b/fs/xfs/scrub/trace.c
@@ -48,7 +48,7 @@ xchk_btree_cur_fsbno(
 
 	if (level == cur->bc_nlevels - 1 &&
 	    cur->bc_ops->type == XFS_BTREE_TYPE_INODE)
-		return XFS_INO_TO_FSB(cur->bc_mp, cur->bc_ino.ip->i_ino);
+		return XFS_INODE_TO_FSB(cur->bc_ino.ip);
 
 	return NULLFSBLOCK;
 }
-- 
2.53.0

