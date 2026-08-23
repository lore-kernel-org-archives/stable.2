Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7859331ED3
	for <stable@vger.kernel.org>; Sun, 23 Aug 2026 18:04:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787508255; cv=none; b=UO6zlGj4Y8jDQHo5KBsd7VZhMbj94HINap9SozA/ZGCHUyQ1k8ks86mCLEP98CYMkhCClfrB6ATU8kxr8+fAUxzQdHf9xo05HX8xlhLP9cd0wkELcok8/OPoxHolUTOS6ZrTxtosyo6KnLEqZIm85RsTW6Gz9iMCrqICiZd+4T8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787508255; c=relaxed/simple;
	bh=VouyjU30cyvRLaQtT++9EAm3YXTpNYw05ciVQiJ4iKs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BTkJUtlIuSg+47KY+R6FAyZy306xzIurZ+KR226Xj+FLHVnQiAveAtqBqeFvq4ZfLnT/zQq9ez8c30lcLQvnyQwNiTgwiT7FdBly671BE6W2gI0FgyhgslNBcK3P3TMV8cQpAyqa1N7GHKGBXpnJEsbhwwhAGOdxPqzRsTAyOQc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ioAmy0Gb; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ioAmy0Gb"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CCC151F000E9;
	Sun, 23 Aug 2026 18:04:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787508253;
	bh=jeIRgEnwBlNXLiAh7ZCrkgRbDlNdbqji+M/YBUmMFtI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ioAmy0GbkGiUlfmVP6aw9VdgITaXxxod8EffZNdL5+Sy433Cvyyd5URQblVtlk8At
	 ZctCivigvgJvOF9cSzFlTYWXbEN7heeHUdmBb440XKzK2HvIL4+HxwUh7jZdtuNgrl
	 HLRYd8e8AppiDfxllTT1Zhl3MpJxClM09CHXHYjla+ge872Smn+Wh3HQ8BpPBUZgH3
	 eP/Fm/WE2SYO7yaONvkEKaucF8tuDHcADAud30NXNf+tXjYfFjr8kHwqF+D/af0BMI
	 oBWoTA0Aef8D08LN2K+6smfqpSd4VT1Lvt5Io7451m3QGzwa4/2WOK/x76PCCC0lyn
	 Hxf6VpQKaOt6w==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Christoph Hellwig <hch@lst.de>,
	Carlos Maiolino <cmaiolino@redhat.com>,
	"Darrick J. Wong" <djwong@kernel.org>,
	Carlos Maiolino <cem@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 7.1.y 1/2] xfs: add a xchk_ip_set_corrupt helper
Date: Sun, 23 Aug 2026 14:04:10 -0400
Message-ID: <20260823180411.1424993-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026082037-faceted-nearby-f8fe@gregkh>
References: <2026082037-faceted-nearby-f8fe@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Christoph Hellwig <hch@lst.de>

[ Upstream commit aa7cfdb6e16b474328c79736f9b9dad09addc81c ]

Add a smaller wrapper to set a inode corrupted by the xfs_inode
pointer.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Carlos Maiolino <cmaiolino@redhat.com>
Reviewed-by: "Darrick J. Wong" <djwong@kernel.org>
Signed-off-by: Carlos Maiolino <cem@kernel.org>
Stable-dep-of: 8ed78104722b ("xfs: rtsummary scrub should treat rtbitmap corruption errors as an xref error")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/xfs/scrub/bmap.c      |  8 ++++----
 fs/xfs/scrub/common.c    | 10 +++++-----
 fs/xfs/scrub/common.h    |  2 ++
 fs/xfs/scrub/dir.c       |  2 +-
 fs/xfs/scrub/dirtree.c   |  4 ++--
 fs/xfs/scrub/metapath.c  |  6 +++---
 fs/xfs/scrub/nlinks.c    | 12 ++++++------
 fs/xfs/scrub/parent.c    |  6 +++---
 fs/xfs/scrub/rtbitmap.c  | 12 ++++++------
 fs/xfs/scrub/rtsummary.c | 12 ++++++------
 10 files changed, 38 insertions(+), 36 deletions(-)

