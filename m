Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 665DF23643F
	for <stable@vger.kernel.org>; Mon, 24 Aug 2026 00:24:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787531083; cv=none; b=jZgGz2YxQCEI0UC43to6qPjoR0jUxVTm4/7UzB5Og9KDG6jdW5nIaMvXeKswUM4EcMAxGn897l01lquLJAg0g1evIVirv+XkfzBepZ/yKfdX2DWbj4yVmuQH/XGheASVDzNPXviOVNQDBYVwD+nUND4SejUk55feMrYA9n/2Ol0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787531083; c=relaxed/simple;
	bh=VuyVw5l/tyLWpb7fQJQk9ZlEqSl2rT9vxJ8ZNcpNCvY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ADDRVy2YVV5bUZFMzDNnMq/v7wlKC228CbkP2PmidtyZ3OH4Nr/YJE7BWd6zj3Fw6osDMCxj849HBPC4MD1ZHO6aVO/nCROx+hHXW5ByXCkGavVK3y7lwJmHUjRBjxy5eGz/XTahNIVW8OZv2Rd854hz/gGluWchBkaaNPgdCCA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gaWWQGli; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gaWWQGli"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B6F6D1F00A3D;
	Mon, 24 Aug 2026 00:24:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787531082;
	bh=g3ZFMxWEgnexJ581Q7H9NgKFqn3nVZc7Ra0aj9wDIJA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=gaWWQGliGPuQ5na+euTIoNorVt7m1DrHBP8AeqmW4WjpllSYTkfKM5BwQ6s/h35Zy
	 0VCi0Qg8zNN4lOYhlynx+Mxwk7dTMZPfs89ukliLGpw/+edTPWOiVn2o44o0kgE1xi
	 GmlMTf8PPOUR4tizqN+24Fm2+wr807u7L0rIcYehi5MOA99NYtOGYZUIUTdjlRxooi
	 +BTi2bzDqsd1wN4HWQVAJ88T4SFAhbG/i6wA2kA1n32vlg2cpqtH5ZWeSydGh+1yPE
	 p+WFt74T3TqeiiQUG9XlW09AzMq6C+gLeUVqf6ihGf3v9kfrPVhnZztVii04pse+bO
	 FGIOtXlP5Opfw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: "Darrick J. Wong" <djwong@kernel.org>,
	Christoph Hellwig <hch@lst.de>,
	Carlos Maiolino <cem@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y 2/2] xfs: don't livelock in scrub on a circular unlinked list
Date: Sun, 23 Aug 2026 20:24:38 -0400
Message-ID: <20260824002438.2776945-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260824002438.2776945-1-sashal@kernel.org>
References: <2026082044-numbness-grandkid-8ead@gregkh>
 <20260824002438.2776945-1-sashal@kernel.org>
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
index 51a767fbf7616..938885a391632 100644
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
@@ -893,7 +895,8 @@ xchk_agi_xref(
 /*
  * Walk the incore unlinked list for a particular AGI bucket to construct
  * the unlinked inode bitmap for later reconstruction of the unlinked list.
- * Returns 1 if we should keep checking, or 0 to stop checking.
+ * Returns 1 if we should keep checking, 0 to stop checking, or a negative
+ * errno.
  */
 static int
 xchk_iunlink_bucket(
@@ -901,36 +904,57 @@ xchk_iunlink_bucket(
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
@@ -943,8 +967,10 @@ xchk_iunlink(
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
@@ -1031,7 +1057,9 @@ xchk_agi(
 	if (pag->pagi_freecount != be32_to_cpu(agi->agi_freecount))
 		xchk_block_set_corrupt(sc, sc->sa.agi_bp);
 
-	xchk_iunlink(sc, agi);
+	error = xchk_iunlink(sc, agi);
+	if (error)
+		goto out;
 
 	xchk_agi_xref(sc);
 out:
diff --git a/fs/xfs/scrub/agheader_repair.c b/fs/xfs/scrub/agheader_repair.c
index 235cefe9422c5..5cb03887d09a5 100644
--- a/fs/xfs/scrub/agheader_repair.c
+++ b/fs/xfs/scrub/agheader_repair.c
@@ -1089,18 +1089,22 @@ xrep_iunlink_walk_ondisk_bucket(
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
@@ -1108,15 +1112,24 @@ xrep_iunlink_walk_ondisk_bucket(
 		if (bucket != agino % XFS_AGI_UNLINKED_BUCKETS)
 			break;
 
+		if (xagino_bitmap_test(&seen, agino, &len))
+			break;
+
 		next_agino = xrep_iunlink_next(sc, agino);
 		if (!next_agino)
 			next_agino = xrep_iunlink_reload_next(ragi, prev_agino,
 					agino);
 
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

