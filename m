Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793886338;
	b=qG/+3YLFWS/Pk/ZeuUOndy49a22Xjs3Eu6l98Yl8WBi68bP6ZMjphC6Nkdd5D0uJtOi/
	 EnzDS2C0js9ieYEgp4NM2nN+Yfj73r/aJuP95/j22UsnzWK7G4Jt9mxOvZ+z6nuJCTX4U
	 Xu1o6HjOFIOv/map3tMMz+rmTmcopGG7SFzhf7qm+Z2I7i+ixrCjRtuU6KhJl5nHjD9M/
	 dD3WxfoCuSsh2FvclKeoiZRuYsupzZt8+5uKdkYs/tygisI3lyu2Ndg4Ic6QeZe5KY3bX
	 zZMT71exl9JFY7/XMupLhUFSuid2MskNMNVrypBvQCS+Bne+gRk+bOW36UBDVGVAHWg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793886338;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=/8uHk+Rg2/UcML9aTBosOPTbE3kdCGVUYAmOFZ8SYbk=;
	b=ZqiYZDItCqA9GvUr7NshXs9QCcOUm+1k0X27+SCJOfr78u+cRmCw85e2DauC8shqgR3f
	 HENCOfsxpd7KNtbSbuMVdDpnBAMrZtErb1/t1XiRDEWlGH47NRvpN6c8KXAQrF8t9PFlx
	 tPybnY25848jejsDa3eeEzua7euHELKBncNLsWvHhvTL7x3TAeSkVFEMOGQMrnPFA9fR0
	 SZlPWBmIsoFVQgd5JNA/B3051Dcw0iEq3+aDRR58YsM26buap7XM3zT9u6v+1Ts5+/tTj
	 TWu8D2k/LVel1tNGITb4sqLGFdbGTUPAf8NiEbOyJ9nK+tLWZ0StyloY8vevd4a/dEw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=l2t2k9ZA;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 708A8606A31B
	for <stable@vger.kernel.org>; Thu,  5 Nov 2026 13:45:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=l2t2k9ZA
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6A5581F000C1;
	Thu,  5 Nov 2026 13:45:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793886337;
	bh=/8uHk+Rg2/UcML9aTBosOPTbE3kdCGVUYAmOFZ8SYbk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=l2t2k9ZAovLJS/1aDpega4l2I+mrq9a4g+ZZ2O8kJDMNWuKj6kkCr4p33bQsO5WvL
	 /r27Oc/CxPpcqC1oj8HPZ177RN6jVi752AQd1yxma0mTepSEk8gEW/HfJLrhIpLe+g
	 KsageJOAzZN9TCE6eSG1BLtwdvAJuKE0aucn+IA78xAIY5G97LTW/c7B0+6EfruJET
	 4+Kj3gXBRHifkWmZflHFy9RfVwPt0GhG//R+mT9Cs/vBdy1bdQAvHk1ZeTGyvPBQPd
	 mdYTK7r+4tyPD2BXwGGMelnFPuPQtjb7NLbQYH9P+GBXh7gb15SZPHl/LuJ7xTJeF1
	 nT/oLlZO9Qqpw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: "Darrick J. Wong" <djwong@kernel.org>,
	Christoph Hellwig <hch@lst.de>,
	Carlos Maiolino <cem@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y] xfs: mark cow extents bad if there's no rmap mapping for them
Date: Thu,  5 Nov 2026 08:45:35 -0500
Message-ID: <20261105134353.1393384-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026110406-poise-feisty-313e@gregkh>
References: <2026110406-poise-feisty-313e@gregkh>
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

[ Upstream commit 2ffc0619c9c2881443c5fffb10db8f2bc0aa2ce8 ]

LOLLM noticed that we fail to mark cow staging extents as bad if there's
a cow staging extent but no rmap record for the cow staging event.
Close this gap.

