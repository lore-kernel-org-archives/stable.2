Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A85C4D6C52
	for <stable@vger.kernel.org>; Thu, 17 Sep 2026 15:17:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789658272; cv=none; b=K58eHZqoGB1qzj1PG+fH0l5TnY/W5uNUJwRn73CnNGmKk260zajcfNUFANUmaXJBe/bo+QVPjAd3ia6EwLl/9782SsK0iZg4+Ys3GI+08TgYDKzTM7vCkPR/F3iIzS7vVIEFTmnB25Gci8tgBQ3Osi4EUl8iIJj6RevwX7sMrTg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789658272; c=relaxed/simple;
	bh=2F0CSfu8tosyFav6ITL5PgdaBYyvZA+Bc7I47NcSHFM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RIjV3Ni4DLdXBVLkhc4PIIxG5mFvhrXoBqWURGZrOzASbzyZyewbeh0JLOI4qDuIWPxqeBOlsCyG8zf89JExy4vz0Lpfjwp8RpWR6neR25GD7dvUHJxLF65tjk/yNz3lDpT2QiU4aJjFkaFJ15S3W6Sz+Bat2hRHQ2zSZV1mhZY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nVYLQ9Mr; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nVYLQ9Mr"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 347F21F008BF;
	Thu, 17 Sep 2026 15:17:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789658247;
	bh=VYSNhXlUFSCqvI0xESx8/9umcaXOjEL/niIBpcB9Zyg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=nVYLQ9Mrh4ZqW/bXiq19TgzfHHl9aI+C+tRJATkniCe+3BfDWUWBoKYD900N1gBtd
	 Kx9vt/gmmbDAx4Kh1qAGz2pZhu9IjpzofZWdGL5zaCdFN/6XBWcxywJDox1945WjA0
	 apeGZuRC7T6ejlNg2BX0NAkA+aPmud8JrmVpvkmjDYI6+ecvVX0H33r1qzLGnUx3p1
	 uc1kyE6Db7K40tmZERIll6U0ByLoTaZ8AOUS8TusWe67ec86IU3BE/i3BBKmzoxK6K
	 TFUp12bQKQwV7FOhR5HmNVN6fZ8Gdl+b/HQzczRthDEz0k2RgBexlfslM3Sw09UgaL
	 iUUgUpN12XEQQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Christoph Hellwig <hch@lst.de>,
	Carlos Maiolino <cmaiolino@redhat.com>,
	"Darrick J. Wong" <djwong@kernel.org>,
	Carlos Maiolino <cem@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18.y 3/9] xfs: add a XFS_INODE_TO_AGINO helper
Date: Thu, 17 Sep 2026 11:17:17 -0400
Message-ID: <20260917151724.693663-3-sashal@kernel.org>
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

[ Upstream commit f46edc9f1310d27710e2b39bf561ecef51f879d2 ]

Add a shortcut for the common XFS_INO_TO_AGINO(mp, ip->i_ino) pattern.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Carlos Maiolino <cmaiolino@redhat.com>
Reviewed-by: "Darrick J. Wong" <djwong@kernel.org>
Signed-off-by: Carlos Maiolino <cem@kernel.org>
Stable-dep-of: 865b751e7503 ("xfs: don't stash removename operations with unknown ftype")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/xfs/libxfs/xfs_format.h     |  2 ++
 fs/xfs/libxfs/xfs_inode_util.c |  5 ++---
 fs/xfs/scrub/agheader_repair.c | 10 +++-------
 fs/xfs/scrub/trace.h           | 10 +++++-----
 fs/xfs/xfs_icache.c            | 10 +++++-----
 fs/xfs/xfs_inode.c             |  2 +-
 fs/xfs/xfs_trace.h             | 12 +++++-------
 7 files changed, 23 insertions(+), 28 deletions(-)

diff --git a/fs/xfs/libxfs/xfs_format.h b/fs/xfs/libxfs/xfs_format.h
index 36a00c174f1ea..f812c6782492c 100644
--- a/fs/xfs/libxfs/xfs_format.h
+++ b/fs/xfs/libxfs/xfs_format.h
@@ -1280,6 +1280,8 @@ static inline bool xfs_dinode_is_metadir(const struct xfs_dinode *dip)
 	XFS_INO_TO_AGNO((ip)->i_mount, (ip)->i_ino)
 #define	XFS_INO_TO_AGINO(mp,i)		\
 	((xfs_agino_t)(i) & XFS_INO_MASK(XFS_INO_AGINO_BITS(mp)))
+#define	XFS_INODE_TO_AGINO(ip)		\
+	XFS_INO_TO_AGINO((ip)->i_mount, (ip)->i_ino)
 #define	XFS_INO_TO_AGBNO(mp,i)		\
 	(((xfs_agblock_t)(i) >> XFS_INO_OFFSET_BITS(mp)) & \
 		XFS_INO_MASK(XFS_INO_AGBNO_BITS(mp)))
