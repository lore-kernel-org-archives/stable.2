Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793890930;
	b=bZnGZaryKKB44PIUJFCrEmxb5WncoFIa8uXPPhmBDXz+QcVVan2AhLNVS2/ghEFSx0Qr
	 DfxPvOpHdUzD6RT0aO0q8IGW6hNXxCqlBuzdizorFkZLPRlpLbI4A3tMSveaFEv2rMz9J
	 PuFaAIAZ/4r1L5W0GgjVKgHeGzTDdhWv0ncY+ILEUo2GaYFg1leLewFZBCgnqHJ0cyrw3
	 VCnHi9o0sHXWGDa/jkzxyVuGpGiQJ2nOugY6cv6qJk8aOpHdQMRZpOU3YuDlMT7DeD7Dl
	 rrqUoltnZ0t+wZnSif8nXgeYE5X73SORAcTt9Y98+HpR+c+AtAyXPjPee0UO/UQ7QEg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793890930;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=974nuGvRc85oTJShO4eEdpOa4/VLre4jFNqCZ+Ho7T4=;
	b=q+w/KumAoEWJ+DCNHcUnpnVO7F/l0O6Z5Njj/hXk4rBmQAkIn/cky1O4TKk3ewWTJza0
	 Xl3Tl1UIaSHfF55dvKtIbzAzA6/suRNjxAOPsT5ZjBsEcAaqz4dC4701J8cjbl+QNzq63
	 pX1dl0QRAuOuHeUo1XkrBmSx7HztwBD7jqzxGn6m+tDqewvmdNq9LSPWCMGVWh7YUpgWb
	 aOEXqDttJaJ7tECuZlH+x/eMvXRvwtI+gDz3SN74VTEsu/Kcu7ubxLUNFnYO0wFxn2P09
	 xeqNoxQ/RIvNXpr0QV8iMlpPRaznDQq3+our81COuj93XTTDci9Y35frpHXhZck8aUA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="QDSc/9Pm";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EDC0606A339
	for <stable@vger.kernel.org>; Thu,  5 Nov 2026 15:02:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=QDSc/9Pm
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 723A71F000C1;
	Thu,  5 Nov 2026 15:02:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793890930;
	bh=974nuGvRc85oTJShO4eEdpOa4/VLre4jFNqCZ+Ho7T4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=QDSc/9Pm93yyK5fsckBIuaKD5L2fKkNhrrSweRLGPDRYl4MnNmpsu79waL+o5S/rm
	 SOFfGW2gIuyaGXhSmfLMsT/HwY2ClJMmn5rwqL2+NZPxe9CY2od7BWU+G3cVzntcfz
	 LQ+f8pdbrLBkcUOWwD4z43jHPY/rOjQPxOPmvsj5MgPvFf2FLTQ6l6G07ux5fYkAoy
	 rgEsmX/RAx2Bb4N1rKdgu1+DIhLt++/604Xc76Jq1ebEPYhSXriLpgBu1WpqXyK1GV
	 +Mkqkdosb9BVUmg+na/vTOup5hwH/4Yl1st1SVw/ccTtwm4zEsJLFeKJKMO6W5uO3c
	 JAdrgyEg/I6Sw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: "Darrick J. Wong" <djwong@kernel.org>,
	Christoph Hellwig <hch@lst.de>,
	Carlos Maiolino <cem@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y] xfs: cross-reference the primary superblock
Date: Thu,  5 Nov 2026 10:02:08 -0500
Message-ID: <20261105150119.1837412-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026110440-single-collision-69cc@gregkh>
References: <2026110440-single-collision-69cc@gregkh>
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
[ sashal: initialized the error variable to zero in xchk_superblock() ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/xfs/scrub/agheader.c | 17 ++++++++---------
 1 file changed, 8 insertions(+), 9 deletions(-)

diff --git a/fs/xfs/scrub/agheader.c b/fs/xfs/scrub/agheader.c
index b7b838bd4ba43..89193f07b451f 100644
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
@@ -344,7 +342,8 @@ xchk_superblock(
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

