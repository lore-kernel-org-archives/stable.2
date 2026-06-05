Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 087C23E556C
	for <stable@vger.kernel.org>; Fri,  5 Jun 2026 18:43:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780685030; cv=none; b=uB+l5jvgwvf+NqvsqT09bWmuIur4+QRJ2/no0dGvOuWIKLlFx9IW+bQvi11V4Ke6FlsBooawWoWwZXeczD56ey1LqyKqiqDSLwkC8OxL9PeHl5FY27LdpalnNYqDx3hyaAwuXVp8SCVglcZM9T2afRL3cAXLWELRnt63MneDeSA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780685030; c=relaxed/simple;
	bh=uvwSqiH+WqChYPpNZ0rJX0SQYPniBrlkWF8DqYIyRTc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=G90N/J7IjK/dtYJIE1+3g3z6PM0acKyaveUTEEsh6oG3WfdwvFKQz2SAvDHpEMv9+7CW4/xBUTborHQCiQO3BCmiSXg3YX/RtYzo9JcfDRExEM1rKQD8pTR2xmiDfJ70kIEIH0xxKbpiI8SFb/TkIkO90NP3WjNC/Mso5634Opo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=r0YCI+3o; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="r0YCI+3o"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=ntdINcV/MtFDkQvCBTRmJMDU8OdksVLywgaGQ7MRh9o=; b=r0YCI+3ohErhmkBaRYSP7/1y3y
	UX9qXulTq4xgmk5YvuTDr1DLa32LPhA3Ap4POS+usU1gf0TKQ6cY2kMjB7Z3dyrhAjdfqDR+uyI+N
	s6nZro/jIdKk5QQPZ10X7lxSRWDfsfBP+ngv6qpfVHr4xl0ZYXH4771HWEbCmdzrQ5vol0lujYOSQ
	P3VJNo2M646odG4bH2G30NQDX14kJ/5XtEf4xqc3zpWIIkLDSeiZ2RvE1gL3ujOAfns6QEukYnOWs
	7rYue5YyxGZwZISbpB9fUanAaCpR+0TBML+s34jYRQ+X29toxIwGu//dAXcVna/DLD4widGjI5diU
	MleglF6Q==;
Received: from 2a02-8389-2341-5b80-decc-1a96-daaa-a2cc.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:decc:1a96:daaa:a2cc] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wVZWD-000000014Ax-19RR;
	Fri, 05 Jun 2026 18:43:45 +0000
From: Christoph Hellwig <hch@lst.de>
To: Carlos Maiolino <cem@kernel.org>
Cc: stable@vger.kernel.org,
	"Darrick J. Wong" <djwong@kernel.org>
Subject: [PATCH 1/2] xfs: pass back updated nb from xfs_growfs_compute_deltas
Date: Fri,  5 Jun 2026 20:43:33 +0200
Message-ID: <20260605184339.590868-2-hch@lst.de>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260605184339.590868-1-hch@lst.de>
References: <20260605184339.590868-1-hch@lst.de>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

xfs_growfs_compute_deltas can update nb for corner cases like a number
of blocks that would create a less the minimal sized AG, or running
past the max AG limit.  Pass back the calculated value to the caller,
as it relies on to calculate the new numeber of perag structures.

Note that the grown file system size is not affected by this
miscaculation as it uses the passed back delta value.

Fixes: a49b7ff63f98 ("xfs: Refactoring the nagcount and delta calculation")
Cc: <stable@vger.kernel.org> # v7.0
Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: "Darrick J. Wong" <djwong@kernel.org>
---
 fs/xfs/libxfs/xfs_ag.c | 10 +++++-----
 fs/xfs/libxfs/xfs_ag.h |  2 +-
 fs/xfs/xfs_fsops.c     |  2 +-
 3 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/fs/xfs/libxfs/xfs_ag.c b/fs/xfs/libxfs/xfs_ag.c
index dcd2f93b6a6c..0c5f0548021f 100644
--- a/fs/xfs/libxfs/xfs_ag.c
+++ b/fs/xfs/libxfs/xfs_ag.c
@@ -866,7 +866,7 @@ xfs_ag_shrink_space(
 void
 xfs_growfs_compute_deltas(
 	struct xfs_mount	*mp,
-	xfs_rfsblock_t		nb,
+	xfs_rfsblock_t		*nb,
 	int64_t			*deltap,
 	xfs_agnumber_t		*nagcountp)
 {
@@ -874,19 +874,19 @@ xfs_growfs_compute_deltas(
 	int64_t		delta;
 	xfs_agnumber_t	nagcount;
 
-	nb_div = nb;
+	nb_div = *nb;
 	nb_mod = do_div(nb_div, mp->m_sb.sb_agblocks);
 	if (nb_mod && nb_mod >= XFS_MIN_AG_BLOCKS)
 		nb_div++;
 	else if (nb_mod)
-		nb = nb_div * mp->m_sb.sb_agblocks;
+		*nb = nb_div * mp->m_sb.sb_agblocks;
 
 	if (nb_div > XFS_MAX_AGNUMBER + 1) {
 		nb_div = XFS_MAX_AGNUMBER + 1;
-		nb = nb_div * mp->m_sb.sb_agblocks;
+		*nb = nb_div * mp->m_sb.sb_agblocks;
 	}
 	nagcount = nb_div;
-	delta = nb - mp->m_sb.sb_dblocks;
+	delta = *nb - mp->m_sb.sb_dblocks;
 	*deltap = delta;
 	*nagcountp = nagcount;
 }
diff --git a/fs/xfs/libxfs/xfs_ag.h b/fs/xfs/libxfs/xfs_ag.h
index 16a9b43a3c27..8aa4266c5571 100644
--- a/fs/xfs/libxfs/xfs_ag.h
+++ b/fs/xfs/libxfs/xfs_ag.h
@@ -330,7 +330,7 @@ int xfs_ag_init_headers(struct xfs_mount *mp, struct aghdr_init_data *id);
 int xfs_ag_shrink_space(struct xfs_perag *pag, struct xfs_trans **tpp,
 			xfs_extlen_t delta);
 void
-xfs_growfs_compute_deltas(struct xfs_mount *mp, xfs_rfsblock_t nb,
+xfs_growfs_compute_deltas(struct xfs_mount *mp, xfs_rfsblock_t *nb,
 			int64_t *deltap, xfs_agnumber_t *nagcountp);
 int xfs_ag_extend_space(struct xfs_perag *pag, struct xfs_trans *tp,
 			xfs_extlen_t len);
diff --git a/fs/xfs/xfs_fsops.c b/fs/xfs/xfs_fsops.c
index 8d64d904d73c..436857356a0a 100644
--- a/fs/xfs/xfs_fsops.c
+++ b/fs/xfs/xfs_fsops.c
@@ -124,7 +124,7 @@ xfs_growfs_data_private(
 			mp->m_sb.sb_rextsize);
 	if (error)
 		return error;
-	xfs_growfs_compute_deltas(mp, nb, &delta, &nagcount);
+	xfs_growfs_compute_deltas(mp, &nb, &delta, &nagcount);
 
 	/*
 	 * Reject filesystems with a single AG because they are not
-- 
2.53.0

