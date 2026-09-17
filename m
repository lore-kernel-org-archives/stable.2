Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49DC34B7A30
	for <stable@vger.kernel.org>; Thu, 17 Sep 2026 15:17:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789658283; cv=none; b=eSAVI4HFxMeGFDFUMeRg3Se5hXdw15KqE4CigkCyxo3j5ZvCgldq1CS9nX182WF35897JTWZ4Oc/GdZ2ayudcwa2Lsmur1lU5fyMW/dOKNxj6JXpPEQCzmVbDCxGSnwe8G4JF3dDVEuNS6CzG4+ojxx3EGGZ/8PZ1/geEz3kSvU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789658283; c=relaxed/simple;
	bh=Se7A+yM6c/DhVOre0Ryf5XsACblMcgJ6fSWFdyggkL8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FVRMIjEywodv3yQc8Xn1YidnDWqITtrZ7PDwDMucc9wzX8kLMtnPyeAMieAHQbv3lf0mjOTwvjB2rRxuaM8GaALOceMfdjFUVLpVPemArXvzBlQyBnLOHi/hS/ngvNtxdv8bp8L6PL4JblU7hpYSdPyM+l6Ra+LaOdXTdgr02As=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ogsIj+fE; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ogsIj+fE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0D4331F008BD;
	Thu, 17 Sep 2026 15:17:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789658249;
	bh=+Na1UbK0bGm6kpMXwLgNkMJKMNJEEtMpX55jhtqkvys=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ogsIj+fEzHcTEg3z0Y0L6uUxfe4vELkwq7X1Q+NLO/zN4Vy8ZtoUMgVymHWiPtYiz
	 utfUzFBlYls5xXq4G2o5GmXLsAOLEECnwUvMd5ypeuoQmX9WDGaAhDzIudvQ35N0F9
	 OOMoaxjOgKF5Fw5JMBnkON1uX55kfb3Zz4xCZ3TrBW9mb6pUZWYVvJjqoKcQoPKRfr
	 ACuptG6fzBc81wfJPN8J/hcErh/hwZXDhXELkn18LZgdHwT+00u6oIziHYy5wY3wmu
	 TsLVerG7yYWs+y+1mudSLVdR/CvAFkx6XqufMoT+k2mOdu7SF6Xc6YoDxAP8OfYogU
	 BctJfAeKfBHwg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Christoph Hellwig <hch@lst.de>,
	Carlos Maiolino <cmaiolino@redhat.com>,
	"Darrick J. Wong" <djwong@kernel.org>,
	Carlos Maiolino <cem@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18.y 5/9] xfs: add a xfs_rmap_inode_bmbt_owner
Date: Thu, 17 Sep 2026 11:17:19 -0400
Message-ID: <20260917151724.693663-5-sashal@kernel.org>
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

[ Upstream commit ee237a900ceef00c8d1ca17a5cfadbd50fba67e9 ]

Add a small wrapper for initializing the bmbt owner to i_ino.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Carlos Maiolino <cmaiolino@redhat.com>
Reviewed-by: "Darrick J. Wong" <djwong@kernel.org>
Signed-off-by: Carlos Maiolino <cem@kernel.org>
Stable-dep-of: 865b751e7503 ("xfs: don't stash removename operations with unknown ftype")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/xfs/libxfs/xfs_bmap.c       | 4 ++--
 fs/xfs/libxfs/xfs_bmap_btree.c | 4 ++--
 fs/xfs/libxfs/xfs_btree.c      | 4 ++--
 fs/xfs/libxfs/xfs_rmap.h       | 2 ++
 fs/xfs/scrub/bmap.c            | 2 +-
 fs/xfs/scrub/bmap_repair.c     | 4 ++--
 fs/xfs/scrub/newbt.c           | 2 +-
 fs/xfs/scrub/reap.c            | 2 +-
 fs/xfs/scrub/rtrefcount.c      | 2 +-
 fs/xfs/scrub/rtrmap.c          | 3 +--
 10 files changed, 15 insertions(+), 14 deletions(-)

