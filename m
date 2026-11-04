Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793805191;
	b=SzH3SM0V/9+Vu+HNOPr3df56b3UbB/5vBovePoXthn/lJ5nTOT6LPFIf03rPerFpb/XW
	 Ez5AZqWeL/wzwp5YWeKBSAvKtej7Sl/8drLnTd0NH4v/2+LaCrJ/0ZWLiHFTvx39g6EUK
	 ur4Jk7STe7CTQ0RrA5uj8SU8LVIPSFaw3D3s1uIPF1/iWQWSrr4wDy2cr39pCKDRpesPJ
	 7hW1Qp95osXpE6FE1CpUa1mIMb3Ke8oeywBNIgvIGA4QuiV60/zUAl+A6GAAYBJ4Iy2wl
	 ZywK643xv0GiQE8DKyR6vduqMtJ9VD0ws2gQhnobceLqZx78A2SCShoh1XK2KXmnavw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793805191;
	h=Received:DKIM-Signature:Subject:To:Cc:From:Date:Message-ID:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=dskWzzN1hH35FxTBczFkiwz7l/M/BHHM5cU7UnvpCbg=;
	b=s03g6vUYj4ELru1e/XsjQSZ+A2BscxoH6bC5idEbqY9AFR/vj7wEtTPaIcQsG4clFVYC
	 h0j59Z76XPiGYqc4Q3wZPg6SL79rT+rtQIHdvzTBPgQ9OXVaVglCkfpidQntAm02wTnfL
	 MC/VnpbEaAU24EouiL1FE4iZvVtu5gsVolemqBXGP4qXX72ILIJ5LYV9RQ5JK3tycAXfh
	 qr9nNCC30GAsFPzb8IzCV1g4gbgQYdmBRfgvqoxugimFCKbSe6N6svJ4CPlKX7A66qzu3
	 PwgeTP4NDKcdMePoCXbdclhsN2wy/zt36A2fHBQ6YVWWJhSKS4veyzBGokQr/hkKgdQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=mCM61fHS;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E109E606D822
	for <stable@vger.kernel.org>; Wed,  4 Nov 2026 15:13:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=mCM61fHS
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EF5CA1F000C1;
	Wed,  4 Nov 2026 15:13:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1793805190;
	bh=dskWzzN1hH35FxTBczFkiwz7l/M/BHHM5cU7UnvpCbg=;
	h=Subject:To:Cc:From:Date;
	b=mCM61fHSUJX4ucZ8KqgoOP70GkdPYggAbz5ET7NDo9C8q6cOgTKZnYfRwBAN2mnQA
	 eozEq+Q/5RXVKTWBuGXKexOCR7TG8PGgs8EjF86NUfgdrZhXxrNzd4cfyIwpzg6zxs
	 JyGk0DRjCP10CMMaUCSA5rrAxGIKtSO4v0V3DQUI=
Subject: FAILED: patch "[PATCH] xfs: mark cow extents bad if there's no rmap mapping for them" failed to apply to 6.12-stable tree
To: djwong@kernel.org,cem@kernel.org,hch@lst.de
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 04 Nov 2026 16:13:06 +0100
Message-ID: <2026110406-poise-feisty-313e@gregkh>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.12-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.12.y
git checkout FETCH_HEAD
git cherry-pick -x 2ffc0619c9c2881443c5fffb10db8f2bc0aa2ce8
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026110406-poise-feisty-313e@gregkh' --subject-prefix 'PATCH 6.12.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 2ffc0619c9c2881443c5fffb10db8f2bc0aa2ce8 Mon Sep 17 00:00:00 2001
From: "Darrick J. Wong" <djwong@kernel.org>
Date: Tue, 22 Sep 2026 23:01:16 -0700
Subject: [PATCH] xfs: mark cow extents bad if there's no rmap mapping for them

LOLLM noticed that we fail to mark cow staging extents as bad if there's
a cow staging extent but no rmap record for the cow staging event.
Close this gap.

Cc: stable@vger.kernel.org # v6.8
Fixes: dbbdbd0086320a ("xfs: repair problems in CoW forks")
Signed-off-by: Darrick J. Wong <djwong@kernel.org>
Assisted-by: LOLLM # finding obvious bugs
Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Carlos Maiolino <cem@kernel.org>

diff --git a/fs/xfs/scrub/cow_repair.c b/fs/xfs/scrub/cow_repair.c
index 8dd9c0266e21..e49d9396edc5 100644
--- a/fs/xfs/scrub/cow_repair.c
+++ b/fs/xfs/scrub/cow_repair.c
@@ -200,29 +200,35 @@ xrep_cow_mark_missing_staging_rmap(
 	void				*priv)
 {
 	struct xrep_cow			*xc = priv;
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
+				xfs_gbno_to_fsb(cur->bc_group, xc->next_bno),
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
+				xfs_gbno_to_fsb(cur->bc_group, bad_bno),
+				bad_end - bad_bno);
+		if (error)
+			return error;
 	}
 
-	return xrep_cow_mark_file_range(xc,
-			xfs_gbno_to_fsb(cur->bc_group, rec_bno), rec_len);
+	xc->next_bno = max(xc->next_bno, rec_end);
+	return error;
 }
 
 /*
@@ -263,10 +269,12 @@ xrep_cow_find_bad(
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
@@ -278,7 +286,7 @@ xrep_cow_find_bad(
 
 	/* Mark any CoW fork extents that are shared. */
 	rc_low.rc_startblock = xc->irec_startbno;
