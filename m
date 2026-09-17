Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2A6B2C1788
	for <stable@vger.kernel.org>; Thu, 17 Sep 2026 15:17:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789658279; cv=none; b=c5bGoAe8JvOaB9IlYc1P8wiF8O0Os0sMKyiuQm2BmR8t9zDhrt8IAzRijAQvgDkt0gZD4RjlL43YRhNjKorQEIYmst/XxN1No3S491bHUYXeIoT1Caw9drn8PpBJU5UQBkRLJb9L+BWen7UKMT+ICsDhISvL0s0NHTSif+V1ZHA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789658279; c=relaxed/simple;
	bh=N9yfSn2B+LgnjxaakHJUe4EL3Y4Vb5qKJFWzvTEuYww=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=h1Er8JPXU2mQV7UNFq6bw70Hnxh9PatCDhF9YSBBC6eXUcmQlLnYBXw4k24IJwdj/WpTGIztz6VbflDFgGpwouGtIkGr4y4CLYBLq9Hb26D28yQR4pU8rJ10pWLbp5TyckhB2rdViYttfQn8BH9VDvimig49Eb6kVs5GHbVbVdE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IdrELTmU; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IdrELTmU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3F1411F008A6;
	Thu, 17 Sep 2026 15:17:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789658246;
	bh=AONTbRbdqQeVT4ifEpdeVVd531GwfRTGE+cT+8cokyQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=IdrELTmUO2Ndb2p9J5rKtG8maN4uZgEMFg4dJb7s2V26AQAXLHnl5xvWUcj1SQiWs
	 KhyYlMk70/eUeavW1cXUwRO+gfQ+RvZBHR+UhRqEW5sgITevIJ3gZQ1paZlzsUkHNV
	 8TBaGiys2QxDrgHR2NCyMG53SVBz0J5snQ8wD9bnqKzJWw4TXaZXAIekp727sLh+oT
	 p4/0FmzxUxTAUNlKOLfVsqbiDmn4RGoxuHA0F5jR45UykSSc2neby3AjOlHliWLdvt
	 mvPdS0evxBrbYxO6xKO3Q/2TR3AOnNfWaBFWe82qSZwLTkfOr/Ghn7mXFaDHP1wYb8
	 WwnWBNDt/vuog==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Christoph Hellwig <hch@lst.de>,
	Carlos Maiolino <cmaiolino@redhat.com>,
	"Darrick J. Wong" <djwong@kernel.org>,
	Carlos Maiolino <cem@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18.y 2/9] xfs: add a XFS_INODE_TO_AGNO helper
Date: Thu, 17 Sep 2026 11:17:16 -0400
Message-ID: <20260917151724.693663-2-sashal@kernel.org>
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

[ Upstream commit a22166add624818a6c43b807d37f99483ba268a6 ]

Add a shortcut for the common XFS_INO_TO_AGNO(mp, ip->i_ino) pattern.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Carlos Maiolino <cmaiolino@redhat.com>
Reviewed-by: "Darrick J. Wong" <djwong@kernel.org>
Signed-off-by: Carlos Maiolino <cem@kernel.org>
Stable-dep-of: 865b751e7503 ("xfs: don't stash removename operations with unknown ftype")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/xfs/libxfs/xfs_dir2.c       |  4 ++--
 fs/xfs/libxfs/xfs_format.h     |  2 ++
 fs/xfs/libxfs/xfs_ialloc.c     |  2 +-
 fs/xfs/libxfs/xfs_inode_util.c |  2 +-
 fs/xfs/scrub/agheader_repair.c |  8 +++-----
 fs/xfs/scrub/dir_repair.c      |  2 +-
 fs/xfs/scrub/inode_repair.c    |  3 +--
 fs/xfs/scrub/nlinks_repair.c   |  2 +-
 fs/xfs/scrub/parent_repair.c   |  2 +-
 fs/xfs/scrub/trace.h           |  8 ++++----
 fs/xfs/xfs_icache.c            | 14 ++++++--------
 fs/xfs/xfs_inode.c             |  9 ++++-----
 fs/xfs/xfs_trace.h             |  9 ++++-----
 13 files changed, 31 insertions(+), 36 deletions(-)