diff --git a/fs/xfs/libxfs/xfs_bmap.c b/fs/xfs/libxfs/xfs_bmap.c
index 73e618d656e25..33a4f047dfdfc 100644
--- a/fs/xfs/libxfs/xfs_bmap.c
+++ b/fs/xfs/libxfs/xfs_bmap.c
@@ -602,7 +602,7 @@ xfs_bmap_btree_to_extents(
 	if ((error = xfs_btree_check_block(cur, cblock, 0, cbp)))
 		return error;
 
-	xfs_rmap_ino_bmbt_owner(&oinfo, ip->i_ino, whichfork);
+	xfs_rmap_inode_bmbt_owner(&oinfo, ip, whichfork);
 	error = xfs_free_extent_later(cur->bc_tp, cbno, 1, &oinfo,
 			XFS_AG_RESV_NONE, 0);
 	if (error)
@@ -676,7 +676,7 @@ xfs_bmap_extents_to_btree(
 	memset(&args, 0, sizeof(args));
 	args.tp = tp;
 	args.mp = mp;
-	xfs_rmap_ino_bmbt_owner(&args.oinfo, ip->i_ino, whichfork);
+	xfs_rmap_inode_bmbt_owner(&args.oinfo, ip, whichfork);
 
 	args.minlen = args.maxlen = args.prod = 1;
 	args.wasdel = wasdel;
diff --git a/fs/xfs/libxfs/xfs_bmap_btree.c b/fs/xfs/libxfs/xfs_bmap_btree.c
index 188feac04b603..10e0e649a2a09 100644
--- a/fs/xfs/libxfs/xfs_bmap_btree.c
+++ b/fs/xfs/libxfs/xfs_bmap_btree.c
@@ -217,7 +217,7 @@ xfs_bmbt_alloc_block(
 	memset(&args, 0, sizeof(args));
 	args.tp = cur->bc_tp;
 	args.mp = cur->bc_mp;
-	xfs_rmap_ino_bmbt_owner(&args.oinfo, cur->bc_ino.ip->i_ino,
+	xfs_rmap_inode_bmbt_owner(&args.oinfo, cur->bc_ino.ip,
 			cur->bc_ino.whichfork);
 	args.minlen = args.maxlen = args.prod = 1;
 	args.wasdel = cur->bc_flags & XFS_BTREE_BMBT_WASDEL;
@@ -280,7 +280,7 @@ xfs_bmbt_free_block(
 	struct xfs_owner_info	oinfo;
 	int			error;
 
-	xfs_rmap_ino_bmbt_owner(&oinfo, ip->i_ino, cur->bc_ino.whichfork);
+	xfs_rmap_inode_bmbt_owner(&oinfo, ip, cur->bc_ino.whichfork);
 	error = xfs_free_extent_later(cur->bc_tp, fsbno, 1, &oinfo,
 			XFS_AG_RESV_NONE, 0);
 	if (error)
diff --git a/fs/xfs/libxfs/xfs_btree.c b/fs/xfs/libxfs/xfs_btree.c
index 1b2166ac327a1..90a795d5965c1 100644
--- a/fs/xfs/libxfs/xfs_btree.c
+++ b/fs/xfs/libxfs/xfs_btree.c
@@ -5607,7 +5607,7 @@ xfs_btree_alloc_metafile_block(
 
 	ASSERT(xfs_is_metadir_inode(ip));
 
-	xfs_rmap_ino_bmbt_owner(&args.oinfo, ip->i_ino, cur->bc_ino.whichfork);
+	xfs_rmap_inode_bmbt_owner(&args.oinfo, ip, cur->bc_ino.whichfork);
 	error = xfs_alloc_vextent_start_ag(&args, XFS_INODE_TO_FSB(ip));
 	if (error)
 		return error;
@@ -5639,7 +5639,7 @@ xfs_btree_free_metafile_block(
 
 	ASSERT(xfs_is_metadir_inode(ip));
 
-	xfs_rmap_ino_bmbt_owner(&oinfo, ip->i_ino, cur->bc_ino.whichfork);
+	xfs_rmap_inode_bmbt_owner(&oinfo, ip, cur->bc_ino.whichfork);
 	error = xfs_free_extent_later(tp, fsbno, 1, &oinfo, XFS_AG_RESV_METAFILE,
 			0);
 	if (error)
diff --git a/fs/xfs/libxfs/xfs_rmap.h b/fs/xfs/libxfs/xfs_rmap.h
index 5f39f6e53cd19..7188459f61cf3 100644
--- a/fs/xfs/libxfs/xfs_rmap.h
+++ b/fs/xfs/libxfs/xfs_rmap.h
@@ -21,6 +21,8 @@ xfs_rmap_ino_bmbt_owner(
 	if (whichfork == XFS_ATTR_FORK)
 		oi->oi_flags |= XFS_OWNER_INFO_ATTR_FORK;
 }
+#define xfs_rmap_inode_bmbt_owner(oi, ip, whichfork) \
+	xfs_rmap_ino_bmbt_owner(oi, (ip)->i_ino, whichfork)
 
 static inline void
 xfs_rmap_ino_owner(
diff --git a/fs/xfs/scrub/bmap.c b/fs/xfs/scrub/bmap.c
index 845e1538077e3..ba7cb3837c752 100644
--- a/fs/xfs/scrub/bmap.c
+++ b/fs/xfs/scrub/bmap.c
@@ -600,7 +600,7 @@ xchk_bmap_btree(
 
 	/* Check the btree structure. */
 	cur = xfs_bmbt_init_cursor(mp, sc->tp, ip, whichfork);
-	xfs_rmap_ino_bmbt_owner(&oinfo, ip->i_ino, whichfork);
+	xfs_rmap_inode_bmbt_owner(&oinfo, ip, whichfork);
 	error = xchk_btree(sc, cur, xchk_bmapbt_rec, &oinfo, info);
 	xfs_btree_del_cursor(cur, error);
 out:
diff --git a/fs/xfs/scrub/bmap_repair.c b/fs/xfs/scrub/bmap_repair.c
index 747cd9389b491..fa6bb8673b0fb 100644
--- a/fs/xfs/scrub/bmap_repair.c
+++ b/fs/xfs/scrub/bmap_repair.c
@@ -760,7 +760,7 @@ xrep_bmap_build_new_fork(
 	 * Prepare to construct the new fork by initializing the new btree
 	 * structure and creating a fake ifork in the ifakeroot structure.
 	 */
-	xfs_rmap_ino_bmbt_owner(&oinfo, sc->ip->i_ino, rb->whichfork);
+	xfs_rmap_inode_bmbt_owner(&oinfo, sc->ip, rb->whichfork);
 	error = xrep_newbt_init_inode(&rb->new_bmapbt, sc, rb->whichfork,
 			&oinfo);
 	if (error)
@@ -833,7 +833,7 @@ xrep_bmap_remove_old_tree(
 	struct xfs_owner_info	oinfo;
 
 	/* Free the old bmbt blocks if they're not in use. */
-	xfs_rmap_ino_bmbt_owner(&oinfo, sc->ip->i_ino, rb->whichfork);
+	xfs_rmap_inode_bmbt_owner(&oinfo, sc->ip, rb->whichfork);
 	return xrep_reap_fsblocks(sc, &rb->old_bmbt_blocks, &oinfo);
 }
 
diff --git a/fs/xfs/scrub/newbt.c b/fs/xfs/scrub/newbt.c
index 40e10ba4db371..b89ff2b43c4fd 100644
--- a/fs/xfs/scrub/newbt.c
+++ b/fs/xfs/scrub/newbt.c
@@ -145,7 +145,7 @@ xrep_newbt_init_metadir_inode(
 
 	ASSERT(xfs_is_metadir_inode(sc->ip));
 
-	xfs_rmap_ino_bmbt_owner(&oinfo, sc->ip->i_ino, XFS_DATA_FORK);
+	xfs_rmap_inode_bmbt_owner(&oinfo, sc->ip, XFS_DATA_FORK);
 
 	ifp = kmem_cache_zalloc(xfs_ifork_cache, XCHK_GFP_FLAGS);
 	if (!ifp)
diff --git a/fs/xfs/scrub/reap.c b/fs/xfs/scrub/reap.c
index 07f5bb8a64212..fbd0460dc06d3 100644
--- a/fs/xfs/scrub/reap.c
+++ b/fs/xfs/scrub/reap.c
@@ -1205,7 +1205,7 @@ xrep_reap_metadir_fsblocks(
 	ASSERT(xfs_is_metadir_inode(sc->ip));
 
 	xreap_configure_agextent_limits(&rs);
-	xfs_rmap_ino_bmbt_owner(&oinfo, sc->ip->i_ino, XFS_DATA_FORK);
+	xfs_rmap_inode_bmbt_owner(&oinfo, sc->ip, XFS_DATA_FORK);
 	error = xfsb_bitmap_walk(bitmap, xreap_fsmeta_extent, &rs);
 	if (error)
 		return error;
diff --git a/fs/xfs/scrub/rtrefcount.c b/fs/xfs/scrub/rtrefcount.c
index 24eb2a664aab8..1fee16e4e2339 100644
--- a/fs/xfs/scrub/rtrefcount.c
+++ b/fs/xfs/scrub/rtrefcount.c
@@ -556,7 +556,7 @@ xchk_rtrefcountbt(
 	if (error || (sc->sm->sm_flags & XFS_SCRUB_OFLAG_CORRUPT))
 		return error;
 
-	xfs_rmap_ino_bmbt_owner(&btree_oinfo, rtg_refcount(sc->sr.rtg)->i_ino,
+	xfs_rmap_inode_bmbt_owner(&btree_oinfo, rtg_refcount(sc->sr.rtg),
 			XFS_DATA_FORK);
 	error = xchk_btree(sc, sc->sr.refc_cur, xchk_rtrefcountbt_rec,
 			&btree_oinfo, &rrc);
diff --git a/fs/xfs/scrub/rtrmap.c b/fs/xfs/scrub/rtrmap.c
index e75fa9c095e0b..1e52d1e731a99 100644
--- a/fs/xfs/scrub/rtrmap.c
+++ b/fs/xfs/scrub/rtrmap.c
@@ -250,7 +250,6 @@ int
 xchk_rtrmapbt(
 	struct xfs_scrub	*sc)
 {
-	struct xfs_inode	*ip = rtg_rmap(sc->sr.rtg);
 	struct xfs_owner_info	oinfo;
 	struct xchk_rtrmap	cr = { };
 	int			error;
@@ -259,7 +258,7 @@ xchk_rtrmapbt(
 	if (error || (sc->sm->sm_flags & XFS_SCRUB_OFLAG_CORRUPT))
 		return error;
 
-	xfs_rmap_ino_bmbt_owner(&oinfo, ip->i_ino, XFS_DATA_FORK);
+	xfs_rmap_inode_bmbt_owner(&oinfo, rtg_rmap(sc->sr.rtg), XFS_DATA_FORK);
 	return xchk_btree(sc, sc->sr.rmap_cur, xchk_rtrmapbt_rec, &oinfo, &cr);
 }
 
-- 
2.53.0

