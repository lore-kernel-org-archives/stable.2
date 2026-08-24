Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8BA42E3FE
	for <stable@vger.kernel.org>; Mon, 24 Aug 2026 00:09:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787530176; cv=none; b=tQATHZ3gG73YovEbtTj3w0B76S48D+YcBayTrRqMPY2PS0pxckoiX5EW0cQbBcMqRo5nscg7jqIl6s5jA6Gl3YNveNVkiLCDoalBjG4T123p4UZFH0GV4/+l6AoK/JRg6F5Oj4ZF1Dl2TpOuRX72CaPtZHi+ERsMTQs9NUgTuRU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787530176; c=relaxed/simple;
	bh=+QMjj+Ryvh4j9XLLaCkCxqTHqPrx6K+Nflc22UogVzo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IYcbSmfzT/oIBvo5vJp/LeFO2Y3HXl3iAntT1Lvkk45NdogXk8DsJfNAbOStG3yMsXGKVX4aYGRiz8FA2FcQT9pTdgCyNJ8yTwA9D9QUv4oC5aKMA2Ux/Q20PCt2qaMVN5f9ksqz6TPdykzb/c0Pu9fXRMfYs8TsnW3x3GqCqtY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=U6MeDZ7q; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="U6MeDZ7q"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C20DB1F00A3A;
	Mon, 24 Aug 2026 00:09:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787530175;
	bh=BUGndJ+0BcpFrqc7WqCDnWqmx6zpSXa1dn/J8GmWvZQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=U6MeDZ7qF6JJckptcYSnSKrEY48ZXbZJcgFVSrha7AzmJPm0aPfd+J4aerq6foO4n
	 HvdlZxxJyDVp54e38dy8BU4aYZX66aCwSu+YfbQ7jSUSBbystZnGxUij02duaIzKSS
	 Vdb9HilO2jOxGviYhiiW4IOugFUM7qRqf6EbHU1jHsTP6a4rMTyFEQ73SeWaFqSbS5
	 UGrJQYzk/ZVfT57O3spRYysXhsXT+ENb6BFPJeFAFyQiGDKb67IUTUS4JX3v70rxOP
	 s7Tvt0ewzidHGDqLnRMQrNKJv74Hof+59iSJTUyzwdx9Bvm2twEny8urjjhNXDo47k
	 dl1QtbOrYL59w==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: "Darrick J. Wong" <djwong@kernel.org>,
	Christoph Hellwig <hch@lst.de>,
	Carlos Maiolino <cem@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18.y 2/2] xfs: don't livelock in scrub on a circular unlinked list
Date: Sun, 23 Aug 2026 20:09:32 -0400
Message-ID: <20260824000932.2649491-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260824000932.2649491-1-sashal@kernel.org>
References: <2026082043-rely-pentagram-07de@gregkh>
 <20260824000932.2649491-1-sashal@kernel.org>
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
index 7c44ea7a26c95..fb403a7bf4310 100644
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
index d18944449b3a9..6ed9c6fa52116 100644
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