diff --git a/fs/xfs/libxfs/xfs_inode_util.c b/fs/xfs/libxfs/xfs_inode_util.c
index 3f1b1b396ba76..c8b5e19185ec4 100644
--- a/fs/xfs/libxfs/xfs_inode_util.c
+++ b/fs/xfs/libxfs/xfs_inode_util.c
@@ -462,10 +462,9 @@ xfs_iunlink_insert_inode(
 	struct xfs_buf		*agibp,
 	struct xfs_inode	*ip)
 {
-	struct xfs_mount	*mp = tp->t_mountp;
 	struct xfs_agi		*agi = agibp->b_addr;
 	xfs_agino_t		next_agino;
-	xfs_agino_t		agino = XFS_INO_TO_AGINO(mp, ip->i_ino);
+	xfs_agino_t		agino = XFS_INODE_TO_AGINO(ip);
 	short			bucket_index = agino % XFS_AGI_UNLINKED_BUCKETS;
 	int			error;
 
@@ -551,7 +550,7 @@ xfs_iunlink_remove_inode(
 {
 	struct xfs_mount	*mp = tp->t_mountp;
 	struct xfs_agi		*agi = agibp->b_addr;
-	xfs_agino_t		agino = XFS_INO_TO_AGINO(mp, ip->i_ino);
+	xfs_agino_t		agino = XFS_INODE_TO_AGINO(ip);
 	xfs_agino_t		head_agino;
 	short			bucket_index = agino % XFS_AGI_UNLINKED_BUCKETS;
 	int			error;
diff --git a/fs/xfs/scrub/agheader_repair.c b/fs/xfs/scrub/agheader_repair.c
index 6dd2fe929b8c2..63557e70f3e6e 100644
--- a/fs/xfs/scrub/agheader_repair.c
+++ b/fs/xfs/scrub/agheader_repair.c
@@ -1166,18 +1166,14 @@ xrep_iunlink_visit(
 	struct xrep_agi		*ragi,
 	unsigned int		batch_idx)
 {
-	struct xfs_mount	*mp = ragi->sc->mp;
 	struct xfs_inode	*ip = ragi->lookup_batch[batch_idx];
-	xfs_agino_t		agino;
-	unsigned int		bucket;
+	xfs_agino_t		agino = XFS_INODE_TO_AGINO(ip);
+	unsigned int		bucket = agino % XFS_AGI_UNLINKED_BUCKETS;
 	int			error;
 
 	ASSERT(XFS_INODE_TO_AGNO(ip) == pag_agno(ragi->sc->sa.pag));
 	ASSERT(xfs_inode_on_unlinked_list(ip));
 
-	agino = XFS_INO_TO_AGINO(mp, ip->i_ino);
-	bucket = agino % XFS_AGI_UNLINKED_BUCKETS;
-
 	trace_xrep_iunlink_visit(ragi->sc->sa.pag, bucket,
 			ragi->iunlink_heads[bucket], ip);
 
@@ -1246,7 +1242,7 @@ xrep_iunlink_mark_incore(
 			if (XFS_INODE_TO_AGNO(ip) != pag_agno(pag))
 				continue;
 			first_index = XFS_INO_TO_AGINO(mp, ip->i_ino + 1);
-			if (first_index < XFS_INO_TO_AGINO(mp, ip->i_ino))
+			if (first_index < XFS_INODE_TO_AGINO(ip))
 				done = true;
 		}
 
diff --git a/fs/xfs/scrub/trace.h b/fs/xfs/scrub/trace.h
index 16d896cf640bf..82e67724af5eb 100644
--- a/fs/xfs/scrub/trace.h
+++ b/fs/xfs/scrub/trace.h
@@ -3449,7 +3449,7 @@ TRACE_EVENT(xrep_iunlink_visit,
 	TP_fast_assign(
 		__entry->dev = pag_mount(pag)->m_super->s_dev;
 		__entry->agno = pag_agno(pag);
-		__entry->agino = XFS_INO_TO_AGINO(pag_mount(pag), ip->i_ino);
+		__entry->agino = XFS_INODE_TO_AGINO(ip);
 		__entry->bucket = bucket;
 		__entry->bucket_agino = bucket_agino;
 		__entry->prev_agino = ip->i_prev_unlinked;
@@ -3480,7 +3480,7 @@ TRACE_EVENT(xrep_iunlink_reload_next,
 	TP_fast_assign(
 		__entry->dev = ip->i_mount->m_super->s_dev;
 		__entry->agno = XFS_INODE_TO_AGNO(ip);
-		__entry->agino = XFS_INO_TO_AGINO(ip->i_mount, ip->i_ino);
+		__entry->agino = XFS_INODE_TO_AGINO(ip);
 		__entry->old_prev_agino = ip->i_prev_unlinked;
 		__entry->prev_agino = prev_agino;
 		__entry->next_agino = ip->i_next_unlinked;
@@ -3510,7 +3510,7 @@ TRACE_EVENT(xrep_iunlink_reload_ondisk,
 	TP_fast_assign(
 		__entry->dev = ip->i_mount->m_super->s_dev;
 		__entry->agno = XFS_INODE_TO_AGNO(ip);
-		__entry->agino = XFS_INO_TO_AGINO(ip->i_mount, ip->i_ino);
+		__entry->agino = XFS_INODE_TO_AGINO(ip);
 		__entry->nlink = VFS_I(ip)->i_nlink;
 		__entry->next_agino = ip->i_next_unlinked;
 	),
@@ -3599,7 +3599,7 @@ TRACE_EVENT(xrep_iunlink_relink_next,
 	TP_fast_assign(
 		__entry->dev = ip->i_mount->m_super->s_dev;
 		__entry->agno = XFS_INODE_TO_AGNO(ip);
-		__entry->agino = XFS_INO_TO_AGINO(ip->i_mount, ip->i_ino);
+		__entry->agino = XFS_INODE_TO_AGINO(ip);
 		__entry->next_agino = ip->i_next_unlinked;
 		__entry->new_next_agino = next_agino;
 	),
@@ -3625,7 +3625,7 @@ TRACE_EVENT(xrep_iunlink_relink_prev,
 	TP_fast_assign(
 		__entry->dev = ip->i_mount->m_super->s_dev;
 		__entry->agno = XFS_INODE_TO_AGNO(ip);
-		__entry->agino = XFS_INO_TO_AGINO(ip->i_mount, ip->i_ino);
+		__entry->agino = XFS_INODE_TO_AGINO(ip);
 		__entry->prev_agino = ip->i_prev_unlinked;
 		__entry->new_prev_agino = prev_agino;
 	),
diff --git a/fs/xfs/xfs_icache.c b/fs/xfs/xfs_icache.c
index 8b86000c796f8..a17434fa034bb 100644
--- a/fs/xfs/xfs_icache.c
+++ b/fs/xfs/xfs_icache.c
@@ -409,7 +409,7 @@ xfs_iget_recycle(
 	 */
 	ip->i_flags &= ~XFS_IRECLAIM_RESET_FLAGS;
 	ip->i_flags |= XFS_INEW;
-	xfs_perag_clear_inode_tag(pag, XFS_INO_TO_AGINO(mp, ip->i_ino),
+	xfs_perag_clear_inode_tag(pag, XFS_INODE_TO_AGINO(ip),
 			XFS_ICI_RECLAIM_TAG);
 	inode->i_state = I_NEW;
 	spin_unlock(&ip->i_flags_lock);
@@ -1284,7 +1284,7 @@ xfs_blockgc_set_iflag(
 	pag = xfs_perag_get(mp, XFS_INODE_TO_AGNO(ip));
 	spin_lock(&pag->pag_ici_lock);
 
-	xfs_perag_set_inode_tag(pag, XFS_INO_TO_AGINO(mp, ip->i_ino),
+	xfs_perag_set_inode_tag(pag, XFS_INODE_TO_AGINO(ip),
 			XFS_ICI_BLOCKGC_TAG);
 
 	spin_unlock(&pag->pag_ici_lock);
@@ -1321,7 +1321,7 @@ xfs_blockgc_clear_iflag(
 	pag = xfs_perag_get(mp, XFS_INODE_TO_AGNO(ip));
 	spin_lock(&pag->pag_ici_lock);
 
-	xfs_perag_clear_inode_tag(pag, XFS_INO_TO_AGINO(mp, ip->i_ino),
+	xfs_perag_clear_inode_tag(pag, XFS_INODE_TO_AGINO(ip),
 			XFS_ICI_BLOCKGC_TAG);
 
 	spin_unlock(&pag->pag_ici_lock);
@@ -1799,7 +1799,7 @@ xfs_icwalk_ag(
 			if (XFS_INODE_TO_AGNO(ip) != pag_agno(pag))
 				continue;
 			first_index = XFS_INO_TO_AGINO(mp, ip->i_ino + 1);
-			if (first_index < XFS_INO_TO_AGINO(mp, ip->i_ino))
+			if (first_index < XFS_INODE_TO_AGINO(ip))
 				done = true;
 		}
 
@@ -1917,7 +1917,7 @@ xfs_inodegc_set_reclaimable(
 	trace_xfs_inode_set_reclaimable(ip);
 	ip->i_flags &= ~(XFS_NEED_INACTIVE | XFS_INACTIVATING);
 	ip->i_flags |= XFS_IRECLAIMABLE;
-	xfs_perag_set_inode_tag(pag, XFS_INO_TO_AGINO(mp, ip->i_ino),
+	xfs_perag_set_inode_tag(pag, XFS_INODE_TO_AGINO(ip),
 			XFS_ICI_RECLAIM_TAG);
 
 	spin_unlock(&ip->i_flags_lock);
diff --git a/fs/xfs/xfs_inode.c b/fs/xfs/xfs_inode.c
index 66277d8156c25..b71b8aec2a9aa 100644
--- a/fs/xfs/xfs_inode.c
+++ b/fs/xfs/xfs_inode.c
@@ -2858,7 +2858,7 @@ xfs_inode_reload_unlinked_bucket(
 	struct xfs_agi		*agi;
 	struct xfs_perag	*pag;
 	xfs_agnumber_t		agno = XFS_INODE_TO_AGNO(ip);
-	xfs_agino_t		agino = XFS_INO_TO_AGINO(mp, ip->i_ino);
+	xfs_agino_t		agino = XFS_INODE_TO_AGINO(ip);
 	xfs_agino_t		prev_agino, next_agino;
 	unsigned int		bucket;
 	bool			foundit = false;
diff --git a/fs/xfs/xfs_trace.h b/fs/xfs/xfs_trace.h
index 47b938aed8359..58f6feda255f0 100644
--- a/fs/xfs/xfs_trace.h
+++ b/fs/xfs/xfs_trace.h
@@ -4500,8 +4500,7 @@ TRACE_EVENT(xfs_iunlink_update_dinode,
 	TP_fast_assign(
 		__entry->dev = pag_mount(iup->pag)->m_super->s_dev;
 		__entry->agno = pag_agno(iup->pag);
-		__entry->agino =
-			XFS_INO_TO_AGINO(iup->ip->i_mount, iup->ip->i_ino);
+		__entry->agino = XFS_INODE_TO_AGINO(iup->ip);
 		__entry->old_ptr = old_ptr;
 		__entry->new_ptr = iup->next_agino;
 	),
@@ -4526,7 +4525,7 @@ TRACE_EVENT(xfs_iunlink_reload_next,
 	TP_fast_assign(
 		__entry->dev = ip->i_mount->m_super->s_dev;
 		__entry->agno = XFS_INODE_TO_AGNO(ip);
-		__entry->agino = XFS_INO_TO_AGINO(ip->i_mount, ip->i_ino);
+		__entry->agino = XFS_INODE_TO_AGINO(ip);
 		__entry->prev_agino = ip->i_prev_unlinked;
 		__entry->next_agino = ip->i_next_unlinked;
 	),
@@ -4549,7 +4548,7 @@ TRACE_EVENT(xfs_inode_reload_unlinked_bucket,
 	TP_fast_assign(
 		__entry->dev = ip->i_mount->m_super->s_dev;
 		__entry->agno = XFS_INODE_TO_AGNO(ip);
-		__entry->agino = XFS_INO_TO_AGINO(ip->i_mount, ip->i_ino);
+		__entry->agino = XFS_INODE_TO_AGINO(ip);
 	),
 	TP_printk("dev %d:%d agno 0x%x agino 0x%x bucket %u",
 		  MAJOR(__entry->dev), MINOR(__entry->dev),
@@ -4569,7 +4568,7 @@ DECLARE_EVENT_CLASS(xfs_ag_inode_class,
 	TP_fast_assign(
 		__entry->dev = VFS_I(ip)->i_sb->s_dev;
 		__entry->agno = XFS_INODE_TO_AGNO(ip);
-		__entry->agino = XFS_INO_TO_AGINO(ip->i_mount, ip->i_ino);
+		__entry->agino = XFS_INODE_TO_AGINO(ip);
 	),
 	TP_printk("dev %d:%d agno 0x%x agino 0x%x",
 		  MAJOR(__entry->dev), MINOR(__entry->dev),
@@ -4766,8 +4765,7 @@ TRACE_EVENT(xfs_btree_commit_ifakeroot,
 		__entry->dev = cur->bc_mp->m_super->s_dev;
 		__assign_str(name);
 		__entry->agno = XFS_INODE_TO_AGNO(cur->bc_ino.ip);
-		__entry->agino = XFS_INO_TO_AGINO(cur->bc_mp,
-					cur->bc_ino.ip->i_ino);
+		__entry->agino = XFS_INODE_TO_AGINO(cur->bc_ino.ip);
 		__entry->levels = cur->bc_ino.ifake->if_levels;
 		__entry->blocks = cur->bc_ino.ifake->if_blocks;
 		__entry->whichfork = cur->bc_ino.whichfork;
-- 
2.53.0

