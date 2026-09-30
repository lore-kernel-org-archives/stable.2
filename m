Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4850251EE0F
	for <stable@vger.kernel.org>; Wed, 30 Sep 2026 17:34:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790789669; cv=none; b=kOoTcbxLaLbpClcA4SLHsb3Lw3OhM8xXF1K6TCJDPw5ke9VzLPAbta6T5NFFQwI89ahlLypUvFvzEs+n6WJbP/OndI94KxdDbjAXknnQ5vmHJsSjbrU3z5SuRJtXY7udo2inzab4cg5UB7zcbgGC8W/iKL1YMApKvRQqW+qcygc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790789669; c=relaxed/simple;
	bh=mBepCMPcBXVwCECvhfvTlQQrvzYxkP8jwepqnteCOM4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YMtQdAtENGx7S3efUsn/8WzSasc5el4oQJS7sNxXHHGA+eJyWXVowMxP188PJj66SMIfiPzf0GTFr5RyBbLbTH9jPinPsu0JfrZ+WZV+WVTFShP1gH1wwJFhuyYBMV6zOkc7k4XdegaVLBUGLN34Ozl23wG+hBWsMHgIfbPad3E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EnKvGR7/; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EnKvGR7/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A1FEE1F00898;
	Wed, 30 Sep 2026 17:34:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790789668;
	bh=Cb/BEcT6I0d9AaKpwA8sBQZoPF/BJFsSjYqb9W7ZWNU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=EnKvGR7/vtEtPeEJ/QzzZGQywirZomXjLYxSbEsdHT3RGldQ5LToERxivsiC5ZRAc
	 EogYxPPZpBRLiSXwJmtlUJlX2m4uYZFYRN4vE9xiB1gWXgGXudDgqyNDlT/2spzYO/
	 6hKbI2kLsy63BoLDK2/w9Elqbe7P0I5qh4sxnlj9o9c79VDf17pjnSXDdEuGrka5EF
	 M17VNFZiC6gJ8dXJZJ3f03cUYgmlixOt0KGkot+qLRsX6E9Zre4Ksd1UydGxowmYZn
	 odhK3/S8Lc0XiuXXBfw/H5g3j/IXRxL3LhgdRUI0pRtNxBbJEni2zN/eHtfQhYnXyp
	 Q3orgUVuMaFpw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Christoph Hellwig <hch@lst.de>,
	"Darrick J. Wong" <djwong@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y 1/2] xfs: pass a pag to xfs_difree_inode_chunk
Date: Wed, 30 Sep 2026 13:34:24 -0400
Message-ID: <20260930173425.3645522-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026092919-margarita-pentagram-c4f9@gregkh>
References: <2026092919-margarita-pentagram-c4f9@gregkh>
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
index 0fdb2a30e50d1..29ef6d15c13e0 100644
--- a/fs/xfs/libxfs/xfs_ialloc.c
+++ b/fs/xfs/libxfs/xfs_ialloc.c
@@ -1976,10 +1976,11 @@ xfs_dialloc(
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
@@ -2150,7 +2151,7 @@ xfs_difree_inobt(
 			goto error0;
 		}
 
-		error = xfs_difree_inode_chunk(tp, pag->pag_agno, &rec);
+		error = xfs_difree_inode_chunk(tp, pag, &rec);
 		if (error)
 			goto error0;
 	} else {
-- 
2.53.0