Cc: stable@vger.kernel.org # v6.8
Fixes: dbbdbd0086320a ("xfs: repair problems in CoW forks")
Signed-off-by: Darrick J. Wong <djwong@kernel.org>
Assisted-by: LOLLM # finding obvious bugs
Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Carlos Maiolino <cem@kernel.org>
[ sashal: Replaced xfs_gbno_to_fsb() and xfs_agbno_to_fsb() calls with the existing XFS_AGB_TO_FSB() macro. ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/xfs/scrub/cow_repair.c | 66 +++++++++++++++++++++++++--------------
 1 file changed, 42 insertions(+), 24 deletions(-)

diff --git a/fs/xfs/scrub/cow_repair.c b/fs/xfs/scrub/cow_repair.c
index e8f7cfd4dd22b..853744729577b 100644
--- a/fs/xfs/scrub/cow_repair.c
+++ b/fs/xfs/scrub/cow_repair.c
@@ -194,30 +194,37 @@ xrep_cow_mark_missing_staging_rmap(
 	void				*priv)
 {
 	struct xrep_cow			*xc = priv;
-	xfs_fsblock_t			fsbno;
-	xfs_agblock_t			rec_bno;
-	xfs_extlen_t			rec_len;
-	unsigned int			adj;
+	const xfs_agblock_t		rec_end =
+			rec->rm_startblock + rec->rm_blockcount;
+	int				error = 0;
 
-	if (rec->rm_owner == XFS_RMAP_OWN_COW)
-		return 0;
-
-	rec_bno = rec->rm_startblock;
-	rec_len = rec->rm_blockcount;
-	if (rec_bno < xc->irec_startbno) {
-		adj = xc->irec_startbno - rec_bno;
-		rec_len -= adj;
-		rec_bno += adj;
+	/* Was there a gap since the last rmap? */
+	if (xc->next_bno < rec->rm_startblock) {
+		error = xrep_cow_mark_file_range(xc,
+				XFS_AGB_TO_FSB(xc->sc->mp, cur->bc_ag.pag->pag_agno,
+					       xc->next_bno),
+				rec->rm_startblock - xc->next_bno);
+		if (error)
+			return error;
 	}
 
-	if (rec_bno + rec_len > xc->irec_startbno + xc->irec.br_blockcount) {
-		adj = (rec_bno + rec_len) -
-		      (xc->irec_startbno + xc->irec.br_blockcount);
-		rec_len -= adj;
+	if (rec->rm_owner != XFS_RMAP_OWN_COW) {
+		const xfs_agblock_t	bad_bno =
+				max(xc->irec_startbno, rec->rm_startblock);
+		const xfs_agblock_t	irec_end =
+				xc->irec_startbno + xc->irec.br_blockcount;
+		const xfs_extlen_t	bad_end = min(irec_end, rec_end);
+
+		error = xrep_cow_mark_file_range(xc,
+				XFS_AGB_TO_FSB(xc->sc->mp, cur->bc_ag.pag->pag_agno,
+					       bad_bno),
+				bad_end - bad_bno);
+		if (error)
+			return error;
 	}
 
-	fsbno = XFS_AGB_TO_FSB(xc->sc->mp, cur->bc_ag.pag->pag_agno, rec_bno);
-	return xrep_cow_mark_file_range(xc, fsbno, rec_len);
+	xc->next_bno = max(xc->next_bno, rec_end);
+	return error;
 }
 
 /*
@@ -235,10 +242,12 @@ xrep_cow_find_bad(
 	struct xfs_perag		*pag;
 	struct xfs_scrub		*sc = xc->sc;
 	xfs_agnumber_t			agno;
+	xfs_agblock_t			irec_end;
 	int				error;
 
 	agno = XFS_FSB_TO_AGNO(sc->mp, xc->irec.br_startblock);
 	xc->irec_startbno = XFS_FSB_TO_AGBNO(sc->mp, xc->irec.br_startblock);
+	irec_end = xc->irec_startbno + xc->irec.br_blockcount;
 
 	pag = xfs_perag_get(sc->mp, agno);
 	if (!pag)
@@ -250,7 +259,7 @@ xrep_cow_find_bad(
 
 	/* Mark any CoW fork extents that are shared. */
 	rc_low.rc_startblock = xc->irec_startbno;
-	rc_high.rc_startblock = xc->irec_startbno + xc->irec.br_blockcount - 1;
+	rc_high.rc_startblock = irec_end - 1;
 	rc_low.rc_domain = rc_high.rc_domain = XFS_REFC_DOMAIN_SHARED;
 	error = xfs_refcount_query_range(sc->sa.refc_cur, &rc_low, &rc_high,
 			xrep_cow_mark_shared_staging, xc);
@@ -259,7 +268,7 @@ xrep_cow_find_bad(
 
 	/* Make sure there are CoW staging extents for the whole mapping. */
 	rc_low.rc_startblock = xc->irec_startbno;
-	rc_high.rc_startblock = xc->irec_startbno + xc->irec.br_blockcount - 1;
+	rc_high.rc_startblock = irec_end - 1;
 	rc_low.rc_domain = rc_high.rc_domain = XFS_REFC_DOMAIN_COW;
 	xc->next_bno = xc->irec_startbno;
 	error = xfs_refcount_query_range(sc->sa.refc_cur, &rc_low, &rc_high,
@@ -267,12 +276,11 @@ xrep_cow_find_bad(
 	if (error)
 		goto out_sa;
 
-	if (xc->next_bno < xc->irec_startbno + xc->irec.br_blockcount) {
+	if (xc->next_bno < irec_end) {
 		error = xrep_cow_mark_file_range(xc,
 				XFS_AGB_TO_FSB(sc->mp, pag->pag_agno,
 					       xc->next_bno),
-				xc->irec_startbno + xc->irec.br_blockcount -
-				xc->next_bno);
+				irec_end - xc->next_bno);
 		if (error)
 			goto out_sa;
 	}
@@ -281,11 +289,21 @@ xrep_cow_find_bad(
 	rm_low.rm_startblock = xc->irec_startbno;
 	memset(&rm_high, 0xFF, sizeof(rm_high));
 	rm_high.rm_startblock = xc->irec_startbno + xc->irec.br_blockcount - 1;
+	xc->next_bno = xc->irec_startbno;
 	error = xfs_rmap_query_range(sc->sa.rmap_cur, &rm_low, &rm_high,
 			xrep_cow_mark_missing_staging_rmap, xc);
 	if (error)
 		goto out_sa;
 
+	if (xc->next_bno < irec_end) {
+		error = xrep_cow_mark_file_range(xc,
+				XFS_AGB_TO_FSB(sc->mp, pag->pag_agno,
+					       xc->next_bno),
+				irec_end - xc->next_bno);
+		if (error)
+			goto out_sa;
+	}
+
 	/*
 	 * If userspace is forcing us to rebuild the CoW fork or someone turned
 	 * on the debugging knob, replace everything in the CoW fork.
-- 
2.53.0

