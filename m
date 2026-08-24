Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE9491F8AC5
	for <stable@vger.kernel.org>; Mon, 24 Aug 2026 00:24:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787531083; cv=none; b=mA3A4Ufds6vqejojxsufFh0QBfEFkmzn7qj2nixl7X4uq++YRR7g1gueb+22FVpgh5uqwITbKl/hSm88+dkUw86FDep1XeAVp3LKfew20YwnIZX1xqS1JPr2DdEDOiJ+Msx1nMcsOQFyfxnE4Xjy522PEXDOepxtFt5hdTUPvhI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787531083; c=relaxed/simple;
	bh=qBVBmx1wAi0/fw2WEju97Bjm84i+GTTOnZfPmAUeCqI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JzijUirnQ2Oa6giHhqc49Fqh+5E+5IF7HxmGNV+KSS65t/ne1CYXs3fwpPvDdLXj2wSaYLuSkZCd1yx6Huj0X2+CVxqymrLn2YDYnRAzlcJpARQgL1dtXwAKFSdUEA57JD/9jHvMSBBHK4MfZcJqnZJP04e62sXdSakP3gp/TyM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KtawvBMI; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KtawvBMI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E5BF91F000E9;
	Mon, 24 Aug 2026 00:24:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787531081;
	bh=DAobaQHy+IJ7sORwR77CZfGpNv7S/HXUNjGldZAY4Qw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=KtawvBMI+amMvYkNd6Kkk7w56s4lL4X7D9hOckAQxuNizEQwOM4x+YoKN0BacUylp
	 6pFCUpW6g1R7T+TrySv2ompnRogrvHywz0BbzxL6cZp1uhXWgoDm9iIpTcm0AHGT6r
	 ULYoci0cKqBh/PkFuyYKcXBbFR9D6qGhDnArmwwUcIR7f06GD0HT3cZzN/0yK/bS77
	 9ROk2/tRUMjGXzLgW+PO6UMYfsUKOK/MoiIlbkNv0zrBMpgHTKyDmYzMlij2Gt4Rf0
	 Bv2NqwBOvi/p0WUVqiNHnEjJWmThnicmVrf4z526mhnQwKlYHO2dBekaSGNEFRdX1w
	 WDLAbolbQRK5Q==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: "Darrick J. Wong" <djwong@kernel.org>,
	Christoph Hellwig <hch@lst.de>,
	Carlos Maiolino <cem@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y 1/2] xfs: hoist per-bucket unlinked list check to helper
Date: Sun, 23 Aug 2026 20:24:37 -0400
Message-ID: <20260824002438.2776945-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026082044-numbness-grandkid-8ead@gregkh>
References: <2026082044-numbness-grandkid-8ead@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Darrick J. Wong" <djwong@kernel.org>

[ Upstream commit 7cdafd8f10ebdf745ba6046b9fa67490c343a17f ]

In the next patch we're going to make this loop more exciting, so hoist
the code to a helper function to reduce clutter in the resulting code.

Signed-off-by: Darrick J. Wong <djwong@kernel.org>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Carlos Maiolino <cem@kernel.org>
Stable-dep-of: 527eaaefddb6 ("xfs: don't livelock in scrub on a circular unlinked list")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/xfs/scrub/agheader.c | 64 +++++++++++++++++++++++++++--------------
 1 file changed, 42 insertions(+), 22 deletions(-)

diff --git a/fs/xfs/scrub/agheader.c b/fs/xfs/scrub/agheader.c
index 0f2f1852d58fe..51a767fbf7616 100644
--- a/fs/xfs/scrub/agheader.c
+++ b/fs/xfs/scrub/agheader.c
@@ -890,6 +890,42 @@ xchk_agi_xref(
 	/* scrub teardown will take care of sc->sa for us */
 }
 
+/*
+ * Walk the incore unlinked list for a particular AGI bucket to construct
+ * the unlinked inode bitmap for later reconstruction of the unlinked list.
+ * Returns 1 if we should keep checking, or 0 to stop checking.
+ */
+static int
+xchk_iunlink_bucket(
+	struct xfs_scrub		*sc,
+	unsigned int			bucket,
+	xfs_agino_t			agino)
+{
+	while (agino != NULLAGINO) {
+		struct xfs_inode	*ip;
+
+		if (agino % XFS_AGI_UNLINKED_BUCKETS != bucket) {
+			xchk_block_set_corrupt(sc, sc->sa.agi_bp);
+			return 0;
+		}
+
+		ip = xfs_iunlink_lookup(sc->sa.pag, agino);
+		if (!ip) {
+			xchk_block_set_corrupt(sc, sc->sa.agi_bp);
+			return 0;
+		}
+
+		if (!xfs_inode_on_unlinked_list(ip)) {
+			xchk_block_set_corrupt(sc, sc->sa.agi_bp);
+			return 0;
+		}
+
+		agino = ip->i_next_unlinked;
+	}
+
+	return 1;
+}
+
 /*
  * Check the unlinked buckets for links to bad inodes.  We hold the AGI, so
  * there cannot be any threads updating unlinked list pointers in this AG.
@@ -900,30 +936,14 @@ xchk_iunlink(
 	struct xfs_agi		*agi)
 {
 	unsigned int		i;
-	struct xfs_inode	*ip;
 
 	for (i = 0; i < XFS_AGI_UNLINKED_BUCKETS; i++) {
-		xfs_agino_t	agino = be32_to_cpu(agi->agi_unlinked[i]);
-
-		while (agino != NULLAGINO) {
-			if (agino % XFS_AGI_UNLINKED_BUCKETS != i) {
-				xchk_block_set_corrupt(sc, sc->sa.agi_bp);
-				return;
-			}
-
-			ip = xfs_iunlink_lookup(sc->sa.pag, agino);
-			if (!ip) {
-				xchk_block_set_corrupt(sc, sc->sa.agi_bp);
-				return;
-			}
-
-			if (!xfs_inode_on_unlinked_list(ip)) {
-				xchk_block_set_corrupt(sc, sc->sa.agi_bp);
-				return;
-			}
-
-			agino = ip->i_next_unlinked;
-		}
+		int		ret;
+
+		ret = xchk_iunlink_bucket(sc, i,
+				be32_to_cpu(agi->agi_unlinked[i]));
+		if (ret < 1)
+			return;
 	}
 }
 
-- 
2.53.0

