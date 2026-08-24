Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D441A27456
	for <stable@vger.kernel.org>; Mon, 24 Aug 2026 00:09:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787530175; cv=none; b=P05E9f8FCH7gu6Ea3GGz79ese4DHVYClKy8MGU82keV03DjFgqQezByW4gCIpksOtYcWJusX5b08AYEBqUo45CT0aTwPBmNxzEzedVupcux6aFsmNabKFdBvNHEgjQtPM41VI5i1eRuM5QPtvI2z2w/UWk7hBFgDKIL7CXjSWPk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787530175; c=relaxed/simple;
	bh=GSOCeSUGMDbqEYq67n+XGDYwtPZAyHFtgAA5oYghK5g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=goVJu6MZS4pbwkHNFUT8UFdOMbViM8sJdaxQ/D+ab3cCV+jUYxYI4GSZM6Dj2UhpiOdrARoAemaDo9ONbcXGDAV7diHPf+sMUF4aDRKhy+b6Y/10X4O2lfthcmoIZKEis6Db8mJUUrkgINyQgM4Q1kO7KGXPZMiySSs4wp8ye7s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QoRa1rTJ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QoRa1rTJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E9E991F000E9;
	Mon, 24 Aug 2026 00:09:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787530174;
	bh=gzSS5Y7KSXkTPpTn7FWFCB8MMWVdRjsyy9kkg8piZJo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=QoRa1rTJpK8XFxTzc4+Bl7xP9x6b7ZhLVQBFEOKzReTv69rLpJCYrNDUZrXXLpQzA
	 q1X3QHy8NhlguwmKeF2KIjvFK9JzHfBzdmWvQVABbJxDBYFvh6UrqFiLOcyYmY4nwa
	 KWNsxG0qXjMtscthFESGEJbSfwXvb+lHgmbAWMUG/HlDGlBqkHCE14s3VG6MM5Fpxy
	 PTiLRBANibC97DHQJVmRycjobKbBS4+cZ5mT+qGYR6mv0c+PkYQ554g3DKA0oj4UJp
	 YfT9x4BbvsD8vknosy4ib8upnOAWAL5ehiSDkuztFBVN8KWevIXABTbHoUr4Cfl59h
	 Z5ImeVJU2hozw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: "Darrick J. Wong" <djwong@kernel.org>,
	Christoph Hellwig <hch@lst.de>,
	Carlos Maiolino <cem@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18.y 1/2] xfs: hoist per-bucket unlinked list check to helper
Date: Sun, 23 Aug 2026 20:09:31 -0400
Message-ID: <20260824000932.2649491-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026082043-rely-pentagram-07de@gregkh>
References: <2026082043-rely-pentagram-07de@gregkh>
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
index 2ac2125b83172..7c44ea7a26c95 100644
--- a/fs/xfs/scrub/agheader.c
+++ b/fs/xfs/scrub/agheader.c
@@ -932,6 +932,42 @@ xchk_agi_xref(
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
@@ -942,30 +978,14 @@ xchk_iunlink(
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

