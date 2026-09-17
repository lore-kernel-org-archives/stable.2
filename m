Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6128351477C
	for <stable@vger.kernel.org>; Thu, 17 Sep 2026 14:01:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789653720; cv=none; b=aAldHsOa7QfgtklT4Ko/RsA6jAjvRXJHQSijVXimhK571o4FcH1loB2Luc0s65c9RQhAi5L5iFpdLrGtBiZ8vGUiInQ395qKatY1bJlDJ+DCiAwVjM6Yeu5n4OLPOtNWeeSwPJ3vAmDE4DWPVVFDWB+0RjhHJdwyUbIExLwFwro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789653720; c=relaxed/simple;
	bh=wG/rEWBnq2tM9Ir3q7AdujdsT84ePoiX4mMbaGnidLI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gx8p7zQ64Brpy/HjIvgPV1plpbnxe9N5WqhHlJncKl/NTFwkuPcLnno5IkK3IXWG+mUni+yDI3MU3C0eZEs1aPb5v+9oDtZnQkwUviys71Sr7ED1KIV3Aqw+QYAkI7NrKHrt8bnMKz3nBMmkpOvTopMbrCAI5sFeU6xn4HEg+WA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=S5DPAirm; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="S5DPAirm"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 59F4F1F000FF;
	Thu, 17 Sep 2026 14:01:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789653719;
	bh=k/wh/lHcuIj3kFMeb8e1DcO5ZCHDJukV5a1rRYgwxYY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=S5DPAirmTW5X9iNuN2JqBQlyewBM0DZuQlw7nYybfQNFolGYYR24hheDL4iX3WCWI
	 OKG+oHag0i0XjW6gIs/ZWMpg1jyhc2dtLkPWY3u3SLVwx7Dq/p7IQW2EE9kWA3Wjzb
	 LQFRZbmEnIl2Ms/SB8HNtyjPhvlGc9ub7VPJfGK2a0CztXjgUXte1+5hDhqoY1upEQ
	 4lVMPxYYR9Zi5IYoasD62DXyBLpVGNSuokg5xWY8RwGJe+p6b0tsgQVp7C+UTs04Y5
	 XHbJADWfszwV+Pdg8IjAZoxsorf/rFUVrSo+naH3DplT9xyK9rxbonE/EmsYh9OCMu
	 EKaPLicvUFs5A==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Christoph Hellwig <hch@lst.de>,
	Carlos Maiolino <cmaiolino@redhat.com>,
	"Darrick J. Wong" <djwong@kernel.org>,
	Carlos Maiolino <cem@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18.y 2/4] xfs: convert xchk_inode_xref_set_corrupt to xchk_ip_xref_set_corrupt
Date: Thu, 17 Sep 2026 10:01:53 -0400
Message-ID: <20260917140155.504217-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260917140155.504217-1-sashal@kernel.org>
References: <2026091628-approval-prefix-a4c6@gregkh>
 <20260917140155.504217-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Christoph Hellwig <hch@lst.de>

[ Upstream commit bef4cee25fbc26ee8b07028e461190fa57b02788 ]

All xref corruption reports have the xfs_inode structure, so switch
the helper to work based on that.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Carlos Maiolino <cmaiolino@redhat.com>
Reviewed-by: "Darrick J. Wong" <djwong@kernel.org>
Signed-off-by: Carlos Maiolino <cem@kernel.org>
Stable-dep-of: 4d3c07591534 ("xfs: fix under-reservation of blocks when repairing sf directories")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/xfs/scrub/common.c    | 6 +++---
 fs/xfs/scrub/common.h    | 4 ++--
 fs/xfs/scrub/dirtree.c   | 4 ++--
 fs/xfs/scrub/inode.c     | 6 +++---
 fs/xfs/scrub/nlinks.c    | 2 +-
 fs/xfs/scrub/rtbitmap.c  | 4 ++--
 fs/xfs/scrub/rtsummary.c | 2 +-
 7 files changed, 14 insertions(+), 14 deletions(-)