diff --git a/fs/xfs/libxfs/xfs_dir2.c b/fs/xfs/libxfs/xfs_dir2.c
index 82a338458a517..ecaa2b8c1a99e 100644
--- a/fs/xfs/libxfs/xfs_dir2.c
+++ b/fs/xfs/libxfs/xfs_dir2.c
@@ -920,7 +920,7 @@ xfs_dir_add_child(
 	if (VFS_I(ip)->i_nlink == 0) {
 		struct xfs_perag	*pag;
 
-		pag = xfs_perag_get(mp, XFS_INO_TO_AGNO(mp, ip->i_ino));
+		pag = xfs_perag_get(mp, XFS_INODE_TO_AGNO(ip));
 		error = xfs_iunlink_remove(tp, pag, ip);
 		xfs_perag_put(pag);
 		if (error)
@@ -1247,7 +1247,7 @@ xfs_dir_rename_children(
 
 		ASSERT(VFS_I(du_wip->ip)->i_nlink == 0);
 
-		pag = xfs_perag_get(mp, XFS_INO_TO_AGNO(mp, du_wip->ip->i_ino));
+		pag = xfs_perag_get(mp, XFS_INODE_TO_AGNO(du_wip->ip));
 		error = xfs_iunlink_remove(tp, pag, du_wip->ip);
 		xfs_perag_put(pag);
 		if (error)
diff --git a/fs/xfs/libxfs/xfs_format.h b/fs/xfs/libxfs/xfs_format.h
index 779dac59b1f3b..36a00c174f1ea 100644
--- a/fs/xfs/libxfs/xfs_format.h
+++ b/fs/xfs/libxfs/xfs_format.h
@@ -1276,6 +1276,8 @@ static inline bool xfs_dinode_is_metadir(const struct xfs_dinode *dip)
 	XFS_INO_AGNO_BITS(mp) + XFS_INO_AGINO_BITS(mp)
 #define	XFS_INO_TO_AGNO(mp,i)		\
 	((xfs_agnumber_t)((i) >> XFS_INO_AGINO_BITS(mp)))
+#define	XFS_INODE_TO_AGNO(ip)		\
+	XFS_INO_TO_AGNO((ip)->i_mount, (ip)->i_ino)
 #define	XFS_INO_TO_AGINO(mp,i)		\
 	((xfs_agino_t)(i) & XFS_INO_MASK(XFS_INO_AGINO_BITS(mp)))
 #define	XFS_INO_TO_AGBNO(mp,i)		\
diff --git a/fs/xfs/libxfs/xfs_ialloc.c b/fs/xfs/libxfs/xfs_ialloc.c
index c19d6d713780c..bddf82e0990d9 100644
--- a/fs/xfs/libxfs/xfs_ialloc.c
+++ b/fs/xfs/libxfs/xfs_ialloc.c
@@ -1870,7 +1870,7 @@ xfs_dialloc_pick_ag(
 	if (S_ISDIR(mode))
 		return (atomic_inc_return(&mp->m_agirotor) - 1) % mp->m_maxagi;
 
-	start_agno = XFS_INO_TO_AGNO(mp, dp->i_ino);
+	start_agno = XFS_INODE_TO_AGNO(dp);
 	if (start_agno >= mp->m_maxagi)
 		start_agno = 0;
 
diff --git a/fs/xfs/libxfs/xfs_inode_util.c b/fs/xfs/libxfs/xfs_inode_util.c
index 309ce6dd55538..3f1b1b396ba76 100644
--- a/fs/xfs/libxfs/xfs_inode_util.c
+++ b/fs/xfs/libxfs/xfs_inode_util.c
@@ -529,7 +529,7 @@ xfs_iunlink(
 	ASSERT(VFS_I(ip)->i_mode != 0);
 	trace_xfs_iunlink(ip);
 
-	pag = xfs_perag_get(mp, XFS_INO_TO_AGNO(mp, ip->i_ino));
+	pag = xfs_perag_get(mp, XFS_INODE_TO_AGNO(ip));
 
 	/* Get the agi buffer first.  It ensures lock ordering on the list. */
 	error = xfs_read_agi(pag, tp, 0, &agibp);
diff --git a/fs/xfs/scrub/agheader_repair.c b/fs/xfs/scrub/agheader_repair.c
index 6ed9c6fa52116..6dd2fe929b8c2 100644
--- a/fs/xfs/scrub/agheader_repair.c
+++ b/fs/xfs/scrub/agheader_repair.c
@@ -1148,9 +1148,7 @@ xrep_iunlink_igrab(
 	struct xfs_perag	*pag,
 	struct xfs_inode	*ip)
 {
-	struct xfs_mount	*mp = pag_mount(pag);
-
-	if (XFS_INO_TO_AGNO(mp, ip->i_ino) != pag_agno(pag))
+	if (XFS_INODE_TO_AGNO(ip) != pag_agno(pag))
 		return false;
 
 	if (!xfs_inode_on_unlinked_list(ip))
@@ -1174,7 +1172,7 @@ xrep_iunlink_visit(
 	unsigned int		bucket;
 	int			error;
 
-	ASSERT(XFS_INO_TO_AGNO(mp, ip->i_ino) == pag_agno(ragi->sc->sa.pag));
+	ASSERT(XFS_INODE_TO_AGNO(ip) == pag_agno(ragi->sc->sa.pag));
 	ASSERT(xfs_inode_on_unlinked_list(ip));
 
 	agino = XFS_INO_TO_AGINO(mp, ip->i_ino);
@@ -1245,7 +1243,7 @@ xrep_iunlink_mark_incore(
 			 * us to see this inode, so another lookup from the
 			 * same index will not find it again.
 			 */
-			if (XFS_INO_TO_AGNO(mp, ip->i_ino) != pag_agno(pag))
+			if (XFS_INODE_TO_AGNO(ip) != pag_agno(pag))
 				continue;
 			first_index = XFS_INO_TO_AGINO(mp, ip->i_ino + 1);
 			if (first_index < XFS_INO_TO_AGINO(mp, ip->i_ino))
diff --git a/fs/xfs/scrub/dir_repair.c b/fs/xfs/scrub/dir_repair.c
index e0fa5e6ca1fe8..92603d1e51c47 100644
--- a/fs/xfs/scrub/dir_repair.c
+++ b/fs/xfs/scrub/dir_repair.c
@@ -1576,7 +1576,7 @@ xrep_dir_set_nlink(
 	 * count.  If the directory has no parent, it will be moved to the
 	 * orphanage.
 	 */
-	pag = xfs_perag_get(sc->mp, XFS_INO_TO_AGNO(sc->mp, dp->i_ino));
+	pag = xfs_perag_get(sc->mp, XFS_INODE_TO_AGNO(dp));
 	if (!pag) {
 		ASSERT(0);
 		return -EFSCORRUPTED;
diff --git a/fs/xfs/scrub/inode_repair.c b/fs/xfs/scrub/inode_repair.c
index fdb227dcfd21d..4dc0143497ac5 100644
--- a/fs/xfs/scrub/inode_repair.c
+++ b/fs/xfs/scrub/inode_repair.c
@@ -2011,8 +2011,7 @@ xrep_inode_unlinked(
 		struct xfs_perag	*pag;
 		int			error;
 
-		pag = xfs_perag_get(sc->mp,
-				XFS_INO_TO_AGNO(sc->mp, sc->ip->i_ino));
+		pag = xfs_perag_get(sc->mp, XFS_INODE_TO_AGNO(sc->ip));
 		error = xfs_iunlink_remove(sc->tp, pag, sc->ip);
 		xfs_perag_put(pag);
 		if (error)
diff --git a/fs/xfs/scrub/nlinks_repair.c b/fs/xfs/scrub/nlinks_repair.c
index c3540f3dd2c77..8ff485e21f206 100644
--- a/fs/xfs/scrub/nlinks_repair.c
+++ b/fs/xfs/scrub/nlinks_repair.c
@@ -75,7 +75,7 @@ xrep_nlinks_iunlink_remove(
 	struct xfs_perag	*pag;
 	int			error;
 
-	pag = xfs_perag_get(sc->mp, XFS_INO_TO_AGNO(sc->mp, sc->ip->i_ino));
+	pag = xfs_perag_get(sc->mp, XFS_INODE_TO_AGNO(sc->ip));
 	error = xfs_iunlink_remove(sc->tp, pag, sc->ip);
 	xfs_perag_put(pag);
 	return error;
diff --git a/fs/xfs/scrub/parent_repair.c b/fs/xfs/scrub/parent_repair.c
index 897902c54178d..84c151964b520 100644
--- a/fs/xfs/scrub/parent_repair.c
+++ b/fs/xfs/scrub/parent_repair.c
@@ -1451,7 +1451,7 @@ xrep_parent_set_nondir_nlink(
 		 * The file is on the unlinked list but we found parents.
 		 * Remove the file from the unlinked list.
 		 */
-		pag = xfs_perag_get(sc->mp, XFS_INO_TO_AGNO(sc->mp, ip->i_ino));
+		pag = xfs_perag_get(sc->mp, XFS_INODE_TO_AGNO(ip));
 		if (!pag) {
 			ASSERT(0);
 			return -EFSCORRUPTED;
diff --git a/fs/xfs/scrub/trace.h b/fs/xfs/scrub/trace.h
index 90a7c8cad9b96..16d896cf640bf 100644
--- a/fs/xfs/scrub/trace.h
+++ b/fs/xfs/scrub/trace.h
@@ -3479,7 +3479,7 @@ TRACE_EVENT(xrep_iunlink_reload_next,
 	),
 	TP_fast_assign(
 		__entry->dev = ip->i_mount->m_super->s_dev;
-		__entry->agno = XFS_INO_TO_AGNO(ip->i_mount, ip->i_ino);
+		__entry->agno = XFS_INODE_TO_AGNO(ip);
 		__entry->agino = XFS_INO_TO_AGINO(ip->i_mount, ip->i_ino);
 		__entry->old_prev_agino = ip->i_prev_unlinked;
 		__entry->prev_agino = prev_agino;
@@ -3509,7 +3509,7 @@ TRACE_EVENT(xrep_iunlink_reload_ondisk,
 	),
 	TP_fast_assign(
 		__entry->dev = ip->i_mount->m_super->s_dev;
-		__entry->agno = XFS_INO_TO_AGNO(ip->i_mount, ip->i_ino);
+		__entry->agno = XFS_INODE_TO_AGNO(ip);
 		__entry->agino = XFS_INO_TO_AGINO(ip->i_mount, ip->i_ino);
 		__entry->nlink = VFS_I(ip)->i_nlink;
 		__entry->next_agino = ip->i_next_unlinked;
@@ -3598,7 +3598,7 @@ TRACE_EVENT(xrep_iunlink_relink_next,
 	),
 	TP_fast_assign(
 		__entry->dev = ip->i_mount->m_super->s_dev;
-		__entry->agno = XFS_INO_TO_AGNO(ip->i_mount, ip->i_ino);
+		__entry->agno = XFS_INODE_TO_AGNO(ip);
 		__entry->agino = XFS_INO_TO_AGINO(ip->i_mount, ip->i_ino);
 		__entry->next_agino = ip->i_next_unlinked;
 		__entry->new_next_agino = next_agino;
@@ -3624,7 +3624,7 @@ TRACE_EVENT(xrep_iunlink_relink_prev,
 	),
 	TP_fast_assign(
 		__entry->dev = ip->i_mount->m_super->s_dev;
-		__entry->agno = XFS_INO_TO_AGNO(ip->i_mount, ip->i_ino);
+		__entry->agno = XFS_INODE_TO_AGNO(ip);
 		__entry->agino = XFS_INO_TO_AGINO(ip->i_mount, ip->i_ino);
 		__entry->prev_agino = ip->i_prev_unlinked;
 		__entry->new_prev_agino = prev_agino;
diff --git a/fs/xfs/xfs_icache.c b/fs/xfs/xfs_icache.c
index e44040206851f..8b86000c796f8 100644
--- a/fs/xfs/xfs_icache.c
+++ b/fs/xfs/xfs_icache.c
@@ -439,8 +439,7 @@ xfs_iget_check_free_state(
 			xfs_warn(ip->i_mount,
 "Corruption detected! Free inode 0x%llx not marked free! (mode 0x%x)",
 				ip->i_ino, VFS_I(ip)->i_mode);
-			xfs_agno_mark_sick(ip->i_mount,
-					XFS_INO_TO_AGNO(ip->i_mount, ip->i_ino),
+			xfs_agno_mark_sick(ip->i_mount, XFS_INODE_TO_AGNO(ip),
 					XFS_SICK_AG_INOBT);
 			return -EFSCORRUPTED;
 		}
@@ -449,8 +448,7 @@ xfs_iget_check_free_state(
 			xfs_warn(ip->i_mount,
 "Corruption detected! Free inode 0x%llx has blocks allocated!",
 				ip->i_ino);
-			xfs_agno_mark_sick(ip->i_mount,
-					XFS_INO_TO_AGNO(ip->i_mount, ip->i_ino),
+			xfs_agno_mark_sick(ip->i_mount, XFS_INODE_TO_AGNO(ip),
 					XFS_SICK_AG_INOBT);
 			return -EFSCORRUPTED;
 		}
@@ -1283,7 +1281,7 @@ xfs_blockgc_set_iflag(
 	ip->i_flags |= iflag;
 	spin_unlock(&ip->i_flags_lock);
 
-	pag = xfs_perag_get(mp, XFS_INO_TO_AGNO(mp, ip->i_ino));
+	pag = xfs_perag_get(mp, XFS_INODE_TO_AGNO(ip));
 	spin_lock(&pag->pag_ici_lock);
 
 	xfs_perag_set_inode_tag(pag, XFS_INO_TO_AGINO(mp, ip->i_ino),
@@ -1320,7 +1318,7 @@ xfs_blockgc_clear_iflag(
 	if (!clear_tag)
 		return;
 
-	pag = xfs_perag_get(mp, XFS_INO_TO_AGNO(mp, ip->i_ino));
+	pag = xfs_perag_get(mp, XFS_INODE_TO_AGNO(ip));
 	spin_lock(&pag->pag_ici_lock);
 
 	xfs_perag_clear_inode_tag(pag, XFS_INO_TO_AGINO(mp, ip->i_ino),
@@ -1798,7 +1796,7 @@ xfs_icwalk_ag(
 			 * us to see this inode, so another lookup from the
 			 * same index will not find it again.
 			 */
-			if (XFS_INO_TO_AGNO(mp, ip->i_ino) != pag_agno(pag))
+			if (XFS_INODE_TO_AGNO(ip) != pag_agno(pag))
 				continue;
 			first_index = XFS_INO_TO_AGINO(mp, ip->i_ino + 1);
 			if (first_index < XFS_INO_TO_AGINO(mp, ip->i_ino))
@@ -1912,7 +1910,7 @@ xfs_inodegc_set_reclaimable(
 		ASSERT(0);
 	}
 
-	pag = xfs_perag_get(mp, XFS_INO_TO_AGNO(mp, ip->i_ino));
+	pag = xfs_perag_get(mp, XFS_INODE_TO_AGNO(ip));
 	spin_lock(&pag->pag_ici_lock);
 	spin_lock(&ip->i_flags_lock);
 
diff --git a/fs/xfs/xfs_inode.c b/fs/xfs/xfs_inode.c
index 36b39539e561a..66277d8156c25 100644
--- a/fs/xfs/xfs_inode.c
+++ b/fs/xfs/xfs_inode.c
@@ -1362,7 +1362,7 @@ xfs_inactive_health(
 	if (sick & XFS_SICK_INO_FORGET)
 		return;
 
-	pag = xfs_perag_get(mp, XFS_INO_TO_AGNO(mp, ip->i_ino));
+	pag = xfs_perag_get(mp, XFS_INODE_TO_AGNO(ip));
 	if (!pag) {
 		/* There had better still be a perag structure! */
 		ASSERT(0);
@@ -1801,7 +1801,7 @@ xfs_ifree(
 	ASSERT(ip->i_disk_size == 0 || !S_ISREG(VFS_I(ip)->i_mode));
 	ASSERT(ip->i_nblocks == 0);
 
-	pag = xfs_perag_get(mp, XFS_INO_TO_AGNO(mp, ip->i_ino));
+	pag = xfs_perag_get(mp, XFS_INODE_TO_AGNO(ip));
 
 	error = xfs_inode_uninit(tp, pag, ip, &xic);
 	if (error)
@@ -2310,8 +2310,7 @@ xfs_rename(
 			struct xfs_perag	*pag;
 			struct xfs_buf		*bp;
 
-			pag = xfs_perag_get(mp,
-					XFS_INO_TO_AGNO(mp, inodes[i]->i_ino));
+			pag = xfs_perag_get(mp, XFS_INODE_TO_AGNO(inodes[i]));
 			error = xfs_read_agi(pag, tp, 0, &bp);
 			xfs_perag_put(pag);
 			if (error)
@@ -2858,7 +2857,7 @@ xfs_inode_reload_unlinked_bucket(
 	struct xfs_buf		*agibp;
 	struct xfs_agi		*agi;
 	struct xfs_perag	*pag;
-	xfs_agnumber_t		agno = XFS_INO_TO_AGNO(mp, ip->i_ino);
+	xfs_agnumber_t		agno = XFS_INODE_TO_AGNO(ip);
 	xfs_agino_t		agino = XFS_INO_TO_AGINO(mp, ip->i_ino);
 	xfs_agino_t		prev_agino, next_agino;
 	unsigned int		bucket;
diff --git a/fs/xfs/xfs_trace.h b/fs/xfs/xfs_trace.h
index 434829a5ce7e0..47b938aed8359 100644
--- a/fs/xfs/xfs_trace.h
+++ b/fs/xfs/xfs_trace.h
@@ -4525,7 +4525,7 @@ TRACE_EVENT(xfs_iunlink_reload_next,
 	),
 	TP_fast_assign(
 		__entry->dev = ip->i_mount->m_super->s_dev;
-		__entry->agno = XFS_INO_TO_AGNO(ip->i_mount, ip->i_ino);
+		__entry->agno = XFS_INODE_TO_AGNO(ip);
 		__entry->agino = XFS_INO_TO_AGINO(ip->i_mount, ip->i_ino);
 		__entry->prev_agino = ip->i_prev_unlinked;
 		__entry->next_agino = ip->i_next_unlinked;
@@ -4548,7 +4548,7 @@ TRACE_EVENT(xfs_inode_reload_unlinked_bucket,
 	),
 	TP_fast_assign(
 		__entry->dev = ip->i_mount->m_super->s_dev;
-		__entry->agno = XFS_INO_TO_AGNO(ip->i_mount, ip->i_ino);
+		__entry->agno = XFS_INODE_TO_AGNO(ip);
 		__entry->agino = XFS_INO_TO_AGINO(ip->i_mount, ip->i_ino);
 	),
 	TP_printk("dev %d:%d agno 0x%x agino 0x%x bucket %u",
@@ -4568,7 +4568,7 @@ DECLARE_EVENT_CLASS(xfs_ag_inode_class,
 	),
 	TP_fast_assign(
 		__entry->dev = VFS_I(ip)->i_sb->s_dev;
-		__entry->agno = XFS_INO_TO_AGNO(ip->i_mount, ip->i_ino);
+		__entry->agno = XFS_INODE_TO_AGNO(ip);
 		__entry->agino = XFS_INO_TO_AGINO(ip->i_mount, ip->i_ino);
 	),
 	TP_printk("dev %d:%d agno 0x%x agino 0x%x",
@@ -4765,8 +4765,7 @@ TRACE_EVENT(xfs_btree_commit_ifakeroot,
 	TP_fast_assign(
 		__entry->dev = cur->bc_mp->m_super->s_dev;
 		__assign_str(name);
-		__entry->agno = XFS_INO_TO_AGNO(cur->bc_mp,
-					cur->bc_ino.ip->i_ino);
+		__entry->agno = XFS_INODE_TO_AGNO(cur->bc_ino.ip);
 		__entry->agino = XFS_INO_TO_AGINO(cur->bc_mp,
 					cur->bc_ino.ip->i_ino);
 		__entry->levels = cur->bc_ino.ifake->if_levels;
-- 
2.53.0

