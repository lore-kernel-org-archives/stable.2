Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F087F4E2F3C
	for <stable@vger.kernel.org>; Thu, 17 Sep 2026 15:17:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789658274; cv=none; b=fVWYfEFz0SB/8Wauo34op6XfrlqSYR+8VNeHCAAovyESKDzFbnpzzWj8GAV14roGmxMpCZvyMVmgKSFvQJhqceAiHtXXk5cZ6JKg6i65eVH1AyOvJDAWRrhxNEWdW1paiLaLSxTILewgYom+UqSFmiqIcYJC1CI5K5RYKCpNys0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789658274; c=relaxed/simple;
	bh=y+q7/fUhILXKeecjuqnxY3+VqV4s8hQE7n41BqHd3Dc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QpKZMbTOKdQmFd+mQwHjuda6JxJp43aae7L2lsIsi+w350BuFaxBHki99WxRzM92owbbmiZxFufayJvRYfjpSq5vEgdzUWVZXehZNboafeaD0/nKa+m0ACxNmQNc8XjY9sHj/GPVOK1DD9c4vC2PiZAiTuci4ensZWTRt2VP8Bs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=D5/1tSz2; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="D5/1tSz2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E20291F00902;
	Thu, 17 Sep 2026 15:17:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789658251;
	bh=FnE6p6Te5V2D7Uj6oC2Pmj/GSLYDaeP9Qd5Gm+VIIsQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=D5/1tSz2Cg4miJSXXiJPJRL1ZWL3S4aPrDDcRBhEhh3LYtgpJS5bjk+bx9ZmOEqXR
	 btWY6epEjhclk5t9k4qM76/Wc0Lxla0eHYF96v/2sa3QSgBxIkFWD3kImDUjJZEM8R
	 UyiQUZhXaiTyPL0IwzNC9f/Qr0i6Qr2FfMGaKWiWugzMKk/2ZWUfqdRACK0NxliiFl
	 2uCpV4N7KS+qKgTE0/2k2v36904OTYtPQVPo7130c24x9o2W3sCJvCi1mPDrTzFmDu
	 KrbBNNum5KPEbAx1f20qNOSCgzs0mjg2aLPFp8J8ezdUd8qL0sLz8Gm9M7k2oWUm17
	 TTAsgH8zWI4Kw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Christoph Hellwig <hch@lst.de>,
	Carlos Maiolino <cmaiolino@redhat.com>,
	"Darrick J. Wong" <djwong@kernel.org>,
	Carlos Maiolino <cem@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18.y 7/9] xfs: convert xchk_inode_xref_set_corrupt to xchk_ip_xref_set_corrupt
Date: Thu, 17 Sep 2026 11:17:21 -0400
Message-ID: <20260917151724.693663-7-sashal@kernel.org>
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

[ Upstream commit bef4cee25fbc26ee8b07028e461190fa57b02788 ]

All xref corruption reports have the xfs_inode structure, so switch
the helper to work based on that.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Carlos Maiolino <cmaiolino@redhat.com>
Reviewed-by: "Darrick J. Wong" <djwong@kernel.org>
Signed-off-by: Carlos Maiolino <cem@kernel.org>
Stable-dep-of: 865b751e7503 ("xfs: don't stash removename operations with unknown ftype")
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

