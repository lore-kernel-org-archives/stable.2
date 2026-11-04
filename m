Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793811010;
	b=QdDLFtsSPZGHvyOGNa37wFfVs/AyJlgUL+SIUj6+dyg5CK1pRcL2jeF0M2aV8w//h6F7
	 1c20DPGYZhe/s2PaV4AZt9IE3uN0/CYCsol495gUFUforc/1BAGF83qLuIkUOJUqwXcu2
	 TU5+DJ5T/IfspCnE386HWohpSNDpFvDqavnF2o7u0nLX6eur9SV27+d+iULeSYAlClZYV
	 iyy/SpQAyGFQLVeEwfMHlz2dUXUFhMoTOnEbnyxXwpFTgHYCCQjTbVg9pY/Xjz4zOaYSr
	 E8PAN4De9+Ix5GcgszzaWRqKgrRQ9pkUAZpyoY5UivSBZUAzrXDcZAaPpyHbGVYnJNQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793811010;
	h=Received:DKIM-Signature:Subject:To:Cc:From:Date:Message-ID:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=kLkyDtatBBtyP4/30RbUQ5hdDZmyGNzTGgohPWY+bVA=;
	b=3+vP7RaYtMWrAey4luPDB+kq0VcBk5Z3PY9OjyMR1AFNpB5GeSYHy/x3ndMpRm8YUYyT
	 QAaCuiZkZSy5UUFkVG9MovEbiK4FvoYHgPflaiPjxfrIts8y2MYpcOWTZnTYdqyjRPEk2
	 yjNHp3qzd7EOlNYesC69JYzBSOQmXRSSsFltVv/oj3e6NNRj4ezbWYNeECzIykzo9fIPn
	 Irb25WXzVvxE7eaGbdfQoMV+MRglwdABVaSAHSd4XPNVRUiMl9V1708JOybofQZqZYx1V
	 g+kyeStCj8H7L0wjwM+N+d8E2EOHx0+WI5zX0vfFSJjsA6jjpmrLsJFYdekcPtqnP1Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=xQpfRBj9;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC1CB606A326
	for <stable@vger.kernel.org>; Wed,  4 Nov 2026 16:50:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=xQpfRBj9
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3CB891F000C1;
	Wed,  4 Nov 2026 16:50:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1793811009;
	bh=kLkyDtatBBtyP4/30RbUQ5hdDZmyGNzTGgohPWY+bVA=;
	h=Subject:To:Cc:From:Date;
	b=xQpfRBj9OtSVsiGT/k4GBH+/iqK6hJaL9zA6sCS+72JSZqb9qpzeX17f/rQr7wX04
	 Vop2PaA+SSjkivt3q2yOAmZ4u8tMtcSZ+5ZhUeMm/rztUIQWwldjaG5vH8L7ASA1Pk
	 WAdwLCsA5rHN1+jrw4OFleHT5tFMvapTkBOrZrP0=
Subject: FAILED: patch "[PATCH] xfs: rescan the AGs if incore delalloc counter is negative" failed to apply to 6.12-stable tree
To: djwong@kernel.org,cem@kernel.org,hch@lst.de
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 04 Nov 2026 11:50:08 -0500
Message-ID: <2026110408-wildland-pluck-1671@gregkh>
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
git cherry-pick -x 47b1e941bb55f735d82ba2649412260da78b98f8
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026110408-wildland-pluck-1671@gregkh' --subject-prefix 'PATCH 6.12.y' 'HEAD^..'

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

