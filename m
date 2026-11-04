Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793811015;
	b=PnxoxMeIMehIUUXHL0slAx9UT6aSWjNKQNV0dBqfTnRQrbfgxrjl91No5tZvScDgwIuq
	 TETRbO/8SqGpCcjK97SyQmr6AHAqJ0DddWKKXG4vLvxq8ndHbQWmb20D2TNGv7Q0Uhs9v
	 jCgi6V4XJdGAWgkGmxs5l7hRFMhpBgN9ry3Y40TdBBdTMzmnJAZ1lJoZ1K3OEvCVCHnzH
	 roIuazBf/bOJFjFXnnsGcX6vy3KY7eAZt3qMf0ilk2x9AZmIjHdhh1lYPejwHH2vKaMHL
	 h5C+v1wSf8dsgH6IgVH6lcA81N5efHvkP5KNnrRro8O7eeQpqGj0RkOmRL69GbOPalQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793811015;
	h=Received:DKIM-Signature:Subject:To:Cc:From:Date:Message-ID:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=uiSjP+BTuksMkec7AVdl1nYjNc/cgROfN2EFIUc6DsM=;
	b=cia8fKdtezT4wgY8Cff8lvL5FhRHxAAVwnFqzeOdXQaQM9wzNwtAPsB4Whkz/ee+Xg1J
	 xJE5sqeoRcxSnJaNWM49FIgLlSufTw5gYnzW4sKFvakjzNuxtVSXcoGOwAMdn0UQEqV4Q
	 e780ovvL/qD9cYrHki19cxusDCWLxeOw+sO0tZxPE1ImcVveiUAPDLJnoVt34cI2sCY+m
	 gUFPhBuJEXvDHi4VDoxDLwDQONmCG8FrWgLR3DsGZahU8WKB+2nOKRDRp8jv0osDNWJYP
	 EcRy4VIjHVLziJTkwy/2XykWDU+FESTHKXlLcSA+Pjtc6NxYjCzsqSou08XrSCTZWiA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=sPELOxF4;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5631C606EE8C
	for <stable@vger.kernel.org>; Wed,  4 Nov 2026 16:50:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=sPELOxF4
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9A2FE1F00919;
	Wed,  4 Nov 2026 16:50:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1793811014;
	bh=uiSjP+BTuksMkec7AVdl1nYjNc/cgROfN2EFIUc6DsM=;
	h=Subject:To:Cc:From:Date;
	b=sPELOxF4O2mv6QqFYRhei/C+CmfDiAYMpHJN9Cz+KBF9nDnbunGVmEyyQa0LDFqK0
	 +mNHUCoDR6LfhgyestTj+pjRdoElNiinBVyH0mdbS7idK2ERHNvzTgJCrRBueq7HXo
	 laWxA8vMiBe0rLunPBpsAiB6NECsCf7icrHGGIcQ=
Subject: FAILED: patch "[PATCH] xfs: rescan the AGs if incore delalloc counter is negative" failed to apply to 5.15-stable tree
To: djwong@kernel.org,cem@kernel.org,hch@lst.de
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 04 Nov 2026 11:50:09 -0500
Message-ID: <2026110409-willow-coastline-1f7d@gregkh>
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
git cherry-pick -x 47b1e941bb55f735d82ba2649412260da78b98f8
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026110409-willow-coastline-1f7d@gregkh' --subject-prefix 'PATCH 5.15.y' 'HEAD^..'

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

