Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4968E442B38
	for <stable@vger.kernel.org>; Wed, 16 Sep 2026 17:26:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789579571; cv=none; b=Hx9aCXZgGDh59z0AvZtyT64hNGvGZ1xmQiIDiriU62luqlVH+zL4gadymA/U0xo27RsC3fWXxBbp0COAm51Y1X7BqjjvSfzujsVC+j9epVBnYn/5suPb92Dytz87bp9dqoNbnfaHnusGE94h05nq1/lgW4Y81PmCK2BHVfqQBqU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789579571; c=relaxed/simple;
	bh=lz1QPqVqwJsf98oCTcEeHJjFZYKYF4xVgDBXNNS+X6g=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=Em5jbhcbOan6uhpFsPcSCDDd7/pGLDoD2hNqtL4tNRBDpeCYEme79e/y8dIAjG0isQLC0TKrKxsPZeMmpzCdtRlATVya/P3/4nLOINpCHVkTBOvzP4UoYHz2ifPRv6BbCZ/v+rUA7GDLSURLkLAhXk6YRXd1AHDON4GTGXt9vOI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=aLpFyggd; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="aLpFyggd"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5060C1F000FF;
	Wed, 16 Sep 2026 17:26:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1789579569;
	bh=vUT2Ym6G6u2KY03RXZJDLsh0UyCNEc10TlQACttiYr4=;
	h=Subject:To:Cc:From:Date;
	b=aLpFyggdLnnCRp6vlLOdbsveh1kxELSCQIvy3FTdCyQX8RkfIxjQxIWUKN5MUt646
	 6ypCDsRXFfFf/2jKfCkdjqYCumbEPHOISZqezCO+nJRAUmfGbU/y/JQOQEpFaty0hf
	 YHk4Q3+jr4Htl5F3eUSMgdhy4ksx2R2k018YZZRU=
Subject: FAILED: patch "[PATCH] xfs: snapshot old AGFL before rewriting it" failed to apply to 5.10-stable tree
To: djwong@kernel.org,cem@kernel.org,cmaiolino@redhat.com,hch@lst.de
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 16 Sep 2026 18:21:31 +0100
Message-ID: <2026091630-hungrily-obtain-d7d7@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.10-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.10.y
git checkout FETCH_HEAD
git cherry-pick -x 3466dfef0a20f842363958deea55be9f1d26818a
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026091630-hungrily-obtain-d7d7@gregkh' --subject-prefix 'PATCH 5.10.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 3466dfef0a20f842363958deea55be9f1d26818a Mon Sep 17 00:00:00 2001
From: "Darrick J. Wong" <djwong@kernel.org>
Date: Tue, 8 Sep 2026 23:04:04 -0700
Subject: [PATCH] xfs: snapshot old AGFL before rewriting it

LOLLM complains that we can't undo an attempt at fixing the AGFL if
anything goes wrong during the rewrite, so take a snapshot of the whole
buffer so that we can restore it.  Move the xrep_agfl_update_agf call so
that we only update the AGF if the AGFL update is 100% successful.

While we're at it, fix leaking the used_extents bitmap if the disunion
operation fails.

Cc: stable@vger.kernel.org # v4.19
Fixes: 0e93d3f43ec7d3 ("xfs: repair the AGFL")
Signed-off-by: Darrick J. Wong <djwong@kernel.org>
Assisted-by: LOLLM # finding obvious bugs
Reviewed-by: Carlos Maiolino <cmaiolino@redhat.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Carlos Maiolino <cem@kernel.org>

