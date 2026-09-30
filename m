Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69C843644C1
	for <stable@vger.kernel.org>; Wed, 30 Sep 2026 18:03:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790791428; cv=none; b=Z5Av8pyaBVK0yhthXGf8ry3g6Thoh9lBL8OVdcj4uIh4y/aQjuVXwpLFb30pvQs7a0uRsUd+xto+Wy40raRKvEs5Nw8Z5qEj6ZjQizMJCvofBOnbc+ZM2QdI0FC6laN91zbqwvULi5XU7Qb10Kl7DeDvTdWIjSgi25i3fBNPmcU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790791428; c=relaxed/simple;
	bh=u3CdIgtYeKvRlBCRghKHYZXMykYP2nnuPiOTTZcnW5k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Arp1OZodty/PuKKut54yB/1P9uCqrWTlY6mHN24crgsD7uXWbiTD/9lamjc/CbOkaeg+2isGgTwn3HIdeuzWiJ8QjKV4zMZIh0rNdQWduP9HuMWRpKMGghvcoa6EZGd3Pf7cyuhNqoHnUPGHUxUmUW3ecxA9MBi4GBshXYjeZHA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XhPMYkei; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XhPMYkei"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 904671F00898;
	Wed, 30 Sep 2026 18:03:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790791427;
	bh=yiJFgQ9o1xYeWBbib49se4qh+J4Zgt1JRCeZTSBd/gQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=XhPMYkei/1ppdfGNhT4sH+T3jPQ3iKbOU87mprjrFc6IILi8qDE845wqV8EN3ga8g
	 2e87i96yx5yZzB2CbeqipdOOzufS7vS20+MJ3u74X/e5w+idtIO7wdmFwjl4Yv+xqG
	 J6iCtAJhfsEKSQ1r8Mq3X8f1+pDy5IK0zDBSHmIcFamqZ0KrX30RvKUIBkKV52CKQG
	 Lnp+5CthgW85q1fxmVwojft5ssi67I+NE3TQpu3JN6ovB/LhKFAG4Ra5TYsZWHgLQH
	 iMkgZouFfRCZyM/hODqrrSEj/D/KvZ2wA6kWUzn7XmiMQLHbgEUswyP0he9e/KXTZN
	 OgyHdzbv4Oybg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Christoph Hellwig <hch@lst.de>,
	"Darrick J. Wong" <djwong@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y 1/2] xfs: pass a pag to xfs_difree_inode_chunk
Date: Wed, 30 Sep 2026 14:03:44 -0400
Message-ID: <20260930180345.3983058-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026092920-approve-latitude-dd24@gregkh>
References: <2026092920-approve-latitude-dd24@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Christoph Hellwig <hch@lst.de>

[ Upstream commit 67ce5ba575354da1542e0579fb8c7a871cbf57b3 ]

We'll want to use more than just the agno field in a bit.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Darrick J. Wong <djwong@kernel.org>
Signed-off-by: Darrick J. Wong <djwong@kernel.org>
Stable-dep-of: 65f39d09d737 ("xfs: fix cursor and pointer handling when recovering iunlink buckets")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/xfs/libxfs/xfs_ialloc.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/fs/xfs/libxfs/xfs_ialloc.c b/fs/xfs/libxfs/xfs_ialloc.c
index 4b2894c85ceaa..5b66e9a06ed6d 100644
--- a/fs/xfs/libxfs/xfs_ialloc.c
+++ b/fs/xfs/libxfs/xfs_ialloc.c
@@ -1831,10 +1831,11 @@ xfs_dialloc(
 static int
 xfs_difree_inode_chunk(
 	struct xfs_trans		*tp,
-	xfs_agnumber_t			agno,
+	struct xfs_perag		*pag,
 	struct xfs_inobt_rec_incore	*rec)
 {
 	struct xfs_mount		*mp = tp->t_mountp;
+	xfs_agnumber_t			agno = pag->pag_agno;
 	xfs_agblock_t			sagbno = XFS_AGINO_TO_AGBNO(mp,
 							rec->ir_startino);
 	int				startidx, endidx;
@@ -2005,7 +2006,7 @@ xfs_difree_inobt(
 			goto error0;
 		}
 
-		error = xfs_difree_inode_chunk(tp, pag->pag_agno, &rec);
+		error = xfs_difree_inode_chunk(tp, pag, &rec);
 		if (error)
 			goto error0;
 	} else {
-- 
2.53.0