diff --git a/fs/xfs/scrub/common.c b/fs/xfs/scrub/common.c
index 58f2ed19ef5ac..ecbf965ad6897 100644
--- a/fs/xfs/scrub/common.c
+++ b/fs/xfs/scrub/common.c
@@ -309,12 +309,12 @@ xchk_ino_set_corrupt(
 
 /* Record a corruption while cross-referencing with an inode. */
 void
-xchk_ino_xref_set_corrupt(
+xchk_ip_xref_set_corrupt(
 	struct xfs_scrub	*sc,
-	xfs_ino_t		ino)
+	struct xfs_inode	*ip)
 {
 	sc->sm->sm_flags |= XFS_SCRUB_OFLAG_XCORRUPT;
-	trace_xchk_ino_error(sc, ino, __return_address);
+	trace_xchk_ino_error(sc, ip->i_ino, __return_address);
 }
 
 /* Record corruption in a block indexed by a file fork. */
diff --git a/fs/xfs/scrub/common.h b/fs/xfs/scrub/common.h
index ae998501f8aa9..5f854d3c7e8e1 100644
--- a/fs/xfs/scrub/common.h
+++ b/fs/xfs/scrub/common.h
@@ -41,8 +41,8 @@ void xchk_qcheck_set_corrupt(struct xfs_scrub *sc, unsigned int dqtype,
 
 void xchk_block_xref_set_corrupt(struct xfs_scrub *sc,
 		struct xfs_buf *bp);
-void xchk_ino_xref_set_corrupt(struct xfs_scrub *sc,
-		xfs_ino_t ino);
+void xchk_ip_xref_set_corrupt(struct xfs_scrub *sc,
+		struct xfs_inode *ip);
 void xchk_fblock_xref_set_corrupt(struct xfs_scrub *sc,
 		int whichfork, xfs_fileoff_t offset);
 
diff --git a/fs/xfs/scrub/dirtree.c b/fs/xfs/scrub/dirtree.c
index e202fbc22b013..543a7aecfc7bb 100644
--- a/fs/xfs/scrub/dirtree.c
+++ b/fs/xfs/scrub/dirtree.c
@@ -954,7 +954,7 @@ xchk_dirtree(
 		 * parent pointers are corrupt; this scan cannot be completed
 		 * without full information.
 		 */
-		xchk_ino_xref_set_corrupt(sc, sc->ip->i_ino);
+		xchk_ip_xref_set_corrupt(sc, sc->ip);
 		error = 0;
 		goto out_scanlock;
 	}
@@ -984,7 +984,7 @@ xchk_dirtree(
 		if (oc.bad || oc.good + oc.suspect != 1)
 			xchk_ip_set_corrupt(sc, sc->ip);
 		if (oc.suspect)
-			xchk_ino_xref_set_corrupt(sc, sc->ip->i_ino);
+			xchk_ip_xref_set_corrupt(sc, sc->ip);
 	}
 
 out_scanlock:
diff --git a/fs/xfs/scrub/inode.c b/fs/xfs/scrub/inode.c
index bb3f475b63532..0d30d65f336a3 100644
--- a/fs/xfs/scrub/inode.c
+++ b/fs/xfs/scrub/inode.c
@@ -710,17 +710,17 @@ xchk_inode_xref_bmap(
 	if (!xchk_should_check_xref(sc, &error, NULL))
 		return;
 	if (nextents < xfs_dfork_data_extents(dip))
-		xchk_ino_xref_set_corrupt(sc, sc->ip->i_ino);
+		xchk_ip_xref_set_corrupt(sc, sc->ip);
 
 	error = xchk_inode_count_blocks(sc, XFS_ATTR_FORK, &nextents, &acount);
 	if (!xchk_should_check_xref(sc, &error, NULL))
 		return;
 	if (nextents != xfs_dfork_attr_extents(dip))
-		xchk_ino_xref_set_corrupt(sc, sc->ip->i_ino);
+		xchk_ip_xref_set_corrupt(sc, sc->ip);
 
 	/* Check nblocks against the inode. */
 	if (count + acount != be64_to_cpu(dip->di_nblocks))
-		xchk_ino_xref_set_corrupt(sc, sc->ip->i_ino);
+		xchk_ip_xref_set_corrupt(sc, sc->ip);
 }
 
 /* Cross-reference with the other btrees. */
diff --git a/fs/xfs/scrub/nlinks.c b/fs/xfs/scrub/nlinks.c
index 988262fc99533..d783b32a0b281 100644
--- a/fs/xfs/scrub/nlinks.c
+++ b/fs/xfs/scrub/nlinks.c
@@ -741,7 +741,7 @@ xchk_nlinks_compare_inode(
 		 * number of subdirectory entries in the directory.
 		 */
 		if (obs.children != obs.backrefs)
-			xchk_ino_xref_set_corrupt(sc, ip->i_ino);
+			xchk_ip_xref_set_corrupt(sc, ip);
 	} else {
 		/*
 		 * Non-directories and unlinked directories should not have
diff --git a/fs/xfs/scrub/rtbitmap.c b/fs/xfs/scrub/rtbitmap.c
index 68b8338707608..639e1328c199d 100644
--- a/fs/xfs/scrub/rtbitmap.c
+++ b/fs/xfs/scrub/rtbitmap.c
@@ -284,7 +284,7 @@ xchk_xref_is_used_rt_space(
 	if (xfs_has_zoned(sc->mp)) {
 		if (!xfs_zone_rgbno_is_valid(rtg,
 				xfs_rtb_to_rgbno(sc->mp, rtbno) + len - 1))
-			xchk_ino_xref_set_corrupt(sc, rtg_rmap(rtg)->i_ino);
+			xchk_ip_xref_set_corrupt(sc, rtg_rmap(rtg));
 		return;
 	}
 
@@ -295,5 +295,5 @@ xchk_xref_is_used_rt_space(
 	if (!xchk_should_check_xref(sc, &error, NULL))
 		return;
 	if (is_free)
-		xchk_ino_xref_set_corrupt(sc, rtg_bitmap(rtg)->i_ino);
+		xchk_ip_xref_set_corrupt(sc, rtg_bitmap(rtg));
 }
diff --git a/fs/xfs/scrub/rtsummary.c b/fs/xfs/scrub/rtsummary.c
index dbbbafe8b92d6..a1e2aa580bc1b 100644
--- a/fs/xfs/scrub/rtsummary.c
+++ b/fs/xfs/scrub/rtsummary.c
@@ -190,7 +190,7 @@ xchk_rtsum_record_free(
 	rtlen = xfs_rtxlen_to_extlen(mp, rec->ar_extcount);
 
 	if (!xfs_verify_rtbext(mp, rtbno, rtlen)) {
-		xchk_ino_xref_set_corrupt(sc, rtg_bitmap(rtg)->i_ino);
+		xchk_ip_xref_set_corrupt(sc, rtg_bitmap(rtg));
 		return -EFSCORRUPTED;
 	}
 
-- 
2.53.0