diff --git a/fs/xfs/scrub/bmap.c b/fs/xfs/scrub/bmap.c
index 35e51709a58a1..38b5d47afadda 100644
--- a/fs/xfs/scrub/bmap.c
+++ b/fs/xfs/scrub/bmap.c
@@ -1040,7 +1040,7 @@ xchk_bmap(
 	case XFS_COW_FORK:
 		/* No CoW forks filesystem doesn't support out of place writes */
 		if (!xfs_has_reflink(mp) && !xfs_has_zoned(mp)) {
-			xchk_ino_set_corrupt(sc, sc->ip->i_ino);
+			xchk_ip_set_corrupt(sc, sc->ip);
 			return 0;
 		}
 		break;
@@ -1052,7 +1052,7 @@ xchk_bmap(
 		 * attr here.
 		 */
 		if (!xfs_has_attr(mp))
-			xchk_ino_set_corrupt(sc, sc->ip->i_ino);
+			xchk_ip_set_corrupt(sc, sc->ip);
 		break;
 	default:
 		ASSERT(whichfork == XFS_DATA_FORK);
@@ -1137,7 +1137,7 @@ xchk_bmap_data(
 	int			error;
 
 	if (xchk_file_looks_zapped(sc, XFS_SICK_INO_BMBTD_ZAPPED)) {
-		xchk_ino_set_corrupt(sc, sc->ip->i_ino);
+		xchk_ip_set_corrupt(sc, sc->ip);
 		return 0;
 	}
 
@@ -1165,7 +1165,7 @@ xchk_bmap_attr(
 	 * returning immediately.
 	 */
 	if (xchk_file_looks_zapped(sc, XFS_SICK_INO_BMBTA_ZAPPED)) {
-		xchk_ino_set_corrupt(sc, sc->ip->i_ino);
+		xchk_ip_set_corrupt(sc, sc->ip);
 		return 0;
 	}
 
diff --git a/fs/xfs/scrub/common.c b/fs/xfs/scrub/common.c
index 3d40cb0b2496c..b271f4c4ef436 100644
--- a/fs/xfs/scrub/common.c
+++ b/fs/xfs/scrub/common.c
@@ -1110,7 +1110,7 @@ xchk_install_live_inode(
 	struct xfs_inode	*ip)
 {
 	if (!igrab(VFS_I(ip))) {
-		xchk_ino_set_corrupt(sc, ip->i_ino);
+		xchk_ip_set_corrupt(sc, ip);
 		return -EFSCORRUPTED;
 	}
 
@@ -1439,13 +1439,13 @@ xchk_metadata_inode_forks(
 
 	/* Metadata inodes don't live on the rt device. */
 	if (sc->ip->i_diflags & XFS_DIFLAG_REALTIME) {
-		xchk_ino_set_corrupt(sc, sc->ip->i_ino);
+		xchk_ip_set_corrupt(sc, sc->ip);
 		return 0;
 	}
 
 	/* They should never participate in reflink. */
 	if (xfs_is_reflink_inode(sc->ip)) {
-		xchk_ino_set_corrupt(sc, sc->ip->i_ino);
+		xchk_ip_set_corrupt(sc, sc->ip);
 		return 0;
 	}
 
@@ -1462,7 +1462,7 @@ xchk_metadata_inode_forks(
 				&error))
 			return error;
 		if (shared)
-			xchk_ino_set_corrupt(sc, sc->ip->i_ino);
+			xchk_ip_set_corrupt(sc, sc->ip);
 	}
 
 	/*
@@ -1471,7 +1471,7 @@ xchk_metadata_inode_forks(
 	 */
 	if (xfs_inode_hasattr(sc->ip)) {
 		if (!xfs_has_metadir(sc->mp)) {
-			xchk_ino_set_corrupt(sc, sc->ip->i_ino);
+			xchk_ip_set_corrupt(sc, sc->ip);
 			return 0;
 		}
 
diff --git a/fs/xfs/scrub/common.h b/fs/xfs/scrub/common.h
index b494d747c0084..0e23b125720f3 100644
--- a/fs/xfs/scrub/common.h
+++ b/fs/xfs/scrub/common.h
@@ -32,6 +32,8 @@ void xchk_set_corrupt(struct xfs_scrub *sc);
 void xchk_block_set_corrupt(struct xfs_scrub *sc,
 		struct xfs_buf *bp);
 void xchk_ino_set_corrupt(struct xfs_scrub *sc, xfs_ino_t ino);
+#define xchk_ip_set_corrupt(_sc, _ip) \
+	xchk_ino_set_corrupt((_sc), (_ip)->i_ino)
 void xchk_fblock_set_corrupt(struct xfs_scrub *sc, int whichfork,
 		xfs_fileoff_t offset);
 #ifdef CONFIG_XFS_QUOTA
diff --git a/fs/xfs/scrub/dir.c b/fs/xfs/scrub/dir.c
index 09715a4aa154b..8306dfafff3bc 100644
--- a/fs/xfs/scrub/dir.c
+++ b/fs/xfs/scrub/dir.c
@@ -1080,7 +1080,7 @@ xchk_directory(
 
 	/* Plausible size? */
 	if (sc->ip->i_disk_size < xfs_dir2_sf_hdr_size(0)) {
-		xchk_ino_set_corrupt(sc, sc->ip->i_ino);
+		xchk_ip_set_corrupt(sc, sc->ip);
 		return 0;
 	}
 
diff --git a/fs/xfs/scrub/dirtree.c b/fs/xfs/scrub/dirtree.c
index 19f014e2ece6a..7eb285ecc5e26 100644
--- a/fs/xfs/scrub/dirtree.c
+++ b/fs/xfs/scrub/dirtree.c
@@ -979,10 +979,10 @@ xchk_dirtree(
 	xchk_dirtree_evaluate(dl, &oc);
 	if (xchk_dirtree_parentless(dl)) {
 		if (oc.good || oc.bad || oc.suspect)
-			xchk_ino_set_corrupt(sc, sc->ip->i_ino);
+			xchk_ip_set_corrupt(sc, sc->ip);
 	} else {
 		if (oc.bad || oc.good + oc.suspect != 1)
-			xchk_ino_set_corrupt(sc, sc->ip->i_ino);
+			xchk_ip_set_corrupt(sc, sc->ip);
 		if (oc.suspect)
 			xchk_ino_xref_set_corrupt(sc, sc->ip->i_ino);
 	}
diff --git a/fs/xfs/scrub/metapath.c b/fs/xfs/scrub/metapath.c
index 050b86eb12d3e..680a8ba1cdf11 100644
--- a/fs/xfs/scrub/metapath.c
+++ b/fs/xfs/scrub/metapath.c
@@ -314,7 +314,7 @@ xchk_metapath(
 
 	/* Parent required to do anything else. */
 	if (mpath->dp == NULL) {
-		xchk_ino_set_corrupt(sc, sc->ip->i_ino);
+		xchk_ip_set_corrupt(sc, sc->ip);
 		return 0;
 	}
 
@@ -329,7 +329,7 @@ xchk_metapath(
 	trace_xchk_metapath_lookup(sc, mpath->path, mpath->dp, ino);
 	if (error == -ENOENT) {
 		/* No directory entry at all */
-		xchk_ino_set_corrupt(sc, sc->ip->i_ino);
+		xchk_ip_set_corrupt(sc, sc->ip);
 		error = 0;
 		goto out_ilock;
 	}
@@ -337,7 +337,7 @@ xchk_metapath(
 		goto out_ilock;
 	if (ino != sc->ip->i_ino) {
 		/* Pointing to wrong inode */
-		xchk_ino_set_corrupt(sc, sc->ip->i_ino);
+		xchk_ip_set_corrupt(sc, sc->ip);
 	}
 
 out_ilock:
diff --git a/fs/xfs/scrub/nlinks.c b/fs/xfs/scrub/nlinks.c
index 80b28b30d762b..5d0a8d837fede 100644
--- a/fs/xfs/scrub/nlinks.c
+++ b/fs/xfs/scrub/nlinks.c
@@ -719,7 +719,7 @@ xchk_nlinks_compare_inode(
 	 * count, but it will let them decrease it.
 	 */
 	if (total_links > XFS_NLINK_PINNED) {
-		xchk_ino_set_corrupt(sc, ip->i_ino);
+		xchk_ip_set_corrupt(sc, ip);
 		goto out_corrupt;
 	} else if (total_links > XFS_MAXLINK) {
 		xchk_ino_set_warning(sc, ip->i_ino);
@@ -727,7 +727,7 @@ xchk_nlinks_compare_inode(
 
 	/* Link counts should match. */
 	if (total_links != actual_nlink) {
-		xchk_ino_set_corrupt(sc, ip->i_ino);
+		xchk_ip_set_corrupt(sc, ip);
 		goto out_corrupt;
 	}
 
@@ -748,7 +748,7 @@ xchk_nlinks_compare_inode(
 		 * back references.
 		 */
 		if (obs.backrefs != 0) {
-			xchk_ino_set_corrupt(sc, ip->i_ino);
+			xchk_ip_set_corrupt(sc, ip);
 			goto out_corrupt;
 		}
 
@@ -757,7 +757,7 @@ xchk_nlinks_compare_inode(
 		 * children.
 		 */
 		if (obs.children != 0) {
-			xchk_ino_set_corrupt(sc, ip->i_ino);
+			xchk_ip_set_corrupt(sc, ip);
 			goto out_corrupt;
 		}
 	}
@@ -770,7 +770,7 @@ xchk_nlinks_compare_inode(
 		 * the root directory.
 		 */
 		if (obs.parents != 1) {
-			xchk_ino_set_corrupt(sc, ip->i_ino);
+			xchk_ip_set_corrupt(sc, ip);
 			goto out_corrupt;
 		}
 	} else if (actual_nlink > 0) {
@@ -779,7 +779,7 @@ xchk_nlinks_compare_inode(
 		 * least one parent.
 		 */
 		if (obs.parents == 0) {
-			xchk_ino_set_corrupt(sc, ip->i_ino);
+			xchk_ip_set_corrupt(sc, ip);
 			goto out_corrupt;
 		}
 	}
diff --git a/fs/xfs/scrub/parent.c b/fs/xfs/scrub/parent.c
index 8e321b24181cc..dc25e5c84ac14 100644
--- a/fs/xfs/scrub/parent.c
+++ b/fs/xfs/scrub/parent.c
@@ -729,10 +729,10 @@ xchk_parent_count_pptrs(
 			pp->pptrs_found++;
 
 		if (VFS_I(sc->ip)->i_nlink == 0 && pp->pptrs_found > 0)
-			xchk_ino_set_corrupt(sc, sc->ip->i_ino);
+			xchk_ip_set_corrupt(sc, sc->ip);
 		else if (VFS_I(sc->ip)->i_nlink > 0 &&
 			 pp->pptrs_found == 0)
-			xchk_ino_set_corrupt(sc, sc->ip->i_ino);
+			xchk_ip_set_corrupt(sc, sc->ip);
 	} else {
 		/*
 		 * Starting with metadir, we allow checking of parent pointers
@@ -743,7 +743,7 @@ xchk_parent_count_pptrs(
 			pp->pptrs_found++;
 
 		if (VFS_I(sc->ip)->i_nlink != pp->pptrs_found)
-			xchk_ino_set_corrupt(sc, sc->ip->i_ino);
+			xchk_ip_set_corrupt(sc, sc->ip);
 	}
 
 	return 0;
diff --git a/fs/xfs/scrub/rtbitmap.c b/fs/xfs/scrub/rtbitmap.c
index 88b438d8fd89e..97dbe5779a79f 100644
--- a/fs/xfs/scrub/rtbitmap.c
+++ b/fs/xfs/scrub/rtbitmap.c
@@ -200,13 +200,13 @@ xchk_rtbitmap(
 
 	/* Is sb_rextents correct? */
 	if (mp->m_sb.sb_rextents != rtb->rextents) {
-		xchk_ino_set_corrupt(sc, rbmip->i_ino);
+		xchk_ip_set_corrupt(sc, rbmip);
 		return 0;
 	}
 
 	/* Is sb_rextslog correct? */
 	if (mp->m_sb.sb_rextslog != rtb->rextslog) {
-		xchk_ino_set_corrupt(sc, rbmip->i_ino);
+		xchk_ip_set_corrupt(sc, rbmip);
 		return 0;
 	}
 
@@ -215,17 +215,17 @@ xchk_rtbitmap(
 	 * case can we exceed 4bn bitmap blocks since the super field is a u32.
 	 */
 	if (rtb->rbmblocks > U32_MAX) {
-		xchk_ino_set_corrupt(sc, rbmip->i_ino);
+		xchk_ip_set_corrupt(sc, rbmip);
 		return 0;
 	}
 	if (mp->m_sb.sb_rbmblocks != rtb->rbmblocks) {
-		xchk_ino_set_corrupt(sc, rbmip->i_ino);
+		xchk_ip_set_corrupt(sc, rbmip);
 		return 0;
 	}
 
 	/* The bitmap file length must be aligned to an fsblock. */
 	if (rbmip->i_disk_size & mp->m_blockmask) {
-		xchk_ino_set_corrupt(sc, rbmip->i_ino);
+		xchk_ip_set_corrupt(sc, rbmip);
 		return 0;
 	}
 
@@ -235,7 +235,7 @@ xchk_rtbitmap(
 	 * file can be larger than sb_rbmblocks.
 	 */
 	if (rbmip->i_disk_size < XFS_FSB_TO_B(mp, rtb->rbmblocks)) {
-		xchk_ino_set_corrupt(sc, rbmip->i_ino);
+		xchk_ip_set_corrupt(sc, rbmip);
 		return 0;
 	}
 
diff --git a/fs/xfs/scrub/rtsummary.c b/fs/xfs/scrub/rtsummary.c
index efce39d7a1ef7..18074c1ff166a 100644
--- a/fs/xfs/scrub/rtsummary.c
+++ b/fs/xfs/scrub/rtsummary.c
@@ -314,25 +314,25 @@ xchk_rtsummary(
 
 	/* Is sb_rextents correct? */
 	if (mp->m_sb.sb_rextents != rts->rextents) {
-		xchk_ino_set_corrupt(sc, rbmip->i_ino);
+		xchk_ip_set_corrupt(sc, rbmip);
 		return 0;
 	}
 
 	/* Is m_rsumlevels correct? */
 	if (mp->m_rsumlevels != rts->rsumlevels) {
-		xchk_ino_set_corrupt(sc, rsumip->i_ino);
+		xchk_ip_set_corrupt(sc, rsumip);
 		return 0;
 	}
 
 	/* Is m_rsumsize correct? */
 	if (mp->m_rsumblocks != rts->rsumblocks) {
-		xchk_ino_set_corrupt(sc, rsumip->i_ino);
+		xchk_ip_set_corrupt(sc, rsumip);
 		return 0;
 	}
 
 	/* The summary file length must be aligned to an fsblock. */
 	if (rsumip->i_disk_size & mp->m_blockmask) {
-		xchk_ino_set_corrupt(sc, rsumip->i_ino);
+		xchk_ip_set_corrupt(sc, rsumip);
 		return 0;
 	}
 
@@ -342,7 +342,7 @@ xchk_rtsummary(
 	 * the file can be larger than rsumsize.
 	 */
 	if (rsumip->i_disk_size < XFS_FSB_TO_B(mp, rts->rsumblocks)) {
-		xchk_ino_set_corrupt(sc, rsumip->i_ino);
+		xchk_ip_set_corrupt(sc, rsumip);
 		return 0;
 	}
 
@@ -358,7 +358,7 @@ xchk_rtsummary(
 		 * EFSCORRUPTED means the rtbitmap is corrupt, which is an xref
 		 * error since we're checking the summary file.
 		 */
-		xchk_ino_set_corrupt(sc, rbmip->i_ino);
+		xchk_ip_set_corrupt(sc, rbmip);
 		return 0;
 	}
 	if (error)
-- 
2.53.0

