Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 814577E792
	for <stable@vger.kernel.org>; Sun, 23 Aug 2026 18:03:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787508235; cv=none; b=he2Aj5fD6OKEMeAXxSaqwvi2+Hz/4zBqBOwGepaih2ceGPc7m8nOsChjxqxu2VldSQHD6M8790+N5i/I2oZ3VVjnc78EHxqTAKktupQ0Tg6WKqx0lTGis1NUtdvqqmpxTWRCt8ZjASBTBM6x9OYpvnonLi0U7cE1d54Zt81J28M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787508235; c=relaxed/simple;
	bh=LYBj4Njp9O1ZkxYgqUb/9CKS036DHq3z1hPjSb+wwC8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=by2cuYXdwOGfMqA/pukl2wSTHoZE2+IB8cuhUpZXZB8MahH8iv/O3Ja0exmiuBo0wEofIOFyxHAnvydzqnDXyIGxqEVq1xSb+/84XzdB/4Q5NH3CEEAjx7DjX+iXcZMbyChnFree4N2uMEZb6ZQHtRTlo+eFIBWzUCKjuzih9/M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=argSRvDx; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="argSRvDx"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A319E1F00A3E;
	Sun, 23 Aug 2026 18:03:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787508234;
	bh=+4H15LS102bQcPNQICQUZAlrpvIQ1Xd3BjQ/jnDBTTA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=argSRvDxZv/YFmNoJ7/XCkCp7EgBz5elmAJWrPNQvqvDeF57VDnA2yPHwYsTLRt4S
	 Jtr7JLN5uJ5bnzP4YRSr1JgU+n5hDCv3glAto2DnXcNw6e8TcKwNmL0NkqJfXjl63j
	 6k3bvtXsMcCieaTimSWKSnbcvHHFJesS15IP1F2c9+0Ue1Q4L2TS8UF+s2DSwK+GDO
	 YC9ehy95Ukfy+t7wlm+1Q5/pzeanNsick1aCTM6gaPPlUaGHcCz5b9kyLFplHltGYe
	 ExCizSIGEXKYf3JOCRi6jlKTCJpLSPDBS+I9TgtDb2VMwmapx8Rexj0iX9Od1Rw1/Z
	 fGQ3XQk14SA9Q==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: "Darrick J. Wong" <djwong@kernel.org>,
	Christoph Hellwig <hch@lst.de>,
	Carlos Maiolino <cem@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 7.1.y 2/2] xfs: don't livelock in scrub on a circular unlinked list
Date: Sun, 23 Aug 2026 14:03:51 -0400
Message-ID: <20260823180351.1420766-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260823180351.1420766-1-sashal@kernel.org>
References: <2026082043-tameness-radiated-971a@gregkh>
 <20260823180351.1420766-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Darrick J. Wong" <djwong@kernel.org>

[ Upstream commit 527eaaefddb6ec5c83a06c9a1559960dd6361753 ]

LOLLM points out that online fsck can livelock if an unlinked inode list
contains a loop.  Use a bitmap to detect cycles.

Cc: stable@vger.kernel.org # v4.15
Fixes: a12890aebb8959 ("xfs: scrub the AGI")
Signed-off-by: Darrick J. Wong <djwong@kernel.org>
Assisted-by: LOLLM # finding obvious bugs
Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Carlos Maiolino <cem@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/xfs/scrub/agheader.c        | 46 +++++++++++++++++++++++++++-------
 fs/xfs/scrub/agheader_repair.c | 17 +++++++++++--
 2 files changed, 52 insertions(+), 11 deletions(-)

diff --git a/fs/xfs/scrub/agheader.c b/fs/xfs/scrub/agheader.c
index cecf034ef989c..1fa66aa68e169 100644
--- a/fs/xfs/scrub/agheader.c
+++ b/fs/xfs/scrub/agheader.c
@@ -18,6 +18,8 @@
 #include "xfs_inode.h"
 #include "scrub/scrub.h"
 #include "scrub/common.h"
