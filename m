Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793805417;
	b=kcQs1km8UWC/ABA1Ka37QNqHZKszvb4D71/e0Te9UpDdKPsl9Rp9gnMPsMrb56dmYp5M
	 K0ArldiOxjRA8wQUZ76vzOzzgk+Yy2fWK/W5mrZxxfsY/i04tb7szOMZb7sKa1/RlVIFq
	 RdHCAu2Ya7nC3AG1w7rNQuvlKm/V+BzRSN0XfvM8K6tYrO9GyrxDfoQJj+UkeiJdGokf3
	 /Puc33vysp4GJUfHMp5ltKo27cjG4LUQL94iAORbJmW/QeMMRwmeHTQJwtaNitFRUHh0t
	 OFhP84/TaJWg2wIy7EFHd+zrQIKh/NubE3jW4rK1eerxpY3YE0Vo1monw9FCbK9jMRA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793805417;
	h=Received:DKIM-Signature:Subject:To:Cc:From:Date:Message-ID:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=eFrBmYWM8ea/e0vZmQwmIKREwvwfqdfJuS6t8eyq4VY=;
	b=nicR9pjAHwQJKkM5NPaxftjZWJulDE0sh101wxANRwmQDwu6BhzaQv1jQFMtaA7VAyA1
	 eptTJjL0gR1hQdKS+h0xUQY06HukXNfFJZHVUq1J8ECuYiFmljvhcqtb5Di15w3HjmZvz
	 LFCUnjcpMRZAkycNEEiVYrXi4twaqjdcX7NDtFidCz3V1+S7T8xX/eu+jy7cSJfHlYBly
	 eBSswNQqq6fpta8ztb79UVi27a/QkvLgvPMwGSEbvuw0pZEUatyVJeGNhJs83Yd+E+QxK
	 HS5Iaz2viGdbqJekZCjsg7/knj7I6bBMplvVRoKXi8SUD+QWY3Nk+k20uuJFeV1tl7A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=LHiELOGr;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D85BD607477A
	for <stable@vger.kernel.org>; Wed,  4 Nov 2026 15:16:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=LHiELOGr
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0243B1F00919;
	Wed,  4 Nov 2026 15:16:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1793805416;
	bh=eFrBmYWM8ea/e0vZmQwmIKREwvwfqdfJuS6t8eyq4VY=;
	h=Subject:To:Cc:From:Date;
	b=LHiELOGr97e/tb9AyhiF39KDKGWisAOy2410pp5FAGwNEBAwEC73sGO/hsi8J7SDY
	 HqDBGOLnHiZG3VBOK0iy8ypS4UQYGKbSRVQLfbTzicNnCcQhJWD99XjwfYWI0IgP+t
	 vrs+D2iY7gSLbUeuXf9sjowqNCouNWrTy6JDX8Tk=
Subject: FAILED: patch "[PATCH] xfs: cross-reference the primary superblock" failed to apply to 5.15-stable tree
To: djwong@kernel.org,cem@kernel.org,hch@lst.de
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 04 Nov 2026 16:16:41 +0100
Message-ID: <2026110441-sighing-margarine-42bd@gregkh>
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


The patch below does not apply to the 5.15-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.15.y
git checkout FETCH_HEAD
git cherry-pick -x 0c61016006ab08f8346f9e7b1e38559bd4ea499e
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026110441-sighing-margarine-42bd@gregkh' --subject-prefix 'PATCH 5.15.y' 'HEAD^..'

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

