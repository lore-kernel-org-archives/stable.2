Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793888915;
	b=Nr9nCvtWKCMTwIDCFD1HKqkWgLNBntmg12TVqa3CM2Tc7zoMG2qlM1ZiY842Tv3JXssA
	 uWQ13/LNTYA7+MO993LRWZxDzkhs4jw6+j/QsQoIU1ft4ZRFFNEI73joP42BmqK2X617D
	 DhLyeJZfW6f1BUM+FJQsF7nSBTTXPjVdgQ0x2yOIeAuiCSj4T1UMD0ZJPe0aPajWsEJUk
	 qe5dF+gxeUr7789QB182ilsC81i0uzU+oJZJolxWov6PlZEYA7rOcWyEb29EfPH+1u6FZ
	 l+JmwwOR2r0+KPrfT/aN6SlKY+APnd31+UN0A9lyD4T96sVCoDR1QjZisfXuvl0sB7A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793888915;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=uIaAUthm/MgDARQvNS1TVcH9XjD1sJ/r/0JLAe3ABIo=;
	b=hXM8JKFiAMX7A1CrWyDL+3e5mw1LGjWB5lD+Py6dqwHo4NPzGsbuuEJXYyGxa4XQF9Ay
	 3rbMhP9qOMlgOeYsxXXdhE3DT/ZYzIxAyE4XXH7yFUuWFLjtKyxHtx2LZngj/G1HiyJPc
	 RB/d2+4XkvNmaLC16H0BlSBkPasBvraKpAFVcjarT2llUUKN6EhnIKFpwXFY+oIpcPtgq
	 v1ZE4ChWnqKb1ivb86IkSSUwr1cuXctS+THZLwPhUWzQX83RKj28nCPq/NC/OJZG6PJeu
	 07QZ+rR052dTW9Y08/lxtqPZNvd/QeD9zjy9nkCT92wT75ZQGhH5GfcL4uS6VghovCw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=UJLgb4R3;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D48EB606A31B
	for <stable@vger.kernel.org>; Thu,  5 Nov 2026 14:28:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=UJLgb4R3
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DDA6C1F000C1;
	Thu,  5 Nov 2026 14:28:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793888914;
	bh=uIaAUthm/MgDARQvNS1TVcH9XjD1sJ/r/0JLAe3ABIo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=UJLgb4R3lLbajZbIFvW/x4SeprmFcr5ShT5v5VONk5iFsVdqYfSFpeQvELC9Rzf5u
	 +rbH0jWmKV745K9lJFmBRnpalOsUSv7Z+rkhP7eTYdJ9X3dK0IIEl5/HOcQ2JTFfL+
	 wtAc8E/QEJkMJUbDBaQYhZtBQcyBU4ih0gusXnBt6LubiFyS7RSwqfAiUArMufxypb
	 Fo6FJvE24eYAcpAXYUd5QCl91HNDwvr+cRs0dZyiswvUc2f6qoQs1r87JeG4+LL75u
	 OfDS6Ks9Wnp8zgpZrn/q8J5iriTDR9hTNz6abTPUQrdFuQqKSZeMHTF5bW2htLSDRB
	 Mtx/bOgzTf4Rw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: "Darrick J. Wong" <djwong@kernel.org>,
	Christoph Hellwig <hch@lst.de>,
	Carlos Maiolino <cem@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y] xfs: rescan the AGs if incore delalloc counter is negative
Date: Thu,  5 Nov 2026 09:28:32 -0500
Message-ID: <20261105142747.1660390-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026110408-wildland-pluck-1671@gregkh>
References: <2026110408-wildland-pluck-1671@gregkh>
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

[ Upstream commit 47b1e941bb55f735d82ba2649412260da78b98f8 ]

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
[ sashal: Changed the realtime error return to goto out_unlock because the bitmap lock is still held. ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/xfs/scrub/fscounters.c | 17 +++++++++++++++--
 1 file changed, 15 insertions(+), 2 deletions(-)

diff --git a/fs/xfs/scrub/fscounters.c b/fs/xfs/scrub/fscounters.c
index 98634c668b56c..f4906b7d9fb0d 100644
--- a/fs/xfs/scrub/fscounters.c
+++ b/fs/xfs/scrub/fscounters.c
@@ -296,7 +296,7 @@ xchk_fscount_aggregate_agcounts(
 {
 	struct xfs_mount	*mp = sc->mp;
 	struct xfs_perag	*pag;
-	uint64_t		delayed;
+	int64_t			delayed;
 	xfs_agnumber_t		agno;
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
@@ -416,6 +421,7 @@ xchk_fscount_count_frextents(
 	struct xchk_fscounters	*fsc)
 {
 	struct xfs_mount	*mp = sc->mp;
+	int64_t			delayed;
 	int			error;
 
 	fsc->frextents = 0;
@@ -431,7 +437,14 @@ xchk_fscount_count_frextents(
 		goto out_unlock;
 	}
 
-	fsc->frextents_delayed = percpu_counter_sum(&mp->m_delalloc_rtextents);
+	delayed = percpu_counter_sum(&mp->m_delalloc_rtextents);
+	if (delayed < 0) {
+		ASSERT(delayed >= 0);
+		xchk_set_incomplete(sc);
+		error = -EFSCORRUPTED;
+		goto out_unlock;
+	}
+	fsc->frextents_delayed = delayed;
 
 out_unlock:
 	xfs_rtbitmap_unlock_shared(sc->mp, XFS_RBMLOCK_BITMAP);
-- 
2.53.0