-	rc_high.rc_startblock = xc->irec_startbno + xc->irec.br_blockcount - 1;
+	rc_high.rc_startblock = irec_end - 1;
 	rc_low.rc_domain = rc_high.rc_domain = XFS_REFC_DOMAIN_SHARED;
 	error = xfs_refcount_query_range(sc->sa.refc_cur, &rc_low, &rc_high,
 			xrep_cow_mark_shared_staging, xc);
@@ -287,7 +295,7 @@ xrep_cow_find_bad(
 
 	/* Make sure there are CoW staging extents for the whole mapping. */
 	rc_low.rc_startblock = xc->irec_startbno;
-	rc_high.rc_startblock = xc->irec_startbno + xc->irec.br_blockcount - 1;
+	rc_high.rc_startblock = irec_end - 1;
 	rc_low.rc_domain = rc_high.rc_domain = XFS_REFC_DOMAIN_COW;
 	xc->next_bno = xc->irec_startbno;
 	error = xfs_refcount_query_range(sc->sa.refc_cur, &rc_low, &rc_high,
@@ -295,11 +303,10 @@ xrep_cow_find_bad(
 	if (error)
 		goto out_sa;
 
-	if (xc->next_bno < xc->irec_startbno + xc->irec.br_blockcount) {
+	if (xc->next_bno < irec_end) {
 		error = xrep_cow_mark_file_range(xc,
 				xfs_agbno_to_fsb(pag, xc->next_bno),
-				xc->irec_startbno + xc->irec.br_blockcount -
-				xc->next_bno);
+				irec_end - xc->next_bno);
 		if (error)
 			goto out_sa;
 	}
@@ -308,11 +315,20 @@ xrep_cow_find_bad(
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
+				xfs_agbno_to_fsb(pag, xc->next_bno),
+				irec_end - xc->next_bno);
+		if (error)
+			goto out_sa;
+	}
+
 	/*
 	 * If userspace is forcing us to rebuild the CoW fork or someone turned
 	 * on the debugging knob, replace everything in the CoW fork.
@@ -344,9 +360,11 @@ xrep_cow_find_bad_rt(
 	struct xfs_rmap_irec		rm_high = { 0 };
 	struct xfs_scrub		*sc = xc->sc;
 	struct xfs_rtgroup		*rtg;
+	xfs_agblock_t			irec_end;
 	int				error = 0;
 
 	xc->irec_startbno = xfs_rtb_to_rgbno(sc->mp, xc->irec.br_startblock);
+	irec_end = xc->irec_startbno + xc->irec.br_blockcount;
 
 	rtg = xfs_rtgroup_get(sc->mp,
 			xfs_rtb_to_rgno(sc->mp, xc->irec.br_startblock));
@@ -360,7 +378,7 @@ xrep_cow_find_bad_rt(
 
 	/* Mark any CoW fork extents that are shared. */
 	rc_low.rc_startblock = xc->irec_startbno;
-	rc_high.rc_startblock = xc->irec_startbno + xc->irec.br_blockcount - 1;
+	rc_high.rc_startblock = irec_end - 1;
 	rc_low.rc_domain = rc_high.rc_domain = XFS_REFC_DOMAIN_SHARED;
 	error = xfs_refcount_query_range(sc->sr.refc_cur, &rc_low, &rc_high,
 			xrep_cow_mark_shared_staging, xc);
@@ -369,7 +387,7 @@ xrep_cow_find_bad_rt(
 
 	/* Make sure there are CoW staging extents for the whole mapping. */
 	rc_low.rc_startblock = xc->irec_startbno;
-	rc_high.rc_startblock = xc->irec_startbno + xc->irec.br_blockcount - 1;
+	rc_high.rc_startblock = irec_end - 1;
 	rc_low.rc_domain = rc_high.rc_domain = XFS_REFC_DOMAIN_COW;
 	xc->next_bno = xc->irec_startbno;
 	error = xfs_refcount_query_range(sc->sr.refc_cur, &rc_low, &rc_high,
@@ -377,11 +395,10 @@ xrep_cow_find_bad_rt(
 	if (error)
 		goto out_sr;
 
-	if (xc->next_bno < xc->irec_startbno + xc->irec.br_blockcount) {
+	if (xc->next_bno < irec_end) {
 		error = xrep_cow_mark_file_range(xc,
 				xfs_rgbno_to_rtb(rtg, xc->next_bno),
-				xc->irec_startbno + xc->irec.br_blockcount -
-				xc->next_bno);
+				irec_end - xc->next_bno);
 		if (error)
 			goto out_sr;
 	}
@@ -389,12 +406,21 @@ xrep_cow_find_bad_rt(
 	/* Mark any area has an rmap that isn't a COW staging extent. */
 	rm_low.rm_startblock = xc->irec_startbno;
 	memset(&rm_high, 0xFF, sizeof(rm_high));
-	rm_high.rm_startblock = xc->irec_startbno + xc->irec.br_blockcount - 1;
+	rm_high.rm_startblock = irec_end - 1;
+	xc->next_bno = xc->irec_startbno;
 	error = xfs_rmap_query_range(sc->sr.rmap_cur, &rm_low, &rm_high,
 			xrep_cow_mark_missing_staging_rmap, xc);
 	if (error)
 		goto out_sr;
 
+	if (xc->next_bno < irec_end) {
+		error = xrep_cow_mark_file_range(xc,
+				xfs_rgbno_to_rtb(rtg, xc->next_bno),
+				irec_end - xc->next_bno);
+		if (error)
+			goto out_sr;
+	}
+
 	/*
 	 * If userspace is forcing us to rebuild the CoW fork or someone
 	 * turned on the debugging knob, replace everything in the