+#include "scrub/bitmap.h"
+#include "scrub/agino_bitmap.h"
 
 int
 xchk_setup_agheader(
@@ -935,7 +937,8 @@ xchk_agi_xref(
 /*
  * Walk the incore unlinked list for a particular AGI bucket to construct
  * the unlinked inode bitmap for later reconstruction of the unlinked list.
- * Returns 1 if we should keep checking, or 0 to stop checking.
+ * Returns 1 if we should keep checking, 0 to stop checking, or a negative
+ * errno.
  */
 static int
 xchk_iunlink_bucket(
@@ -943,36 +946,57 @@ xchk_iunlink_bucket(
 	unsigned int			bucket,
 	xfs_agino_t			agino)
 {
+	struct xagino_bitmap		seen;
+	int				ret;
+
+	xagino_bitmap_init(&seen);
+
 	while (agino != NULLAGINO) {
 		struct xfs_inode	*ip;
+		unsigned int		len = 1;
 
 		if (agino % XFS_AGI_UNLINKED_BUCKETS != bucket) {
 			xchk_block_set_corrupt(sc, sc->sa.agi_bp);
-			return 0;
+			goto bad;
+		}
+
+		if (xagino_bitmap_test(&seen, agino, &len)) {
+			xchk_block_set_corrupt(sc, sc->sa.agi_bp);
+			goto bad;
 		}
 
 		ip = xfs_iunlink_lookup(sc->sa.pag, agino);
 		if (!ip) {
 			xchk_block_set_corrupt(sc, sc->sa.agi_bp);
-			return 0;
+			goto bad;
 		}
 
 		if (!xfs_inode_on_unlinked_list(ip)) {
 			xchk_block_set_corrupt(sc, sc->sa.agi_bp);
-			return 0;
+			goto bad;
 		}
 
+		ret = xagino_bitmap_set(&seen, agino, 1);
+		if (ret)
+			goto out_bitmap;
+
 		agino = ip->i_next_unlinked;
 	}
-
-	return 1;
+	ret = 1;
+
+out_bitmap:
+	xagino_bitmap_destroy(&seen);
+	return ret;
+bad:
+	ret = 0;
+	goto out_bitmap;
 }
 
 /*
  * Check the unlinked buckets for links to bad inodes.  We hold the AGI, so
  * there cannot be any threads updating unlinked list pointers in this AG.
  */
-STATIC void
+STATIC int
 xchk_iunlink(
 	struct xfs_scrub	*sc,
 	struct xfs_agi		*agi)
@@ -985,8 +1009,10 @@ xchk_iunlink(
 		ret = xchk_iunlink_bucket(sc, i,
 				be32_to_cpu(agi->agi_unlinked[i]));
 		if (ret < 1)
-			return;
+			return ret;
 	}
+
+	return 0;
 }
 
 /* Scrub the AGI. */
@@ -1073,7 +1099,9 @@ xchk_agi(
 	if (pag->pagi_freecount != be32_to_cpu(agi->agi_freecount))
 		xchk_block_set_corrupt(sc, sc->sa.agi_bp);
 
-	xchk_iunlink(sc, agi);
+	error = xchk_iunlink(sc, agi);
+	if (error)
+		goto out;
 
 	xchk_agi_xref(sc);
 out:
diff --git a/fs/xfs/scrub/agheader_repair.c b/fs/xfs/scrub/agheader_repair.c
index c2acd77482699..59375b759ba8f 100644
--- a/fs/xfs/scrub/agheader_repair.c
+++ b/fs/xfs/scrub/agheader_repair.c
@@ -1096,18 +1096,22 @@ xrep_iunlink_walk_ondisk_bucket(
 	struct xrep_agi		*ragi,
 	unsigned int		bucket)
 {
+	struct xagino_bitmap	seen;
 	struct xfs_scrub	*sc = ragi->sc;
 	struct xfs_agi		*agi = ragi->agi_bp->b_addr;
 	xfs_agino_t		prev_agino = NULLAGINO;
 	xfs_agino_t		next_agino;
 	int			error = 0;
 
+	xagino_bitmap_init(&seen);
+
 	next_agino = be32_to_cpu(agi->agi_unlinked[bucket]);
 	while (next_agino != NULLAGINO) {
 		xfs_agino_t	agino = next_agino;
+		unsigned int	len = 1;
 
 		if (xchk_should_terminate(ragi->sc, &error))
-			return error;
+			goto out_bitmap;
 
 		trace_xrep_iunlink_walk_ondisk_bucket(sc->sa.pag, bucket,
 				prev_agino, agino);
@@ -1115,6 +1119,9 @@ xrep_iunlink_walk_ondisk_bucket(
 		if (bucket != agino % XFS_AGI_UNLINKED_BUCKETS)
 			break;
 
+		if (xagino_bitmap_test(&seen, agino, &len))
+			break;
+
 		next_agino = xrep_iunlink_next(sc, agino);
 		if (!next_agino) {
 			error = xrep_iunlink_reload_next(ragi, prev_agino,
@@ -1123,10 +1130,16 @@ xrep_iunlink_walk_ondisk_bucket(
 				break;
 		}
 
+		error = xagino_bitmap_set(&seen, agino, 1);
+		if (error)
+			goto out_bitmap;
+
 		prev_agino = agino;
 	}
 
-	return 0;
+out_bitmap:
+	xagino_bitmap_destroy(&seen);
+	return error;
 }
 
 /* Decide if this is an unlinked inode in this AG. */
-- 
2.53.0

