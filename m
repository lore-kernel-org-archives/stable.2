Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793811014;
	b=3RQyRCP6+W42lFGPZoFug9e9DPgR/H7vypX7v0RFLx8B5pZbhoVyWRKjHuNDw7SFGCfo
	 Xf7mHRdYPIDBF6zwtfqWXG3jVdcD842QsWud7qyXmC8rDVGhQc/QKoacVmGHFfmQAyQ88
	 arXjHeMiu4GoK1i2a8AWve0sd8iGs2gjm2pGCrYSwvTpZxVXjktL/vOnPDtqRy5y3yRLq
	 wPKykQh1mNPUPsE02uYzXlLnaaBiNDON+CFAcyNPtF95lQNhmS48mH0Bq9/e4TL4xF6lV
	 ggHZQ4GFR5ucMHdNv7VAkGA9aKvPc1PMt4i5YkP4N3fkExQZ61OfcplCHZVSf026dgw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793811014;
	h=Received:DKIM-Signature:Subject:To:Cc:From:Date:Message-ID:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=0IvJZwkYRkjowWdOfk5UzcP3OmDYpkQM2vYYuRYBg2Q=;
	b=kEaT7ztQwGjZJwHIREvbmmR3C3wBiV2XIvNpS+mUSEiWhNVzk1dEuyQhR5s3RP+tGkw5
	 2eV6WsyAwV+9//RUASBP8HugsbYyqGvgWf/e1NVn0bD/MCu4EPusxKDjRArMK29E+g6LE
	 N9nWbMyA/ahhaoy6+aN50JBKYVxRuclb5AAIRQgV5a23BpsmMpUnRal9svtOXPojnYq8P
	 h/tD3EA3tTiA2d+FEOCO4IrclPDs66BDCKwaLamCRhV5SX915whmPIsMdLFu/fZEMSnEW
	 9JVq3e2our0+6O/slCJ3A7j6EuLAufBrnVmoWXwIy6Aw4KWecuQIma5N8CVurm+k+EQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=OU+lsNBI;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0C09606EE8C
	for <stable@vger.kernel.org>; Wed,  4 Nov 2026 16:50:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=OU+lsNBI
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 541CD1F00919;
	Wed,  4 Nov 2026 16:50:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1793811013;
	bh=0IvJZwkYRkjowWdOfk5UzcP3OmDYpkQM2vYYuRYBg2Q=;
	h=Subject:To:Cc:From:Date;
	b=OU+lsNBI6gcULCs3na+AiWhI0vOlFbIO59c3a/wE3AoTMBvvXA9+1V9Te0q5bD9qV
	 /xSz1hNKHp/UURJkBKbJAINSeTuJxt+I+to9WD8n8j45HJO5qj9jsckCsWrqOCookg
	 8CG7t/oNLur+Z3r07moW2/FQBq0I0JCDOrD5Y1sM=
Subject: FAILED: patch "[PATCH] xfs: rescan the AGs if incore delalloc counter is negative" failed to apply to 5.10-stable tree
To: djwong@kernel.org,cem@kernel.org,hch@lst.de
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 04 Nov 2026 11:50:09 -0500
Message-ID: <2026110409-dental-lend-b1b3@gregkh>
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


The patch below does not apply to the 5.10-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.10.y
git checkout FETCH_HEAD
git cherry-pick -x 47b1e941bb55f735d82ba2649412260da78b98f8
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026110409-dental-lend-b1b3@gregkh' --subject-prefix 'PATCH 5.10.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 47b1e941bb55f735d82ba2649412260da78b98f8 Mon Sep 17 00:00:00 2001
From: "Darrick J. Wong" <djwong@kernel.org>
Date: Mon, 12 Oct 2026 23:09:07 -0700
Subject: [PATCH] xfs: rescan the AGs if incore delalloc counter is negative

LOLLM complains that percpu_counter_sum can return a negative number but
we instead misinterpret that into a huge unsigned value and do bad
things to fdblocks.  It shouldn't do that, so let's add a retry loop and
an attempt to freeze the filesystem to (hopefully) zero out the incore
delalloc counter.  It probably won't work, but at least failing the
repair beats doing the wrong thing.

Cc: stable@vger.kernel.org # v5.2
Fixes: 75efa57d0bf5fc ("xfs: add online scrub for superblock counters")
Signed-off-by: Darrick J. Wong <djwong@kernel.org>
Assisted-by: LOLLM # finding obvious bugs
Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Carlos Maiolino <cem@kernel.org>

diff --git a/fs/xfs/scrub/fscounters.c b/fs/xfs/scrub/fscounters.c
index 5984fe13a973..67e159f39951 100644
--- a/fs/xfs/scrub/fscounters.c
+++ b/fs/xfs/scrub/fscounters.c
@@ -297,7 +297,7 @@ xchk_fscount_aggregate_agcounts(
 {
 	struct xfs_mount	*mp = sc->mp;
 	struct xfs_perag	*pag = NULL;
-	uint64_t		delayed;
+	int64_t			delayed;
 	int			tries = 8;
 	int			error = 0;
 
@@ -359,6 +359,11 @@ xchk_fscount_aggregate_agcounts(
 	 * of the computation.
 	 */
 	delayed = percpu_counter_sum(&mp->m_delalloc_blks);
+	if (delayed < 0) {
+		ASSERT(delayed >= 0);
+		xchk_set_incomplete(sc);
+		return -EFSCORRUPTED;
+	}
 	fsc->fdblocks -= delayed;
 
 	trace_xchk_fscounters_calc(mp, fsc->icount, fsc->ifree, fsc->fdblocks,
@@ -417,6 +422,7 @@ xchk_fscount_count_frextents(
 {
 	struct xfs_mount	*mp = sc->mp;
 	struct xfs_rtgroup	*rtg = NULL;
+	int64_t			delayed;
 	int			error;
 
 	fsc->frextents = 0;
@@ -442,7 +448,14 @@ xchk_fscount_count_frextents(
 		}
 	}
 
-	fsc->frextents_delayed = percpu_counter_sum(&mp->m_delalloc_rtextents);
+	delayed = percpu_counter_sum(&mp->m_delalloc_rtextents);
+	if (delayed < 0) {
+		ASSERT(delayed >= 0);
+		xchk_set_incomplete(sc);
+		return -EFSCORRUPTED;
+	}
+	fsc->frextents_delayed = delayed;
+
 	return 0;
 }
 #else

