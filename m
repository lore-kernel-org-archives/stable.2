Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3C5852B1F4
	for <stable@vger.kernel.org>; Wed, 30 Sep 2026 17:58:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790791089; cv=none; b=pSNVgEhnkr2ApfW7TKpMap0wrpLH1xzBdCxt1tF3ZpaqpFEZpjONz6/fAB5FbiemftgOkxKV6NSvf4dyaKek0YVUXFWwHlJUEE6UF8xA5M9vPTu06GZY3lcNiqSNszB8K+odbQiyIbrWJXomtgljiP8GV+QEDHQVi1PxxvFk5sA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790791089; c=relaxed/simple;
	bh=Usm7SSlCb2NdTgDtND3qaOqV9GKSq+71hS8LGqGFRG8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sN4lOu63xnGrkfR/yMuuGW/FMevsRsEMaEIJDOP2Ks53VCJ4HiYFBACUtR7MPJfVew1WnNpzjeZgCbPryiaA6BDbw7gvBQ4GgFbvAe5Az1mzFk3lPfhMLEBVDhPPr7340kugUAAkkCOnTMNnjVbJP9b4ErDRzAbLpy79JTzfQqs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NTSjEDX9; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NTSjEDX9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 484161F00898;
	Wed, 30 Sep 2026 17:58:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790791088;
	bh=v7coAOEtjQ37mUhaPqCaZMTIusS6YSDPytYKNd2UZL4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=NTSjEDX9etn2d+sKvyTCtXPytRT8bA/ZlJfo6L20+7enaf7F+gzPsf+icQhE/iQUb
	 F6geMFQiJmQGlg51bVEFU7n49CR+NB/2e47BUHj0n/cDZxmRrKBKHxD9ZU0W4ooFqk
	 8l0Y1+6pb/kt3QRzDfkodAGp+vHOolYymwccIyKCP/5kx1J3A60ZCqbR20KUU+GnaX
	 Gj9mPFftdXCV6EQlDUYUsXpK5kUatGqsLyve3Kvw92CMn8Scjut9lsAXwFExE23uJF
	 PomcB4CqdAy7F9gKUkorbZaCOMMT3yqtsL8QqO2UtU7GMu0s+GD2vbbCuvba5dFY1v
	 XSLm5faS/o9PA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Christoph Hellwig <hch@lst.de>,
	"Darrick J. Wong" <djwong@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y 1/2] xfs: pass a pag to xfs_difree_inode_chunk
Date: Wed, 30 Sep 2026 13:58:05 -0400
Message-ID: <20260930175806.3940388-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026092920-booth-deluge-dbf3@gregkh>
References: <2026092920-booth-deluge-dbf3@gregkh>
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
index b83e54c709069..82f1e725f59e8 100644
--- a/fs/xfs/libxfs/xfs_ialloc.c
+++ b/fs/xfs/libxfs/xfs_ialloc.c
@@ -1837,10 +1837,11 @@ xfs_dialloc(
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
@@ -2009,7 +2010,7 @@ xfs_difree_inobt(
 			goto error0;
 		}
 
-		error = xfs_difree_inode_chunk(tp, pag->pag_agno, &rec);
+		error = xfs_difree_inode_chunk(tp, pag, &rec);
 		if (error)
 			goto error0;
 	} else {
-- 
2.53.0

