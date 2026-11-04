Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793805411;
	b=2LdAGvB0Yl6rwa0aLFfkBgOMXNa4Nd9tx6jDhfO8OvBnJfQo2Fh8s5huAarff5d1bkED
	 XOoAT9SLFUbQCvTw2h0sm/rYh8biwvPl9BW/9UNaYtllVl0Fc6lVna27Yky0TjKz9fHXS
	 BO+vMse0xm5ttQN/FNWTEsoXVSo6Yp3KEW8wtrm20LbAjigb8kJU4PCzRtJ8AliPNQmOI
	 xqroqXMJlBwt890GzAso77gfqOYNe2B5ZasZ03Q6gfFH7R8EA5E8QGAnk53G706Kl9g4E
	 7sJ5LnWbO5Q9UXL8oPZBmSz6YDvqm/HKpzL+PVLDtXiTCp1gUwzV2GgNtw92EhAAnZw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793805411;
	h=Received:DKIM-Signature:Subject:To:Cc:From:Date:Message-ID:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=2ZWXuGKkzN5Kc/DoBGFP90BOyEZ/mikoAqVSg4tzB70=;
	b=y59d5H9z3q5xrZM7n8gK3W8SqLIfB1uh7mOBrIy/OLrUotuKDiMxxfNUSfrIlX2EDaKX
	 tkRkLdhsKdIPQigqTqgVsGVAHifPyOPtJeWsfxtHouxl2JFDpqRDJi0mlzOk2ORHFLhcv
	 UkD6hXO6+Jrt4GmgQ7QqjM9gwvWYl3Hjd/W1ez5/aVRFFFuT47I4iASGZ+j7L7Oj3ykqm
	 S9qH18evogBTmrG6oTJSQ6uWO+sIL2Y7ahCMVBhP0F0T8mCBLgHIqUuCtMR+legiKpMvJ
	 eFf8LBFGiOIzLDWbHkQKk73BVfckDxQsOF2hOHF4BM3FjzvX/D9ur49hQnJD+vX0lQQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=CwFxswnt;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB5C96074747
	for <stable@vger.kernel.org>; Wed,  4 Nov 2026 15:16:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=CwFxswnt
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1ED3B1F000C1;
	Wed,  4 Nov 2026 15:16:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1793805410;
	bh=2ZWXuGKkzN5Kc/DoBGFP90BOyEZ/mikoAqVSg4tzB70=;
	h=Subject:To:Cc:From:Date;
	b=CwFxswntSgAw3UDSZS5Ba9X1tnJOygLsUhbTNPoZsAD7iqvPOjTC+VR7rdjL9wHiL
	 gaLaqLAwB/MO4x3DOiwbvFnDk7Nj1lbzEO1k2cns1InSIfdM+ZvD1YrBFYsMTdk/lf
	 b1OU9a2BevaLqAMwX4/Ue/yoEVrPx048Wzh71Dd0=
Subject: FAILED: patch "[PATCH] xfs: cross-reference the primary superblock" failed to apply to 6.1-stable tree
To: djwong@kernel.org,cem@kernel.org,hch@lst.de
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 04 Nov 2026 16:16:40 +0100
Message-ID: <2026110440-single-collision-69cc@gregkh>
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


The patch below does not apply to the 6.1-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.1.y
git checkout FETCH_HEAD
git cherry-pick -x 0c61016006ab08f8346f9e7b1e38559bd4ea499e
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026110440-single-collision-69cc@gregkh' --subject-prefix 'PATCH 6.1.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 0c61016006ab08f8346f9e7b1e38559bd4ea499e Mon Sep 17 00:00:00 2001
From: "Darrick J. Wong" <djwong@kernel.org>
Date: Thu, 24 Sep 2026 21:11:32 -0700
Subject: [PATCH] xfs: cross-reference the primary superblock

Make sure we cross-reference the primary superblock against the rest of
the AG 0 space metadata.  Drop the unused @bp parameter of
xchk_superblock_xref to avoid complaints about uninitialized variables.

Cc: stable@vger.kernel.org # v4.16
Fixes: 52dc4b44af7419 ("xfs: cross-reference with the bnobt")
Signed-off-by: Darrick J. Wong <djwong@kernel.org>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Carlos Maiolino <cem@kernel.org>

diff --git a/fs/xfs/scrub/agheader.c b/fs/xfs/scrub/agheader.c
index fa5d32ec020a..1dff6cb1b936 100644
--- a/fs/xfs/scrub/agheader.c
+++ b/fs/xfs/scrub/agheader.c
@@ -35,8 +35,7 @@ xchk_setup_agheader(
 /* Cross-reference with the other btrees. */
 STATIC void
 xchk_superblock_xref(
-	struct xfs_scrub	*sc,
-	struct xfs_buf		*bp)
+	struct xfs_scrub	*sc)
 {
 	struct xfs_mount	*mp = sc->mp;
 	xfs_agnumber_t		agno = sc->sm->sm_agno;
@@ -106,16 +105,12 @@ xchk_superblock(
 	struct xfs_dsb		*sb;
 	struct xfs_perag	*pag;
 	size_t			sblen;
-	xfs_agnumber_t		agno;
+	xfs_agnumber_t		agno = sc->sm->sm_agno;
 	uint32_t		v2_ok;
 	__be32			features_mask;
 	int			error;
 	__be16			vernum_mask;
 
-	agno = sc->sm->sm_agno;
-	if (agno == 0)
-		return 0;
-
 	/*
 	 * Grab an active reference to the perag structure.  If we can't get
 	 * it, we're racing with something that's tearing down the AG, so
@@ -125,6 +120,9 @@ xchk_superblock(
 	if (!pag)
 		return -ENOENT;
 
+	if (agno == 0)
+		goto out_xref;
+
 	error = xfs_sb_read_secondary(mp, sc->tp, agno, &bp);
 	/*
 	 * The superblock verifier can return several different error codes
@@ -430,7 +428,8 @@ xchk_superblock(
 	if (memchr_inv((char *)sb + sblen, 0, BBTOB(bp->b_length) - sblen))
 		xchk_block_set_corrupt(sc, bp);
 
-	xchk_superblock_xref(sc, bp);
+out_xref:
+	xchk_superblock_xref(sc);
 out_pag:
 	xfs_perag_put(pag);
 	return error;