diff --git a/fs/xfs/scrub/agheader_repair.c b/fs/xfs/scrub/agheader_repair.c
index 2104512f1ee1..46c95354ca64 100644
--- a/fs/xfs/scrub/agheader_repair.c
+++ b/fs/xfs/scrub/agheader_repair.c
@@ -668,14 +668,16 @@ xrep_agfl_init_header(
 	struct xfs_scrub	*sc,
 	struct xfs_buf		*agfl_bp,
 	struct xagb_bitmap	*agfl_extents,
-	xfs_agblock_t		flcount)
+	xfs_agblock_t		flcount,
+	struct xfs_agfl		*old_agfl)
 {
 	struct xrep_agfl_fill	af = {
 		.sc		= sc,
 		.flcount	= flcount,
 	};
 	struct xfs_mount	*mp = sc->mp;
-	struct xfs_agfl		*agfl;
+	struct xfs_agfl		*agfl = XFS_BUF_TO_AGFL(agfl_bp);
+	const size_t		agfl_sz = BBTOB(agfl_bp->b_length);
 	int			error;
 
 	ASSERT(flcount <= xfs_agfl_size(mp));
@@ -684,8 +686,8 @@ xrep_agfl_init_header(
 	 * Start rewriting the header by setting the bno[] array to
 	 * NULLAGBLOCK, then setting AGFL header fields.
 	 */
-	agfl = XFS_BUF_TO_AGFL(agfl_bp);
-	memset(agfl, 0xFF, BBTOB(agfl_bp->b_length));
+	memcpy(old_agfl, agfl, agfl_sz);
+	memset(agfl, 0xFF, agfl_sz);
 	agfl->agfl_magicnum = cpu_to_be32(XFS_AGFL_MAGIC);
 	agfl->agfl_seqno = cpu_to_be32(pag_agno(sc->sa.pag));
 	uuid_copy(&agfl->agfl_uuid, &mp->m_sb.sb_meta_uuid);
@@ -700,13 +702,18 @@ xrep_agfl_init_header(
 	xagb_bitmap_walk(agfl_extents, xrep_agfl_fill, &af);
 	error = xagb_bitmap_disunion(agfl_extents, &af.used_extents);
 	if (error)
-		return error;
+		goto err_undo;
 
 	/* Write new AGFL to disk. */
 	xfs_trans_buf_set_type(sc->tp, agfl_bp, XFS_BLFT_AGFL_BUF);
-	xfs_trans_log_buf(sc->tp, agfl_bp, 0, BBTOB(agfl_bp->b_length) - 1);
+	xfs_trans_log_buf(sc->tp, agfl_bp, 0, agfl_sz - 1);
 	xagb_bitmap_destroy(&af.used_extents);
 	return 0;
+
+err_undo:
+	xagb_bitmap_destroy(&af.used_extents);
+	memcpy(agfl, old_agfl, agfl_sz);
+	return error;
 }
 
 /* Repair the AGFL. */
@@ -718,6 +725,7 @@ xrep_agfl(
 	struct xfs_mount	*mp = sc->mp;
 	struct xfs_buf		*agf_bp;
 	struct xfs_buf		*agfl_bp;
+	struct xfs_agfl		*old_agfl;
 	xfs_agblock_t		flcount;
 	int			error;
 
@@ -725,6 +733,10 @@ xrep_agfl(
 	if (!xfs_has_rmapbt(mp))
 		return -EOPNOTSUPP;
 
+	old_agfl = kzalloc(BBTOB(XFS_FSS_TO_BB(mp, 1)), XCHK_GFP_FLAGS);
+	if (!old_agfl)
+		return -ENOMEM;
+
 	xagb_bitmap_init(&agfl_extents);
 
 	/*
@@ -734,7 +746,7 @@ xrep_agfl(
 	 */
 	error = xfs_alloc_read_agf(sc->sa.pag, sc->tp, 0, &agf_bp);
 	if (error)
-		return error;
+		goto err_old_agfl;
 
 	/*
 	 * Make sure we have the AGFL buffer, as scrub might have decided it
@@ -745,7 +757,7 @@ xrep_agfl(
 						XFS_AGFL_DADDR(mp)),
 			XFS_FSS_TO_BB(mp, 1), 0, &agfl_bp, NULL);
 	if (error)
-		return error;
+		goto err_old_agfl;
 	agfl_bp->b_ops = &xfs_agfl_buf_ops;
 
 	/* Gather all the extents we're going to put on the new AGFL. */
@@ -762,10 +774,11 @@ xrep_agfl(
 	 * we adjust the AGF flcount (which can fail) so avoid updating any
 	 * buffers until we know that part works.
 	 */
-	xrep_agfl_update_agf(sc, agf_bp, flcount);
-	error = xrep_agfl_init_header(sc, agfl_bp, &agfl_extents, flcount);
+	error = xrep_agfl_init_header(sc, agfl_bp, &agfl_extents, flcount,
+			old_agfl);
 	if (error)
 		goto err;
+	xrep_agfl_update_agf(sc, agf_bp, flcount);
 
 	/*
 	 * Ok, the AGFL should be ready to go now.  Roll the transaction to
@@ -785,6 +798,8 @@ xrep_agfl(
 
 err:
 	xagb_bitmap_destroy(&agfl_extents);
+err_old_agfl:
+	kfree(old_agfl);
 	return error;
 }
 

