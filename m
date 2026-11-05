Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793895920;
	b=TrIeX/jS/mtHxvPghtwI2PUmKYlIMl8h0l/SgZCNTB3a5SCAOM/yexOiWDUvlqpgHCle
	 Bt2sKqLgYnxoEC/bfWrmaUNTGBTwM89yJCZxhmoBQcZvN5164ZFlmhVKRLTiSpO8fP2FP
	 sCTjnmgGogBBreaBl+MICNJdDb6LpXfveslNX7tWYB+EOYTKTIvtKaHS4t43tA3/DaR40
	 RZsR5UJO7wFiB2xtHXBbIJrIYOpJ4DaIq+Im/DFk84wk3z+m7SnrKVW1OXxvq961SY8g8
	 EtWcF59JcBD1CARyqYYc5Tj0xYDaUhaHD5TEqj2s7Z+BBqwQVJMTaSubC+BpBySAS2w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793895920;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=60xpqFWLn7qqLNF2I2yYcO42tIBAUjxxZy65su3/FA0=;
	b=iS85Ij5tX1K8F8McxFTZyTd/S3g8Rx/PWBAdMZqckDar5lQwkcUn0NJllfpRWyBXlk0b
	 Rih+4j8AOKWrZh+BmdEIbbiyT/mQftQFZ21+BHIROh7sBE9Gq3SmGMBGS3f6Dq57MvUrR
	 ZeolzYPmhPa22yC495jbDHKKxQZ5jqX589mkGaSByilUI7F5tN44EC2a86+Kvn5+GRdUe
	 VcMsMCO/oI9oBqQnEBYAeM3kmTGXP1RPw8jSrOf3hW/ErRAuBfLMz/LC6Z7s8fRvkSNB9
	 l2Lvje6YpbNmVWpZh3QKDzeZ6OjcFkqhIu2kegOOe8TYvSH6Jzb0rffHhhHkSkaUxJQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=cjBVGkvE;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C863606A32D
	for <stable@vger.kernel.org>; Thu,  5 Nov 2026 16:25:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=cjBVGkvE
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4B17D1F00919;
	Thu,  5 Nov 2026 16:25:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793895919;
	bh=60xpqFWLn7qqLNF2I2yYcO42tIBAUjxxZy65su3/FA0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=cjBVGkvErpCY9EsGkxq4MkGTjtHmj+sTPF6A+94BwQ6p/yfM1QNofx8ngsSszx41S
	 /cwvvK1Rd3LO0PwuI2jH9FHCbRuoDPRfBt+zy+DBmOwcCNOOr4HF5YpEYzRLhC3tEm
	 732XENs1AyGx7Z6h63jRm6r/odnkYIR8MswtkbpxfxHYN7EM7XrWiEMTM57EucGgVc
	 67ZmC/ahvXVtJQVupSX0ipgafmxAo4fK46tu1JAN5B5vtw4wkmG4h0aICpZFy3ncaf
	 6sDKGUGKZotXB+pAyvd+GpbtSgURr7NMWjLYK+YOGn1qjqTx2+Bt/JmSsuniLqx1MB
	 mtA32IcJn3zcg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: "Darrick J. Wong" <djwong@kernel.org>,
	Christoph Hellwig <hch@lst.de>,
	Carlos Maiolino <cem@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y] xfs: cross-reference the primary superblock
Date: Thu,  5 Nov 2026 11:25:18 -0500
Message-ID: <20261105162506.2145868-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026110441-sighing-margarine-42bd@gregkh>
References: <2026110441-sighing-margarine-42bd@gregkh>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Darrick J. Wong" <djwong@kernel.org>

[ Upstream commit 0c61016006ab08f8346f9e7b1e38559bd4ea499e ]

Make sure we cross-reference the primary superblock against the rest of
the AG 0 space metadata.  Drop the unused @bp parameter of
xchk_superblock_xref to avoid complaints about uninitialized variables.

Cc: stable@vger.kernel.org # v4.16
Fixes: 52dc4b44af7419 ("xfs: cross-reference with the bnobt")
Signed-off-by: Darrick J. Wong <djwong@kernel.org>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Carlos Maiolino <cem@kernel.org>
[ sashal: initialized error to zero in xchk_superblock() ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/xfs/scrub/agheader.c | 17 ++++++++---------
 1 file changed, 8 insertions(+), 9 deletions(-)

diff --git a/fs/xfs/scrub/agheader.c b/fs/xfs/scrub/agheader.c
index ae3c9f6e2c695..46b7a727826cd 100644
--- a/fs/xfs/scrub/agheader.c
+++ b/fs/xfs/scrub/agheader.c
@@ -23,8 +23,7 @@
 /* Cross-reference with the other btrees. */
 STATIC void
 xchk_superblock_xref(
-	struct xfs_scrub	*sc,
-	struct xfs_buf		*bp)
+	struct xfs_scrub	*sc)
 {
 	struct xfs_mount	*mp = sc->mp;
 	xfs_agnumber_t		agno = sc->sm->sm_agno;
@@ -64,16 +63,12 @@ xchk_superblock(
 	struct xfs_buf		*bp;
 	struct xfs_dsb		*sb;
 	struct xfs_perag	*pag;
-	xfs_agnumber_t		agno;
+	xfs_agnumber_t		agno = sc->sm->sm_agno;
 	uint32_t		v2_ok;
 	__be32			features_mask;
-	int			error;
+	int			error = 0;
 	__be16			vernum_mask;
 
-	agno = sc->sm->sm_agno;
-	if (agno == 0)
-		return 0;
-
 	/*
 	 * Grab an active reference to the perag structure.  If we can't get
 	 * it, we're racing with something that's tearing down the AG, so
@@ -83,6 +78,9 @@ xchk_superblock(
 	if (!pag)
 		return -ENOENT;
 
+	if (agno == 0)
+		goto out_xref;
+
 	error = xfs_sb_read_secondary(mp, sc->tp, agno, &bp);
 	/*
 	 * The superblock verifier can return several different error codes
@@ -345,7 +343,8 @@ xchk_superblock(
 			BBTOB(bp->b_length) - sizeof(struct xfs_dsb)))
 		xchk_block_set_corrupt(sc, bp);
 
-	xchk_superblock_xref(sc, bp);
+out_xref:
+	xchk_superblock_xref(sc);
 out_pag:
 	xfs_perag_put(pag);
 	return error;
-- 
2.53.0

